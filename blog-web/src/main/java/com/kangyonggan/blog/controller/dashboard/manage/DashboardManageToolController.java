package com.kangyonggan.blog.controller.dashboard.manage;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.ToolService;
import com.kangyonggan.blog.vo.Tool;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @date 2018/04/02
 */
@Controller
@RequestMapping("dashboard/manage/tool")
public class DashboardManageToolController extends BaseController {

    @Autowired
    private ToolService toolService;

    /**
     * 工具管理
     *
     * @param pageNum
     * @param name
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_TOOL")
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "name", required = false, defaultValue = "") String name,
                        Model model) {
        List<Tool> tools = toolService.searchTools(pageNum, AppConstants.PAGE_SIZE, name);
        PageInfo<Tool> page = new PageInfo(tools);

        model.addAttribute("page", page);
        return getPathList();
    }

    /**
     * 添加工具
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_TOOL")
    public String create(Model model) {
        model.addAttribute("tool", new Tool());
        return getPathForm();
    }

    /**
     * 保存工具
     *
     * @param tool
     * @param result
     * @param iconFile
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_TOOL")
    public Map<String, Object> save(@ModelAttribute("tool") @Valid Tool tool, BindingResult result,
                                    @RequestParam(value = "iconFile", required = false) MultipartFile iconFile) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            toolService.saveToolWithIcon(tool, iconFile);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 编辑工具
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/edit", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_TOOL")
    public String edit(@PathVariable("id") Long id, Model model) {
        model.addAttribute("tool", toolService.findToolById(id));
        return getPathForm();
    }

    /**
     * 更新工具
     *
     * @param tool
     * @param result
     * @param iconFile
     * @return
     * @throws FileUploadException
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @ResponseBody
    @RequiresPermissions("MANAGE_TOOL")
    public Map<String, Object> update(@ModelAttribute("tool") @Valid Tool tool, BindingResult result,
                                      @RequestParam(value = "iconFile", required = false) MultipartFile iconFile) throws FileUploadException {
        Map<String, Object> resultMap = getResultMap();
        if (!result.hasErrors()) {
            toolService.updateToolWithIcon(tool, iconFile);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 删除/恢复
     *
     * @param id
     * @param isDeleted
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/{isDeleted:\\bundelete\\b|\\bdelete\\b}", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @RequiresPermissions("MANAGE_TOOL")
    public String delete(@PathVariable("id") Long id, @PathVariable("isDeleted") String isDeleted, Model model) {
        Tool tool = toolService.findToolById(id);
        tool.setIsDeleted((byte) ("delete".equals(isDeleted) ? 1 : 0));
        toolService.updateTool(tool);

        model.addAttribute("tool", tool);
        return getPathTableTr();
    }

    /**
     * 推荐/取消推荐
     *
     * @param id
     * @param isTop
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/{isTop:\\buntop\\b|\\btop\\b}", method = RequestMethod.GET, produces = MediaType.TEXT_HTML_VALUE)
    @RequiresPermissions("MANAGE_TOOL")
    public String top(@PathVariable("id") Long id, @PathVariable("isTop") String isTop, Model model) {
        Tool tool = toolService.findToolById(id);
        tool.setIsTop((byte) ("top".equals(isTop) ? 1 : 0));
        toolService.updateTool(tool);

        model.addAttribute("tool", tool);
        return getPathTableTr();
    }

    /**
     * 物理删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("MANAGE_TOOL")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("id") Long id) {
        toolService.deleteTool(id);
        return super.getResultMap();
    }


}
