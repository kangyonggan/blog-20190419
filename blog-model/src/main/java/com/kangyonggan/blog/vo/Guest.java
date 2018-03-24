package com.kangyonggan.blog.vo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import lombok.Data;

@Table(name = "tb_guest")
@Data
public class Guest implements Serializable {
    /**
     * 主键, 自增
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * 昵称
     */
    private String realname;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 内容
     */
    private String content;

    /**
     * 状态:{"WAITING":"待审核", "REJECT":"拒绝", "COMPLETE":"审核通过"}
     */
    private String status;

    /**
     * 审核人
     */
    @Column(name = "adjust_username")
    private String adjustUsername;

    /**
     * IP
     */
    private String ip;

    /**
     * IP信息
     */
    @Column(name = "ip_info")
    private String ipInfo;

    /**
     * 回复人
     */
    @Column(name = "reply_username")
    private String replyUsername;

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
     * 回复信息
     */
    @Column(name = "reply_message")
    private String replyMessage;

    private static final long serialVersionUID = 1L;
}