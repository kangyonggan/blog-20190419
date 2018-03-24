package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author kangyonggan
 * @since 3/24/18
 */
@Controller
@RequestMapping("photo")
public class PhotoController extends BaseController {

    /**
     * 相册
     *
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return getPathIndex();
    }

}
