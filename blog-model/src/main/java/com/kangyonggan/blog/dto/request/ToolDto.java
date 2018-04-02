package com.kangyonggan.blog.dto.request;

import lombok.Data;

import java.io.Serializable;

/**
 * @author kangyonggan
 * @date 3/23/18
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

    /**
     * 字符集
     */
    private String charset;

    /**
     * 0: 阴历 / 1: 阳历
     */
    private String lunar;

    /**
     * 年份
     */
    private int year;

    /**
     * 月份
     */
    private int month;

    /**
     * 日期
     */
    private int day;

    /**
     * 时辰
     */
    private int hour;

}
