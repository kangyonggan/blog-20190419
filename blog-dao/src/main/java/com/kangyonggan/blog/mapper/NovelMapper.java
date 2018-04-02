package com.kangyonggan.blog.mapper;

import com.kangyonggan.blog.vo.Novel;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author kangyonggan
 * @date 2018/04/02
 */
@Repository
public interface NovelMapper extends MyMapper<Novel> {

    /**
     * 查找最后一本小说
     *
     * @return
     */
    Integer selectLastNovelCode();

    /**
     * 搜索小说
     *
     * @param code
     * @param name
     * @param author
     * @param categoryCode
     * @return
     */
    List<Novel> searchNovels(@Param("code") String code, @Param("name") String name, @Param("author") String author, @Param("categoryCode") String categoryCode);

    /**
     * 搜索小说，根据name或author
     *
     * @param key
     * @return
     */
    List<Novel> searchNovelsByKey(@Param("key") String key);
}