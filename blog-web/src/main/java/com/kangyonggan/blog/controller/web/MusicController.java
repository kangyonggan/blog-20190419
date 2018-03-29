package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.MusicService;
import com.kangyonggan.blog.util.FileUpload;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.blog.vo.Music;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;

/**
 * @author kangyonggan
 * @since 3/24/18
 */
@Controller
@RequestMapping("music")
public class MusicController extends BaseController {

    @Autowired
    private MusicService musicService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ArticleService articleService;

    /**
     * 音乐首页
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
        List<Music> musics = musicService.findMusicsByCategory(pageNum, 20, categoryCode);
        PageInfo<Music> page = new PageInfo<>(musics);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.MUSIC.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("page", page);
        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        return getPathIndex();
    }

    /**
     * 上传音乐
     *
     * @return
     */
    @RequestMapping(value = "upload", method = RequestMethod.GET)
    public String upload(Model model) {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.MUSIC.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("topArticles", topArticles);
        model.addAttribute("categories", categories);
        return getPathRoot() + "/upload";
    }

    /**
     * 保存音乐
     *
     * @param music
     * @param result
     * @param file
     * @param model
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public String upload(@ModelAttribute("music") @Valid Music music, BindingResult result,
                         @RequestParam(value = "file", required = false) MultipartFile file,
                         Model model) throws FileUploadException {
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.MUSIC.getType());
        List<Article> topArticles = articleService.findTopArticles();

        if (!result.hasErrors()) {
            String fileName = FileUpload.upload(file, "MUSIC");
            String respMsg = musicService.saveMusic(fileName, music.getCategoryCode(), music.getUploadUsername(), music.getUploadRemark());
            model.addAttribute("respMsg", respMsg);
        } else {
            model.addAttribute("respMsg", "表单错误，请重新再试");
        }

        model.addAttribute("topArticles", topArticles);
        model.addAttribute("categories", categories);
        return getPathRoot() + "/result";
    }
}
