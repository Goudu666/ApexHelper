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
    <c:set var="activeNav" value="admin-dashboard" />
    <c:set var="pageMeta" value="ADMIN COMMAND" />
    <c:set var="pageTitle" value="管理员首页" />
    <c:set var="pageSubtitle" value="欢迎，${sessionScope.user.username}。查看系统统计概览。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <section class="hud-card-grid admin-stat-grid">
                <c:forEach var="entry" items="${stats}">
                    <article class="hud-card stat-tile">
                        <span class="hud-label">${entry.key}</span>
                        <strong class="stat-number">${entry.value}</strong>
                    </article>
                </c:forEach>
            </section>
        </main>
    </div>
</body>
</html>
