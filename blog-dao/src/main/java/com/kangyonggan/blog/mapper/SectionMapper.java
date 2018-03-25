package com.kangyonggan.blog.mapper;

import com.kangyonggan.blog.vo.Section;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface SectionMapper extends MyMapper<Section> {

    /**
     * 查找上一章节
     *
     * @param novelCode
     * @param sectionCode
     * @return
     */
    Section selectPrevSection(@Param("novelCode") Integer novelCode, @Param("sectionCode") Integer sectionCode);

    /**
     * 查找下一章节
     *
     * @param novelCode
     * @param sectionCode
     * @return
     */
    Section selectNextSection(@Param("novelCode") Integer novelCode, @Param("sectionCode") Integer sectionCode);
}