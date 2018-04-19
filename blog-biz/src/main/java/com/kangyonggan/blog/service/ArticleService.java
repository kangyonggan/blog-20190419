package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Article;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author kangyonggan
 * @date 2018/04/02
 */
public interface ArticleService {

    /**
     * 搜索文章
     *
     * @param pageNum
     * @param pageSize
     * @param title
     * @param categoryCode
     * @return
     */
    List<Article> searchArticles(int pageNum, int pageSize, String title, String categoryCode);

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
     * @param files
     * @throws FileUploadException
     */
    void updateArticleWithAttachments(Article article, MultipartFile[] files) throws FileUploadException;

    /**
     * 删除文章
     *
     * @param id
     */
    void deleteArticle(Long id);

    /**
     * 更新文章
     *
     * @param article
     */
    void updateArticle(Article article);

    /**
     * 查找推荐文章
     *
     * @return
     */
    List<Article> findTopArticles();

    /**
     * 查找一些文章
     *
     * @param pageNum
     * @param pageSize
     * @param categoryCode
     * @return
     */
    List<Article> findSomeArticles(int pageNum, int pageSize, String categoryCode);

    /**
     * 搜索文章
     *
     * @param pageNum
     * @param pageSize
     * @param key
     * @return
     */
    List<Article> searchArticles(int pageNum, int pageSize, String key);

    /**
     * 查找上一篇文章
     *
     * @param id
     * @return
     */
    Article finPrevArticle(Long id);

    /**
     * 查找下一篇文章
     *
     * @param id
     * @return
     */
    Article finNextArticle(Long id);

    /**
     * 查找wap文章
     *
     * @param pageNum
     * @param pageSize
     * @param categoryCode
     * @param sort
     * @return
     */
    List<Article> findWapArticles(int pageNum, int pageSize, String categoryCode, String sort);
}
