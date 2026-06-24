package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.apex.bean.User;
import com.apex.service.LogService;
import com.apex.service.UserService;

/**
 * 登录 Servlet，负责校验账号并写入 Session。
 */
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService = new UserService();
    private LogService logService = new LogService();

    /**
     * doGet 处理直接访问 /login 的请求，转发到登录页。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // forward 是服务器内部跳转，地址栏不会变。
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    /**
     * doPost 处理登录表单提交。
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // request.getParameter(...) 用来读取表单字段。
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (userService.isBlank(username) || userService.isBlank(password)) {
            // request.setAttribute(...) 把错误信息带回 JSP。
            request.setAttribute("error", "用户名和密码不能为空");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        User user = userService.login(username.trim(), password);
        if (user == null) {
            request.setAttribute("error", "用户名或密码错误");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // request.getSession() 会取得当前 Session，没有则新建。
        HttpSession session = request.getSession();
        // session.setAttribute(...) 保存登录用户，key 必须统一为 user。
        session.setAttribute("user", user);
        logService.log(user, "登录", "用户登录系统");

        // sendRedirect 是浏览器重定向，路径要带项目上下文。
        if ("admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/home");
        }
    }
}
