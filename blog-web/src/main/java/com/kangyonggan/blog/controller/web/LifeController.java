package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.service.AttachmentService;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.LifeService;
import com.kangyonggan.blog.util.MarkdownUtil;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.blog.vo.Life;
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
 * @since 3/16/18
 */
@Controller
@RequestMapping("life")
public class LifeController extends BaseController {

    @Autowired
    private LifeService lifeService;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AttachmentService attachmentService;

    /**
     * 生活列表
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
        List<Life> lifes = lifeService.findSomeLife(pageNum, AppConstants.PAGE_SIZE / 2, categoryCode);
        PageInfo<Life> page = new PageInfo<>(lifes);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.LIFE.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        model.addAttribute("page", page);
        return getPathList();
    }

    /**
     * 生活详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.GET)
    public String detail(@PathVariable("id") Long id, Model model) {
        Life life = lifeService.findLifeById(id);
        life.setContent(MarkdownUtil.markdownToHtml(life.getContent()));
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.LIFE.getType());
        List<Attachment> attachments = attachmentService.findAttachmentsByTypeAndSourceId(AttachmentType.LIFE.getType(), id);
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("life", life);
        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        model.addAttribute("attachments", attachments);
        return getPathDetail();
    }

}
