package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.LoginLog;

import java.text.ParseException;
import java.util.List;

/**
 * @author kangyonggan
 * @since 3/27/18
 */
public interface LoginLogService {

    /**
     * 保存登录日志
     *
     * @param username
     * @param ip
     */
    void saveLoginLog(String username, String ip);

    /**
     * 搜索登录日志
     *
     * @param pageNum
     * @param username
     * @param ip
     * @param beginDate
     * @param endDate
     * @return
     * @throws ParseException
     */
    List<LoginLog> searchLoginLogs(int pageNum, String username, String ip, String beginDate, String endDate) throws ParseException;
}
