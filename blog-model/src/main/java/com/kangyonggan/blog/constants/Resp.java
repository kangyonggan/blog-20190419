package com.kangyonggan.blog.constants;

import lombok.Getter;

/**
 * 响应码枚举
 *
 * @author kangyonggan
 * @since 3/16/18
 */
public enum Resp {

    SUCCESS("0000", "操作成功"),
    FAILURE("9999", "未知错误，请联系管理员！");

    /**
     * 响应码
     */
    @Getter
    String respCo;

    /**
     * 响应消息
     */
    @Getter
    String respMsg;

    Resp(String respCo, String respMsg) {
        this.respCo = respCo;
        this.respMsg = respMsg;
    }

}
