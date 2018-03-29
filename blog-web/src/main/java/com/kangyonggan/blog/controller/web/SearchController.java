package com.kangyonggan.blog.controller.web;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.CategoryType;
import com.kangyonggan.blog.service.ArticleService;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.service.MusicService;
import com.kangyonggan.blog.service.NovelService;
import com.kangyonggan.blog.vo.Article;
import com.kangyonggan.blog.vo.Category;
import com.kangyonggan.blog.vo.Music;
import com.kangyonggan.blog.vo.Novel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
@Controller
@RequestMapping("search")
public class SearchController {

    @Autowired
    private ArticleService articleService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private NovelService novelService;

    @Autowired
    private MusicService musicService;

    /**
     * 搜索
     *
     * @param key
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String search(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                         @RequestParam(value = "key", required = false, defaultValue = "") String key,
                         @RequestParam("type") String type,
                         Model model) {
        if (type.equals(CategoryType.NOVEL.getType())) {
            return searchNovel(pageNum, key, model);
        } else if (type.equals(CategoryType.MUSIC.getType())) {
            return searchMusic(pageNum, key, model);
        } else {
            return searchArticle(pageNum, key, model);
        }
    }

    /**
     * 搜索音乐
     *
     * @param pageNum
     * @param key
     * @param model
     * @return
     */
    private String searchMusic(int pageNum, String key, Model model) {
        List<Music> musics = musicService.searchMusics(pageNum, 8, key);
        PageInfo<Music> page = new PageInfo<>(musics);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        model.addAttribute("page", page);
        return "web/music/index";
    }

    /**
     * 搜索文章
     *
     * @param key
     * @param model
     * @return
     */
    private String searchArticle(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                                 @RequestParam(value = "key", required = false, defaultValue = "") String key,
                                 Model model) {
        List<Article> articles = articleService.searchArticles(pageNum, 8, key);
        PageInfo<Article> page = new PageInfo<>(articles);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.ARTICLE.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        model.addAttribute("page", page);
        return "web/article/list";
    }

    /**
     * 搜索小说
     *
     * @param key
     * @param model
     * @return
     */
    private String searchNovel(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                               @RequestParam(value = "key", required = false, defaultValue = "") String key,
                               Model model) {
        List<Novel> novels = novelService.searchNovels(pageNum, 20, key);
        PageInfo<Novel> page = new PageInfo<>(novels);
        List<Category> categories = categoryService.findCategoriesByType(CategoryType.NOVEL.getType());
        List<Article> topArticles = articleService.findTopArticles();

        model.addAttribute("page", page);
        model.addAttribute("categories", categories);
        model.addAttribute("topArticles", topArticles);
        return "web/novel/index";
    }

}
