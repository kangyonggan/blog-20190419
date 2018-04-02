package com.kangyonggan.blog.servlet;

import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.servlet.DispatcherServlet;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author kangyonggan
 * @date 4/2/18
 */
public class MyDispatcherServlet extends DispatcherServlet {

    @Override
    protected ModelAndView processHandlerException(HttpServletRequest request, HttpServletResponse response,
                                                   Object handler, Exception ex) throws Exception {
        if (ex instanceof HttpRequestMethodNotSupportedException) {
            boolean isCommonReq = !(request.getHeader("accept").contains("application/json") || (request.getHeader("X-Requested-With") != null && request
                    .getHeader("X-Requested-With").contains("XMLHttpRequest")));
            if (isCommonReq) {
                return new ModelAndView("405");
            } else {
                return new ModelAndView("dashboard/405");
            }
        } else {
            return super.processHandlerException(request, response, handler, ex);
        }
    }
}
