package com.kangyonggan.blog.constants;

import lombok.Getter;

/**
 * @author kangyonggan
 * @since 5/5/17
 */
public enum DictionaryType {

    AREA("AREA", "地区"),
    ASCLL("ASCLL", "ascll码"),
    HTML("HTML", "html转移字符");

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
