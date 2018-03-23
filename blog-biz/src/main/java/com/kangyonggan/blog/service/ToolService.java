package com.kangyonggan.blog.service;

import com.kangyonggan.blog.vo.Tool;

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
     * 查找指定个数的推荐工具
     *
     * @param size
     * @return
     */
    List<Tool> findTopTools(int size);

    /**
     * 查找工具
     *
     * @param code
     * @return
     */
    Tool findToolByCode(String code);

}
