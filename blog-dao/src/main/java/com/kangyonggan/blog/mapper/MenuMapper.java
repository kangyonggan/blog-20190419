package com.kangyonggan.blog.mapper;

import com.kangyonggan.blog.vo.Menu;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MenuMapper extends MyMapper<Menu> {

    /**
     * 查找用户菜单
     *
     * @param username
     * @return
     */
    List<Menu> selectMenusByUsername(@Param("username") String username);
}