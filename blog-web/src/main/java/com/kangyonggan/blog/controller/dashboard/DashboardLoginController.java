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
@RequestMapping("dashboard/login")
public class DashboardLoginController extends BaseController {

    /**
     * 登录界面
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return getPathIndex();
    }

}
