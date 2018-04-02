package com.kangyonggan.blog.service.impl;

import com.kangyonggan.blog.constants.MonitorType;
import com.kangyonggan.blog.service.SqlService;
import com.kangyonggan.blog.util.PropertiesUtil;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @date 3/30/18
 */
@Service
@Log4j2
public class SqlServiceImpl implements SqlService {

    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            log.error("jdbc初始化异常", e);
        }
    }

    @Override
    @Log
    public List<Map<String, Object>> query(String sql) throws Exception {
        List<Map<String, Object>> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = getConnect();
            ps = conn.prepareCall(sql);
            rs = ps.executeQuery();

            //获得结果集结构信息,元数据
            ResultSetMetaData md = rs.getMetaData();

            //获得列数
            int columnCount = md.getColumnCount();
            while (rs.next()) {
                Map<String, Object> rowData = new HashMap<>(16);
                for (int i = 1; i <= columnCount; i++) {
                    rowData.put(md.getColumnName(i), rs.getObject(i));
                }
                list.add(rowData);
            }
        } catch (Exception e) {
            log.error("SQL查询异常,{}", sql, e);
            throw e;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    @Override
    @Log
    @Monitor(type = MonitorType.UPDATE, description = "执行SQL:${sql}")
    public int exec(String sql) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        int count = 0;

        try {
            conn = getConnect();
            ps = conn.prepareCall(sql);
            count = ps.executeUpdate();
        } catch (Exception e) {
            log.error("SQL执行异常,{}", sql, e);
            throw e;
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return count;
    }

    /**
     * 获取链接
     *
     * @return
     * @throws Exception
     */
    private Connection getConnect() throws Exception {
        return DriverManager.getConnection(PropertiesUtil.getProperties("jdbc.url"),
                PropertiesUtil.getProperties("jdbc.username"), PropertiesUtil.getProperties("jdbc.password"));
    }

}
