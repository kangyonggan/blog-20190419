package com.kangyonggan.blog.constants;

/**
 * 响应码枚举
 *
 * @author kangyonggan
 * @since 3/16/18
 */
public enum Resp {

    SUCCESS("0000", "操作成功"),
    FAILURE("9999", "未知错误，请联系管理员！");

    String respCo;

    String respMsg;

    Resp(String respCo, String respMsg) {
        this.respCo = respCo;
        this.respMsg = respMsg;
    }

    public String getRespCo() {
        return respCo;
    }

    public String getRespMsg() {
        return respMsg;
    }
}
