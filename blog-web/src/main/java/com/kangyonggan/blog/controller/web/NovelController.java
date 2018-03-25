package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.NovelService;
import com.kangyonggan.blog.service.SectionService;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.blog.vo.Novel;
import com.kangyonggan.blog.vo.Section;
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
 * @since 3/21/18
 */
@Controller
@RequestMapping("novel")
public class NovelController extends BaseController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private NovelService novelService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private SectionService sectionService;

    /**
     * 小说首页
     *
     * @param pageNum
     * @param categoryCode
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode,
                        Model model) {
        List<Novel> novels = novelService.findNovelsByCategory(pageNum, 20, categoryCode);
        PageInfo<Novel> page = new PageInfo<>(novels);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.NOVEL.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("page", page);
        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        return getPathIndex();
    }

    /**
     * 小说详情
     *
     * @param pageNum
     * @param code
     * @param model
     * @return
     */
    @RequestMapping(value = "{code:[\\d]+}", method = RequestMethod.GET)
    public String detail(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                         @PathVariable("code") Integer code, Model model) {
        Novel novel = novelService.findNovelByCode(code);
        List<Section> sections = sectionService.findSectionsByNovelCode(pageNum, 100, code);
        PageInfo<Section> page = new PageInfo<>(sections);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.NOVEL.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        model.addAttribute("page", page);
        model.addAttribute("novel", novel);
        return getPathDetail();
    }

}
