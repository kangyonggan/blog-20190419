package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.GuestBook;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/24/18
 */
public interface GuestBookService {

    /**
     * 查询留言信息
     *
     * @param pageNum
     * @return
     */
    List<GuestBook> findGuestBooksByPage(int pageNum);

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
     * @param guestBook
     */
    void saveGuestBook(GuestBook guestBook);

    /**
     * 更新留言ip信息
     *
     * @param id
     * @param ip
     */
    void updateGuestBookIpInfo(Long id, String ip);
}
