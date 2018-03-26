package com.kangyonggan.blog.service;

import com.kangyonggan.blog.dto.request.ToolDto;
import com.kangyonggan.blog.vo.Tool;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/23/18
 */
public interface ToolService {

    /**
     * 查找所有工具
     *
     * @return
     */
    List<Tool> findAllTools();

    /**
     * 查找工具
     *
     * @param id
     * @return
     */
    Tool findToolById(Long id);

    /**
     * 搜索工具
     *
     * @param pageNum
     * @param pageSize
     * @param title
     * @return
     */
    List<Tool> searchTools(int pageNum, int pageSize, String title);

    /**
     * 保存工具
     *
     * @param tool
     * @param icon
     * @throws FileUploadException
     */
    void saveToolWithIcon(Tool tool, MultipartFile icon) throws FileUploadException;

    /**
     * 更新工具
     *
     * @param tool
     * @param icon
     * @throws FileUploadException
     */
    void updateToolWithIcon(Tool tool, MultipartFile icon) throws FileUploadException;

    /**
     * 更新工具
     *
     * @param tool
     */
    void updateTool(Tool tool);

    /**
     * 删除工具
     *
     * @param id
     */
    void deleteTool(Long id);

    /**
     * 查找一些工具
     *
     * @param size
     * @return
     */
    List<Tool> findSomeTools(int size);

    /**
     * 处理请求
     *
     * @param tool
     * @param model
     * @param toolDto
     * @param file
     * @param props
     * @return
     */
    void handle(Tool tool, Model model, ToolDto toolDto, MultipartFile file, MultipartFile[] props);

    /**
     * 预处理请求
     *
     * @param tool
     * @param model
     */
    void preHandle(Tool tool, Model model);
}
