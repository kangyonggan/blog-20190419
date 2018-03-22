package com.kangyonggan.blog.controller.dashboard.system;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.vo.Category;
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

/**
 * @author kangyonggan
 * @since 2017/1/9
 */
@Controller
@RequestMapping("dashboard/system/category")
public class DashboardSystemCategoryController extends BaseController {

    @Autowired
    private CategoryService categoryService;

    /**
     * 栏目管理
     *
     * @param pageNum
     * @param code
     * @param name
     * @param type
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("SYSTEM_CATEGORY")
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "code", required = false, defaultValue = "") String code,
                        @RequestParam(value = "name", required = false, defaultValue = "") String name,
                        @RequestParam(value = "type", required = false, defaultValue = "") String type,
                        Model model) {
        List<Category> categories = categoryService.searchCategories(pageNum, code, name, type);
        PageInfo<Category> page = new PageInfo(categories);

        model.addAttribute("page", page);
        model.addAttribute("types", CategoryType.values());
        return getPathList();
    }

    /**
     * 添加栏目
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @RequiresPermissions("SYSTEM_CATEGORY")
    public String create(Model model) {
        model.addAttribute("category", new Category());
        model.addAttribute("types", CategoryType.values());
        return getPathFormModal();
    }

    /**
     * 保存栏目
     *
     * @param category
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("SYSTEM_CATEGORY")
    public Map<String, Object> save(@ModelAttribute("category") @Valid Category category, BindingResult result) {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            categoryService.saveCategory(category);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 编辑栏目
     *
     * @param code
     * @param model
     * @return
     */
    @RequestMapping(value = "{code:[\\w_]+}/edit", method = RequestMethod.GET)
    @RequiresPermissions("SYSTEM_CATEGORY")
    public String create(@PathVariable("code") String code, Model model) {
        model.addAttribute("types", CategoryType.values());
        model.addAttribute("category", categoryService.findCategoryByCode(code));
        return getPathFormModal();
    }

    /**
     * 更新栏目
     *
     * @param category
     * @param result
     * @return
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("SYSTEM_CATEGORY")
    public Map<String, Object> update(@ModelAttribute("category") @Valid Category category, BindingResult result) {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            categoryService.updateCategory(category);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 删除/恢复
     *
     * @param code
     * @param isDeleted
     * @param model
     * @return
     */
    @RequestMapping(value = "{code:[\\w_]+}/{isDeleted:\\bundelete\\b|\\bdelete\\b}", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @RequiresPermissions("SYSTEM_CATEGORY")
    public String delete(@PathVariable("code") String code, @PathVariable("isDeleted") String isDeleted, Model model) {
        Category category = categoryService.findCategoryByCode(code);
        category.setIsDeleted((byte) (isDeleted.equals("delete") ? 1 : 0));
        categoryService.updateCategory(category);

        model.addAttribute("category", category);
        model.addAttribute("types", CategoryType.values());
        return getPathTableTr();
    }

    /**
     * 物理删除
     *
     * @param code
     * @return
     */
    @RequestMapping(value = "{code:[\\w_]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("SYSTEM_CATEGORY")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("code") String code) {
        categoryService.deleteCategoryByCode(code);
        return super.getResultMap();
    }

}
