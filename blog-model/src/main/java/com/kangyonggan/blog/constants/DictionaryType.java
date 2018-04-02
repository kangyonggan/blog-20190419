package com.kangyonggan.blog.constants;

import lombok.Getter;

/**
 * @author kangyonggan
 * @since 5/5/17
 */
public enum DictionaryType {

    /**
     * 地区
     */
    AREA("AREA", "地区"),

    /**
     * ascll码
     */
    ASCLL("ASCLL", "ascll码"),

    /**
     * html转译字符
     */
    HTML("HTML", "html转译字符");

    /**
     * 字典类型
     */
    @Getter
    private final String type;

    /**
     * 类型名称
     */
    @Getter
    private final String name;

    DictionaryType(String type, String name) {
        this.type = type;
        this.name = name;
    }

}
