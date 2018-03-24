package com.kangyonggan.blog.vo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import lombok.Data;

@Table(name = "tb_life")
@Data
public class Life implements Serializable {
    /**
     * 主键, 自增
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * 生活标题
     */
    private String title;

    /**
     * 摘要
     */
    private String summary;

    /**
     * 栏目代码
     */
    @Column(name = "category_code")
    private String categoryCode;

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
     * 内容
     */
    private String content;

    private static final long serialVersionUID = 1L;
}