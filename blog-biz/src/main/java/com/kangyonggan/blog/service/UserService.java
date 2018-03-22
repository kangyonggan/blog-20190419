package com.kangyonggan.blog.service;

import com.kangyonggan.blog.dto.ShiroUser;
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

    /**
     * 获取用户登录信息
     *
     * @return
     */
    ShiroUser getShiroUser();
}