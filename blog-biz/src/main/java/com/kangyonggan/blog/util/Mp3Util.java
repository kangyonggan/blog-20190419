package com.kangyonggan.blog.util;

import lombok.extern.log4j.Log4j2;
import org.apache.commons.lang3.StringUtils;
import org.jaudiotagger.audio.mp3.MP3AudioHeader;
import org.jaudiotagger.audio.mp3.MP3File;
import org.jaudiotagger.tag.id3.AbstractID3v2Frame;
import org.jaudiotagger.tag.id3.AbstractID3v2Tag;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * mp3工具类
 *
 * @author kangyonggan
 * @date 9/4/17
 */
@Log4j2
public class Mp3Util {

    /**
     * 解析mp3
     *
     * @param mp3Path  mp3路径
     * @param albumDir 解析出的专辑图片存放目录
     * @return
     */
    public static Map<String, Object> parse(String mp3Path, String albumDir) {
        Map<String, Object> resultMap = new HashMap();

        FileOutputStream out = null;
        try {
            MP3File mp3File = new MP3File(mp3Path);
            MP3AudioHeader header = mp3File.getMP3AudioHeader();
            AbstractID3v2Tag id3v2Tag = mp3File.getID3v2Tag();

            // 时长(秒)
            int duration = header.getTrackLength();
            // 文件大小
            long size = mp3File.getFile().length();
            // 歌曲名
            String name = getInfo(id3v2Tag, "TIT2");
            // 歌手
            String singer = getInfo(id3v2Tag, "TPE1");
            // 专辑
            String album = getInfo(id3v2Tag, "TALB");
            // 专辑图片
            AbstractID3v2Frame frame = (AbstractID3v2Frame) id3v2Tag.frameMap.get("APIC");
            String mimeTpe = (String) frame.getBody().getObjectValue("MIMEType");
            byte[] data = (byte[]) frame.getBody().getObjectValue("PictureData");
            String extension = FileUtil.getExtension(mimeTpe);
            if (StringUtils.isEmpty(extension)) {
                extension = ".jpg";
            }
            out = new FileOutputStream(albumDir + File.separator + album + extension);
            out.write(data);
            out.flush();

            // 写响应
            resultMap.put("duration", duration);
            resultMap.put("size", size);
            resultMap.put("name", name);
            resultMap.put("singer", singer);
            resultMap.put("album", album);
            resultMap.put("mimeTpe", mimeTpe);
            resultMap.put("albumName", album + extension);

            resultMap.put("respCo", 0);
            resultMap.put("respMsg", "解析mp3成功");
        } catch (Exception e) {
            log.warn("解析mp3信息异常", e);
            resultMap.put("respCo", -1);
            resultMap.put("respMsg", e.getLocalizedMessage());
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    log.warn("关闭流异常", e);
                }
            }
        }

        return resultMap;
    }

    /**
     * 获取歌曲信息
     *
     * @param id3v2Tag
     * @param identifier
     * @return
     */
    private static String getInfo(AbstractID3v2Tag id3v2Tag, String identifier) {
        AbstractID3v2Frame frame = (AbstractID3v2Frame) id3v2Tag.frameMap.get(identifier);
        return (String) frame.getBody().getObjectValue("Text");
    }

}
