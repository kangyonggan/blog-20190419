package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.MusicService;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.blog.vo.Music;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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

}
