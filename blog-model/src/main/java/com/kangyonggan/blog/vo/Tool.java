package com.kangyonggan.blog.vo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import lombok.Data;

/**
 * @author kangyonggan
 * @date 2018/04/02
 */
@Table(name = "tb_tool")
@Data
public class Tool implements Serializable {
    /**
     * 主键, 自增
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * 工具代码
     */
    private String code;

    /**
     * 工具名称
     */
    private String name;

    /**
     * 图标
     */
    private String icon;

    /**
     * 是否推荐:{0:不推荐, 1:推荐}
     */
    @Column(name = "is_top")
    private Byte isTop;

    /**
     * 逻辑删除:{0:未删除, 1:已删除}
     */
    @Column(name = "is_deleted")
    private Byte isDeleted;

    /**
     * 创建时间
     */
    @Column(name = "created_time")
    private Date createdTime;

    /**
     * 更新时间
     */
    @Column(name = "updated_time")
    private Date updatedTime;

    private static final long serialVersionUID = 1L;
}