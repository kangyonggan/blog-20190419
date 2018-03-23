package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.mapper.AttachmentMapper;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.util.FileUpload;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
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
            criteria.andEqualTo("categoryCode", StringUtil.toLikeString(categoryCode));
        }

        example.setOrderByClause("is_top desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
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
    @CacheDel(key = "article:id:${article.id}")
    public void updateArticleWithAttachments(Article article, MultipartFile[] files) throws FileUploadException {
        myMapper.updateByPrimaryKeySelective(article);

        if (files.length > 0) {
            saveAttachments(article, files);
        }
    }

    @Override
    @Log
    @CacheDel(key = "article:id:${id}")
    public void deleteArticle(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }

    @Override
    @Log
    @CacheDel(key = "article:id:${article.id}")
    public void updateArticle(Article article) {
        myMapper.updateByPrimaryKeySelective(article);
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
            String url = FileUpload.upload(files[i]);
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
