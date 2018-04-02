package com.kangyonggan.blog.exception;

import lombok.extern.log4j.Log4j2;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author kangyonggan
 * @date 16/9/25
 */
@Log4j2
public class CustomSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver {

    @Override
    protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        log.error("控制器异常", ex);
        String viewName = determineViewName(ex, request);
        if (viewName != null) {
            // ftl格式返回
            boolean isCommonReq = !(request.getHeader("accept").contains("application/json") || (request.getHeader("X-Requested-With") != null && request
                    .getHeader("X-Requested-With").contains("XMLHttpRequest")));
            if (isCommonReq) {
                // 如果不是异步请求
                // Apply HTTP status code for error views, if specified.
                // Only apply it if we're processing a top-level request.
                Integer statusCode = determineStatusCode(request, viewName);
                if (statusCode != null) {
                    applyStatusCodeIfPossible(request, response, statusCode);
                }
                return getModelAndView(viewName, ex, request);
            } else {// 返回内嵌界面
                return getModelAndView("dashboard/" + viewName, ex, request);
            }
        } else {
            return null;
        }
    }
}
