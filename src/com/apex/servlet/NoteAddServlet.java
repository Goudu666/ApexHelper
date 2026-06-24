package com.apex.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.apex.bean.StrategyNote;
import com.apex.bean.User;
import com.apex.service.LogService;
import com.apex.service.NoteService;

/**
 * 新增笔记 Servlet，负责展示新增表单和保存笔记。
 */
public class NoteAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoteService noteService = new NoteService();
    private LogService logService = new LogService();

    /**
     * doGet 展示新增笔记页面。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("formTitle", "新增战术笔记");
        request.setAttribute("formAction", request.getContextPath() + "/note/add");
        request.getRequestDispatcher("/pages/note-form.jsp").forward(request, response);
    }

    /**
     * doPost 保存新增笔记。
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        StrategyNote note = buildNoteFromRequest(request, user.getId());

        if (noteService.isInvalid(note)) {
            request.setAttribute("error", "标题、地图、传奇和内容都不能为空");
            request.setAttribute("note", note);
            request.setAttribute("formTitle", "新增战术笔记");
            request.setAttribute("formAction", request.getContextPath() + "/note/add");
            request.getRequestDispatcher("/pages/note-form.jsp").forward(request, response);
            return;
        }

        if (noteService.addNote(note)) {
            logService.log(user, "新增笔记", "新增战术笔记：" + note.getTitle());
            response.sendRedirect(request.getContextPath() + "/note/list");
        } else {
            request.setAttribute("error", "新增失败，请稍后重试");
            request.setAttribute("note", note);
            request.setAttribute("formTitle", "新增战术笔记");
            request.setAttribute("formAction", request.getContextPath() + "/note/add");
            request.getRequestDispatcher("/pages/note-form.jsp").forward(request, response);
        }
    }

    /**
     * 从请求参数组装笔记对象。
     */
    private StrategyNote buildNoteFromRequest(HttpServletRequest request, int userId) {
        StrategyNote note = new StrategyNote();
        note.setUserId(userId);
        note.setTitle(trim(request.getParameter("title")));
        note.setMapName(trim(request.getParameter("mapName")));
        note.setLegendName(trim(request.getParameter("legendName")));
        note.setContent(trim(request.getParameter("content")));
        return note;
    }

    /**
     * 去掉表单字符串两端空格。
     */
    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
