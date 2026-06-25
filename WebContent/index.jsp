<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 首页：提供登录和注册入口；${...} 是 JSP EL 表达式。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="entry-shell">
        <section class="entry-hero">
            <p class="hud-kicker">APEX//HELPER</p>
            <h1>Apex Legends 战术整备与数据助手系统</h1>
            <p>传统 JavaWeb 课程设计演示版：JSP + Servlet + JavaBean + DAO + JDBC + MySQL。</p>
            <div class="actions">
                <a class="btn primary" href="${pageContext.request.contextPath}/login.jsp">登录</a>
                <a class="btn" href="${pageContext.request.contextPath}/register.jsp">注册</a>
            </div>
        </section>

        <aside class="entry-status hud-panel">
            <span class="hud-label">TACTICAL COMPANION</span>
            <strong>READY</strong>
            <p>传奇数据、武器数据、战术笔记、模拟战绩和后台统计已就绪。</p>
            <c:if test="${not empty sessionScope.user}">
                <div class="entry-session">
                    <span>当前已登录：${sessionScope.user.username}</span>
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'admin'}">
                            <a class="btn small" href="${pageContext.request.contextPath}/admin/dashboard">进入管理员首页</a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn small" href="${pageContext.request.contextPath}/user/home">进入用户首页</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </aside>
    </div>
</body>
</html>
