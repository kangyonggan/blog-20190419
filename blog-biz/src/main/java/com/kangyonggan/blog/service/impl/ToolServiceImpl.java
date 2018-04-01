package com.kangyonggan.blog.service.impl;

import com.alibaba.druid.sql.SQLUtils;
import com.github.pagehelper.PageHelper;
import com.google.zxing.WriterException;
import com.kangyonggan.blog.constants.*;
import com.kangyonggan.blog.dto.request.ToolDto;
import com.kangyonggan.blog.service.DictionaryService;
import com.kangyonggan.blog.service.ToolService;
import com.kangyonggan.blog.util.*;
import com.kangyonggan.blog.vo.Dictionary;
import com.kangyonggan.blog.vo.Tool;
import com.kangyonggan.extra.core.annotation.Cache;
import com.kangyonggan.extra.core.annotation.CacheDel;
import com.kangyonggan.extra.core.annotation.Log;
import com.kangyonggan.extra.core.annotation.Monitor;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.entity.Example;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Set;

/**
 * @author kangyonggan
 * @since 3/23/18
 */
@Service
@Log4j2
public class ToolServiceImpl extends BaseService<Tool> implements ToolService {

    private static final String RESULT = "result";

    @Autowired
    private DictionaryService dictionaryService;

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
    @Monitor(type = MonitorType.UPDATE, description = "更新工具${tool.code}")
    @CacheDel(key = {"tool:all", "tool:id:${tool.id}", "tool:some:*"})
    public void updateTool(Tool tool) {
        myMapper.updateByPrimaryKeySelective(tool);
    }

    @Override
    @Log
    @Monitor(type = MonitorType.DELETE, description = "删除工具${id}")
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
    public void handle(Tool tool, Model model, ToolDto toolDto, MultipartFile file, MultipartFile[] props) {
        model.addAttribute(AppConstants.RESP_CO, Resp.SUCCESS.getRespCo());
        model.addAttribute(AppConstants.RESP_MSG, Resp.SUCCESS.getRespMsg());

        try {
            if (tool.getCode().equals("qr")) {
                // 生成二维码
                qrHandle(toolDto, model);
            } else if (tool.getCode().equals("qr2")) {
                // 二维码解析
                qr2Handle(file, model);
            } else if (tool.getCode().equals("xml")) {
                // xml格式化
                model.addAttribute("result", XmlUtil.format(toolDto.getData()));
            } else if (tool.getCode().equals("sql")) {
                // sql格式化
                sqlHandle(toolDto, model);
            } else if (tool.getCode().equals("json")) {
                model.addAttribute(RESULT, GsonUtil.format(toolDto.getData()));
            } else if (tool.getCode().equals("js")) {
                model.addAttribute(RESULT, CompressorUtil.compressJS(toolDto.getData()));
            } else if (tool.getCode().equals("css")) {
                model.addAttribute(RESULT, CompressorUtil.compressCSS(toolDto.getData()));
            } else if (tool.getCode().equals("idcard")) {
                idcardHandle(toolDto, model);
            } else if (tool.getCode().equals("gencard")) {
                model.addAttribute("cityCodes", IDCardUtil.getCityCodes());
                model.addAttribute(RESULT, IDCardUtil.genIdCard(toolDto.getProv(), toolDto.getStartAge(), toolDto.getEndAge(), toolDto.getSex(), toolDto.getLen(), toolDto.getCount()));
            } else if (tool.getCode().equals("charset")) {
                model.addAttribute(RESULT, CharsetUtil.convert(toolDto.getData(), toolDto.getCharset()));
            } else if (tool.getCode().equals("bazi")) {
                bazihandle(toolDto, model);
            } else if (tool.getCode().equals("compare")) {
                compareHandle(props, model);
            } else {
                model.addAttribute(AppConstants.RESP_CO, Resp.FAILURE.getRespCo());
                model.addAttribute(AppConstants.RESP_MSG, "暂不支持此工具");
            }
        } catch (Exception e) {
            log.error("工具调用异常", e);
            model.addAttribute(AppConstants.RESP_CO, Resp.FAILURE.getRespCo());
            model.addAttribute(AppConstants.RESP_MSG, e.getMessage() == null ? Resp.FAILURE.getRespMsg() : e.getMessage());
        }
    }

