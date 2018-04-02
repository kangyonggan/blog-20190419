package com.kangyonggan.blog.constants;

import lombok.Getter;

/**
 * 栏目类型
 */
public enum CategoryType {

    /**
     * 文章
     */
    ARTICLE("ARTICLE", "文章"),

    /**
     * 小说
     */
    NOVEL("NOVEL", "小说"),

    /**
     * 音乐
     */
    MUSIC("MUSIC", "音乐"),

    /**
     * 生活
     */
    LIFE("LIFE", "生活");

    /**
     * 栏目类型
     */
    @Getter
    private String type;

    /**
     * 类型名称
     */
    @Getter
    private String name;

    CategoryType(String type, String name) {
        this.type = type;
        this.name = name;
    }

}
