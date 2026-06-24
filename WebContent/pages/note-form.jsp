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
    <div class="page-shell narrow">
        <div class="topbar">
            <div>
                <h1>${formTitle}</h1>
                <p class="muted">字段会保存到 t_tactic_note 表。</p>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/note/list">返回列表</a>
        </div>

        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>

        <form action="${formAction}" method="post" class="panel form">
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
    </div>
</body>
</html>
