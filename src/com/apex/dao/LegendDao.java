package com.apex.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.apex.bean.Legend;
import com.apex.util.DBUtil;

/**
 * 传奇 DAO，负责读取 t_legend 表。
 */
public class LegendDao {
    /**
     * 查询所有传奇数据。
     */
    public List<Legend> findAll() {
        List<Legend> legends = new ArrayList<Legend>();
        String sql = "SELECT id, name, english_name, position, skill_desc, tactic_tip FROM t_legend ORDER BY id ASC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                legends.add(mapRowToLegend(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return legends;
    }

    /**
     * 根据 id 查询单个传奇。
     */
    public Legend findById(int id) {
        String sql = "SELECT id, name, english_name, position, skill_desc, tactic_tip FROM t_legend WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToLegend(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * 统计传奇数量。
     */
    public int countLegends() {
        String sql = "SELECT COUNT(*) FROM t_legend";

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
     * 把 ResultSet 当前行转换成 Legend 对象。
     */
    private Legend mapRowToLegend(ResultSet rs) throws SQLException {
        Legend legend = new Legend();
        legend.setId(rs.getInt("id"));
        legend.setName(rs.getString("name"));
        legend.setEnglishName(rs.getString("english_name"));
        legend.setPosition(rs.getString("position"));
        legend.setSkillDesc(rs.getString("skill_desc"));
        legend.setTacticTip(rs.getString("tactic_tip"));
        return legend;
    }
}
