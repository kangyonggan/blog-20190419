package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.mapper.NovelMapper;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.NovelService;
import com.kangyonggan.blog.service.RedisService;
import com.kangyonggan.blog.service.SectionService;
import com.kangyonggan.blog.util.FileUtil;
import com.kangyonggan.blog.util.HtmlUtil;
import com.kangyonggan.blog.util.PropertiesUtil;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Novel;
import com.kangyonggan.blog.vo.Section;
import com.kangyonggan.extra.core.annotation.Log;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.nodes.Document;
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
public class NovelServiceImpl extends BaseService<Novel> implements NovelService {

    @Autowired
    private NovelMapper novelMapper;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private SectionService sectionService;

    @Autowired
    private RedisService redisService;

    private String prefix = PropertiesUtil.getProperties("redis.prefix") + ":";

    @PostConstruct
    public void init() {
        redisService.delete(prefix + NOVEL_UPDATE_FLAG);
        log.info("小说更新标识已重置");
    }

    @Override
    @Log
    public Integer findLastNovelCode() {
        return novelMapper.selectLastNovelCode();
    }

    @Override
    public List<Novel> findNovelsByCategory(int pageNum, int pageSize, String categoryCode) {
        Novel novel = new Novel();
        novel.setIsDeleted(AppConstants.IS_DELETED_NO);
        if (StringUtils.isNotEmpty(categoryCode)) {
            novel.setCategoryCode(categoryCode);
        }

        PageHelper.startPage(pageNum, pageSize);
        List<Novel> novels = myMapper.select(novel);

        // 查找最新章节
        return findNewSection(novels);
    }

    @Override
    public List<Novel> searchNovels(int pageNum, int pageSize, String code, String name, String author, String categoryCode) {
        Example example = new Example(Novel.class);

        Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotEmpty(code)) {
            criteria.andEqualTo("code", code);
        }
        if (StringUtils.isNotEmpty(name)) {
            criteria.andLike("name", StringUtil.toLikeString(name));
        }
        if (StringUtils.isNotEmpty(author)) {
            criteria.andLike("author", StringUtil.toLikeString(author));
        }
        if (StringUtils.isNotEmpty(categoryCode)) {
            criteria.andEqualTo("categoryCode", categoryCode);
        }

        example.setOrderByClause("id desc");
        PageHelper.startPage(pageNum, pageSize);
        List<Novel> novels = myMapper.selectByExample(example);
        return findNewSection(novels);
    }

    @Override
    @Log
    public Novel findNovelByCode(Integer code) {
        Novel novel = new Novel();
        novel.setCode(code);

        return myMapper.selectOne(novel);
    }

    @Override
    @Log
    public void updateNovel(Novel novel) {
        Example example = new Example(Novel.class);
        example.createCriteria().andEqualTo("code", novel.getCode());

        myMapper.updateByConditionSelective(novel, example);
    }

    @Override
    @Log
    public void deleteNovel(Integer code) {
        Novel novel = new Novel();
        novel.setCode(code);

        myMapper.delete(novel);
    }

    @Override
    public List<Novel> searchNovels(int pageNum, int pageSize, String key) {
        Example example = new Example(Novel.class);
        example.createCriteria().andLike("name", StringUtil.toLikeString(key));
        example.or(example.createCriteria().andLike("author", StringUtil.toLikeString(key)));

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public void updateNovelFromNow(Integer code) {
        Object flag = redisService.get(prefix + NOVEL_UPDATE_FLAG);

        if (flag != null) {
            log.info("小说已经正在更新中,本次不再重复更新");
            return;
        }

        redisService.set(prefix + NOVEL_UPDATE_FLAG, "1");

        if (code == null) {
            code = 1;
        }
        int currentCount = 0;
        List<String> categoryCodes = categoryService.findCategoryCodesByType(CategoryType.NOVEL.getType());
        while (true) {
            Document document = HtmlUtil.parseUrl(BI_QU_GE_URL + "book/" + code);
            if (document == null) {
                currentCount++;
                code++;
                if (currentCount >= ERR_COUNT) {
                    log.info("小说连续{}本都解析不了，可能已经没有更多小说了", currentCount);
                    break;
                }
                continue;
            }

            try {
                parseNovel(document, code++, categoryCodes);
            } catch (Exception e) {
                log.error("小说解析异常, 继续解析下一本", e);
            }
        }

        redisService.delete(prefix + NOVEL_UPDATE_FLAG);
    }

    /**
     * 查找最新章节
     *
     * @param novels
     */
    private List<Novel> findNewSection(List<Novel> novels) {
        for (Novel novel : novels) {
            Section section = sectionService.findLastSectionByNovelCode(novel.getCode());
            novel.setLastSection(section);
        }

        return novels;
    }


    /**
     * 解析小说
     *
     * @param document
     * @param code
     * @param categoryCodes
     * @throws Exception
     */
    @Transactional(propagation = Propagation.NOT_SUPPORTED)
    public void parseNovel(Document document, int code, List<String> categoryCodes) throws Exception {
        // 判断库中是否已存在
        if (existNovel(code)) {
            log.info("小说{}已存在，继续更新下一本", code);
            return;
        }

        String name = document.select("#maininfo #info h1").html().trim();
        String author = document.select("#maininfo #info p").get(0).html().trim();
        String categoryCode = document.select(".box_con .con_top a").get(1).attr("href").replaceAll("/", "");
        if (!categoryCodes.contains(categoryCode)) {
            categoryCode = "qita";
        }

        String picUrl = document.select("#fmimg img").attr("src");
        author = author.substring(author.indexOf("：") + 1);
        String descp = document.select("#intro p").get(0).html().trim();

        Novel novel = new Novel();
        novel.setCode(code);
        novel.setName(name);
        novel.setAuthor(author);
        novel.setDescp(descp);
        novel.setCategoryCode(categoryCode);

        String filePath = "cover/" + code + picUrl.substring(picUrl.lastIndexOf("."));
        try {
            FileUtil.downloadFromUrl(picUrl, PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + filePath);
        } catch (Exception e) {
            filePath = "static/app/images/nocover.jpg";
        }
        novel.setPicUrl(filePath);

        log.info("抓取小说{}", novel);
        saveNovel(novel);
    }

    /**
     * 报错小说
     *
     * @param novel
     */
    private void saveNovel(Novel novel) {
        myMapper.insertSelective(novel);
    }

    /**
     * 判断小说是否已经存在
     *
     * @param code
     * @return
     */
    private boolean existNovel(int code) {
        Novel novel = new Novel();
        novel.setCode(code);

        return super.exists(novel);
    }
}
