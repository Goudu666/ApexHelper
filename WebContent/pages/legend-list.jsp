<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 传奇数据页：c:forEach 遍历 Servlet 放入 request 的 legends。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>传奇数据 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <c:set var="activeNav" value="legend" />
    <c:set var="pageMeta" value="LEGEND INTEL" />
    <c:set var="pageTitle" value="传奇数据" />
    <c:set var="pageSubtitle" value="定位、技能说明和战术建议来自数据库初始化数据。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <section class="hud-list-grid legend-grid">
                <c:forEach var="legend" items="${legends}">
                    <article class="hud-data-card">
                        <div class="hud-data-head">
                            <div>
                                <h2>${legend.name}</h2>
                                <p>${legend.englishName}</p>
                            </div>
                            <span>${legend.position}</span>
                        </div>
                        <div class="hud-data-body">
                            <span class="hud-label">SKILLS</span>
                            <p>${legend.skillDesc}</p>
                        </div>
                        <div class="hud-data-body">
                            <span class="hud-label">TACTIC</span>
                            <p>${legend.tacticTip}</p>
                        </div>
                    </article>
                </c:forEach>
            </section>
        </main>
    </div>
</body>
</html>
