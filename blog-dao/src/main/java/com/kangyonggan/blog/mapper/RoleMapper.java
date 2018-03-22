package com.kangyonggan.blog.mapper;

import com.kangyonggan.blog.vo.Role;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RoleMapper extends MyMapper<Role> {

    /**
     * 查找用户角色
     *
     * @param username
     * @return
     */
    List<Role> selectRolesByUsername(@Param("username") String username);

    /**
     * 删除用户所有角色
     *
     * @param username
     */
    void deleteAllRolesByUsername(@Param("username") String username);

    /**
     * 删除角色菜单
     *
     * @param code
     */
    void deleteRoleMenus(@Param("code") String code);

    /**
     * 插入角色菜单
     *
     * @param code
     * @param menuCodes
     */
    void insertRoleMenus(@Param("code") String code, @Param("menuCodes") List<String> menuCodes);

}