package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.service.ToolService;
import com.kangyonggan.blog.util.FileUpload;
import com.kangyonggan.blog.util.StringUtil;
import com.kangyonggan.blog.vo.Tool;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
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
    @Cache(key = "tool:all")
    public List<Tool> findAllTools() {
        Example example = new Example(Tool.class);
        example.createCriteria().andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        example.setOrderByClause("is_top desc");
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    @Cache(key = "tool:id:${id}")
    public Tool findToolById(Long id) {
        return myMapper.selectByPrimaryKey(id);
    }

    @Override
    @Log
    public List<Tool> searchTools(int pageNum, int pageSize, String name) {
        Example example = new Example(Tool.class);
        Example.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotEmpty(name)) {
            criteria.andLike("name", StringUtil.toLikeString(name));
        }

        example.setOrderByClause("is_top desc");

        PageHelper.startPage(pageNum, pageSize);
        return myMapper.selectByExample(example);
    }

    @Override
    @Log
    @CacheDel(key = {"tool:all", "tool:some:*"})
    public void saveToolWithIcon(Tool tool, MultipartFile icon) throws FileUploadException {
        if (icon != null && !icon.isEmpty()) {
            String url = FileUpload.upload(icon, "TOOL");
            tool.setIcon(url);
        }
        myMapper.insertSelective(tool);
    }

    @Override
    @Log
    @CacheDel(key = {"tool:all", "tool:id:${tool.id}", "tool:some:*"})
    public void updateToolWithIcon(Tool tool, MultipartFile icon) throws FileUploadException {
        if (icon != null && !icon.isEmpty()) {
            String url = FileUpload.upload(icon, "TOOL");
            tool.setIcon(url);
        }

        myMapper.updateByPrimaryKeySelective(tool);
    }

    @Override
    @Log
    @CacheDel(key = {"tool:all", "tool:id:${tool.id}", "tool:some:*"})
    public void updateTool(Tool tool) {
        myMapper.updateByPrimaryKeySelective(tool);
    }

    @Override
    @Log
    @CacheDel(key = {"tool:all", "tool:id:${id}", "tool:some:*"})
    public void deleteTool(Long id) {
        myMapper.deleteByPrimaryKey(id);
    }

    @Override
    @Log
    @Cache(key = "tool:some:${size}")
    public List<Tool> findSomeTools(int size) {
        Example example = new Example(Tool.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("isDeleted", AppConstants.IS_DELETED_NO);

        example.setOrderByClause("is_top desc");

        PageHelper.startPage(1, size);
        return myMapper.selectByExample(example);
    }
}
