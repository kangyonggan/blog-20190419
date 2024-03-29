package com.kangyonggan.blog.handle;

import com.kangyonggan.blog.service.MonitorService;
import com.kangyonggan.blog.util.SpringUtils;
import com.kangyonggan.extra.core.handle.MonitorHandle;
import com.kangyonggan.extra.core.model.MonitorInfo;
import lombok.extern.log4j.Log4j2;

/**
 * @author kangyonggan
 * @date 3/30/18
 */
@Log4j2
public class DbMonitorHandle implements MonitorHandle {

    private MonitorService monitorService;

    @Override
    public Object handle(MonitorInfo monitorInfo) {
        try {
            getMonitorService().saveMonitor(monitorInfo);
        } catch (Exception e) {
            log.error("保存监控信息异常", e);
        }
        return monitorInfo.getReturnValue();
    }

    private MonitorService getMonitorService() {
        if (monitorService == null) {
            monitorService = SpringUtils.getBean(MonitorService.class);
        }

        return monitorService;
    }

}
