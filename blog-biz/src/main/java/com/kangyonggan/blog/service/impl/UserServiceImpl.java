package com.kangyonggan.blog.service.impl;

import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.dto.ShiroUser;
import com.kangyonggan.blog.service.UserService;
import com.kangyonggan.blog.util.Digests;
import com.kangyonggan.blog.util.Encodes;
import com.kangyonggan.blog.vo.User;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

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

    @Override
    @Log
    @CacheDel(key = {"user:username:${user.username}", "role:username:${user.username}", "menu:username:${user.username}"})
    public void updateUserByUsername(User user) {
        Example example = new Example(User.class);
        example.createCriteria().andEqualTo("username", user.getUsername());
        myMapper.updateByExampleSelective(user, example);
    }

    @Override
    @Log
    @CacheDel(key = "user:username:${user.username}")
    public void updateUserPassword(User user) {
        User tUser = new User();
        tUser.setUsername(user.getUsername());
        tUser.setPassword(user.getPassword());
        tUser.setSalt(user.getSalt());

        entryptPassword(tUser);

        updateUserByUsername(tUser);
    }

    /**
     * 设定安全的密码，生成随机的salt并经过N次 sha-1 hash
     *
     * @param user
     */
    private void entryptPassword(User user) {
        byte[] salt = Digests.generateSalt(AppConstants.SALT_SIZE);
        user.setSalt(Encodes.encodeHex(salt));

        byte[] hashPassword = Digests.sha1(user.getPassword().getBytes(), salt, AppConstants.HASH_INTERATIONS);
        user.setPassword(Encodes.encodeHex(hashPassword));
    }
}
