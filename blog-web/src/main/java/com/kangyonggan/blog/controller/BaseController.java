package com.kangyonggan.blog.controller;

import com.kangyonggan.blog.constants.AppConstants;
import com.kangyonggan.blog.constants.Resp;
import com.kangyonggan.blog.util.StringUtil;
import lombok.extern.log4j.Log4j2;
import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringUtils;

import java.util.Map;

/**
 * @author kangyonggan
 * @since 2016/12/10
 */
@Log4j2
public class BaseController {

    private String PATH_ROOT;
    private static final String LIST = "/list";
    private static final String INDEX = "/index";
    private static final String FORM = "/form";
    private static final String FORM_MODAL = "/form-modal";
    private static final String DETAIL = "/detail";
    private static final String DETAIL_MODAL = "/detail-modal";
    private static final String TABLE_TR = "/table-tr";

    public BaseController() {
        String className = getClass().getSimpleName();
        String arr[] = StringUtil.camelToArray(className);

        PATH_ROOT = "";
        for (int i = 0; i < arr.length - 1; i++) {
            if (i != 0) {
                PATH_ROOT += "/";
            }
            PATH_ROOT += arr[i];
        }

        if (!PATH_ROOT.startsWith("dashboard")) {
            PATH_ROOT = "web/" + PATH_ROOT;
        }
    }

    protected String getPathRoot() {
        return PATH_ROOT;
    }

    protected String getPathIndex() {
        return PATH_ROOT + INDEX;
    }

    protected String getPathList() {
        return PATH_ROOT + LIST;
    }

    protected String getPathForm() {
        return PATH_ROOT + FORM;
    }

    protected String getPathDetail() {
        return PATH_ROOT + DETAIL;
    }

    protected String getPathFormModal() {
        return PATH_ROOT + FORM_MODAL;
    }

    protected String getPathDetailModal() {
        return PATH_ROOT + DETAIL_MODAL;
    }

    protected String getPathTableTr() {
        return PATH_ROOT + TABLE_TR;
    }

    protected Map<String, Object> getResultMap() {
        Map<String, Object> resultMap = new HashedMap();
        resultMap.put(AppConstants.RESP_CO, Resp.SUCCESS.getRespCo());
        resultMap.put(AppConstants.RESP_MSG, Resp.SUCCESS.getRespMsg());

        return resultMap;
    }

    protected void setResultMapFailure(Map<String, Object> resultMap) {
        setResultMapFailure(resultMap, null);
    }

    protected void setResultMapFailure(Map<String, Object> resultMap, String msg) {
        resultMap.put(AppConstants.RESP_CO, Resp.FAILURE.getRespCo());
        resultMap.put(AppConstants.RESP_MSG, StringUtils.isEmpty(msg) ? Resp.FAILURE.getRespMsg() : msg);
    }

}

