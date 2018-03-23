package com.kangyonggan.blog.constants;

/**
 * 附件类型
 */
public enum AttachmentType {

    ARTICLE("ARTICLE", "文章");

    private String type;
    private String name;

    AttachmentType(String type, String name) {
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
