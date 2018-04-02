package com.kangyonggan.blog.dto.response;

import lombok.Data;

import java.io.Serializable;

/**
 * @author kangyonggan
 * @date 8/11/17
 */
@Data
public class CommonResponse implements Serializable {

    private static final long serialVersionUID = 1L;

    private String respCo;

    private String respMsg;

}
