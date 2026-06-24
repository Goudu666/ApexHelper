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
    <div class="page-shell">
        <div class="topbar">
            <div>
                <h1>模拟玩家战绩</h1>
                <p class="muted">输入昵称关键字查询，留空显示全部模拟数据。</p>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/user/home">返回首页</a>
        </div>

        <form action="${pageContext.request.contextPath}/stat/search" method="get" class="search-form">
            <input type="text" name="keyword" value="${keyword}" placeholder="例如：Ras">
            <button type="submit" class="btn primary">查询</button>
        </form>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>昵称</th>
                        <th>段位</th>
                        <th>总击杀</th>
                        <th>总伤害</th>
                        <th>胜场数</th>
                        <th>常用传奇</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="stats" items="${statsList}">
                        <tr>
                            <td>${stats.nickname}</td>
                            <td>${stats.rankName}</td>
                            <td>${stats.totalKills}</td>
                            <td>${stats.totalDamage}</td>
                            <td>${stats.wins}</td>
                            <td>${stats.mainLegend}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty statsList}">
                        <tr>
                            <td colspan="6" class="empty">没有匹配的模拟战绩。</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
