package com.kangyonggan.blog.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.kangyonggan.blog.dto.ShiroUser;
import com.kangyonggan.blog.service.MonitorService;
import com.kangyonggan.blog.service.UserService;
import com.kangyonggan.blog.vo.Monitor;
import com.kangyonggan.extra.core.model.MonitorInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * @author kangyonggan
 * @date 3/30/18
 */
@Service
public class MonitorServiceImpl extends BaseService<Monitor> implements MonitorService {

    @Autowired
    private UserService userService;

    @Override
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void saveMonitor(MonitorInfo monitorInfo) {
        Monitor monitor = new Monitor();
        BeanUtils.copyProperties(monitorInfo, monitor);

        monitor.setBeginTime(new Date(monitorInfo.getMethodStartTime()));
        monitor.setEndTime(new Date(monitorInfo.getMethodEndTime()));

        monitor.setHasReturnValue((byte) (monitorInfo.getHasReturnValue() ? 1 : 0));
        if (monitorInfo.getHasReturnValue()) {
            monitor.setReturnValue(JSONObject.toJSONString(monitorInfo.getReturnValue()));
        }
        if (StringUtils.isEmpty(monitor.getReturnValue())) {
            monitor.setReturnValue(StringUtils.EMPTY);
        }
        monitor.setArgs(JSONObject.toJSONString(monitorInfo.getArgs()));
        ShiroUser shiroUser = userService.getShiroUser();
        if (shiroUser != null) {
            monitor.setUsername(shiroUser.getUsername());
        }

        myMapper.insertSelective(monitor);
    }
}
