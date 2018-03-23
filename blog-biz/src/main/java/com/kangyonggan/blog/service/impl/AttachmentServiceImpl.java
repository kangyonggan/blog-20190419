package com.kangyonggan.blog.service.impl;

import com.kangyonggan.blog.service.AttachmentService;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.extra.core.annotation.Log;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/23/18
 */
@Service
public class AttachmentServiceImpl extends BaseService<Attachment> implements AttachmentService {

    @Override
    @Log
    public List<Attachment> findAttachmentsByTypeAndSourceId(String type, Long sourceId) {
        Attachment attachment = new Attachment();
        attachment.setType(type);
        attachment.setSourceId(sourceId);

        return myMapper.select(attachment);
    }
}
