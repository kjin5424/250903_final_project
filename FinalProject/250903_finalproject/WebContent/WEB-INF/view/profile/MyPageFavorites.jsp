<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>

<div class="content-section">
    <div class="page-header">
        <h1 class="page-title">❤️ 즐겨찾기</h1>
        <p class="page-description">관심 있는 모임을 모아보세요</p>
    </div>

    <div class="group-grid-3x3">
        <c:choose>
            <c:when test="${not empty favoriteGroup}">
                <c:forEach var="favoriteGroupDTO" items="${favoriteGroup}">
                    <div class="group-card-large">
                        <div class="card-image-area">
                            <c:choose>
                                <c:when test="${not empty favoriteGroupDTO.savePath}">
                                    <img src="<%=cp%>/img/group/${favoriteGroupDTO.savePath}" alt="${favoriteGroupDTO.groupTitle}">
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${favoriteGroupDTO.topicType eq '1'}">📖</c:when>
                                        <c:when test="${favoriteGroupDTO.topicType eq '2'}">🌐</c:when>
                                        <c:when test="${favoriteGroupDTO.topicType eq '3'}">💻</c:when>
                                        <c:when test="${favoriteGroupDTO.topicType eq '4'}">🚀</c:when>
                                        <c:when test="${favoriteGroupDTO.topicType eq '5'}">📜</c:when>
                                        <c:when test="${favoriteGroupDTO.topicType eq '6'}">📝</c:when>
                                        <c:when test="${favoriteGroupDTO.topicType eq '7'}">🎨</c:when>
                                        <c:otherwise>📌</c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="card-body">
                            <div class="card-title">${favoriteGroupDTO.groupTitle}</div>
                            <div class="card-info-list">
                                <div class="info-item"><span>👥</span><span>${favoriteGroupDTO.currentMemberCount}/${favoriteGroupDTO.headCount}명</span></div>
                                <div class="info-item"><span>📍</span><span>${favoriteGroupDTO.onOff}</span></div>
                            </div>
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--spacing-sm);">
                                <button class="btn btn-primary btn-sm" onclick="viewGroup('${favoriteGroupDTO.groupApplyCode}')">참여하기</button>
                                <button class="btn btn-ghost btn-sm" onclick="removeFavorite('${favoriteGroupDTO.groupApplyCode}')">삭제</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">❤️</div>
                    <div class="empty-state-text">즐겨찾기한 모임이 없습니다</div>
                    <p style="margin-top: var(--spacing-md); font-size: 14px;">
                        관심 있는 모임을 즐겨찾기에 추가해보세요
                    </p>
                    <a href="grouplist.jsp" class="empty-state-action" style="margin-top: var(--spacing-lg);">
                        모임 둘러보기
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    function viewGroup(groupApplyCode) {
        window.location.href = '<%=cp %>/home.do?groupApplyCode=' + groupApplyCode;
    }
    
    function removeFavorite(groupApplyCode) {
        if(confirm('즐겨찾기에서 삭제하시겠습니까?')) {
            alert('즐겨찾기에서 삭제되었습니다.');
            location.reload();
        }
    }
</script>