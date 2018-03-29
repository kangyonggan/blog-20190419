package com.kangyonggan.blog.controller.dashboard.manage;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.dto.ShiroUser;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.MusicService;
import com.kangyonggan.blog.service.UserService;
import com.kangyonggan.blog.util.FileUpload;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.blog.vo.Music;
import com.kangyonggan.blog.vo.User;
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
@RequestMapping("dashboard/manage/music")
public class DashboardManageMusicController extends BaseController {

    @Autowired
    private MusicService musicService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserService userService;

    /**
     * 音乐管理
     *
     * @param pageNum
     * @param name
     * @param singer
     * @param album
     * @param categoryCode
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_MUSIC")
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "name", required = false, defaultValue = "") String name,
                        @RequestParam(value = "singer", required = false, defaultValue = "") String singer,
                        @RequestParam(value = "album", required = false, defaultValue = "") String album,
                        @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode,
                        Model model) {
        List<Music> musics = musicService.searchMusics(pageNum, AppConstants.PAGE_SIZE, name, singer, album, categoryCode);
        PageInfo<Music> page = new PageInfo(musics);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.MUSIC.getType());

        model.addAttribute("page", page);
        model.addAttribute("categories", categories);
        return getPathList();
    }

    /**
     * 添加音乐
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_MUSIC")
    public String create(Model model) {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.MUSIC.getType());

        model.addAttribute("categories", categories);
        return getPathFormModal();
    }

    /**
     * 保存音乐
     *
     * @param music
     * @param result
     * @param file
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_MUSIC")
    public Map<String, Object> save(@ModelAttribute("music") @Valid Music music, BindingResult result,
                                    @RequestParam(value = "file", required = false) MultipartFile file) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            String fileName = FileUpload.upload(file, "MUSIC");
            User user = userService.findUserByUsername(userService.getShiroUser().getUsername());
            musicService.saveMusic(fileName, music.getCategoryCode(), user.getRealname(), music.getUploadRemark());
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
    @RequiresPermissions("MANAGE_MUSIC")
    public String delete(@PathVariable("id") Long id, @PathVariable("isDeleted") String isDeleted, Model model) {
        Music music = musicService.findMusicById(id);
        music.setIsDeleted((byte) (isDeleted.equals("delete") ? 1 : 0));
        musicService.updateMusic(music);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.MUSIC.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("music", music);
        return getPathTableTr();
    }

    /**
     * 物理删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_MUSIC")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("id") Long id) {
        musicService.deleteMusic(id);
        return super.getResultMap();
    }


    /**
     * 编辑音乐
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/edit", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_MUSIC")
    public String edit(@PathVariable("id") Long id, Model model) {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.MUSIC.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("music", musicService.findMusicById(id));
        return getPathRoot() + "/edit-modal";
    }

    /**
     * 更新音乐
     *
     * @param music
     * @param result
     * @return
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_MUSIC")
    public Map<String, Object> update(@ModelAttribute("music") @Valid Music music, BindingResult result) {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            musicService.updateMusic(music);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 审核通过/审核不通过
     *
     * @param id
     * @param status
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/{status:\\bCOMPLETE\\b|\\bREJECT\\b|\\bWAITING\\b}", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @RequiresPermissions("MANAGE_MUSIC")
    public String status(@PathVariable("id") Long id, @PathVariable("status") String status, Model model) {
        ShiroUser shiroUser = userService.getShiroUser();
        Music music = musicService.findMusicById(id);

        music.setStatus(status);
        music.setAdjustUsername(shiroUser.getUsername());
        musicService.updateMusic(music);

        List<Category> categories = categoryService.findCategoriesByType(CategoryType.MUSIC.getType());

        model.addAttribute("categories", categories);
        model.addAttribute("music", music);
        return getPathTableTr();
    }
}
