package com.apex.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.apex.bean.Weapon;
import com.apex.util.DBUtil;

/**
 * 武器 DAO，负责读取 t_weapon 表。
 */
public class WeaponDao {
    /**
     * 查询所有武器数据。
     */
    public List<Weapon> findAll() {
        List<Weapon> weapons = new ArrayList<Weapon>();
        String sql = "SELECT id, name, english_name, weapon_type, damage, head_damage, ammo_type, recommend_scene "
                + "FROM t_weapon ORDER BY id ASC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                weapons.add(mapRowToWeapon(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return weapons;
    }

    /**
     * 统计武器数量。
     */
    public int countWeapons() {
        String sql = "SELECT COUNT(*) FROM t_weapon";

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
     * 把 ResultSet 当前行转换成 Weapon 对象。
     */
    private Weapon mapRowToWeapon(ResultSet rs) throws SQLException {
        Weapon weapon = new Weapon();
        weapon.setId(rs.getInt("id"));
        weapon.setName(rs.getString("name"));
        weapon.setEnglishName(rs.getString("english_name"));
        weapon.setWeaponType(rs.getString("weapon_type"));
        weapon.setDamage(rs.getInt("damage"));
        weapon.setHeadDamage(rs.getInt("head_damage"));
        weapon.setAmmoType(rs.getString("ammo_type"));
        weapon.setRecommendScene(rs.getString("recommend_scene"));
        return weapon;
    }
}
