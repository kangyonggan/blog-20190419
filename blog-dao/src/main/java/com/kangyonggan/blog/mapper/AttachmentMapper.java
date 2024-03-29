package com.kangyonggan.blog.mapper;

import com.kangyonggan.blog.vo.Attachment;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author kangyonggan
 * @date 2018/04/02
 */
@Repository
public interface AttachmentMapper extends MyMapper<Attachment> {

    /**
     * 批量保存附件
     *
     * @param attachments
     */
    void insertAttachments(@Param("attachments") List<Attachment> attachments);

}