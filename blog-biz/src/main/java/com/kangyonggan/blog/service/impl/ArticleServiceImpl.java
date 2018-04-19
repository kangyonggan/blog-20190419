package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.constants.MonitorType;
import com.kangyonggan.blog.mapper.AttachmentMapper;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.util.*;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.entity.Example;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author kangyonggan
 * @date 2018/04/02
 */
@Service
@Log4j2
public class ArticleServiceImpl extends BaseService<Article> implements ArticleService {

    @Autowired
    private AttachmentMapper attachmentMapper;

    private static Pattern pattern = Pattern.compile("!\\[.*]\\(.*\\)");

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

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    @CacheDel(key = "article:tops")
    public void saveArticleWithAttachments(Article article, MultipartFile[] files) throws FileUploadException {
        myMapper.insertSelective(article);

        if (files.length > 0) {
            saveAttachments(article, files);
        }

        genRssFile();
    }

    @Override
    @Log
    @Cache(key = "article:id:${id}")
    public Article findArticleById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    @CacheDel(key = {"article:id:${article.id}", "article:tops"})
    public void updateArticleWithAttachments(Article article, MultipartFile[] files) throws FileUploadException {
        myMapper.updateByPrimaryKeySelective(article);

        if (files.length > 0) {
            saveAttachments(article, files);
        }

        genRssFile();
    }

    @Override
    @Log
    @CacheDel(key = {"article:id:${id}", "article:tops"})
    @Monitor(type = MonitorType.DELETE, description = "删除文章id=${id}")
    public void deleteArticle(Long id) {
        myMapper.deleteByPrimaryKey(id);
        genRssFile();
    }

    @Override
    @Log
    @CacheDel(key = {"article:id:${article.id}", "article:tops"})
    @Monitor(type = MonitorType.UPDATE, description = "更新文章${article.title}")
    public void updateArticle(Article article) {
        myMapper.updateByPrimaryKeySelective(article);
        genRssFile();
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

        example.setOrderByClause("id desc");

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
            example.or(example.createCriteria().andLike("summary", StringUtil.toLikeString(key)).andEqualTo("isDeleted", AppConstants.IS_DELETED_NO));
        }

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public Article finPrevArticle(Long id) {
        Example example = new Example(Article.class);
        example.createCriteria().andEqualTo("isDeleted", AppConstants.IS_DELETED_NO).andLessThan("id", id);

        example.selectProperties("id", "title");

        example.setOrderByClause("id desc");

        PageHelper.startPage(1, 1);
        List<Article> articles = myMapper.selectByExample(example);
        return articles.isEmpty() ? null : articles.get(0);
    }

    @Override
    @Log
    public Article finNextArticle(Long id) {
        Example example = new Example(Article.class);
        example.createCriteria().andEqualTo("isDeleted", AppConstants.IS_DELETED_NO).andGreaterThan("id", id);

        example.selectProperties("id", "title");

        example.setOrderByClause("id asc");

        PageHelper.startPage(1, 1);
        List<Article> articles = myMapper.selectByExample(example);
        return articles.isEmpty() ? null : articles.get(0);
    }

    @Override
    public List<Article> findWapArticles(int pageNum, int pageSize, String categoryCode, String sort) {
        Example example = new Example(Article.class);

        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        if (StringUtils.isNotEmpty(categoryCode)) {
            criteria.andEqualTo("categoryCode", categoryCode);
        }

        example.selectProperties("id", "title", "summary", "categoryCode", "content");

        if (StringUtils.isEmpty(sort)) {
            sort = "desc";
        }

        example.setOrderByClause("id " + sort);

        PageHelper.startPage(pageNum, pageSize);
        List<Article> articles = myMapper.selectByExample(example);
        return dealArticles(articles);
    }

    /**
     * 处理文章首图
     *
     * @param articles
     * @return
     */
    private List<Article> dealArticles(List<Article> articles) {
        for (Article article : articles) {
            String content = article.getContent();
            Matcher matcher = pattern.matcher(content);
            if (matcher.find()) {
                String pic = matcher.group();
                pic = pic.substring(pic.indexOf("(") + 1, pic.lastIndexOf(")"));
                article.setPicture(pic);
            }
        }
        return articles;
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

    /**
     * 生成rss文件
     */
    private void genRssFile() {
        Example example = new Example(Article.class);
        example.createCriteria().andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);
        example.setOrderByClause("id desc");
        List<Article> articles = myMapper.selectByExample(example);

        StringBuilder rss = new StringBuilder("<feed xmlns=\"http://www.w3.org/2005/Atom\"><title>");
        rss.append(PropertiesUtil.getProperties("app.name")).append("</title>");
        rss.append("<link href=\"/rss/blog.xml\" rel=\"self\"/>").append("<link href=\"https://www.kangyonggan.com/\"/>");
        rss.append("<updated>").append(DateUtil.toXmlDateTime(new Date())).append("</updated>");
        rss.append("<id>https://www.kangyonggan.com/</id>");
        rss.append("<author><name>").append(PropertiesUtil.getProperties("app.author")).append("</name></author>");

        for (Article article : articles) {
            rss.append("<entry><title>").append(article.getTitle()).append("</title>");
            rss.append("<link href=\"https://www.kangyonggan.com/article/").append(article.getId()).append("\"/>");
            rss.append("<id>https://www.kangyonggan.com/article/").append(article.getId()).append("</id>");
            rss.append("<published>").append(DateUtil.toXmlDateTime(article.getCreatedTime())).append("</published>");
            rss.append("<updated>").append(DateUtil.toXmlDateTime(article.getUpdatedTime())).append("</updated>");
            rss.append("<content type=\"html\"><![CDATA[").append(MarkdownUtil.markdownToHtml(article.getContent())).append("]]></content>");

            int index = article.getContent().indexOf("<!-- more -->");
            if (index > -1) {
                String summary = article.getContent().substring(0, index);
                rss.append("<summary type=\"html\"><![CDATA[").append(MarkdownUtil.markdownToHtml(summary)).append("]]></summary>");
            } else {
                rss.append("<summary type=\"html\"><![CDATA[").append(MarkdownUtil.markdownToHtml(article.getContent())).append("]]></summary>");
            }

            rss.append("<category term=\"").append(article.getCategoryCode()).append("\" scheme=\"https://www.kangyonggan.com/article?category=").append(article.getCategoryCode()).append("\"/>");
            rss.append("</entry>");
        }

        rss.append("</feed>");

        File file = new File(PropertiesUtil.getProperties("file.root.path") + "rss/blog.xml");

        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }

        BufferedWriter writer = null;
        try {
            writer = new BufferedWriter(new FileWriter(file));
            writer.write(rss.toString());
            writer.flush();
        } catch (Exception e) {
            log.error("生成博客rss异常, 文件路径：" + PropertiesUtil.getProperties("file.root.path") + "rss/blog.xml", e);
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (Exception e) {
                    log.error("写rss后关闭输入流异常", e);
                }
            }
        }
    }
}
