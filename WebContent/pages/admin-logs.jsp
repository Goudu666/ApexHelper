<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 管理员日志页：展示注册、登录、笔记操作等系统日志。 --%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>系统日志 - ApexHelper</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
    <c:set var="activeNav" value="admin-logs" />
    <c:set var="pageMeta" value="SYSTEM LOGS" />
    <c:set var="pageTitle" value="系统日志" />
    <c:set var="pageSubtitle" value="最近 200 条关键操作记录。" />

    <div class="hud-shell">
        <%@ include file="common/sidebar.jspf" %>
        <main class="hud-main">
            <%@ include file="common/topbar.jspf" %>

            <section class="hud-panel">
                <div class="panel-heading">
                    <div>
                        <span class="hud-label">AUDIT TRAIL</span>
                        <h2>关键操作记录</h2>
                    </div>
                </div>

                <div class="table-wrap compact-table">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>操作用户</th>
                                <th>操作类型</th>
                                <th>操作内容</th>
                                <th>操作时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log" items="${logs}">
                                <tr>
                                    <td>${log.id}</td>
                                    <td>${log.username}</td>
                                    <td>${log.actionType}</td>
                                    <td>${log.actionContent}</td>
                                    <td>${log.createTime}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty logs}">
                                <tr>
                                    <td colspan="5" class="empty">暂无日志。</td>
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
