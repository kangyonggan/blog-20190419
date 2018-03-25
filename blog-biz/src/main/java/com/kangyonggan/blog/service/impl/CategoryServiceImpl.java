package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.util.Collections3;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.extra.core.annotation.Log;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

@Service
public class CategoryServiceImpl extends BaseService<Category> implements CategoryService {

    @Override
    public List<Category> searchCategories(int pageNum, String code, String name, String type) {
        Example example = new Example(Category.class);

        Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotEmpty(code)) {
            criteria.andLike("code", StringUtil.toLikeString(code));
        }
        if (StringUtils.isNotEmpty(name)) {
            criteria.andLike("name", StringUtil.toLikeString(name));
        }
        if (StringUtils.isNotEmpty(type)) {
            criteria.andEqualTo("type", type);
        }

        example.setOrderByClause("sort asc");

        PageHelper.startPage(pageNum, AppConstants.PAGE_SIZE);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public void saveCategory(Category category) {
        myMapper.insertSelective(category);
    }

    @Override
    @Log
    public Category findCategoryById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Category> findCategoriesByType(String type) {
        Example example = new Example(Category.class);

        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("type", type);

        example.setOrderByClause("sort asc");

        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public void updateCategory(Category category) {
        myMapper.updateByPrimaryKeySelective(category);
    }

    @Override
    @Log
    public void deleteCategoryById(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }

    @Override
    @Log
    public Category findCategoryByTypeAndCode(String type, String code) {
        Category category = new Category();
        category.setCode(code);
        category.setType(type);

        return myMapper.selectOne(category);
    }

    @Override
    @Log
    public List<String> findCategoryCodesByType(String type) {
        Category category = new Category();
        category.setType(type);
        List<Category> categories = myMapper.select(category);
        return Collections3.extractToList(categories, "code");
    }
}
