package com.kangyonggan.blog.constants;

import lombok.Getter;

/**
 * 栏目类型
 */
public enum CategoryType {

    ARTICLE("ARTICLE", "文章"),
    NOVEL("NOVEL", "小说"),
    MUSIC("MUSIC", "音乐"),
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
