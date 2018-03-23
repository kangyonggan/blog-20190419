package com.kangyonggan.blog.controller.dashboard.manage;

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
import org.apache.commons.fileupload.FileUploadException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("dashboard/manage/article")
public class DashboardManageArticleController extends BaseController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AttachmentService attachmentService;

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
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());

        model.addAttribute("page", page);
        model.addAttribute("categories", categories);
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
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("article", new Article());
        return getPathForm();
    }

    /**
     * 保存文章
     *
     * @param article
     * @param result
     * @param files
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_ARTICLE")
    public Map<String, Object> save(@ModelAttribute("article") @Valid Article article, BindingResult result,
                                    @RequestParam(value = "files", required = false) MultipartFile[] files) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            articleService.saveArticleWithAttachments(article, files);
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
    public String edit(@PathVariable("id") Long id, Model model) {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());
        List<Attachment> attachments = attachmentService.findAttachmentsByTypeAndSourceId(AttachmentType.ARTICLE.getType(), id);

        model.addAttribute("categories", categories);
        model.addAttribute("attachments", attachments);
        model.addAttribute("article", articleService.findArticleById(id));
        return getPathForm();
    }

    /**
     * 文章详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_ARTICLE")
    public String detail(@PathVariable("id") Long id, Model model) {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());
        List<Attachment> attachments = attachmentService.findAttachmentsByTypeAndSourceId(AttachmentType.ARTICLE.getType(), id);
        Article article = articleService.findArticleById(id);
        article.setContent(MarkdownUtil.markdownToHtml(article.getContent()));

        model.addAttribute("categories", categories);
        model.addAttribute("attachments", attachments);
        model.addAttribute("article", article);
        return getPathDetail();
    }

    /**
     * 更新文章
     *
     * @param article
     * @param result
     * @param files
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_ARTICLE")
    public Map<String, Object> update(@ModelAttribute("article") @Valid Article article, BindingResult result,
                                      @RequestParam(value = "files", required = false) MultipartFile[] files) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            articleService.updateArticleWithAttachments(article, files);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 删除附件
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "deleteAttachment/{id:[\\d]+}", method = RequestMethod.GET)
    @ResponseBody
    @RequiresPermissions("MANAGE_ARTICLE")
    public Map<String, Object> deleteAttachment(@PathVariable("id") Long id) {
        attachmentService.deleteAttachment(id);

        return getResultMap();
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
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("article", article);
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
