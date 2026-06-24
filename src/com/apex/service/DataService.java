package com.apex.service;

import java.util.List;

import com.apex.bean.Legend;
import com.apex.bean.PlayerStats;
import com.apex.bean.Weapon;
import com.apex.dao.LegendDao;
import com.apex.dao.PlayerStatsDao;
import com.apex.dao.WeaponDao;

/**
 * 数据 Service，负责传奇、武器和模拟战绩查询。
 */
public class DataService {
    private LegendDao legendDao = new LegendDao();
    private WeaponDao weaponDao = new WeaponDao();
    private PlayerStatsDao playerStatsDao = new PlayerStatsDao();

    /**
     * 查询全部传奇。
     */
    public List<Legend> findAllLegends() {
        return legendDao.findAll();
    }

    /**
     * 查询全部武器。
     */
    public List<Weapon> findAllWeapons() {
        return weaponDao.findAll();
    }

    /**
     * 按玩家昵称查询模拟战绩。
     */
    public List<PlayerStats> searchPlayerStats(String keyword) {
        return playerStatsDao.searchByNickname(keyword);
    }
}
