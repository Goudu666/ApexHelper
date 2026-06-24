<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 管理员用户列表：展示 User JavaBean 字段。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户列表 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="page-shell">
        <div class="topbar">
            <div>
                <h1>用户列表</h1>
                <p class="muted">查看系统账号和角色。</p>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/admin/dashboard">返回后台</a>
        </div>

        <div class="admin-nav">
            <a class="btn" href="${pageContext.request.contextPath}/admin/dashboard">系统统计</a>
            <a class="btn primary" href="${pageContext.request.contextPath}/admin/users">用户列表</a>
            <a class="btn" href="${pageContext.request.contextPath}/admin/logs">系统日志</a>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>角色</th>
                        <th>创建时间</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.username}</td>
                            <td>${user.role}</td>
                            <td>${user.createTime}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
