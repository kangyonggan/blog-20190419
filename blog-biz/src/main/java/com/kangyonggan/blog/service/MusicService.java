package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Music;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/28/18
 */
public interface MusicService {

    /**
     * 保存音乐
     *
     * @param fileName
     * @param uploadUsername
     * @param uploadRemark
     * @return 返回异常信息
     */
    String saveMusic(String fileName, String uploadUsername, String uploadRemark);

    /**
     * 查找音乐
     *
     * @param pageNum
     * @param pageSize
     * @param categoryCode
     * @return
     */
    List<Music> findMusicsByCategory(int pageNum, int pageSize, String categoryCode);
}
