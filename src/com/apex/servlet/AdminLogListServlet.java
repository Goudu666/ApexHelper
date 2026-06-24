package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.service.AdminService;

/**
 * 管理员日志 Servlet，负责展示系统操作日志。
 */
public class AdminLogListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminService adminService = new AdminService();

    /**
     * doGet 查询日志列表并转发到 JSP。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("logs", adminService.findAllLogs());
        request.getRequestDispatcher("/pages/admin-logs.jsp").forward(request, response);
    }
}
