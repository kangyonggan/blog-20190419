package com.kangyonggan.blog.controller.mobile;

import com.kangyonggan.blog.constants.Resp;
import com.kangyonggan.blog.dto.response.SectionResponse;
import com.kangyonggan.blog.dto.response.SectionsResponse;
import com.kangyonggan.blog.service.SectionService;
import com.kangyonggan.blog.vo.Section;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author kangyonggan
 * @date 8/24/17
 */
@RestController
@RequestMapping("mobile/section")
@Log4j2
public class MobileSectionController {

    @Autowired
    private SectionService sectionService;

    /**
     * 查找指定章节
     *
     * @param novelCode
     * @param code
     * @return
     */
    @RequestMapping(method = RequestMethod.POST)
    public SectionResponse section(@RequestParam("novelCode") int novelCode, @RequestParam("code") int code) {
        SectionResponse response = new SectionResponse();

        try {
            Section section = sectionService.findSectionByCode(novelCode, code);

            if (section == null) {
                response.setRespCo(Resp.FAILURE.getRespCo());
                response.setRespMsg("不存在的章节");
                return response;
            }

            response.setSection(section);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("查找小说章节异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }

    /**
     * 查找下一个章节
     *
     * @param novelCode
     * @param code
     * @return
     */
    @RequestMapping(value = "next", method = RequestMethod.POST)
    public SectionResponse nextSection(@RequestParam("novelCode") int novelCode, @RequestParam("code") int code) {
        SectionResponse response = new SectionResponse();

        try {
            Section nextSection = sectionService.findNextSectionByCodeWithContent(novelCode, code);

            if (nextSection == null) {
                response.setRespCo(Resp.FAILURE.getRespCo());
                response.setRespMsg("不存在下一个章节");
                return response;
            }

            response.setSection(nextSection);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("查找小说章节异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }

    /**
     * 查找上一个章节
     *
     * @param novelCode
     * @param code
     * @return
     */
    @RequestMapping(value = "prev", method = RequestMethod.POST)
    public SectionResponse prevSection(@RequestParam("novelCode") int novelCode, @RequestParam("code") int code) {
        SectionResponse response = new SectionResponse();

        try {
            Section nextSection = sectionService.findPrevSectionByCodeWithContent(novelCode, code);

            if (nextSection == null) {
                response.setRespCo(Resp.FAILURE.getRespCo());
                response.setRespMsg("不存在上一个章节");
                return response;
            }

            response.setSection(nextSection);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("查找小说章节异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }

    /**
     * 查找第一个章节
     *
     * @param novelCode
     * @return
     */
    @RequestMapping(value = "first", method = RequestMethod.POST)
    public SectionResponse lastSection(@RequestParam("novelCode") int novelCode) {
        SectionResponse response = new SectionResponse();

        try {
            Section section = sectionService.findFirstSection(novelCode);

            if (section == null) {
                response.setRespCo(Resp.FAILURE.getRespCo());
                response.setRespMsg("小说章节尚未拉取，可以联系康永敢优先拉取此小说");
                return response;
            }

            response.setSection(section);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("查找小说第一个章节异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }

    /**
     * 查找小说后面100章
     *
     * @param novelCode
     * @param code
     * @return
     */
    @RequestMapping(value = "cache", method = RequestMethod.POST)
    public SectionsResponse sectionCache(@RequestParam("novelCode") int novelCode, @RequestParam("code") int code) {
        SectionsResponse response = new SectionsResponse();

        try {
            List<Section> sections = sectionService.findNext100Sections(novelCode, code);
            response.setSections(sections);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("查找小说后面100章异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }

    /**
     * 查找小说全部章节
     *
     * @param novelCode
     * @return
     */
    @RequestMapping(value = "all", method = RequestMethod.POST)
    public SectionsResponse sections(@RequestParam("novelCode") int novelCode) {
        SectionsResponse response = new SectionsResponse();

        try {
            List<Section> sections = sectionService.findNovelSections(novelCode);

            response.setSections(sections);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("查找小说全部章节异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }
}
