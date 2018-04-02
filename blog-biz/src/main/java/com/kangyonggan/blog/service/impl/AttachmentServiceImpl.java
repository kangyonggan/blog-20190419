package com.kangyonggan.blog.service.impl;

import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.MonitorType;
import com.kangyonggan.blog.service.AttachmentService;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author kangyonggan
 * @date 3/23/18
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
    @Monitor(type = MonitorType.DELETE, description = "删除附件id=${id}")
    public void deleteAttachment(Long id) {
        Attachment attachment = new Attachment();
        attachment.setId(id);
        attachment.setIsDeleted(AppConstants.IS_DELETED_YES);

        myMapper.updateByPrimaryKeySelective(attachment);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.INSERT, description = "保存附件${attachment.originalFilename}")
    public void saveAttachment(Attachment attachment) {
        myMapper.insertSelective(attachment);
    }
}
