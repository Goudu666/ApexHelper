package com.apex.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.apex.bean.User;

/**
 * 登录过滤器，负责登录拦截和管理员页面权限检查。
 */
public class LoginFilter implements Filter {
    /**
     * doFilter 在请求进入 Servlet/JSP 前执行。
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // ServletRequest 需要转成 HttpServletRequest 才能读取 URI 和 Session。
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String contextPath = httpRequest.getContextPath();
        String requestPath = httpRequest.getRequestURI().substring(contextPath.length());

        if (isPublicPath(requestPath)) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = httpRequest.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");

        if (user == null) {
            httpResponse.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        if (requestPath.startsWith("/admin/") && !"admin".equals(user.getRole())) {
            httpResponse.sendRedirect(contextPath + "/user/home?error=forbidden");
            return;
        }

        chain.doFilter(request, response);
    }

    /**
     * 判断是否是不需要登录的公开路径。
     */
    private boolean isPublicPath(String requestPath) {
        return requestPath.equals("/")
                || requestPath.equals("/index.jsp")
                || requestPath.equals("/login.jsp")
                || requestPath.equals("/register.jsp")
                || requestPath.equals("/login")
                || requestPath.equals("/register")
                || requestPath.equals("/favicon.ico")
                || requestPath.startsWith("/static/")
                || requestPath.endsWith(".css")
                || requestPath.endsWith(".js")
                || requestPath.endsWith(".png")
                || requestPath.endsWith(".jpg")
                || requestPath.endsWith(".jpeg")
                || requestPath.endsWith(".gif")
                || requestPath.endsWith(".svg")
                || requestPath.endsWith(".webp")
                || requestPath.endsWith(".ico")
                || requestPath.endsWith(".woff")
                || requestPath.endsWith(".woff2")
                || requestPath.endsWith(".ttf")
                || requestPath.endsWith(".map");
    }
}
