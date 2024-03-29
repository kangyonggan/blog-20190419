package com.kangyonggan.blog.engine;

import com.kangyonggan.blog.service.NovelService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

/**
 * @author kangyonggan
 * @date 3/25/18
 */
@Log4j2
public class CoverEngine {

    @Autowired
    private NovelService novelService;

    /**
     * 每天早上9点更新小说封面
     * cron表达式：* * * * * *（秒 分 时 日 月 星期）
     */
    @Scheduled(cron = "0 0 9 * * *")
    public void execute() {
        log.info("引擎自动更新小说封面开始...");
        novelService.updateNovelCover();
        log.info("引擎自动更新小说封面结束!");
    }

}
