package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 传奇详情预留 Servlet，本项目演示版统一跳转到传奇列表。
 */
public class LegendDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * doGet 目前重定向到传奇列表。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/legend/list");
    }
}
