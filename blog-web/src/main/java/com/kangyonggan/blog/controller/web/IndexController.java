package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author kangyonggan
 * @since 3/16/18
 */
@Controller
@RequestMapping("/")
public class IndexController extends BaseController {

    /**
     * 首页
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return getPathRoot();
    }

}
