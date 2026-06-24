package com.apex.service;

import com.apex.bean.User;
import com.apex.dao.LogDao;

/**
 * 日志 Service，负责记录用户关键操作。
 */
public class LogService {
    private LogDao logDao = new LogDao();

    /**
     * 记录已登录用户的操作。
     */
    public void log(User user, String actionType, String actionContent) {
        if (user == null) {
            logDao.addLog(null, "guest", actionType, actionContent);
        } else {
            logDao.addLog(Integer.valueOf(user.getId()), user.getUsername(), actionType, actionContent);
        }
    }

    /**
     * 记录未登录或刚注册用户的操作。
     */
    public void logGuest(String username, String actionType, String actionContent) {
        logDao.addLog(null, username, actionType, actionContent);
    }
}
