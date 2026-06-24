package com.apex.dao;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 统计 DAO，组合多个基础 DAO 的数量查询。
 */
public class StatsDao {
    private UserDao userDao = new UserDao();
    private StrategyNoteDao noteDao = new StrategyNoteDao();
    private LegendDao legendDao = new LegendDao();
    private WeaponDao weaponDao = new WeaponDao();

    /**
     * 查询管理员看板需要的统计数字。
     */
    public Map<String, Integer> getAdminStats() {
        Map<String, Integer> stats = new LinkedHashMap<String, Integer>();
        stats.put("用户数量", Integer.valueOf(userDao.countUsers()));
        stats.put("笔记数量", Integer.valueOf(noteDao.countAll()));
        stats.put("传奇数量", Integer.valueOf(legendDao.countLegends()));
        stats.put("武器数量", Integer.valueOf(weaponDao.countWeapons()));
        return stats;
    }

    /**
     * 查询当前用户自己的笔记数量。
     */
    public int countMyNotes(int userId) {
        return noteDao.countByUserId(userId);
    }
}
