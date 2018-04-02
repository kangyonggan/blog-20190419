package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Role;

import java.util.List;

/**
 * @author kangyonggan
 * @date 3/22/18
 */
public interface RoleService {

    /**
     * 查找用户角色
     *
     * @param username
     * @return
     */
    List<Role> findRolesByUsername(String username);

    /**
     * 校验角色代码是否存在
     *
     * @param code
     * @return
     */
    boolean existsRoleCode(String code);

    /**
     * 查找所有角色
     *
     * @return
     */
    List<Role> findAllRoles();

    /**
     * 搜索角色
     *
     * @param pageNum
     * @param code
     * @param name
     * @return
     */
    List<Role> searchRoles(int pageNum, String code, String name);

    /**
     * 保存角色
     *
     * @param role
     */
    void saveRole(Role role);

    /**
     * 更新角色
     *
     * @param role
     */
    void updateRole(Role role);

    /**
     * 更新角色菜单
     *
     * @param code
     * @param menuCodes
     */
    void updateRoleMenus(String code, String menuCodes);

    /**
     * 查找角色
     *
     * @param code
     * @return
     */
    Role findRoleByCode(String code);

    /**
     * 删除角色
     *
     * @param code
     */
    void deleteRoleByCode(String code);
}
