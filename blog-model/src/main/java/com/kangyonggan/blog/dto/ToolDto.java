package com.kangyonggan.blog.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * @author kangyonggan
 * @since 3/23/18
 */
@Data
public class ToolDto implements Serializable {

    /**
     * 通用数据字段
     */
    private String data;

    /**
     * 二维码大小
     */
    private int size;

}
