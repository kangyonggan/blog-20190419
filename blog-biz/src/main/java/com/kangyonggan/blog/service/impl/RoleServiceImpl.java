package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.MonitorType;
import com.kangyonggan.blog.mapper.RoleMapper;
import com.kangyonggan.blog.service.RoleService;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Role;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.Arrays;
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
    @Log
    @Cache(key = "role:username:${username}")
    public List<Role> findRolesByUsername(String username) {
        return roleMapper.selectRolesByUsername(username);
    }

    @Override
    @Log
    public boolean existsRoleCode(String code) {
        Role role = new Role();
        role.setCode(code);

        return super.exists(role);
    }

    @Override
    @Log
    @Cache(key = "role:all")
    public List<Role> findAllRoles() {
        Role role = new Role();
        role.setIsDeleted(AppConstants.IS_DELETED_NO);

        return myMapper.select(role);
    }

    @Override
    public List<Role> searchRoles(int pageNum, String code, String name) {
        Example example = new Example(Role.class);

        Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotEmpty(code)) {
            criteria.andLike("code", StringUtil.toLikeString(code));
        }
        if (StringUtils.isNotEmpty(name)) {
            criteria.andLike("name", StringUtil.toLikeString(name));
        }

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, AppConstants.PAGE_SIZE);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.INSERT, description = "保存角色${role.code}")
    public void saveRole(Role role) {
        myMapper.insertSelective(role);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.UPDATE, description = "更新角色${role.code}")
    @CacheDel(key = {"role:code:${role.code}", "role:all", "role:username*", "menu:username*"})
    public void updateRole(Role role) {
        Example example = new Example(Role.class);
        example.createCriteria().andEqualTo("code", role.getCode());

        myMapper.updateByExampleSelective(role, example);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.UPDATE, description = "更新角色菜单${code}, ${menuCodes}")
    @CacheDel(key = {"menu:role:${code}", "menu:username*"})
    public void updateRoleMenus(String code, String menuCodes) {
        deleteRoleMenus(code);

        if (StringUtils.isNotEmpty(menuCodes)) {
            roleMapper.insertRoleMenus(code, Arrays.asList(menuCodes.split(",")));
        }
    }

    @Override
    @Log
    @Cache(key = "role:code:${code}")
    public Role findRoleByCode(String code) {
        Role role = new Role();
        role.setCode(code);

        return myMapper.selectOne(role);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.DELETE, description = "删除角色${code}")
    @CacheDel(key = {"role:code:${code}", "role:all", "role:username*", "menu:username*"})
    public void deleteRoleByCode(String code) {
        Role role = new Role();
        role.setCode(code);

        myMapper.delete(role);
    }

    /**
     * 删除角色菜单
     *
     * @param code
     */
    private void deleteRoleMenus(String code) {
        roleMapper.deleteRoleMenus(code);
    }
}
