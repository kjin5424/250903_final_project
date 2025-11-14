<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>


<div class="content-section">
    <div class="page-header">
        <h1 class="page-title">📜 이전 모임</h1>
        <p class="page-description">종료되었거나 과거 기록으로 남긴 모임입니다</p>
    </div>

    <div class="group-grid-3x3">
        <c:choose>
            <c:when test="${not empty quitGroup}">
                <c:forEach var="quitGroupDTO" items="${quitGroup}">
                    <div class="group-card-large">
                        <div class="card-image-area">
                            <c:choose>
                                <c:when test="${not empty quitGroupDTO.savePath}">
                                    <img src="<%=cp%>/img/group/${quitGroupDTO.savePath}" alt="${quitGroupDTO.groupTitle}">
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${quitGroupDTO.topicType eq '1'}">📖</c:when>
                                        <c:when test="${quitGroupDTO.topicType eq '2'}">🌐</c:when>
                                        <c:when test="${quitGroupDTO.topicType eq '3'}">💻</c:when>
                                        <c:when test="${quitGroupDTO.topicType eq '4'}">🚀</c:when>
                                        <c:when test="${quitGroupDTO.topicType eq '5'}">📜</c:when>
                                        <c:when test="${quitGroupDTO.topicType eq '6'}">📝</c:when>
                                        <c:when test="${quitGroupDTO.topicType eq '7'}">🎨</c:when>
                                        <c:otherwise>📌</c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="card-body">
                            <div class="card-title">${quitGroupDTO.groupTitle}</div>
                            <div class="card-info-list">
                                <div class="info-item">
                                    <span>📅</span>
                                    <span>기간: ${quitGroupDTO.joinDate} ~ ${quitGroupDTO.quitDate}</span>
                                </div>
                            </div>
                            <button class="btn btn-outline btn-sm" style="width: 100%;" onclick="viewGroupHistory('${quitGroupDTO.groupApplyCode}')">기록 보기</button>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">📜</div>
                    <div class="empty-state-text">이전 모임이 없습니다</div>
                    <p style="margin-top: var(--spacing-md); font-size: 14px;">
                        탈퇴하거나 종료된 모임이 여기에 표시됩니다
                    </p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    function viewGroupHistory(groupApplyCode) {
        window.location.href = 'group_history.jsp?id=' + groupApplyCode;
    }
</script>
