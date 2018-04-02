package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.service.AttachmentService;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.util.MarkdownUtil;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.blog.vo.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author kangyonggan
 * @date 3/16/18
 */
@Controller
@RequestMapping("article")
public class ArticleController extends BaseController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AttachmentService attachmentService;

    /**
     * 文章列表
     *
     * @param pageNum
     * @param categoryCode
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                       @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode,
                       Model model) {
        List<Article> articles = articleService.findSomeArticles(pageNum, 8, categoryCode);
        PageInfo<Article> page = new PageInfo<>(articles);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        model.addAttribute("page", page);
        return getPathList();
    }

    /**
     * 文章详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.GET)
    public String detail(@PathVariable("id") Long id, Model model) {
        Article article = articleService.findArticleById(id);
        article.setContent(MarkdownUtil.markdownToHtml(article.getContent()));
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());
        List<Attachment> attachments = attachmentService.findAttachmentsByTypeAndSourceId(AttachmentType.ARTICLE.getType(), id);
        List<Article> topArticles = articleService.findTopArticles();
        Article prevArticle = articleService.finPrevArticle(id);
        Article nextArticle = articleService.finNextArticle(id);

        model.addAttribute("article", article);
        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        model.addAttribute("attachments", attachments);
        model.addAttribute("prevArticle", prevArticle);
        model.addAttribute("nextArticle", nextArticle);
        return getPathDetail();
    }

}
