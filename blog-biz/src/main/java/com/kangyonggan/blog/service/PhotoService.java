package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Photo;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/29/18
 */
public interface PhotoService {

    /**
     * 查找所有相册
     *
     * @return
     */
    List<Photo> findAllPhotos();

    /**
     * 查找相册
     *
     * @param id
     * @return
     */
    Photo findPhotoById(Long id);

    /**
     * 搜索相册
     *
     * @param pageNum
     * @param pageSize
     * @param title
     * @return
     */
    List<Photo> searchPhotos(int pageNum, int pageSize, String title);

    /**
     * 保存相册
     *
     * @param photo
     */
    void savePhoto(Photo photo);

    /**
     * 更新相册
     *
     * @param photo
     */
    void updatePhoto(Photo photo);

    /**
     * 删除相册
     *
     * @param id
     */
    void deletePhoto(Long id);

}
