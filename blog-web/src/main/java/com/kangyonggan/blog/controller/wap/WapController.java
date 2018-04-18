package com.kangyonggan.blog.controller.wap;

import com.kangyonggan.blog.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author kangyonggan
 * @date 4/18/18
 */
@Controller
@RequestMapping("wap")
public class WapController extends BaseController {

    /**
     * wap首页
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return getPathIndex();
    }

}
