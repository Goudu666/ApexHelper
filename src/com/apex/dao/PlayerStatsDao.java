package com.apex.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.apex.bean.PlayerStats;
import com.apex.util.DBUtil;

/**
 * 模拟玩家战绩 DAO，负责查询 t_player_stat 表。
 */
public class PlayerStatsDao {
    /**
     * 按昵称模糊查询；关键词为空时返回全部模拟数据。
     */
    public List<PlayerStats> searchByNickname(String keyword) {
        List<PlayerStats> statsList = new ArrayList<PlayerStats>();
        String sql = "SELECT id, nickname, rank_name, total_kills, total_damage, wins, main_legend "
                + "FROM t_player_stat WHERE nickname LIKE ? ORDER BY total_kills DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            String safeKeyword = keyword == null ? "" : keyword.trim();
            ps.setString(1, "%" + safeKeyword + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    statsList.add(mapRowToStats(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statsList;
    }

    /**
     * 把 ResultSet 当前行转换成 PlayerStats 对象。
     */
    private PlayerStats mapRowToStats(ResultSet rs) throws SQLException {
        PlayerStats stats = new PlayerStats();
        stats.setId(rs.getInt("id"));
        stats.setNickname(rs.getString("nickname"));
        stats.setRankName(rs.getString("rank_name"));
        stats.setTotalKills(rs.getInt("total_kills"));
        stats.setTotalDamage(rs.getInt("total_damage"));
        stats.setWins(rs.getInt("wins"));
        stats.setMainLegend(rs.getString("main_legend"));
        return stats;
    }
}
