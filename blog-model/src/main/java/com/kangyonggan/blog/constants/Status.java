package com.kangyonggan.blog.constants;

import lombok.Getter;

/**
 * @author kangyonggan
 * @date 5/5/17
 */
public enum Status {

    /**
     * 待审核
     */
    WAITING("WAITING", "待审核"),

    /**
     * 审核通过
     */
    COMPLETE("COMPLETE", "审核通过"),

    /**
     * 拒绝
     */
    REJECT("REJECT", "拒绝");

    /**
     * 状态
     */
    @Getter
    private final String status;

    /**
     * 状态名称
     */
    @Getter
    private final String name;

    Status(String status, String name) {
        this.status = status;
        this.name = name;
    }

}
