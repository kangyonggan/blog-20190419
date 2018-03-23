package com.kangyonggan.blog.controller.web;

import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.dto.ToolDto;
import com.kangyonggan.blog.service.ToolService;
import com.kangyonggan.blog.vo.Tool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.Map;

/**
 * @author kangyonggan
 * @since 3/21/18
 */
@Controller
@RequestMapping("tool")
public class ToolController extends BaseController {

    @Autowired
    private ToolService toolService;

    /**
     * 常用工具
     *
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String index(Model model) {
        model.addAttribute("tools", toolService.findAllTools());
        return getPathIndex();
    }

    /**
     * 工具详情
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.GET)
    public String detail(@PathVariable("id") Long id, Model model) {
        Tool tool = toolService.findToolById(id);

        model.addAttribute("tool", tool);
        return getPathDetail();
    }

    /**
     * 处理提交
     *
     * @param id
     * @param toolDto
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}", method = RequestMethod.POST)
    public String submit(@PathVariable("id") Long id, ToolDto toolDto, Model model) {
        Tool tool = toolService.findToolById(id);
        Map<String, Object> resultMap = toolService.handle(tool, toolDto);

        model.addAttribute("tool", tool);
        model.addAttribute("resultMap", resultMap);
        return getPathDetail();
    }
}
