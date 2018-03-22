package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

@Service
public class ArticleServiceImpl extends BaseService<Article> implements ArticleService {

    @Override
    public List<Article> searchArticles(int pageNum, String title, String categoryCode) {
        Example example = new Example(Article.class);

        Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotEmpty(title)) {
            criteria.andLike("title", StringUtil.toLikeString(title));
        }
        if (StringUtils.isNotEmpty(categoryCode)) {
            criteria.andEqualTo("categoryCode", StringUtil.toLikeString(categoryCode));
        }

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, AppConstants.PAGE_SIZE);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public void saveArticle(Article article) {
        myMapper.insertSelective(article);
    }

    @Override
    @Log
    @Cache(key = "article:id:${id}")
    public Article findArticleById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    @Log
    @CacheDel(key = "article:id:${article.id}")
    public void updateArticle(Article article) {
        myMapper.updateByPrimaryKeySelective(article);
    }

    @Override
    @Log
    @CacheDel(key = "article:id:${id}")
    public void deleteArticle(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }
}
