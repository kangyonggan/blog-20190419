package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Guest;

import java.util.List;

/**
 * @author kangyonggan
 * @date 3/24/18
 */
public interface GuestService {

    /**
     * 查询留言信息
     *
     * @param pageNum
     * @return
     */
    List<Guest> findGuestsByPage(int pageNum);

    /**
     * 判断ip是不是灌水
     *
     * @param ip
     * @return
     */
    boolean isQuickWrite(String ip);

    /**
     * 保存留言
     *
     * @param guest
     */
    void saveGuest(Guest guest);

    /**
     * 更新留言ip信息
     *
     * @param id
     * @param ip
     */
    void updateGuestIpInfo(Long id, String ip);

    /**
     * 搜索留言
     *
     * @param pageNum
     * @param status
     * @return
     */
    List<Guest> searchGuest(int pageNum, String status);

    /**
     * 查找留言
     *
     * @param id
     * @return
     */
    Guest findGuestById(Long id);

    /**
     * 更新留言
     *
     * @param guest
     */
    void updateGuest(Guest guest);

    /**
     * 删除留言
     *
     * @param id
     */
    void deleteGuestById(Long id);
}
