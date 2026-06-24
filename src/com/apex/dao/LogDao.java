package com.apex.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.apex.bean.LogRecord;
import com.apex.util.DBUtil;

/**
 * 系统日志 DAO，负责写入和查询 t_system_log 表。
 */
public class LogDao {
    /**
     * 写入一条系统日志。
     */
    public boolean addLog(Integer userId, String username, String actionType, String actionContent) {
        String sql = "INSERT INTO t_system_log(user_id, username, action_type, action_content) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            if (userId == null) {
                ps.setNull(1, java.sql.Types.INTEGER);
            } else {
                ps.setInt(1, userId.intValue());
            }
            ps.setString(2, username);
            ps.setString(3, actionType);
            ps.setString(4, actionContent);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * 查询最近的系统日志。
     */
    public List<LogRecord> findAll() {
        List<LogRecord> logs = new ArrayList<LogRecord>();
        String sql = "SELECT id, user_id, username, action_type, action_content, create_time "
                + "FROM t_system_log ORDER BY create_time DESC, id DESC LIMIT 200";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                logs.add(mapRowToLog(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return logs;
    }

    /**
     * 把 ResultSet 当前行转换成 LogRecord 对象。
     */
    private LogRecord mapRowToLog(ResultSet rs) throws SQLException {
        LogRecord log = new LogRecord();
        int userId = rs.getInt("user_id");
        log.setUserId(rs.wasNull() ? null : Integer.valueOf(userId));
        log.setId(rs.getInt("id"));
        log.setUsername(rs.getString("username"));
        log.setActionType(rs.getString("action_type"));
        log.setActionContent(rs.getString("action_content"));
        log.setCreateTime(rs.getTimestamp("create_time"));
        return log;
    }
}
