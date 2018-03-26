package com.kangyonggan.blog.mapper;

import com.kangyonggan.blog.vo.Category;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryMapper extends MyMapper<Category> {

    /**
     * 查找所有分类，带有小说总数
     *
     * @return
     */
    List<Category> selectAllCategoryWithBookCount();
}