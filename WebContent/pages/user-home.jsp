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
    <div class="page-shell">
        <div class="topbar">
            <div>
                <h1>玩家控制台</h1>
                <p class="muted">欢迎，${sessionScope.user.username}</p>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/logout">退出登录</a>
        </div>

        <c:if test="${param.error == 'forbidden'}">
            <div class="message error">普通用户不能访问管理员页面。</div>
        </c:if>

        <div class="grid cards">
            <a class="card" href="${pageContext.request.contextPath}/legend/list">
                <h2>传奇数据</h2>
                <p>查看传奇定位、技能说明和战术建议。</p>
            </a>
            <a class="card" href="${pageContext.request.contextPath}/weapon/list">
                <h2>武器数据</h2>
                <p>查看武器类型、伤害、弹药和推荐场景。</p>
            </a>
            <a class="card" href="${pageContext.request.contextPath}/note/list">
                <h2>战术笔记</h2>
                <p>当前已有 ${noteCount} 条个人笔记。</p>
            </a>
            <a class="card" href="${pageContext.request.contextPath}/stat/search">
                <h2>模拟战绩</h2>
                <p>按玩家昵称查询本地模拟战绩。</p>
            </a>
        </div>
    </div>
</body>
</html>
