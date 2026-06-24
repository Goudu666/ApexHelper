package com.apex.service;

import java.util.List;
import java.util.Map;

import com.apex.bean.LogRecord;
import com.apex.bean.User;
import com.apex.dao.LogDao;
import com.apex.dao.StatsDao;

/**
 * 管理员 Service，负责后台统计、用户列表和日志列表。
 */
public class AdminService {
    private StatsDao statsDao = new StatsDao();
    private UserService userService = new UserService();
    private LogDao logDao = new LogDao();

    /**
     * 查询后台首页统计数字。
     */
    public Map<String, Integer> getDashboardStats() {
        return statsDao.getAdminStats();
    }

    /**
     * 查询用户列表。
     */
    public List<User> findAllUsers() {
        return userService.findAllUsers();
    }

    /**
     * 查询系统日志列表。
     */
    public List<LogRecord> findAllLogs() {
        return logDao.findAll();
    }
}
