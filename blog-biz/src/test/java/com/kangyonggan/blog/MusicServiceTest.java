package com.kangyonggan.blog;

import com.kangyonggan.blog.service.MusicService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author kangyonggan
 * @date 3/28/18
 */
public class MusicServiceTest extends AbstractServiceTest {

    @Autowired
    private MusicService musicService;

    /**
     * 测试保存音乐
     */
    @Test
    public void testSaveMusic() {
        musicService.saveMusic("upload/2.mp3", null, "康永敢", "测试上传音乐");
    }

}
