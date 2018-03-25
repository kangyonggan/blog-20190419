package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Section;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
public interface SectionService {

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
}