    /**
     * properties文件对比
     *
     * @param files
     * @param model
     * @throws Exception
     */
    private void compareHandle(MultipartFile[] files, Model model) throws Exception {
        StringBuilder result = new StringBuilder();
        if (files.length != 2) {
            result.append("请选择两个properties文件");
            model.addAttribute(RESULT, result.toString());
            return;
        }

        Properties propLeft = PropertiesUtil.readProperties(files[0].getInputStream());
        Properties propRight = PropertiesUtil.readProperties(files[1].getInputStream());

        // 文件1中有但是文件2中没有的key
        List<String> leftHasOnly = compare(propLeft, propRight);

        // 文件2中有但是文件1中没有的key
        List<String> rightHasOnly = compare(propRight, propLeft);

        // 两个文件中都有，但是值不一样的key
        List<String> diff = diff(propLeft, propRight);

        if (!leftHasOnly.isEmpty()) {
            result.append("================================================================\n");
            result.append("文件一独有的key：\n");
            for (String key : leftHasOnly) {
                result.append(key).append("\n");
            }
            result.append("================================================================\n\n\n\n");
        }

        if (!rightHasOnly.isEmpty()) {
            result.append("================================================================\n");
            result.append("文件二独有的key：\n");
            for (String key : rightHasOnly) {
                result.append(key).append("\n");
            }
            result.append("================================================================\n\n\n\n");
        }

        if (!diff.isEmpty()) {
            result.append("================================================================\n");
            result.append("key一样但是值不一样的：\n");
            for (String key : diff) {
                result.append(key).append("\n");
            }
            result.append("================================================================\n\n\n\n");
        }

        if (result.length() == 0) {
            result.append("两个文件key和value都是一样的");
        }

        model.addAttribute(RESULT, result.toString());
    }

    /**
     * 八字、五行
     *
     * @param toolDto
     * @param model
     * @throws Exception
     */
    private void bazihandle(ToolDto toolDto, Model model) throws Exception {
        String bazi;
        String yinli;
        String yangli;
        if (toolDto.getLunar().equals("0")) {
            bazi = DestinyUtil.getEightWord4Lunar(toolDto.getYear(), toolDto.getMonth(), toolDto.getDay(), toolDto.getHour());
            yinli = LocalDate.of(toolDto.getYear(), toolDto.getMonth(), toolDto.getDay()).format(DateTimeFormatter.BASIC_ISO_DATE);
            yangli = CalendarUtil.lunarToSolar(yinli);
        } else {
            bazi = DestinyUtil.getEightWord(toolDto.getYear(), toolDto.getMonth(), toolDto.getDay(), toolDto.getHour());
            yangli = LocalDate.of(toolDto.getYear(), toolDto.getMonth(), toolDto.getDay()).format(DateTimeFormatter.BASIC_ISO_DATE);
            yinli = CalendarUtil.solarToLunar(yangli);
        }
        String wuxing = DestinyUtil.getWuXing(bazi);
        String shengxiao = DestinyUtil.getShengXiao(Integer.parseInt(yangli.substring(0, 4)));
        String yunshi = DestinyUtil.getYunShi(wuxing.substring(4, 5), Integer.parseInt(yangli.substring(4, 6)));

        StringBuilder result = new StringBuilder();
        result.append("阴历出生年月：").append(yinli).append("\n");
        result.append("阳历出生年月：").append(yangli).append("\n");
        result.append("生辰八字：").append(bazi).append("\n");
        result.append("五行：").append(wuxing).append("\n");
        result.append(DestinyUtil.wuxing(wuxing));
        result.append("生肖：").append(shengxiao).append("\n");
        result.append("运势：").append(yunshi).append("\n");

        model.addAttribute("result", result.toString());
    }

    /**
     * 身份证查询
     *
     * @param toolDto
     * @param model
     */
    private void idcardHandle(ToolDto toolDto, Model model) {
        String res[] = IDCardUtil.isIdCard(toolDto.getData());
        if (res[0].equals("0")) {
            String year = IDCardUtil.getYearFromIdCard(toolDto.getData());
            model.addAttribute("province", IDCardUtil.getProvinceFromIdCard(toolDto.getData()));
            model.addAttribute("age", IDCardUtil.getAgeFromIdCard(toolDto.getData()));
            model.addAttribute("year", year);
            String month = IDCardUtil.getMonthFromIdCard(toolDto.getData());
            model.addAttribute("month", month);
            String day = IDCardUtil.getDayFromIdCard(toolDto.getData());
            model.addAttribute("day", day);
            model.addAttribute("sex", IDCardUtil.getSexFromIdCard(toolDto.getData()));
            model.addAttribute("area", IDCardUtil.getAreaFromIdCard(toolDto.getData()));
            model.addAttribute("shengXiao", DestinyUtil.getShengXiao(Integer.parseInt(year)));
            model.addAttribute("ganZhi", DestinyUtil.getYearColumn(Integer.parseInt(year)));
            String tianGan = DestinyUtil.getDayColumn(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day)).substring(0, 1);
            model.addAttribute("yunshi", DestinyUtil.getYunShi(DestinyUtil.getTianGanWuXing(tianGan), Integer.parseInt(month)));

            if (toolDto.getData().length() == 15) {
                model.addAttribute("to18", IDCardUtil.convert15To18(toolDto.getData()));
            } else {
                model.addAttribute("to15", IDCardUtil.convert18To15(toolDto.getData()));
            }
        }

