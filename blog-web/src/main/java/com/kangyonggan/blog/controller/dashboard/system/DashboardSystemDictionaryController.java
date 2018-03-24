package com.kangyonggan.blog.controller.dashboard.system;

import com.github.pagehelper.PageInfo;
import com.kangyonggan.blog.constants.DictionaryType;
import com.kangyonggan.blog.controller.BaseController;
import com.kangyonggan.blog.service.DictionaryService;
import com.kangyonggan.blog.vo.Dictionary;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

/**
 * @author kangyonggan
 * @since 2017/1/9
 */
@Controller
@RequestMapping("dashboard/system/dictionary")
public class DashboardSystemDictionaryController extends BaseController {

    @Autowired
    private DictionaryService dictionaryService;

    /**
     * 字典管理
     *
     * @param pageNum
     * @param type
     * @param value
     * @param model
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    @RequiresPermissions("SYSTEM_DICTIONARY")
    public String index(@RequestParam(value = "p", required = false, defaultValue = "1") int pageNum,
                        @RequestParam(value = "type", required = false, defaultValue = "") String type,
                        @RequestParam(value = "value", required = false, defaultValue = "") String value,
                        Model model) {
        List<Dictionary> dictionaries = dictionaryService.searchDictionaries(pageNum, type, value);
        PageInfo<Dictionary> page = new PageInfo(dictionaries);

        model.addAttribute("page", page);
        model.addAttribute("types", DictionaryType.values());
        return getPathList();
    }

    /**
     * 添加
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "create", method = RequestMethod.GET)
    @RequiresPermissions("SYSTEM_DICTIONARY")
    public String create(Model model) {
        model.addAttribute("types", DictionaryType.values());
        model.addAttribute("dictionary", new Dictionary());
        return getPathFormModal();
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
    @RequiresPermissions("SYSTEM_DICTIONARY")
    public String delete(@PathVariable("id") Long id, @PathVariable("isDeleted") String isDeleted, Model model) {
        Dictionary dictionary = dictionaryService.findDictionaryById(id);
        dictionary.setIsDeleted((byte) (isDeleted.equals("delete") ? 1 : 0));
        dictionaryService.updateDictionary(dictionary);

        model.addAttribute("dictionary", dictionary);
        model.addAttribute("types", DictionaryType.values());
        return getPathTableTr();
    }

    /**
     * 保存
     *
     * @param dictionary
     * @param result
     * @return
     */
    @RequestMapping(value = "save", method = RequestMethod.POST)
    @RequiresPermissions("SYSTEM_DICTIONARY")
    @ResponseBody
    public Map<String, Object> save(@ModelAttribute("dictionary") @Valid Dictionary dictionary, BindingResult result) {
        Map<String, Object> resultMap = getResultMap();

        if (!result.hasErrors()) {
            dictionaryService.saveDictionary(dictionary);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }

    /**
     * 编辑
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/edit", method = RequestMethod.GET)
    @RequiresPermissions("SYSTEM_DICTIONARY")
    public String edit(@PathVariable("id") Long id, Model model) {
        model.addAttribute("dictionary", dictionaryService.findDictionaryById(id));
        model.addAttribute("types", DictionaryType.values());
        return getPathFormModal();
    }

    /**
     * 物理删除
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "{id:[\\d]+}/remove", method = RequestMethod.GET)
    @RequiresPermissions("SYSTEM_DICTIONARY")
    @ResponseBody
    public Map<String, Object> remove(@PathVariable("id") Long id) {
        dictionaryService.deleteDictionaryById(id);
        return super.getResultMap();
    }

    /**
     * 更新
     *
     * @param dictionary
     * @param result
     * @return
     */
    @RequestMapping(value = "update", method = RequestMethod.POST)
    @RequiresPermissions("SYSTEM_DICTIONARY")
    @ResponseBody
    public Map<String, Object> update(@ModelAttribute("dictionary") @Valid Dictionary dictionary, BindingResult result) {
        Map<String, Object> resultMap = getResultMap();

        if (!result.hasErrors()) {
            dictionaryService.updateDictionary(dictionary);
        } else {
            setResultMapFailure(resultMap);
        }

        return resultMap;
    }
}
