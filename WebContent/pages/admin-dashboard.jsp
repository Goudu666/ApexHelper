<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 管理员首页：遍历 stats 这个 Map 展示统计项。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理员首页 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="page-shell">
        <div class="topbar">
            <div>
                <h1>管理员首页</h1>
                <p class="muted">欢迎，${sessionScope.user.username}</p>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/logout">退出登录</a>
        </div>

        <div class="admin-nav">
            <a class="btn primary" href="${pageContext.request.contextPath}/admin/dashboard">系统统计</a>
            <a class="btn" href="${pageContext.request.contextPath}/admin/users">用户列表</a>
            <a class="btn" href="${pageContext.request.contextPath}/admin/logs">系统日志</a>
        </div>

        <div class="grid cards">
            <c:forEach var="entry" items="${stats}">
                <div class="card">
                    <h2>${entry.key}</h2>
                    <p class="stat-number">${entry.value}</p>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
