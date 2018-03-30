package com.kangyonggan.blog.service;

import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @since 3/30/18
 */
public interface SqlService {

    /**
     * 查询SQL
     *
     * @param sql
     * @return
     * @throws Exception
     */
    List<Map<String, Object>> query(String sql) throws Exception;

    /**
     * 执行SQL
     *
     * @param sql
     * @return
     * @throws Exception
     */
    int exec(String sql) throws Exception;
}
