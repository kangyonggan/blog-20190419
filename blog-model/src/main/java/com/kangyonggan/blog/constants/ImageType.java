package com.kangyonggan.blog.constants;

import lombok.Getter;

/**
 * @author kangyonggan
 * @date 4/2/18
 */
public enum ImageType {

    /**
     * gif
     */
    GIF("image/gif"),

    /**
     * png
     */
    PNG("image/png"),

    /**
     * jpeg
     */
    JPEG("image/jpeg");

    /**
     * 图片类型
     */
    @Getter
    private final String type;

    ImageType(String type) {
        this.type = type;
    }

}
