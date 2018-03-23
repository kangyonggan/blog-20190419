package com.kangyonggan.blog.vo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import lombok.Data;

@Table(name = "tb_attachment")
@Data
public class Attachment implements Serializable {
    /**
     * 主键, 自增
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * 附件类型
     */
    private String type;

    /**
     * 附件来源
     */
    @Column(name = "source_id")
    private Long sourceId;

    /**
     * 附件地址
     */
    private String url;

    /**
     * 附件原名
     */
    @Column(name = "original_filename")
    private String originalFilename;

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