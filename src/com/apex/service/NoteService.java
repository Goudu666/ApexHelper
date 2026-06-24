package com.apex.service;

import java.util.List;

import com.apex.bean.StrategyNote;
import com.apex.dao.StrategyNoteDao;

/**
 * 战术笔记 Service，负责当前用户自己的笔记业务。
 */
public class NoteService {
    private StrategyNoteDao noteDao = new StrategyNoteDao();

    /**
     * 查询当前用户的笔记列表。
     */
    public List<StrategyNote> findMyNotes(int userId) {
        return noteDao.findByUserId(userId);
    }

    /**
     * 查询当前用户的一条笔记。
     */
    public StrategyNote findMyNote(int id, int userId) {
        return noteDao.findByIdAndUserId(id, userId);
    }

    /**
     * 新增当前用户的笔记。
     */
    public boolean addNote(StrategyNote note) {
        return noteDao.add(note);
    }

    /**
     * 修改当前用户自己的笔记。
     */
    public boolean updateNote(StrategyNote note) {
        return noteDao.update(note);
    }

    /**
     * 删除当前用户自己的笔记。
     */
    public boolean deleteNote(int id, int userId) {
        return noteDao.delete(id, userId);
    }

    /**
     * 判断笔记关键字段是否为空。
     */
    public boolean isInvalid(StrategyNote note) {
        return isBlank(note.getTitle())
                || isBlank(note.getMapName())
                || isBlank(note.getLegendName())
                || isBlank(note.getContent());
    }

    /**
     * 判断字符串是否为空。
     */
    private boolean isBlank(String value) {
        return value == null || value.trim().length() == 0;
    }
}
