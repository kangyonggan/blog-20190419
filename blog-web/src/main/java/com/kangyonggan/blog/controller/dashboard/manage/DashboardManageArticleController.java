package com.kangyonggan.blog.controller.dashboard.manage;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.vo.Article;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("dashboard/manage/article")
public class DashboardManageArticleController extends BaseController {

    @Autowired
    private ArticleService articleService;

    /**
     * 文章管理
     *
     * @param pageNum
     * @param title
     * @param categoryCode
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_ARTICLE")
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "title", required = false, defaultValue = "") String title,
                        @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode,
                        Model model) {
        List<Article> articles = articleService.searchArticles(pageNum, title, categoryCode);
        PageInfo<Article> page = new PageInfo(articles);

        model.addAttribute("page", page);
        model.addAttribute("types", CategoryType.values());
        return getPathList();
    }

    /**
     * 添加文章
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_ARTICLE")
    public String create(Model model) {
        model.addAttribute("article", new Article());
        model.addAttribute("types", CategoryType.values());
        return getPathForm();
    }

    /**
     * 保存文章
     *
     * @param article
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_ARTICLE")
    public Map<String, Object> save(@ModelAttribute("article") @Valid Article article, BindingResult result) {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            articleService.saveArticle(article);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 编辑文章
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/edit", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_ARTICLE")
    public String create(@PathVariable("id") Long id, Model model) {
        model.addAttribute("types", CategoryType.values());
        model.addAttribute("article", articleService.findArticleById(id));
        return getPathForm();
    }

    /**
     * 更新文章
     *
     * @param article
     * @param result
     * @return
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_ARTICLE")
    public Map<String, Object> update(@ModelAttribute("article") @Valid Article article, BindingResult result) {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            articleService.updateArticle(article);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 删除/恢复
     *
     * @param id
     * @param isDeleted
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/{isDeleted:\\bundelete\\b|\\bdelete\\b}", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @RequiresPermissions("MANAGE_ARTICLE")
    public String delete(@PathVariable("id") Long id, @PathVariable("isDeleted") String isDeleted, Model model) {
        Article article = articleService.findArticleById(id);
        article.setIsDeleted((byte) (isDeleted.equals("delete") ? 1 : 0));
        articleService.updateArticle(article);

        model.addAttribute("article", article);
        model.addAttribute("types", CategoryType.values());
        return getPathTableTr();
    }

    /**
     * 物理删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_ARTICLE")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("id") Long id) {
        articleService.deleteArticle(id);
        return super.getResultMap();
    }


}
