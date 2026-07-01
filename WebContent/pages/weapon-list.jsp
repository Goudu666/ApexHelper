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
    <c:set var="activeNav" value="weapon" />
    <c:set var="pageMeta" value="ARSENAL" />
    <c:set var="pageTitle" value="武器数据" />
    <c:set var="pageSubtitle" value="展示武器类型、伤害、弹药类型和推荐场景。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <section class="weapon-layout">
                <div class="hud-panel weapon-summary">
                    <span class="hud-label">COLLECTION</span>
                    <strong>WEAPON DATABASE</strong>
                    <p>按课程设计数据库展示当前武器条目，数值来自初始化数据。</p>
                </div>

                <div class="weapon-grid">
                    <c:forEach var="weapon" items="${weapons}">
                        <article class="weapon-card">
                            <div class="weapon-card-head">
                                <div>
                                    <h2>${weapon.name}</h2>
                                    <p>${weapon.englishName}</p>
                                </div>
                                <span>${weapon.weaponType}</span>
                            </div>
                            <div class="weapon-stats">
                                <div>
                                    <span>身体伤害</span>
                                    <strong>${weapon.damage}</strong>
                                </div>
                                <div>
                                    <span>头部伤害</span>
                                    <strong>${weapon.headDamage}</strong>
                                </div>
                            </div>
                            <div class="weapon-meta">
                                <span>${weapon.ammoType}</span>
                                <p>${weapon.recommendScene}</p>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
