package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.service.LogService;
import com.apex.service.UserService;

/**
 * 注册 Servlet，负责普通玩家注册。
 */
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
    private LogService logService = new LogService();

    /**
     * doGet 展示注册页面。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    /**
     * doPost 处理注册表单。
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (userService.isBlank(username) || userService.isBlank(password) || userService.isBlank(confirmPassword)) {
            request.setAttribute("error", "用户名和密码不能为空");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "两次输入的密码不一致");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (userService.usernameExists(username.trim())) {
            request.setAttribute("error", "用户名已存在，请更换用户名");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        boolean success = userService.register(username, password);
        if (success) {
            logService.logGuest(username.trim(), "注册", "新用户注册成功");
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");
        } else {
            request.setAttribute("error", "注册失败，请稍后重试");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
