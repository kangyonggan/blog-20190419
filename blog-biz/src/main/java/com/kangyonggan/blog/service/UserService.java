package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.User;

/**
 * @author kangyonggan
 * @since 3/22/18
 */
public interface UserService {

    /**
     * 查找用户
     *
     * @param username
     * @return
     */
    User findUserByUsername(String username);
}
