package com.kangyonggan.blog.constants;

/**
 * 栏目类型
 */
public enum CategoryType {

    ARTICLE("ARTICLE", "博文"),
    NOVEL("NOVEL", "小说");

    private String type;
    private String name;

    CategoryType(String type, String name) {
        this.type = type;
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public String getName() {
        return name;
    }
}
