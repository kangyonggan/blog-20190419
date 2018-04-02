package com.kangyonggan.blog.dto.response;

import com.kangyonggan.blog.vo.Novel;
import lombok.Data;

import java.util.List;

/**
 * @author kangyonggan
 * @date 8/11/17
 */
@Data
public class NovelsResponse extends CommonResponse {

    private List<Novel> novels;

}


