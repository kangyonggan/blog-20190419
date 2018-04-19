package com.kangyonggan.blog.controller.wap;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
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
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @date 4/18/18
 */
@Controller
@RequestMapping("wap/article")
public class WapArticleController extends BaseController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CategoryService categoryService;

    /**
     * 文章列表
     *
     * @param pageNum
     * @param categoryCode
     * @param sort
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                       @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode,
                       @RequestParam(value = "sort", required = false, defaultValue = "") String sort,
                       Model model) {
        List<Article> articles = articleService.findWapArticles(pageNum, 20, categoryCode, sort);
        PageInfo<Article> page = new PageInfo<>(articles);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("page", page);
        return getPathList();
    }

    /**
     * 文章列表
     *
     * @param pageNum
     * @param categoryCode
     * @param sort
     * @return
     */
    @RequestMapping(value = "page", method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> page(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                                    @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode,
                                    @RequestParam(value = "sort", required = false, defaultValue = "") String sort) {
        Map<String, Object> resultMap = getResultMap();
        List<Article> articles = articleService.findWapArticles(pageNum, 20, categoryCode, sort);
        PageInfo<Article> page = new PageInfo<>(articles);

        resultMap.put("page", page);
        return resultMap;
    }

}
