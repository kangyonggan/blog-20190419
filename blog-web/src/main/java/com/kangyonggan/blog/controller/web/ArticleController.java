package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author kangyonggan
 * @since 3/16/18
 */
@Controller
@RequestMapping("article")
public class ArticleController extends BaseController {

    /**
     * 文章列表
     *
     * @param pageNum
     * @param categoryCode
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                       @RequestParam(value = "categoryCode", required = false, defaultValue = "") String categoryCode) {
        return getPathList();
    }

    /**
     * 文章详情
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.GET)
    public String detail(@PathVariable("id") Long id) {
        return getPathDetail();
    }

}
