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

}