package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.mapper.SectionMapper;
import com.kangyonggan.blog.service.NovelService;
import com.kangyonggan.blog.service.RedisService;
import com.kangyonggan.blog.service.SectionService;
import com.kangyonggan.blog.util.HtmlUtil;
import com.kangyonggan.blog.util.PropertiesUtil;
import com.kangyonggan.blog.vo.Novel;
import com.kangyonggan.blog.vo.Section;
import com.kangyonggan.extra.core.annotation.Log;
import lombok.extern.log4j.Log4j2;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
@Service
@Log4j2
public class SectionServiceImpl extends BaseService<Section> implements SectionService {

    @Autowired
    private SectionMapper sectionMapper;

    @Autowired
    private RedisService redisService;

    @Autowired
    private NovelService novelService;

    private String prefix = PropertiesUtil.getProperties("redis.prefix") + ":";

    @PostConstruct
    public void init() {
        redisService.deleteAll(prefix + SECTION_UPDATE_FLAG + "*");
        log.info("所有小说章节的更新标识已重置");
    }

    @Override
    @Log
    public Section findLastSectionByNovelCode(Integer code) {
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("novelCode", code);
        example.setOrderByClause("code desc");

        example.selectProperties("id", "code", "title", "novelCode");

        PageHelper.startPage(1, 1);
        List<Section> sections = myMapper.selectByExample(example);
        if (sections.isEmpty()) {
            return null;
        }
        return sections.get(0);
    }

    @Override
    public List<Section> findSectionsByNovelCode(int pageNum, int pageSize, Integer code) {
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("novelCode", code).andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        example.setOrderByClause("id asc");
        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    public List<Section> findNovelSections(Integer code) {
        Section section = new Section();
        section.setIsDeleted(AppConstants.IS_DELETED_NO);
        section.setNovelCode(code);

        return myMapper.select(section);
    }

    @Override
    public Section findSectionByCode(Integer code) {
        Section section = new Section();
        section.setCode(code);

        return myMapper.selectOne(section);
    }

    @Override
    @Log
    public Section findPrevSectionByCode(Integer novelCode, Integer sectionCode) {
        return sectionMapper.selectPrevSection(novelCode, sectionCode);
    }

    @Override
    @Log
    public Section findNextSectionByCode(Integer novelCode, Integer sectionCode) {
        return sectionMapper.selectNextSection(novelCode, sectionCode);
    }

    @Override
    @Log
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public void updateSections(Integer novelCode) {
        Object flag = redisService.get(prefix + SECTION_UPDATE_FLAG + novelCode);

        if (flag != null) {
            log.info("本小说正在更新, 此次不再重复更新");
            return;
        }
        redisService.set(prefix + SECTION_UPDATE_FLAG + novelCode, "1");

        try {
            pullSections(novelCode);
        } catch (Exception e) {
            log.warn("更新小说章节异常", e);
        }
        redisService.delete(prefix + SECTION_UPDATE_FLAG + novelCode);
    }

    @Override
    @Log
    public void deleteSections(Integer novelCode) {
        Section section = new Section();
        section.setNovelCode(novelCode);

        myMapper.delete(section);
    }

    @Override
    @Log
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public void updateAllSections() {
        int lastNovelCode = novelService.findLastNovelCode();
        for (int novelCode = 1; novelCode <= lastNovelCode; novelCode++) {
            Novel novel = novelService.findNovelByCode(novelCode);
            if (novel != null) {
                updateSections(novelCode);
            }
        }
    }

    @Override
    @Log
    public void updateSectionsFromNow(Integer novelCode) {
        int lastNovelCode = novelService.findLastNovelCode();
        for (int code = novelCode; code <= lastNovelCode; code++) {
            Novel novel = novelService.findNovelByCode(code);
            if (novel != null) {
                updateSections(code);
            }
        }
    }

    @Override
    @Log
    public Section findFirstSection(int novelCode) {
        Example example = new Example(Section.class);

        example.createCriteria().andEqualTo("novelCode", novelCode);

        example.setOrderByClause("code asc");
        PageHelper.startPage(1, 1);
        List<Section> sections = myMapper.selectByExample(example);

        return sections.isEmpty() ? null : sections.get(0);
    }

    @Override
    public List<Section> findNext100Sections(Integer novelCode, Integer code) {
        Example example = new Example(Section.class);
        example.createCriteria().andEqualTo("novelCode", novelCode).andGreaterThanOrEqualTo("code", code);

        example.setOrderByClause("code asc");

        PageHelper.startPage(1, 100);
        return myMapper.selectByExample(example);
    }

    @Override
    public Section findNextSectionByCodeWithContent(Integer novelCode, int code) {
        Example example = new Example(Section.class);

        example.createCriteria().andEqualTo("novelCode", novelCode);
        example.createCriteria().andGreaterThan("code", code);

        example.setOrderByClause("code asc");

        PageHelper.startPage(1, 1);
        List<Section> sections = myMapper.selectByExample(example);
        if (sections.isEmpty()) {
            return null;
        }

        return sections.get(0);
    }

    @Override
    public Section findPrevSectionByCodeWithContent(Integer novelCode, int code) {
        Example example = new Example(Section.class);

        example.createCriteria().andEqualTo("novelCode", novelCode);
        example.createCriteria().andLessThan("code", code);

        example.setOrderByClause("code desc");

        PageHelper.startPage(1, 1);
        List<Section> sections = myMapper.selectByExample(example);
        if (sections.isEmpty()) {
            return null;
        }

        return sections.get(0);
    }

    /**
     * 拉取小说章节
     *
     * @param novelCode
     */
    private void pullSections(Integer novelCode) {
        Novel novel = novelService.findNovelByCode(novelCode);

        if (novel == null) {
            return;
        }

        try {
            // 最新章节
            Section lastSection = findLastSectionByNovelCode(novelCode);

            Document bookDoc = HtmlUtil.parseUrl(NovelService.BI_QU_GE_URL + "book/" + novelCode);
            Elements elements = bookDoc.select("#list dl dd a");

            int startNum = 0;
            if (lastSection != null) {
                for (int i = 0; i < elements.size(); i++) {
                    Element element = elements.get(i);
                    String scode = element.attr("href");
                    scode = scode.substring(scode.lastIndexOf("/") + 1, scode.lastIndexOf("."));
                    if (lastSection.getCode() == Integer.parseInt(scode)) {
                        startNum = i + 1;
                        break;
                    }
                }
            }

            log.info("从第{}章节开始更新", startNum);
            for (int i = startNum; i < elements.size(); i++) {
                Element element = elements.get(i);
                String scode = element.attr("href");
                scode = scode.substring(scode.lastIndexOf("/") + 1, scode.lastIndexOf("."));
                parseSection(novelCode, Integer.parseInt(scode));
            }
        } catch (Exception e) {
            log.warn("抓取章节异常", e);
            return;
        }
    }

    /**
     * 解析章节
     *
     * @param novelCode
     * @param sectionCode
     */
    private void parseSection(int novelCode, int sectionCode) {
        Document doc = HtmlUtil.parseUrl(NovelService.BI_QU_GE_URL + "/book/" + novelCode + "/" + sectionCode + ".html");

        String title = doc.select(".bookname h1").html().trim();
        String content = doc.select("#content").html();

        Section section = new Section();
        section.setNovelCode(novelCode);
        section.setCode(sectionCode);
        section.setTitle(title);
        section.setContent(content);

        log.info("章节【{}】保存成功", section.getTitle());
        myMapper.insertSelective(section);
    }
}
