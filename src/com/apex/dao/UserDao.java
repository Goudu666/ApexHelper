package com.apex.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.apex.bean.User;
import com.apex.util.DBUtil;

/**
 * 用户 DAO，负责 t_user 表的注册、登录和列表查询。
 */
public class UserDao {

    /**
     * 根据用户名查询用户。
     */
    public User findByUsername(String username) {
        String sql = "SELECT id, username, password, avatar, role, create_time FROM t_user WHERE username = ?";

        // try-with-resources 会自动关闭数据库资源。
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            // PreparedStatement 用 ? 绑定用户输入，避免 SQL 注入。
            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 注册新用户。
     */
    public boolean register(User user) {
        String sql = "INSERT INTO t_user(username, password, avatar, role) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getAvatar());
            ps.setString(4, user.getRole() == null ? "user" : user.getRole());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * 根据用户名和密码登录。
     */
    public User login(String username, String password) {
        String sql = "SELECT id, username, password, avatar, role, create_time "
                + "FROM t_user WHERE username = ? AND password = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 查询全部用户，供管理员查看。
     */
    public List<User> findAll() {
        List<User> users = new ArrayList<User>();
        String sql = "SELECT id, username, password, avatar, role, create_time FROM t_user ORDER BY id ASC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            // List<T> 用来保存多条查询结果。
            while (rs.next()) {
                users.add(mapRowToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    /**
     * 统计用户数量。
     */
    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM t_user";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 把 ResultSet 当前行转换成 User 对象。
     */
    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setAvatar(rs.getString("avatar"));
        user.setRole(rs.getString("role"));
        user.setCreateTime(rs.getTimestamp("create_time"));
        return user;
    }
}
