package com.kangyonggan.blog.mapper;

import com.kangyonggan.blog.vo.Category;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author kangyonggan
 * @date 2018/04/02
 */
@Repository
public interface CategoryMapper extends MyMapper<Category> {

    /**
     * 查找所有分类，带有小说总数
     *
     * @return
     */
    List<Category> selectAllCategoryWithNovelCount();
}