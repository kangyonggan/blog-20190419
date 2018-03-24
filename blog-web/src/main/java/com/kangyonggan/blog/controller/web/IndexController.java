package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.service.LifeService;
import com.kangyonggan.blog.service.ToolService;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Life;
import com.kangyonggan.blog.vo.Tool;
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

    @Autowired
    private ToolService toolService;

    @Autowired
    private LifeService lifeService;

    /**
     * 首页
     *
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(Model model) {
        List<Article> articles = articleService.findSomeArticles(1, 6, null);
        List<Tool> tools = toolService.findSomeTools(6);
        List<Life> lifes = lifeService.findSomeLife(1, 4, null);

        model.addAttribute("articles", articles);
        model.addAttribute("tools", tools);
        model.addAttribute("lifes", lifes);
        return getPathRoot();
    }

    /**
     * 关于我
     *
     * @return
     */
    @RequestMapping(value = "about", method = RequestMethod.GET)
    public String about() {
        return "web/about";
    }

}
