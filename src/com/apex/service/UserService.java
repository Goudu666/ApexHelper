package com.apex.service;

import java.util.List;

import com.apex.bean.User;
import com.apex.dao.UserDao;

/**
 * 用户 Service，负责注册、登录和用户列表业务。
 */
public class UserService {
    private UserDao userDao = new UserDao();

    /**
     * 判断字符串是否为空。
     */
    public boolean isBlank(String value) {
        return value == null || value.trim().length() == 0;
    }

    /**
     * 检查用户名是否已经存在。
     */
    public boolean usernameExists(String username) {
        return userDao.findByUsername(username) != null;
    }

    /**
     * 注册普通用户。
     */
    public boolean register(String username, String password) {
        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(password);
        user.setAvatar("static/img/default-avatar.png");
        user.setRole("user");
        return userDao.register(user);
    }

    /**
     * 根据用户名和密码登录。
     */
    public User login(String username, String password) {
        return userDao.login(username, password);
    }

    /**
     * 查询全部用户。
     */
    public List<User> findAllUsers() {
        return userDao.findAll();
    }
}
