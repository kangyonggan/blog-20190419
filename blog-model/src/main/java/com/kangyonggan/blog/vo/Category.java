package com.kangyonggan.blog.vo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import lombok.Data;

@Table(name = "tb_category")
@Data
public class Category implements Serializable {
    /**
     * 主键, 自增
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * 栏目代码
     */
    private String code;

    /**
     * 栏目名称
     */
    private String name;

    /**
     * 栏目类型
     */
    private String type;

    /**
     * 栏目排序(从0开始)
     */
    private Integer sort;

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

    /**
     * 小说数量
     */
    @Transient
    private Integer novelCnt;

    private static final long serialVersionUID = 1L;
}