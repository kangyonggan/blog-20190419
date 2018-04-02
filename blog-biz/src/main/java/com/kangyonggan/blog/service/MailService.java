package com.kangyonggan.blog.service;

/**
 * @author kangyonggan
 * @date 4/12/17
 */
public interface MailService {

    /**
     * 异步发送邮件
     *
     * @param to
     * @param title
     * @param text
     */
    void send(String to, String title, String text);

}
