<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 战术笔记列表页：只展示当前登录用户自己的 notes。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>战术笔记 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <c:set var="activeNav" value="note" />
    <c:set var="pageMeta" value="LOADOUT NOTES" />
    <c:set var="pageTitle" value="战术笔记" />
    <c:set var="pageSubtitle" value="新增、查看、修改和删除自己的战术笔记。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <div class="hud-toolbar">
                <a class="btn primary" href="${pageContext.request.contextPath}/note/add">新增笔记</a>
            </div>

            <c:if test="${param.error == 'notfound'}">
                <div class="message error">没有找到这条笔记，或它不属于当前用户。</div>
            </c:if>
            <c:if test="${param.error == 'delete'}">
                <div class="message error">删除失败，可能不是你的笔记。</div>
            </c:if>

            <section class="hud-panel">
                <div class="panel-heading">
                    <div>
                        <span class="hud-label">TACTIC RECORDS</span>
                        <h2>个人笔记列表</h2>
                    </div>
                    <span class="hud-count">PRIVATE</span>
                </div>

                <div class="table-wrap compact-table">
                    <table>
                        <thead>
                            <tr>
                                <th>标题</th>
                                <th>地图</th>
                                <th>传奇</th>
                                <th>内容</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%-- c:forEach 遍历当前用户自己的 notes。 --%>
                            <c:forEach var="note" items="${notes}">
                                <tr>
                                    <td>${note.title}</td>
                                    <td>${note.mapName}</td>
                                    <td>${note.legendName}</td>
                                    <td class="wide-text">${note.content}</td>
                                    <td>${note.createTime}</td>
                                    <td class="row-actions">
                                        <a class="btn small" href="${pageContext.request.contextPath}/note/edit?id=${note.id}">编辑</a>
                                        <form action="${pageContext.request.contextPath}/note/delete" method="post" class="inline-form">
                                            <input type="hidden" name="id" value="${note.id}">
                                            <button type="submit" class="btn danger small">删除</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty notes}">
                                <tr>
                                    <td colspan="6" class="empty">暂无笔记，请先新增一条。</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
