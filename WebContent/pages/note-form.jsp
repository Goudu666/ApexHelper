<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 战术笔记表单页：新增和编辑共用同一个 JSP。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>${formTitle} - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <c:set var="activeNav" value="note" />
    <c:set var="pageMeta" value="LOADOUT EDITOR" />
    <c:set var="pageTitle" value="${formTitle}" />
    <c:set var="pageSubtitle" value="字段会保存到 t_tactic_note 表。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <div class="hud-toolbar">
                <a class="btn" href="${pageContext.request.contextPath}/note/list">返回列表</a>
            </div>

            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <section class="editor-layout">
                <aside class="hud-panel editor-hint">
                    <span class="hud-label">TACTIC FILE</span>
                    <strong>${formTitle}</strong>
                    <p>建议记录地图点位、队伍配置、进圈路线和交战注意事项。</p>
                </aside>

                <form action="${formAction}" method="post" class="hud-panel form">
                    <c:if test="${not empty note.id}">
                        <input type="hidden" name="id" value="${note.id}">
                    </c:if>

                    <label>标题
                        <input type="text" name="title" value="${note.title}">
                    </label>
                    <label>地图
                        <input type="text" name="mapName" value="${note.mapName}" placeholder="例如：奥林匹斯">
                    </label>
                    <label>传奇
                        <input type="text" name="legendName" value="${note.legendName}" placeholder="例如：恶灵">
                    </label>
                    <label>内容
                        <textarea name="content" rows="8">${note.content}</textarea>
                    </label>
                    <button type="submit" class="btn primary full">保存</button>
                </form>
            </section>
        </main>
    </div>
</body>
</html>
