package com.kangyonggan.blog.handle;

import com.kangyonggan.blog.service.RedisService;
import com.kangyonggan.blog.util.SpringUtils;
import com.kangyonggan.extra.core.exception.MethodCalledFrequencyException;
import com.kangyonggan.extra.core.handle.FrequencyHandle;
import lombok.extern.log4j.Log4j2;

/**
 * @author kangyonggan
 * @since 2017/11/7 0007
 */
@Log4j2
public class RedisFrequencyHandle implements FrequencyHandle {

    public void limit(String key, long interval, boolean interrupt) {
        boolean isLimited = this.isLimited(key, interval);
        if (isLimited) {
            String msg = String.format("Method %s called frequency during %sms times.", key, interval);
            log.warn(msg);
            if (interrupt) {
                throw new MethodCalledFrequencyException(msg);
            }
        }

    }

    private synchronized boolean isLimited(String key, Long interval) {
        Long lastTime = this.getLastTime(key);
        Long currentTime = System.currentTimeMillis();
        if (interval.longValue() > currentTime.longValue() - lastTime.longValue()) {
            return true;
        } else {
            SpringUtils.getBean(RedisService.class).set(key, currentTime);
            return false;
        }
    }

    private Long getLastTime(String key) {
        RedisService redisService = SpringUtils.getBean(RedisService.class);
        Object lastTime = redisService.get(key);
        if (lastTime == null) {
            lastTime = 0L;
            redisService.set(key, lastTime);
        }

        return (Long) lastTime;
    }
}
