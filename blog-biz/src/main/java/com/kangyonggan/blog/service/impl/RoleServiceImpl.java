package com.kangyonggan.blog.service.impl;

import com.kangyonggan.blog.mapper.RoleMapper;
import com.kangyonggan.blog.service.RoleService;
import com.kangyonggan.blog.vo.Role;
import com.kangyonggan.extra.core.annotation.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/22/18
 */
@Service
public class RoleServiceImpl extends BaseService<Role> implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    @Cache(key = "role:username:${username}")
    public List<Role> findRolesByUsername(String username) {
        return roleMapper.selectRolesByUsername(username);
    }
}
