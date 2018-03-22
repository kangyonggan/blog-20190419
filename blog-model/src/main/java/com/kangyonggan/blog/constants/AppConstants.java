package com.kangyonggan.blog.constants;

/**
 * @author kangyonggan
 * @since 3/16/18
 */
public interface AppConstants {

    /**
     * 响应码的key
     */
    String RESP_CO = "respCo";

    /**
     * 响应消息的key
     */
    String RESP_MSG = "respMsg";

    /**
     * Shiro常量
     */
    String HASH_ALGORITHM = "SHA-1";
    int HASH_INTERATIONS = 2;
    int SALT_SIZE = 8;

    /**
     * 把验证码存放在session中的key
     */
    String KEY_CAPTCHA = "key-captcha";

}
