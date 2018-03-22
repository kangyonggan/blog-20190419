package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Role;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/22/18
 */
public interface RoleService {

    /**
     * 查找用户角色
     *
     * @param username
     * @return
     */
    List<Role> findRolesByUsername(String username);
}
