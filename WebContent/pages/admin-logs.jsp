<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 管理员日志页：展示注册、登录、笔记操作等系统日志。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>系统日志 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="page-shell">
        <div class="topbar">
            <div>
                <h1>系统日志</h1>
                <p class="muted">最近 200 条关键操作记录。</p>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/admin/dashboard">返回后台</a>
        </div>

        <div class="admin-nav">
            <a class="btn" href="${pageContext.request.contextPath}/admin/dashboard">系统统计</a>
            <a class="btn" href="${pageContext.request.contextPath}/admin/users">用户列表</a>
            <a class="btn primary" href="${pageContext.request.contextPath}/admin/logs">系统日志</a>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>操作用户</th>
                        <th>操作类型</th>
                        <th>操作内容</th>
                        <th>操作时间</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="log" items="${logs}">
                        <tr>
                            <td>${log.id}</td>
                            <td>${log.username}</td>
                            <td>${log.actionType}</td>
                            <td>${log.actionContent}</td>
                            <td>${log.createTime}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty logs}">
                        <tr>
                            <td colspan="5" class="empty">暂无日志。</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
