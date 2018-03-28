package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.service.MusicService;
import com.kangyonggan.blog.util.FileUpload;
import com.kangyonggan.blog.util.Mp3Util;
import com.kangyonggan.blog.util.PropertiesUtil;
import com.kangyonggan.blog.vo.Music;
import com.kangyonggan.extra.core.annotation.Log;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

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
    public String saveMusic(String fileName, String uploadUsername, String uploadRemark) {
        Map<String, Object> map = Mp3Util.parse(PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + fileName, PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + "cover");

        try {
            if ((int) map.get("respCo") == 0) {
                // 重新保存文件，使用新的文件名: 歌手 - 歌曲名.mp3
                String newFilename = "music/" + map.get("singer") + " - " + map.get("name") + ".mp3";
                FileUpload.copy(fileName, newFilename);

                // 落库
                map.put("uploadUsername", uploadUsername);
                map.put("uploadRemark", uploadRemark);
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
        music.setCategoryCode(categoryCode);

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.select(music);
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

        myMapper.insertSelective(music);
    }
}
