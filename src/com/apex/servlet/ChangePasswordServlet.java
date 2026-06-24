package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 修改密码预留 Servlet，本项目演示版暂不开放该功能。
 */
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * doGet 返回普通用户首页。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/user/home");
    }
}
