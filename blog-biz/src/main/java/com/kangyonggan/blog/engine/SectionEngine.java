package com.kangyonggan.blog.engine;

import com.kangyonggan.blog.service.NovelService;
import com.kangyonggan.blog.service.SectionService;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author kangyonggan
 * @since 3/25/18
 */
@Component
@Log4j2
public class SectionEngine {

    @Autowired
    private SectionService sectionService;

    /**
     * 每天凌晨1点更新章节
     * cron表达式：* * * * * *（秒 分 时 日 月 星期）
     */
    @Scheduled(cron = "0 0 1 * * *")
    public void execute() {
        log.info("引擎自动更新章节开始...");
        sectionService.updateAllSections();
        log.info("引擎自动更新章节结束!");
    }

}
