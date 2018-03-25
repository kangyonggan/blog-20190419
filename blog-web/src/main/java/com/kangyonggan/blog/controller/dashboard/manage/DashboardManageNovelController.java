package com.kangyonggan.blog.controller.dashboard.manage;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.NovelService;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.blog.vo.Novel;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("dashboard/manage/novel")
public class DashboardManageNovelController extends BaseController {

    @Autowired
    private NovelService novelService;

    @Autowired
    private CategoryService categoryService;

    /**
     * 小说管理
     *
     * @param pageNum
     * @param code
     * @param name
     * @param author
     * @param categoryCode
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_NOVEL")
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "code", required = false, defaultValue = "") String code,
                        @RequestParam(value = "name", required = false, defaultValue = "") String name,
                        @RequestParam(value = "author", required = false, defaultValue = "") String author,
                        @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode,
                        Model model) {
        List<Novel> novels = novelService.searchNovels(pageNum, AppConstants.PAGE_SIZE, code, name, author, categoryCode);
        PageInfo<Novel> page = new PageInfo(novels);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.NOVEL.getType());

        model.addAttribute("page", page);
        model.addAttribute("categories", categories);
        return getPathList();
    }

    /**
     * 删除/恢复
     *
     * @param code
     * @param isDeleted
     * @param model
     * @return
     */
    @RequestMapping(value = "{code:[\\d]+}/{isDeleted:\\bundelete\\b|\\bdelete\\b}", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @RequiresPermissions("MANAGE_NOVEL")
    public String delete(@PathVariable("code") Integer code, @PathVariable("isDeleted") String isDeleted, Model model) {
        Novel novel = novelService.findNovelByCode(code);
        novel.setIsDeleted((byte) (isDeleted.equals("delete") ? 1 : 0));
        novelService.updateNovel(novel);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.NOVEL.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("novel", novel);
        return getPathTableTr();
    }

    /**
     * 物理删除
     *
     * @param code
     * @return
     */
    @RequestMapping(value = "{code:[\\d]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_NOVEL")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("code") Integer code) {
        novelService.deleteNovel(code);
        return super.getResultMap();
    }

    /**
     * 从此处开始更新小说
     *
     * @param code
     * @return
     */
    @RequestMapping(value = "{code:[\\d]+}/update", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_NOVEL")
    @ResponseBody
    public Map<String, Object> updateNow(@PathVariable("code") Integer code) {
        new Thread() {
            @Override
            public void run() {
                novelService.updateNovelFromNow(code);
            }
        }.start();
        return super.getResultMap();
    }

    /**
     * 更新所有小说
     *
     * @return
     */
    @RequestMapping(value = "update", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_NOVEL")
    @ResponseBody
    public Map<String, Object> updateAll() {
        new Thread() {
            @Override
            public void run() {
                novelService.updateNovelFromNow(novelService.findLastNovelCode());
            }
        }.start();
        return super.getResultMap();
    }

}