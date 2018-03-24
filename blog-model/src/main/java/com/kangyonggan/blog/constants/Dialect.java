package com.kangyonggan.blog.constants;

import lombok.Getter;

/**
 * @author kangyonggan
 * @since 7/6/17
 */
public enum Dialect {

    MySQL("MySQL"),
    Oracle("Oracle"),
    SQLServer("SQLServer");

    /**
     * 数据库方言
     */
    @Getter
    private final String dialect;

    Dialect(String dialect) {
        this.dialect = dialect;
    }

}