        model.addAttribute("isIdCard", res[0].equals("0"));
    }

    /**
     * SQL格式化
     *
     * @param toolDto
     * @param model
     */
    private void sqlHandle(ToolDto toolDto, Model model) {
        String result = "不支持的方言";
        if (Dialect.MySQL.getDialect().equals(toolDto.getDialect())) {
            result = SQLUtils.formatMySql(toolDto.getData());
        } else if (Dialect.Oracle.getDialect().equals(toolDto.getDialect())) {
            result = SQLUtils.formatOracle(toolDto.getData());
        } else if (Dialect.SQLServer.getDialect().equals(toolDto.getDialect())) {
            result = SQLUtils.formatSQLServer(toolDto.getData());
        }

        model.addAttribute("dialects", Dialect.values());
        model.addAttribute(RESULT, result);
    }

    @Override
    public void preHandle(Tool tool, Model model) {
        if (tool.getCode().equals("ascll")) {
            List<Dictionary> asclls = dictionaryService.findDictionariesByType(DictionaryType.ASCLL.getType());
            model.addAttribute("asclls", asclls);
        } else if (tool.getCode().equals("html")) {
            List<Dictionary> htmls = dictionaryService.findDictionariesByType(DictionaryType.HTML.getType());
            model.addAttribute("htmls", htmls);
        } else if (tool.getCode().equals("sql")) {
            model.addAttribute("dialects", Dialect.values());
        } else if (tool.getCode().equals("gencard")) {
            model.addAttribute("cityCodes", IDCardUtil.getCityCodes());
        }
    }

    /**
     * 生成二维码
     *
     * @param toolDto
     * @param model
     * @throws IOException
     * @throws WriterException
     */
    private void qrHandle(ToolDto toolDto, Model model) throws IOException, WriterException {
        String qrName = RandomUtil.getRandomString("QR") + ".png";
        String name = PropertiesUtil.getProperties(AppConstants.FILE_PATH_ROOT) + AppConstants.FILE_UPLOAD + qrName;
        QrCodeUtil.genQrCode(name, toolDto.getData(), toolDto.getSize());
        log.info("二维码生成成功，路径： {}", name);
        model.addAttribute(RESULT, AppConstants.FILE_UPLOAD + qrName);
    }

    /**
     * 二维码解析
     *
     * @param file
     * @param model
     * @throws IOException
     * @throws WriterException
     */
    private void qr2Handle(MultipartFile file, Model model) throws Exception {
        String result = QrCodeUtil.decode(file.getInputStream());
        log.info("二维码解析结果：{}", result);
        model.addAttribute(RESULT, result);
    }

    /**
     * 查找first中有的，但是second中没有的
     *
     * @param first
     * @param second
     * @return
     */
    private List<String> compare(Properties first, Properties second) {
        List<String> list = new ArrayList();

        Set<Object> keys = first.keySet();
        for (Object keyObj : keys) {
            String key = (String) keyObj;
            boolean exist = false;
            Set<Object> keys2 = second.keySet();
            for (Object keyObj2 : keys2) {
                String key2 = (String) keyObj2;
                if (key.equals(key2)) {
                    exist = true;
                }
            }
            if (!exist) {
                list.add(key);
            }
        }

        return list;
    }

    /**
     * 查找key一样，但是值不一样的
     *
     * @param first
     * @param second
     * @return
     */
    private List<String> diff(Properties first, Properties second) {
        List<String> list = new ArrayList();

        Set<Object> keys = first.keySet();
        for (Object keyObj : keys) {
            String key = (String) keyObj;
            boolean flag = false;
            Set<Object> keys2 = second.keySet();
            for (Object keyObj2 : keys2) {
                String key2 = (String) keyObj2;
                if (key.equals(key2)) {
                    if (!first.get(key).equals(second.get(key2))) {
                        // key一样，但是值不一样
                        flag = true;
                    } else {
                        // 值也一样就pass
                        break;
                    }
                }
            }
            if (flag) {
                list.add(key);
            }
        }
        return list;
    }
}
