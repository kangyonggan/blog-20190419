package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.vo.Article;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/16/18
 */
@Controller
@RequestMapping("/")
public class IndexController extends BaseController {

    @Autowired
    private ArticleService articleService;

    /**
     * 首页
     *
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(Model model) {
        List<Article> articles = articleService.searchArticles(1, 6, null, null);

        model.addAttribute("articles", articles);
        return getPathRoot();
    }

}
