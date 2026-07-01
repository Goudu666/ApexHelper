<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 模拟战绩页：按昵称查询本地模拟数据。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>模拟玩家战绩 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <c:set var="activeNav" value="stat" />
    <c:set var="pageMeta" value="CAREER RECORD" />
    <c:set var="pageTitle" value="模拟玩家战绩" />
    <c:set var="pageSubtitle" value="输入昵称关键字查询，留空显示全部模拟数据。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <section class="stat-layout">
                <form action="${pageContext.request.contextPath}/stat/search" method="get" class="hud-panel search-form">
                    <label class="sr-only">玩家昵称</label>
                    <input type="text" name="keyword" value="${keyword}" placeholder="例如：Ras">
                    <button type="submit" class="btn primary">查询</button>
                </form>

                <div class="stat-card-grid">
                    <c:forEach var="stats" items="${statsList}">
                        <article class="hud-data-card stat-card">
                            <div class="hud-data-head">
                                <div>
                                    <h2>${stats.nickname}</h2>
                                    <p>${stats.rankName}</p>
                                </div>
                                <span>${stats.mainLegend}</span>
                            </div>
                            <div class="weapon-stats">
                                <div>
                                    <span>总击杀</span>
                                    <strong>${stats.totalKills}</strong>
                                </div>
                                <div>
                                    <span>总伤害</span>
                                    <strong>${stats.totalDamage}</strong>
                                </div>
                                <div>
                                    <span>胜场数</span>
                                    <strong>${stats.wins}</strong>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>

                <c:if test="${empty statsList}">
                    <div class="hud-panel empty">没有匹配的模拟战绩。</div>
                </c:if>
            </section>
        </main>
    </div>
</body>
</html>
