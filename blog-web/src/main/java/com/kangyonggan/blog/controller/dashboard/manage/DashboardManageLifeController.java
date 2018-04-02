package com.kangyonggan.blog.controller.dashboard.manage;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.AttachmentService;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.LifeService;
import com.kangyonggan.blog.util.MarkdownUtil;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.blog.vo.Life;
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

/**
 * @author kangyonggan
 * @date 2018/04/02
 */
@Controller
@RequestMapping("dashboard/manage/life")
public class DashboardManageLifeController extends BaseController {

    @Autowired
    private LifeService lifeService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AttachmentService attachmentService;

    /**
     * 生活管理
     *
     * @param pageNum
     * @param title
     * @param categoryCode
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_LIFE")
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "title", required = false, defaultValue = "") String title,
                        @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode,
                        Model model) {
        List<Life> lifes = lifeService.searchLifes(pageNum, AppConstants.PAGE_SIZE, title, categoryCode);
        PageInfo<Article> page = new PageInfo(lifes);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.LIFE.getType());

        model.addAttribute("page", page);
        model.addAttribute("categories", categories);
        return getPathList();
    }

    /**
     * 添加生活
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_LIFE")
    public String create(Model model) {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.LIFE.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("life", new Life());
        return getPathForm();
    }

    /**
     * 保存生活
     *
     * @param life
     * @param result
     * @param files
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_LIFE")
    public Map<String, Object> save(@ModelAttribute("life") @Valid Life life, BindingResult result,
                                    @RequestParam(value = "files", required = false) MultipartFile[] files) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            lifeService.saveLifeWithAttachments(life, files);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 编辑生活
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/edit", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_LIFE")
    public String edit(@PathVariable("id") Long id, Model model) {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.LIFE.getType());
        List<Attachment> attachments = attachmentService.findAttachmentsByTypeAndSourceId(AttachmentType.LIFE.getType(), id);

        model.addAttribute("categories", categories);
        model.addAttribute("attachments", attachments);
        model.addAttribute("life", lifeService.findLifeById(id));
        return getPathForm();
    }

    /**
     * 生活详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_LIFE")
    public String detail(@PathVariable("id") Long id, Model model) {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.LIFE.getType());
        List<Attachment> attachments = attachmentService.findAttachmentsByTypeAndSourceId(AttachmentType.LIFE.getType(), id);
        Life life = lifeService.findLifeById(id);
        life.setContent(MarkdownUtil.markdownToHtml(life.getContent()));

        model.addAttribute("categories", categories);
        model.addAttribute("attachments", attachments);
        model.addAttribute("life", life);
        return getPathDetail();
    }

    /**
     * 更新生活
     *
     * @param life
     * @param result
     * @param files
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_LIFE")
    public Map<String, Object> update(@ModelAttribute("life") @Valid Life life, BindingResult result,
                                      @RequestParam(value = "files", required = false) MultipartFile[] files) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            lifeService.updateLifeWithAttachments(life, files);
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
    @RequiresPermissions("MANAGE_LIFE")
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
    @RequiresPermissions("MANAGE_LIFE")
    public String delete(@PathVariable("id") Long id, @PathVariable("isDeleted") String isDeleted, Model model) {
        Life life = lifeService.findLifeById(id);
        life.setIsDeleted((byte) ("delete".equals(isDeleted) ? 1 : 0));
        lifeService.updateLife(life);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.LIFE.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("life", life);
        return getPathTableTr();
    }

    /**
     * 物理删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_LIFE")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("id") Long id) {
        lifeService.deleteLife(id);
        return super.getResultMap();
    }


}
