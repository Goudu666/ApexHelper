<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 普通用户首页：从 sessionScope.user 读取当前用户。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户首页 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <c:set var="activeNav" value="home" />
    <c:set var="pageMeta" value="COMMAND CENTER" />
    <c:set var="pageTitle" value="玩家控制台" />
    <c:set var="pageSubtitle" value="欢迎，${sessionScope.user.username}。从左侧选择整备模块。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <c:if test="${param.error == 'forbidden'}">
                <div class="message error">普通用户不能访问管理员页面。</div>
            </c:if>

            <section class="hud-dashboard">
                <div class="hud-panel hud-panel-large command-panel">
                    <p class="hud-kicker">TACTICAL COMPANION</p>
                    <h2>战术整备与数据助手</h2>
                    <p>查看最新传奇与武器数据，维护自己的战术笔记，并查询模拟玩家战绩。</p>
                    <div class="command-actions">
                        <a class="btn primary" href="${pageContext.request.contextPath}/weapon/list">进入武器库</a>
                        <a class="btn" href="${pageContext.request.contextPath}/legend/list">查看传奇情报</a>
                    </div>
                </div>

                <aside class="hud-panel hud-side-card">
                    <span class="hud-label">LOADOUT NOTES</span>
                    <strong>${noteCount}</strong>
                    <p>当前个人战术笔记数量</p>
                    <a class="btn small" href="${pageContext.request.contextPath}/note/list">管理笔记</a>
                </aside>
            </section>

            <section class="hud-card-grid">
                <a class="hud-card" href="${pageContext.request.contextPath}/legend/list">
                    <span class="hud-card-code">02</span>
                    <h2>传奇数据</h2>
                    <p>定位、技能说明和战术建议。</p>
                </a>
                <a class="hud-card" href="${pageContext.request.contextPath}/weapon/list">
                    <span class="hud-card-code">03</span>
                    <h2>武器数据</h2>
                    <p>类型、伤害、弹药和推荐场景。</p>
                </a>
                <a class="hud-card" href="${pageContext.request.contextPath}/note/list">
                    <span class="hud-card-code">04</span>
                    <h2>战术笔记</h2>
                    <p>新增、编辑、删除自己的笔记。</p>
                </a>
                <a class="hud-card" href="${pageContext.request.contextPath}/stat/search">
                    <span class="hud-card-code">05</span>
                    <h2>模拟战绩</h2>
                    <p>按昵称查询本地模拟数据。</p>
                </a>
            </section>
        </main>
    </div>
</body>
</html>
