package com.apex.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.apex.bean.StrategyNote;
import com.apex.util.DBUtil;

/**
 * 战术笔记 DAO，所有查询、修改和删除都绑定当前 userId。
 */
public class StrategyNoteDao {
    /**
     * 查询当前用户的所有笔记。
     */
    public List<StrategyNote> findByUserId(int userId) {
        List<StrategyNote> notes = new ArrayList<StrategyNote>();
        String sql = "SELECT id, user_id, title, map_name, legend_name, content, create_time, update_time "
                + "FROM t_tactic_note WHERE user_id = ? ORDER BY update_time DESC, id DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    notes.add(mapRowToNote(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notes;
    }

    /**
     * 按笔记 id 和当前用户 id 查询一条笔记。
     */
    public StrategyNote findByIdAndUserId(int id, int userId) {
        String sql = "SELECT id, user_id, title, map_name, legend_name, content, create_time, update_time "
                + "FROM t_tactic_note WHERE id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToNote(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 新增当前用户的战术笔记。
     */
    public boolean add(StrategyNote note) {
        String sql = "INSERT INTO t_tactic_note(user_id, title, map_name, legend_name, content) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, note.getUserId());
            ps.setString(2, note.getTitle());
            ps.setString(3, note.getMapName());
            ps.setString(4, note.getLegendName());
            ps.setString(5, note.getContent());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * 修改当前用户自己的战术笔记。
     */
    public boolean update(StrategyNote note) {
        String sql = "UPDATE t_tactic_note SET title = ?, map_name = ?, legend_name = ?, content = ? "
                + "WHERE id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, note.getTitle());
            ps.setString(2, note.getMapName());
            ps.setString(3, note.getLegendName());
            ps.setString(4, note.getContent());
            ps.setInt(5, note.getId());
            ps.setInt(6, note.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * 删除当前用户自己的战术笔记。
     */
    public boolean delete(int id, int userId) {
        String sql = "DELETE FROM t_tactic_note WHERE id = ? AND user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * 统计全部笔记数量，供管理员看板使用。
     */
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM t_tactic_note";

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
     * 统计当前用户的笔记数量。
     */
    public int countByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM t_tactic_note WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * 把 ResultSet 当前行转换成 StrategyNote 对象。
     */
    private StrategyNote mapRowToNote(ResultSet rs) throws SQLException {
        StrategyNote note = new StrategyNote();
        note.setId(rs.getInt("id"));
        note.setUserId(rs.getInt("user_id"));
        note.setTitle(rs.getString("title"));
        note.setMapName(rs.getString("map_name"));
        note.setLegendName(rs.getString("legend_name"));
        note.setContent(rs.getString("content"));
        note.setCreateTime(rs.getTimestamp("create_time"));
        note.setUpdateTime(rs.getTimestamp("update_time"));
        return note;
    }
}
