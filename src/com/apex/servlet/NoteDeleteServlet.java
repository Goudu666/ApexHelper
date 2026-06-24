package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.bean.User;
import com.apex.service.LogService;
import com.apex.service.NoteService;

/**
 * 删除笔记 Servlet，负责删除当前用户自己的笔记。
 */
public class NoteDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoteService noteService = new NoteService();
    private LogService logService = new LogService();

    /**
     * doPost 删除笔记，删除时绑定当前登录用户 id。
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int id = parseId(request.getParameter("id"));

        if (id > 0 && noteService.deleteNote(id, user.getId())) {
            logService.log(user, "删除笔记", "删除战术笔记，id=" + id);
            response.sendRedirect(request.getContextPath() + "/note/list");
        } else {
            response.sendRedirect(request.getContextPath() + "/note/list?error=delete");
        }
    }

    /**
     * doGet 也跳转回列表，避免误用链接删除。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/note/list");
    }

    /**
     * 安全解析 id 参数。
     */
    private int parseId(String idValue) {
        try {
            return Integer.parseInt(idValue);
        } catch (Exception e) {
            return 0;
        }
    }
}
