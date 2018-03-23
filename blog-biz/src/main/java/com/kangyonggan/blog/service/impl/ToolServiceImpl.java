package com.kangyonggan.blog.service.impl;

import com.github.pagehelper.PageHelper;
import com.google.zxing.WriterException;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.Resp;
import com.kangyonggan.blog.dto.ToolDto;
import com.kangyonggan.blog.service.ToolService;
import com.kangyonggan.blog.util.*;
import com.kangyonggan.blog.vo.Tool;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.entity.Example;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @since 3/23/18
 */
@Service
@Log4j2
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

    @Override
    public Map<String, Object> handle(Tool tool, ToolDto toolDto, MultipartFile file) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put(AppConstants.RESP_CO, Resp.SUCCESS.getRespCo());
        resultMap.put(AppConstants.RESP_MSG, Resp.SUCCESS.getRespMsg());

        try {
            if (tool.getCode().equals("qr")) {
                // 生成二维码
                qrHandle(toolDto, resultMap);
            } else if (tool.getCode().equals("qr2")) {
                // 二维码解析
                qr2Handle(file, resultMap);
            } else {
                resultMap.put(AppConstants.RESP_CO, Resp.FAILURE.getRespCo());
                resultMap.put(AppConstants.RESP_MSG, "暂不支持此工具");
            }
        } catch (Exception e) {
            log.error("工具调用异常", e);
            resultMap.put(AppConstants.RESP_CO, Resp.FAILURE.getRespCo());
            resultMap.put(AppConstants.RESP_MSG, e.getMessage() == null ? Resp.FAILURE.getRespMsg() : e.getMessage());
        }

        return resultMap;
    }

    /**
     * 生成二维码
     *
     * @param toolDto
     * @param resultMap
     * @throws IOException
     * @throws WriterException
     */
    private void qrHandle(ToolDto toolDto, Map<String, Object> resultMap) throws IOException, WriterException {
        String qrName = RandomUtil.getRandomString("QR") + ".png";
        String name = PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + AppConstants.FILE_UPLOAD + qrName;
        QrCodeUtil.genQrCode(name, toolDto.getData(), toolDto.getSize());
        log.info("二维码生成成功，路径： {}", qrName);
        resultMap.put("result", AppConstants.FILE_UPLOAD + qrName);
    }

    /**
     * 二维码解析
     *
     * @param file
     * @param resultMap
     * @throws IOException
     * @throws WriterException
     */
    private void qr2Handle(MultipartFile file, Map<String, Object> resultMap) throws Exception {
        String result = QrCodeUtil.decode(file.getInputStream());
        log.info("二维码解析结果：{}", result);
        resultMap.put("result", result);
    }
}
