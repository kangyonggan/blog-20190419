package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
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
    @CacheDel(key = "category:type:${category.type}")
    public void saveCategory(Category category) {
        myMapper.insertSelective(category);
    }

    @Override
    @Log
    @Cache(key = "category:code:${code}")
    public Category findCategoryByCode(String code) {
        Category category = new Category();
        category.setCode(code);

        return myMapper.selectOne(category);
    }

    @Override
    @Cache(key = "category:type:${type}")
    public List<Category> findCategoriesByType(String type) {
        Example example = new Example(Category.class);

        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("type", type);

        example.setOrderByClause("sort asc");

        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    @CacheDel(key = {"category:code:${category.code}", "category:type:${category.type}"})
    public void updateCategory(Category category) {
        Example example = new Example(Category.class);
        example.createCriteria().andEqualTo("code", category.getCode());

        myMapper.updateByExampleSelective(category, example);
    }

    @Override
    @Log
    @CacheDel(key = {"category:code:${code}", "category:type:*"})
    public void deleteCategoryByCode(String code) {
        Category category = new Category();
        category.setCode(code);

        myMapper.delete(category);
    }
}
