package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Attachment;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/23/18
 */
public interface AttachmentService {

    /**
     * 根据类型和来源查找附件
     *
     * @param type
     * @param sourceId
     * @return
     */
    List<Attachment> findAttachmentsByTypeAndSourceId(String type, Long sourceId);

    /**
     * 删除附件
     *
     * @param id
     */
    void deleteAttachment(Long id);
}
