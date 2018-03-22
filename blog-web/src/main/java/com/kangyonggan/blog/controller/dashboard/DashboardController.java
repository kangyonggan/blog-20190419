package com.kangyonggan.blog.controller.dashboard;

import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.dto.ShiroUser;
import com.kangyonggan.blog.service.MenuService;
import com.kangyonggan.blog.service.UserService;
import com.kangyonggan.blog.vo.Menu;
import com.kangyonggan.blog.vo.User;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/22/18
 */
@Controller
@RequestMapping("dashboard")
public class DashboardController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    /**
     * 工作台模板
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("DASHBOARD")
    public String layout(Model model) {
        ShiroUser shiroUser = userService.getShiroUser();
        User user = userService.findUserByUsername(shiroUser.getUsername());
        List<Menu> menus = menuService.findMenusByUsername(shiroUser.getUsername());

        model.addAttribute("_user", user);
        model.addAttribute("_menus", menus);
        return getPathRoot() + "/layout";
    }

    /**
     * 工作台首页
     *
     * @return
     */
    @RequestMapping(value = "index", method = RequestMethod.GET)
    @RequiresPermissions("DASHBOARD")
    public String index() {
        return getPathRoot() + "/index";
    }


}
