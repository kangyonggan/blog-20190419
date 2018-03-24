package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Life;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/24/18
 */
public interface LifeService {

    /**
     * 搜索生活
     *
     * @param pageNum
     * @param pageSize
     * @param title
     * @param categoryCode
     * @return
     */
    List<Life> searchLifes(int pageNum, int pageSize, String title, String categoryCode);

    /**
     * 保存生活和附件
     *
     * @param life
     * @param files
     * @throws FileUploadException
     */
    void saveLifeWithAttachments(Life life, MultipartFile[] files) throws FileUploadException;

    /**
     * 查找生活
     *
     * @param id
     * @return
     */
    Life findLifeById(Long id);

    /**
     * 更新生活和附件
     *
     * @param life
     * @param files
     * @throws FileUploadException
     */
    void updateLifeWithAttachments(Life life, MultipartFile[] files) throws FileUploadException;

    /**
     * 更新生活
     *
     * @param life
     */
    void updateLife(Life life);

    /**
     * 删除生活
     *
     * @param id
     */
    void deleteLife(Long id);

    /**
     * 查找一些生活动态
     *
     * @param pageNum
     * @param pageSize
     * @param categoryCode
     * @return
     */
    List<Life> findSomeLife(int pageNum, int pageSize, String categoryCode);
}
