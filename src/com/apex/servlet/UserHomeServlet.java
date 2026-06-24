package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.bean.User;
import com.apex.service.NoteService;

/**
 * 普通用户首页 Servlet，负责显示欢迎信息和个人统计。
 */
public class UserHomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoteService noteService = new NoteService();

    /**
     * doGet 展示普通玩家控制台。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        request.setAttribute("noteCount", Integer.valueOf(noteService.findMyNotes(user.getId()).size()));
        request.getRequestDispatcher("/pages/user-home.jsp").forward(request, response);
    }
}
