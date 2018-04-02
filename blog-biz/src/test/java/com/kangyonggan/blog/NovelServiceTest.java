package com.kangyonggan.blog;

import com.kangyonggan.blog.service.NovelService;
import lombok.extern.log4j.Log4j2;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @author kangyonggan
 * @date 3/25/18
 */
@Log4j2
public class NovelServiceTest extends AbstractServiceTest {

    @Autowired
    private NovelService novelService;

    /**
     * 测试更新小说
     */
    @Test
    public void testUploadNovelFromNow() {
        novelService.updateNovelFromNow(novelService.findLastNovelCode());
    }

}
