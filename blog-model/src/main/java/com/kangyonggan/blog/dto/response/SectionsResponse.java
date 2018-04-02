package com.kangyonggan.blog.dto.response;

import com.kangyonggan.blog.vo.Section;
import lombok.Data;

import java.util.List;

/**
 * @author kangyonggan
 * @date 8/11/17
 */
@Data
public class SectionsResponse extends CommonResponse {

    private List<Section> sections;

}


