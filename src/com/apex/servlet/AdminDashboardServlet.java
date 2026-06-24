package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.service.AdminService;

/**
 * 管理员统计 Servlet，负责后台首页统计。
 */
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminService adminService = new AdminService();

    /**
     * doGet 展示管理员统计页。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("stats", adminService.getDashboardStats());
        request.getRequestDispatcher("/pages/admin-dashboard.jsp").forward(request, response);
    }
}
