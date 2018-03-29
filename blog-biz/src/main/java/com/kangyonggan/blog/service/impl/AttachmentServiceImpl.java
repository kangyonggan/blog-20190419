package com.kangyonggan.blog.service.impl;

import com.kangyonggan.blog.constants.AppConstants;
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
        attachment.setIsDeleted(AppConstants.IS_DELETED_NO);

        return myMapper.select(attachment);
    }

    @Override
    @Log
    public void deleteAttachment(Long id) {
        Attachment attachment = new Attachment();
        attachment.setId(id);
        attachment.setIsDeleted(AppConstants.IS_DELETED_YES);

        myMapper.updateByPrimaryKeySelective(attachment);
    }

    @Override
    @Log
    public void saveAttachment(Attachment attachment) {
        myMapper.insertSelective(attachment);
    }
}
