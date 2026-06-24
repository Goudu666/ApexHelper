package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.service.DataService;

/**
 * 传奇列表 Servlet，负责展示数据库中的传奇资料。
 */
public class LegendListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DataService dataService = new DataService();

    /**
     * doGet 查询传奇列表并转发到 JSP。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("legends", dataService.findAllLegends());
        request.getRequestDispatcher("/pages/legend-list.jsp").forward(request, response);
    }
}
