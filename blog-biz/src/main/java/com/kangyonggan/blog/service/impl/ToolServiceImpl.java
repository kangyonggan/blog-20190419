package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.service.ToolService;
import com.kangyonggan.blog.vo.Tool;
import com.kangyonggan.extra.core.annotation.Log;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @author kangyonggan
 * @since 3/23/18
 */
@Service
public class ToolServiceImpl extends BaseService<Tool> implements ToolService {

    @Override
    @Log
    public List<Tool> findAllTools() {
        Example example = new Example(Tool.class);
        example.createCriteria().andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        example.setOrderByClause("is_top desc");
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public List<Tool> findTopTools(int size) {
        Example example = new Example(Tool.class);
        example.createCriteria()
                .andEqualTo("isDeleted", AppConstants.IS_DELETED_NO)
                .andEqualTo("isTop", 1);

        example.setOrderByClause("is_top desc");

        PageHelper.startPage(1, size);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    public Tool findToolByCode(String code) {
        Tool tool = new Tool();
        tool.setCode(code);
        tool.setIsDeleted(AppConstants.IS_DELETED_NO);

        return myMapper.selectOne(tool);
    }
}
