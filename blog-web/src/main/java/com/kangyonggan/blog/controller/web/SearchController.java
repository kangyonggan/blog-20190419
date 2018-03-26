package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
@Controller
@RequestMapping("search")
public class SearchController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CategoryService categoryService;

    /**
     * 搜索
     *
     * @param key
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "key", required = false, defaultValue = "") String key,
                        Model model) {
        List<Article> articles = articleService.searchArticles(pageNum, 8, key);
        PageInfo<Article> page = new PageInfo<>(articles);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        model.addAttribute("page", page);
        model.addAttribute("key", key);
        return "web/article/list";
    }

}
