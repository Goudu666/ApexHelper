package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.apex.bean.User;
import com.apex.service.LogService;

/**
 * 退出 Servlet，负责清除 Session 并回到登录页。
 */
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LogService logService = new LogService();

    /**
     * doGet 和 doPost 都执行退出登录。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logout(request, response);
    }

    /**
     * doPost 也允许退出，方便表单按钮使用。
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logout(request, response);
    }

    /**
     * 清除 Session 并重定向到登录页。
     */
    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            logService.log(user, "退出", "用户退出登录");
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
