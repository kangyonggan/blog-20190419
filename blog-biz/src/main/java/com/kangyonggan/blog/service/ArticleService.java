package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Article;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ArticleService {

    /**
     * 搜索文章
     *
     * @param pageNum
     * @param title
     * @param categoryCode
     * @return
     */
    List<Article> searchArticles(int pageNum, String title, String categoryCode);

    /**
     * 保存文章
     *
     * @param article
     * @param files
     * @throws FileUploadException
     */
    void saveArticleWithAttachments(Article article, MultipartFile[] files) throws FileUploadException;

    /**
     * 查找文章
     *
     * @param id
     * @return
     */
    Article findArticleById(Long id);

    /**
     * 更新文章
     *
     * @param article
     */
    void updateArticle(Article article);

    /**
     * 删除文章
     *
     * @param id
     */
    void deleteArticle(Long id);

}
