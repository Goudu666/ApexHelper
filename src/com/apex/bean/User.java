package com.apex.bean;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * 用户 JavaBean，保存登录用户、角色和创建时间。
 */
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String username;
    private String password;
    private String avatar;
    private String role;
    private Timestamp createTime;

    public User() {
    }

    public User(int id, String username, String password, String avatar, String role, Timestamp createTime) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.avatar = avatar;
        this.role = role;
        this.createTime = createTime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", avatar='" + avatar + '\'' +
                ", role='" + role + '\'' +
                ", createTime=" + createTime +
                '}';
    }
}
