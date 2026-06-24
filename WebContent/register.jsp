<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 注册页：普通玩家注册，c:if 用来判断是否显示错误。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户注册 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="page-shell auth-shell">
        <div class="panel">
            <h1>用户注册</h1>
            <p class="muted">注册账号默认角色为普通用户。</p>

            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" class="form">
                <label>用户名
                    <input type="text" name="username" value="${param.username}" autocomplete="username">
                </label>
                <label>密码
                    <input type="password" name="password" autocomplete="new-password">
                </label>
                <label>确认密码
                    <input type="password" name="confirmPassword" autocomplete="new-password">
                </label>
                <button type="submit" class="btn primary full">注册</button>
            </form>

            <p class="tip">已有账号？<a href="${pageContext.request.contextPath}/login.jsp">去登录</a></p>
        </div>
    </div>
</body>
</html>
