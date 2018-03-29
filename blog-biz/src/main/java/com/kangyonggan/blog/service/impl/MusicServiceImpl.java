package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.Status;
import com.kangyonggan.blog.service.MusicService;
import com.kangyonggan.blog.util.Mp3Util;
import com.kangyonggan.blog.util.PropertiesUtil;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Music;
import com.kangyonggan.extra.core.annotation.Log;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @since 3/28/18
 */
@Service
@Log4j2
public class MusicServiceImpl extends BaseService<Music> implements MusicService {

    @Override
    @Log
    public String saveMusic(String fileName, String categoryCode, String uploadUsername, String uploadRemark) {
        Map<String, Object> map = Mp3Util.parse(PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + fileName, PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + "cover");

        try {
            if ((int) map.get("respCo") == 0) {
                // 落库
                map.put("uploadUsername", uploadUsername);
                map.put("uploadRemark", uploadRemark);
                map.put("categoryCode", categoryCode);
                map.put("fileName", fileName);
                saveMusic(map);
                return "保存成功";
            } else {
                return "文件解析异常";
            }
        } catch (Exception e) {
            log.error("保存音乐异常", e);
            return e.getMessage();
        }
    }

    @Override
    public List<Music> findMusicsByCategory(int pageNum, int pageSize, String categoryCode) {
        Music music = new Music();
        music.setIsDeleted(AppConstants.IS_DELETED_NO);
        music.setStatus(Status.COMPLETE.getStatus());
        if (StringUtils.isNotEmpty(categoryCode)) {
            music.setCategoryCode(categoryCode);
        }

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.select(music);
    }

    @Override
    public List<Music> searchMusics(int pageNum, int pageSize, String name, String singer, String album, String categoryCode) {
        Example example = new Example(Music.class);

        Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotEmpty(name)) {
            criteria.andLike("name", StringUtil.toLikeString(name));
        }
        if (StringUtils.isNotEmpty(singer)) {
            criteria.andLike("singer", StringUtil.toLikeString(singer));
        }
        if (StringUtils.isNotEmpty(album)) {
            criteria.andLike("album", StringUtil.toLikeString(album));
        }
        if (StringUtils.isNotEmpty(categoryCode)) {
            criteria.andEqualTo("categoryCode", categoryCode);
        }

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public Music findMusicById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    @Log
    public void updateMusic(Music music) {
        myMapper.updateByPrimaryKeySelective(music);
    }

    @Override
    @Log
    public void deleteMusic(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Music> searchMusics(int pageNum, int pageSize, String key) {
        Example example = new Example(Music.class);

        example.or(example.createCriteria().andLike("name", StringUtil.toLikeString(key)).andEqualTo("isDeleted", AppConstants.IS_DELETED_NO));
        example.or(example.createCriteria().andLike("singer", StringUtil.toLikeString(key)).andEqualTo("isDeleted", AppConstants.IS_DELETED_NO));
        example.or(example.createCriteria().andLike("album", StringUtil.toLikeString(key)).andEqualTo("isDeleted", AppConstants.IS_DELETED_NO));

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    /**
     * 保存音乐
     *
     * @param resultMap
     */
    private void saveMusic(Map<String, Object> resultMap) {
        Music music = new Music();
        music.setName((String) resultMap.get("name"));
        music.setSinger((String) resultMap.get("singer"));
        music.setAlbum((String) resultMap.get("album"));
        music.setAlbumCoverPath("cover/" + resultMap.get("albumName"));
        music.setDuration((Integer) resultMap.get("duration"));
        music.setSize((Long) resultMap.get("size"));
        music.setUploadUsername((String) resultMap.get("uploadUsername"));
        music.setUploadRemark((String) resultMap.get("uploadRemark"));
        music.setCategoryCode((String) resultMap.get("categoryCode"));
        music.setMusicPath((String) resultMap.get("fileName"));

        myMapper.insertSelective(music);
    }
}
