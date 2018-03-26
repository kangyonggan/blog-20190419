package com.kangyonggan.blog.dto.response;

import com.kangyonggan.blog.vo.Category;
import lombok.Data;

import java.util.List;

/**
 * @author kangyonggan
 * @since 8/11/17
 */
@Data
public class CategoriesResponse extends CommonResponse {

    private List<Category> categories;

}
