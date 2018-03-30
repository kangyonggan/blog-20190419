package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.constants.MonitorType;
import com.kangyonggan.blog.mapper.AttachmentMapper;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.util.FileUpload;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

@Service
public class ArticleServiceImpl extends BaseService<Article> implements ArticleService {

    @Autowired
    private AttachmentMapper attachmentMapper;

    @Override
    public List<Article> searchArticles(int pageNum, int pageSize, String title, String categoryCode) {
        Example example = new Example(Article.class);

        Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotEmpty(title)) {
            criteria.andLike("title", StringUtil.toLikeString(title));
        }
        if (StringUtils.isNotEmpty(categoryCode)) {
            criteria.andEqualTo("categoryCode", categoryCode);
        }

        example.setOrderByClause("is_top desc, id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    @CacheDel(key = "article:tops")
    @Monitor(type = MonitorType.INSERT, description = "发布文章${article.title}")
    public void saveArticleWithAttachments(Article article, MultipartFile[] files) throws FileUploadException {
        myMapper.insertSelective(article);

        if (files.length > 0) {
            saveAttachments(article, files);
        }
    }

    @Override
    @Log
    @Cache(key = "article:id:${id}")
    public Article findArticleById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    @CacheDel(key = {"article:id:${article.id}", "article:tops"})
    @Monitor(type = MonitorType.UPDATE, description = "更新文章${article.title}")
    public void updateArticleWithAttachments(Article article, MultipartFile[] files) throws FileUploadException {
        myMapper.updateByPrimaryKeySelective(article);

        if (files.length > 0) {
            saveAttachments(article, files);
        }
    }

    @Override
    @Log
    @CacheDel(key = {"article:id:${id}", "article:tops"})
    public void deleteArticle(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }

    @Override
    @Log
    @CacheDel(key = {"article:id:${article.id}", "article:tops"})
    public void updateArticle(Article article) {
        myMapper.updateByPrimaryKeySelective(article);
    }

    @Override
    @Cache(key = "article:tops")
    public List<Article> findTopArticles() {
        Article article = new Article();
        article.setIsDeleted(AppConstants.IS_DELETED_NO);
        article.setIsTop((byte) 1);

        return myMapper.select(article);
    }

    @Override
    @Log
    public List<Article> findSomeArticles(int pageNum, int pageSize, String categoryCode) {
        Example example = new Example(Article.class);

        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        if (StringUtils.isNotEmpty(categoryCode)) {
            criteria.andEqualTo("categoryCode", categoryCode);
        }

        example.selectProperties("id", "title", "summary", "categoryCode", "isTop", "isDeleted", "createdTime");

        example.setOrderByClause("is_top desc, id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    public List<Article> searchArticles(int pageNum, int pageSize, String key) {
        Example example = new Example(Article.class);

        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);
        if (StringUtils.isNotEmpty(key)) {
            criteria.andLike("title", StringUtil.toLikeString(key));
            example.or(example.createCriteria().andLike("summary", StringUtil.toLikeString(key)));
        }

        example.setOrderByClause("is_top desc, id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    /**
     * 批量保存附件
     *
     * @param article
     * @param files
     * @throws FileUploadException
     */
    private void saveAttachments(Article article, MultipartFile[] files) throws FileUploadException {
        List<Attachment> attachments = new ArrayList<>();
        for (int i = 0; i < files.length; i++) {
            Attachment attachment = new Attachment();
            String url = FileUpload.upload(files[i], "ARTICLE");
            String originalFilename = files[i].getOriginalFilename();

            attachment.setType(AttachmentType.ARTICLE.getType());
            attachment.setSourceId(article.getId());
            attachment.setUrl(url);
            attachment.setOriginalFilename(originalFilename);
            attachments.add(attachment);
        }

        // 批量保存附件
        attachmentMapper.insertAttachments(attachments);
    }
}
