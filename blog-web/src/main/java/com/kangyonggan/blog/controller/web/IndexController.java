package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.*;
import com.kangyonggan.blog.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
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

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private NovelService novelService;

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
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.NOVEL.getType());
        List<List<Novel>> novelsList = new ArrayList<>();
        for (Category category : categories) {
            novelsList.add(novelService.findNovelsByCategory(1, 6, category.getCode()));
        }

        model.addAttribute("articles", articles);
        model.addAttribute("tools", tools);
        model.addAttribute("lifes", lifes);
        model.addAttribute("categories", categories);
        model.addAttribute("novelsList", novelsList);
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
