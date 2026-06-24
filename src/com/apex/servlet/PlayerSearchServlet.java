package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.service.DataService;

/**
 * 模拟玩家战绩 Servlet，负责按昵称查询本地模拟数据。
 */
public class PlayerSearchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DataService dataService = new DataService();

    /**
     * doGet 查询模拟玩家战绩。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        request.setAttribute("keyword", keyword == null ? "" : keyword.trim());
        request.setAttribute("statsList", dataService.searchPlayerStats(keyword));
        request.getRequestDispatcher("/pages/player-stat.jsp").forward(request, response);
    }

    /**
     * doPost 转给 doGet，方便搜索表单使用 GET 或 POST。
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
