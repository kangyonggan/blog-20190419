package com.kangyonggan.blog.constants;

import lombok.Getter;


/**
 * 附件类型
 *
 * @author kangyonggan
 * @date 2018/04/02
 */
public enum AttachmentType {

    /**
     * 文章
     */
    ARTICLE("ARTICLE", "文章"),

    /**
     * 相册
     */
    PHOTO("PHOTO", "相册"),

    /**
     * 生活
     */
    LIFE("LIFE", "生活");

    /**
     * 附件类型
     */
    @Getter
    private String type;

    /**
     * 类型名称
     */
    @Getter
    private String name;

    AttachmentType(String type, String name) {
        this.type = type;
        this.name = name;
    }
}
