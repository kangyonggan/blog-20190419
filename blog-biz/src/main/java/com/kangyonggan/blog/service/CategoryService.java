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
     * 根据ID查找栏目
     *
     * @param id
     * @return
     */
    Category findCategoryById(Long id);

    /**
     * 根据类型查找栏目
     *
     * @param type
     * @return
     */
    List<Category> findCategoriesByType(String type);

    /**
     * 根据ID更新栏目
     *
     * @param category
     */
    void updateCategory(Category category);

    /**
     * 物理删除栏目
     *
     * @param id
     */
    void deleteCategoryById(Long id);

    /**
     * 根据栏目类型和代码查找栏目
     *
     * @param type
     * @param code
     * @return
     */
    Category findCategoryByTypeAndCode(String type, String code);

    /**
     * 查找栏目代码
     *
     * @param type
     * @return
     */
    List<String> findCategoryCodesByType(String type);
}
