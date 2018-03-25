package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
@Controller
@RequestMapping("search")
public class SearchController extends BaseController {

    /**
     * 搜索
     *
     * @param key
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(@RequestParam(value = "key", required = false, defaultValue = "") String key,
                        Model model) {

        model.addAttribute("key", key);
        return getPathIndex();
    }

}
