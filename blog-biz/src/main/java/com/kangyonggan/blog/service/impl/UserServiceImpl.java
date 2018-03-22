package com.kangyonggan.blog.service.impl;

import com.kangyonggan.blog.dto.ShiroUser;
import com.kangyonggan.blog.service.UserService;
import com.kangyonggan.blog.vo.User;
import com.kangyonggan.extra.core.annotation.Cache;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;

/**
 * @author kangyonggan
 * @since 3/22/18
 */
@Service
public class UserServiceImpl extends BaseService<User> implements UserService {

    @Override
    @Cache(key = "user:username:${username}")
    public User findUserByUsername(String username) {
        User user = new User();
        user.setUsername(username);
        return myMapper.selectOne(user);
    }

    @Override
    public ShiroUser getShiroUser() {
        return (ShiroUser) SecurityUtils.getSubject().getPrincipal();
    }
}
