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
    <c:set var="activeNav" value="admin-users" />
    <c:set var="pageMeta" value="USER ROSTER" />
    <c:set var="pageTitle" value="用户列表" />
    <c:set var="pageSubtitle" value="查看系统账号和角色。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <section class="hud-panel">
                <div class="panel-heading">
                    <div>
                        <span class="hud-label">ACCOUNT LIST</span>
                        <h2>系统账号</h2>
                    </div>
                </div>

                <div class="table-wrap compact-table">
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
            </section>
        </main>
    </div>
</body>
</html>
