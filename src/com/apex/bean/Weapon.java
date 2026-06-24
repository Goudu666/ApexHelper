package com.apex.bean;

/**
 * 武器数据 JavaBean，保存武器名称、伤害和推荐场景。
 */
public class Weapon {
    private int id;
    private String name;
    private String weaponType;
    private int damage;
    private String ammoType;
    private String recommendScene;

    public Weapon() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getWeaponType() {
        return weaponType;
    }

    public void setWeaponType(String weaponType) {
        this.weaponType = weaponType;
    }

    public int getDamage() {
        return damage;
    }

    public void setDamage(int damage) {
        this.damage = damage;
    }

    public String getAmmoType() {
        return ammoType;
    }

    public void setAmmoType(String ammoType) {
        this.ammoType = ammoType;
    }

    public String getRecommendScene() {
        return recommendScene;
    }

    public void setRecommendScene(String recommendScene) {
        this.recommendScene = recommendScene;
    }
}
