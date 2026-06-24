package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.service.AdminService;

/**
 * 管理员用户列表 Servlet，负责展示系统用户。
 */
public class AdminUserListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AdminService adminService = new AdminService();

    /**
     * doGet 查询用户列表并转发到 JSP。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("users", adminService.findAllUsers());
        request.getRequestDispatcher("/pages/admin-users.jsp").forward(request, response);
    }
}
