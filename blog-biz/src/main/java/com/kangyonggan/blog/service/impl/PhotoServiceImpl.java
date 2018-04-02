package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.MonitorType;
import com.kangyonggan.blog.service.PhotoService;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Photo;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author kangyonggan
 * @date 3/29/18
 */
@Service
public class PhotoServiceImpl extends BaseService<Photo> implements PhotoService {

    @Override
    @Log
    public List<Photo> findAllPhotos() {
        Photo photo = new Photo();
        photo.setIsDeleted(AppConstants.IS_DELETED_NO);

        return myMapper.select(photo);
    }

    @Override
    @Log
    public Photo findPhotoById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Photo> searchPhotos(int pageNum, int pageSize, String title) {
        Example example = new Example(Photo.class);

        if (StringUtils.isNotEmpty(title)) {
            example.createCriteria().andLike("title", StringUtil.toLikeString(title));
        }

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.INSERT, description = "保存相册${photo.title}")
    public void savePhoto(Photo photo) {
        myMapper.insertSelective(photo);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.UPDATE, description = "更新相册${photo.title}")
    public void updatePhoto(Photo photo) {
        myMapper.updateByPrimaryKeySelective(photo);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.DELETE, description = "删除相册id=${id}")
    public void deletePhoto(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }
}
