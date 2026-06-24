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
    <div class="page-shell">
        <div class="topbar">
            <div>
                <h1>传奇数据</h1>
                <p class="muted">定位、技能说明和战术建议来自数据库初始化数据。</p>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/user/home">返回首页</a>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>名称</th>
                        <th>定位</th>
                        <th>技能说明</th>
                        <th>战术建议</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="legend" items="${legends}">
                        <tr>
                            <td>${legend.name}</td>
                            <td>${legend.position}</td>
                            <td>${legend.skillDesc}</td>
                            <td>${legend.tacticTip}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
