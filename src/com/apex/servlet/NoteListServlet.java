package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.bean.User;
import com.apex.service.NoteService;

/**
 * 笔记列表 Servlet，负责查看当前用户自己的战术笔记。
 */
public class NoteListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoteService noteService = new NoteService();

    /**
     * doGet 查询当前登录用户的笔记列表。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        request.setAttribute("notes", noteService.findMyNotes(user.getId()));
        request.getRequestDispatcher("/pages/note-list.jsp").forward(request, response);
    }
}
