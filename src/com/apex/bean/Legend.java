package com.apex.bean;

/**
 * 传奇数据 JavaBean，保存页面展示用的传奇资料。
 */
public class Legend {
    private int id;
    private String name;
    private String englishName;
    private String position;
    private String skillDesc;
    private String tacticTip;

    public Legend() {
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

    public String getEnglishName() {
        return englishName;
    }

    public void setEnglishName(String englishName) {
        this.englishName = englishName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getSkillDesc() {
        return skillDesc;
    }

    public void setSkillDesc(String skillDesc) {
        this.skillDesc = skillDesc;
    }

    public String getTacticTip() {
        return tacticTip;
    }

    public void setTacticTip(String tacticTip) {
        this.tacticTip = tacticTip;
    }
}
