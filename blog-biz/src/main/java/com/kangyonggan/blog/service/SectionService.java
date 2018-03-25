package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Section;

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

}
