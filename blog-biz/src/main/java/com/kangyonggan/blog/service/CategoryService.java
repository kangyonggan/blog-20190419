package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Category;

import java.util.List;

public interface CategoryService {

    /**
     * 搜索栏目
     *
     * @param pageNum
     * @param code
     * @param name
     * @param type
     * @return
     */
    List<Category> searchCategories(int pageNum, String code, String name, String type);

    /**
     * 保存栏目
     *
     * @param category
     */
    void saveCategory(Category category);

    /**
     * 根据栏目代码查找栏目
     *
     * @param code
     * @return
     */
    Category findCategoryByCode(String code);

    /**
     * 根据类型查找栏目
     *
     * @param type
     * @return
     */
    List<Category> findCategoriesByType(String type);

    /**
     * 根据栏目代码更新栏目
     *
     * @param category
     */
    void updateCategory(Category category);

    /**
     * 物理删除栏目
     *
     * @param code
     */
    void deleteCategoryByCode(String code);
}
