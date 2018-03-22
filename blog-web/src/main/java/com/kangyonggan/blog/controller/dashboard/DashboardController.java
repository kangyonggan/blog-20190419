package com.kangyonggan.blog.controller.dashboard;

import com.kangyonggan.blog.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author kangyonggan
 * @since 3/22/18
 */
@Controller
@RequestMapping("dashboard")
public class DashboardController extends BaseController {

    /**
     * 工作台模板
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String layout() {
        return getPathRoot() + "/layout";
    }

    /**
     * 工作台首页
     *
     * @return
     */
    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String index() {
        return getPathRoot() + "/index";
    }

}
