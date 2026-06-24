<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 武器数据页：EL 表达式 ${weapon.name} 调用 JavaBean getter。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>武器数据 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <div class="page-shell">
        <div class="topbar">
            <div>
                <h1>武器数据</h1>
                <p class="muted">展示武器类型、伤害、弹药类型和推荐场景。</p>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/user/home">返回首页</a>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>名称</th>
                        <th>英文名</th>
                        <th>类型</th>
                        <th>身体伤害</th>
                        <th>头部伤害</th>
                        <th>弹药</th>
                        <th>推荐场景</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="weapon" items="${weapons}">
                        <tr>
                            <td>${weapon.name}</td>
                            <td>${weapon.englishName}</td>
                            <td>${weapon.weaponType}</td>
                            <td>${weapon.damage}</td>
                            <td>${weapon.headDamage}</td>
                            <td>${weapon.ammoType}</td>
                            <td>${weapon.recommendScene}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
