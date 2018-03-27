package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Section;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
public interface SectionService {

    /**
     * 章节更新标识
     */
    String SECTION_UPDATE_FLAG = "section:update:flag:";

    /**
     * 查找书籍最新章节
     *
     * @param code
     * @return
     */
    Section findLastSectionByNovelCode(Integer code);

    /**
     * 查找小说章节
     *
     * @param pageNum
     * @param pageSize
     * @param code
     * @return
     */
    List<Section> findSectionsByNovelCode(int pageNum, int pageSize, Integer code);

    /**
     * 查找小说章节列表
     *
     * @param code
     * @return
     */
    List<Section> findNovelSections(Integer code);

    /**
     * 查找章节
     *
     * @param code
     * @return
     */
    Section findSectionByCode(Integer code);

    /**
     * 查找上一章节
     *
     * @param novelCode
     * @param sectionCode
     * @return
     */
    Section findPrevSectionByCode(Integer novelCode, Integer sectionCode);

    /**
     * 查找下一章节
     *
     * @param novelCode
     * @param sectionCode
     * @return
     */
    Section findNextSectionByCode(Integer novelCode, Integer sectionCode);

    /**
     * 拉取最新章节
     *
     * @param novelCode
     */
    void updateSections(Integer novelCode);

    /**
     * 清空章节
     *
     * @param novelCode
     */
    void deleteSections(Integer novelCode);

    /**
     * 更新所有章节
     */
    void updateAllSections();

    /**
     * 从某处更新所有章节
     *
     * @param novelCode
     */
    void updateSectionsFromNow(Integer novelCode);

    /**
     * 查找第一章
     *
     * @param novelCode
     * @return
     */
    Section findFirstSection(int novelCode);

    /**
     * 查找后面100章
     *
     * @param novelCode
     * @param code
     * @return
     */
    List<Section> findNext100Sections(Integer novelCode, Integer code);
}
