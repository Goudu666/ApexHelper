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
    <div class="page-shell narrow">
        <div class="hero">
            <h1>Apex Legends 战术整备与数据助手系统</h1>
            <p>传统 JavaWeb 课程设计演示版：JSP + Servlet + JavaBean + DAO + JDBC + MySQL。</p>
            <div class="actions">
                <a class="btn primary" href="${pageContext.request.contextPath}/login.jsp">登录</a>
                <a class="btn" href="${pageContext.request.contextPath}/register.jsp">注册</a>
            </div>
            <c:if test="${not empty sessionScope.user}">
                <p class="tip">
                    当前已登录：
                    <strong>${sessionScope.user.username}</strong>
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'admin'}">
                            <a href="${pageContext.request.contextPath}/admin/dashboard">进入管理员首页</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/home">进入用户首页</a>
                        </c:otherwise>
                    </c:choose>
                </p>
            </c:if>
        </div>
    </div>
</body>
</html>
