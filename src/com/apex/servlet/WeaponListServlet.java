package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.service.DataService;

/**
 * 武器列表 Servlet，负责展示数据库中的武器资料。
 */
public class WeaponListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DataService dataService = new DataService();

    /**
     * doGet 查询武器列表并转发到 JSP。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("weapons", dataService.findAllWeapons());
        request.getRequestDispatcher("/pages/weapon-list.jsp").forward(request, response);
    }
}
