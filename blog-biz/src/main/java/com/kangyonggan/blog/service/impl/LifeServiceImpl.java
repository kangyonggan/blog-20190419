package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.AttachmentType;
import com.kangyonggan.blog.mapper.AttachmentMapper;
import com.kangyonggan.blog.service.LifeService;
import com.kangyonggan.blog.util.FileUpload;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Attachment;
import com.kangyonggan.blog.vo.Life;
import com.kangyonggan.extra.core.annotation.Log;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

/**
 * @author kangyonggan
 * @since 3/24/18
 */
@Service
public class LifeServiceImpl extends BaseService<Life> implements LifeService {

    @Autowired
    private AttachmentMapper attachmentMapper;

    @Override
    public List<Life> searchLifes(int pageNum, int pageSize, String title, String categoryCode) {
        Example example = new Example(Life.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotEmpty(title)) {
            criteria.andLike("title", StringUtil.toLikeString(title));
        }
        if (StringUtils.isNotEmpty(categoryCode)) {
            criteria.andEqualTo("categoryCode", categoryCode);
        }

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    public void saveLifeWithAttachments(Life life, MultipartFile[] files) throws FileUploadException {
        myMapper.insertSelective(life);

        if (files.length > 0) {
            saveAttachments(life, files);
        }
    }

    @Override
    @Log
    public Life findLifeById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateLifeWithAttachments(Life life, MultipartFile[] files) throws FileUploadException {
        myMapper.updateByPrimaryKeySelective(life);

        if (files.length > 0) {
            saveAttachments(life, files);
        }
    }

    @Override
    @Log
    public void updateLife(Life life) {
        myMapper.updateByPrimaryKeySelective(life);
    }

    @Override
    @Log
    public void deleteLife(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }

    @Override
    public List<Life> findSomeLife(int pageNum, int pageSize, String categoryCode) {
        Example example = new Example(Life.class);
        Example.Criteria criteria = example.createCriteria();

        criteria.andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);
        if (StringUtils.isNotEmpty(categoryCode)) {
            criteria.andEqualTo("categoryCode", categoryCode);
        }

        example.selectProperties("id", "title", "summary", "categoryCode", "isDeleted", "createdTime");

        example.setOrderByClause("id desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    /**
     * 批量保存附件
     *
     * @param life
     * @param files
     * @throws FileUploadException
     */
    private void saveAttachments(Life life, MultipartFile[] files) throws FileUploadException {
        List<Attachment> attachments = new ArrayList<>();
        for (int i = 0; i < files.length; i++) {
            Attachment attachment = new Attachment();
            String url = FileUpload.upload(files[i], "LIFE");
            String originalFilename = files[i].getOriginalFilename();

            attachment.setType(AttachmentType.LIFE.getType());
            attachment.setSourceId(life.getId());
            attachment.setUrl(url);
            attachment.setOriginalFilename(originalFilename);
            attachments.add(attachment);
        }

        // 批量保存附件
        attachmentMapper.insertAttachments(attachments);
    }
}
