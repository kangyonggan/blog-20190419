package com.kangyonggan.blog.mapper;

import com.kangyonggan.blog.vo.Novel;
import org.springframework.stereotype.Repository;

@Repository
public interface NovelMapper extends MyMapper<Novel> {

    /**
     * 查找最后一本小说
     *
     * @return
     */
    Integer selectLastNovelCode();

}