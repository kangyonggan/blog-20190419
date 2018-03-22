package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Menu;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/22/18
 */
public interface MenuService {

    /**
     * 查找用户菜单
     *
     * @param username
     * @return
     */
    List<Menu> findMenusByUsername(String username);
}
