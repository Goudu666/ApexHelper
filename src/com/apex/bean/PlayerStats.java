package com.apex.bean;

/**
 * 模拟玩家战绩 JavaBean，数据来自本地初始化表。
 */
public class PlayerStats {
    private int id;
    private String nickname;
    private String rankName;
    private int totalKills;
    private int totalDamage;
    private int wins;
    private String mainLegend;

    public PlayerStats() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getRankName() {
        return rankName;
    }

    public void setRankName(String rankName) {
        this.rankName = rankName;
    }

    public int getTotalKills() {
        return totalKills;
    }

    public void setTotalKills(int totalKills) {
        this.totalKills = totalKills;
    }

    public int getTotalDamage() {
        return totalDamage;
    }

    public void setTotalDamage(int totalDamage) {
        this.totalDamage = totalDamage;
    }

    public int getWins() {
        return wins;
    }

    public void setWins(int wins) {
        this.wins = wins;
    }

    public String getMainLegend() {
        return mainLegend;
    }

    public void setMainLegend(String mainLegend) {
        this.mainLegend = mainLegend;
    }
}
