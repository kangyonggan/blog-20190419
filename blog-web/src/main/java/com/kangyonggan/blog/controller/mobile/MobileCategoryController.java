package com.kangyonggan.blog.controller.mobile;

import com.kangyonggan.blog.constants.Resp;
import com.kangyonggan.blog.dto.response.CategoriesResponse;
import com.kangyonggan.blog.service.CategoryService;
import com.kangyonggan.blog.vo.Category;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @author kangyonggan
 * @date 8/24/17
 */
@RestController
@RequestMapping("mobile/category")
@Log4j2
public class MobileCategoryController {

    @Autowired
    private CategoryService categoryService;

    /**
     * 查找所有分类
     *
     * @return
     */
    @RequestMapping(value = "all", method = RequestMethod.POST)
    public CategoriesResponse categories() {
        CategoriesResponse response = new CategoriesResponse();

        try {
            List<Category> categories = categoryService.findAllCategoryWithNovelCount();
            response.setCategories(categories);
            response.setRespCo(Resp.SUCCESS.getRespCo());
            response.setRespMsg(Resp.SUCCESS.getRespMsg());
        } catch (Exception e) {
            log.warn("查询小说全部分类异常", e);
            response.setRespCo(Resp.FAILURE.getRespCo());
            response.setRespMsg(Resp.FAILURE.getRespMsg());
        }

        return response;
    }
}
