package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Music;

import java.util.List;

/**
 * @author kangyonggan
 * @date 3/28/18
 */
public interface MusicService {

    /**
     * 保存音乐
     *
     * @param fileName
     * @param categoryCode
     * @param uploadUsername
     * @param uploadRemark
     * @return 返回异常信息
     */
    String saveMusic(String fileName, String categoryCode, String uploadUsername, String uploadRemark);

    /**
     * 查找音乐
     *
     * @param pageNum
     * @param pageSize
     * @param categoryCode
     * @return
     */
    List<Music> findMusicsByCategory(int pageNum, int pageSize, String categoryCode);

    /**
     * 搜索音乐
     *
     * @param pageNum
     * @param pageSize
     * @param name
     * @param singer
     * @param album
     * @param categoryCode
     * @return
     */
    List<Music> searchMusics(int pageNum, int pageSize, String name, String singer, String album, String categoryCode);

    /**
     * 查找音乐
     *
     * @param id
     * @return
     */
    Music findMusicById(Long id);

    /**
     * 更新音乐
     *
     * @param music
     */
    void updateMusic(Music music);

    /**
     * 删除音乐
     *
     * @param id
     */
    void deleteMusic(Long id);

    /**
     * 搜索音乐
     *
     * @param pageNum
     * @param pageSize
     * @param key
     * @return
     */
    List<Music> searchMusics(int pageNum, int pageSize, String key);
}
