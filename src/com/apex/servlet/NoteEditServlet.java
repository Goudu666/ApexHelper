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
 * 编辑笔记 Servlet，负责展示编辑表单和保存修改。
 */
public class NoteEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private NoteService noteService = new NoteService();
    private LogService logService = new LogService();

    /**
     * doGet 展示编辑页面，只能读取当前用户自己的笔记。
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int id = parseId(request.getParameter("id"));
        StrategyNote note = noteService.findMyNote(id, user.getId());

        if (note == null) {
            response.sendRedirect(request.getContextPath() + "/note/list?error=notfound");
            return;
        }

        request.setAttribute("note", note);
        request.setAttribute("formTitle", "编辑战术笔记");
        request.setAttribute("formAction", request.getContextPath() + "/note/edit");
        request.getRequestDispatcher("/pages/note-form.jsp").forward(request, response);
    }

    /**
     * doPost 保存当前用户自己的笔记修改。
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        User user = (User) request.getSession().getAttribute("user");
        StrategyNote note = buildNoteFromRequest(request, user.getId());
        note.setId(parseId(request.getParameter("id")));

        if (note.getId() <= 0 || noteService.isInvalid(note)) {
            request.setAttribute("error", "标题、地图、传奇和内容都不能为空");
            request.setAttribute("note", note);
            request.setAttribute("formTitle", "编辑战术笔记");
            request.setAttribute("formAction", request.getContextPath() + "/note/edit");
            request.getRequestDispatcher("/pages/note-form.jsp").forward(request, response);
            return;
        }

        if (noteService.updateNote(note)) {
            logService.log(user, "修改笔记", "修改战术笔记：" + note.getTitle());
            response.sendRedirect(request.getContextPath() + "/note/list");
        } else {
            request.setAttribute("error", "修改失败，可能不是你的笔记");
            request.setAttribute("note", note);
            request.setAttribute("formTitle", "编辑战术笔记");
            request.setAttribute("formAction", request.getContextPath() + "/note/edit");
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
     * 安全解析 id 参数。
     */
    private int parseId(String idValue) {
        try {
            return Integer.parseInt(idValue);
        } catch (Exception e) {
            return 0;
        }
    }

    /**
     * 去掉表单字符串两端空格。
     */
    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
