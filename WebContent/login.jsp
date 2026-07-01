<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 登录页：表单提交到 /login，错误信息用 EL 输出。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>登录 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="auth-console">
        <section class="auth-copy">
            <p class="hud-kicker">APEX//HELPER</p>
            <h1>TACTICAL COMPANION</h1>
            <p>登录后进入战术整备面板，查看传奇、武器、笔记和模拟战绩。</p>
            <div class="auth-codes">
                <span>普通用户：player / player123</span>
                <span>管理员：admin / admin123</span>
            </div>
        </section>

        <div class="panel auth-panel">
            <h1>用户登录</h1>
            <p class="muted">输入账号进入对应控制台。</p>

            <c:if test="${param.registered == '1'}">
                <div class="message success">注册成功，请登录。</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" class="form">
                <label>用户名
                    <input type="text" name="username" value="${param.username}" autocomplete="username">
                </label>
                <label>密码
                    <input type="password" name="password" autocomplete="current-password">
                </label>
                <button type="submit" class="btn primary full">登录</button>
            </form>

            <p class="tip">还没有账号？<a href="${pageContext.request.contextPath}/register.jsp">去注册</a></p>
            <p class="tip"><a href="${pageContext.request.contextPath}/index.jsp">返回首页</a></p>
        </div>
    </div>
</body>
</html>
