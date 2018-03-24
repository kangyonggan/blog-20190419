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

    /**
     * 数据库方言
     */
    private String dialect;

    /**
     * 省份
     */
    private String prov;

    /**
     * 起始年龄
     */
    private int startAge;

    /**
     * 截止年龄
     */
    private int endAge;

    /**
     * 性别，{0：男，1：女}
     */
    private String sex;

    /**
     * 身份证长度
     */
    private int len;

    /**
     * 数量
     */
    private int count;

}
