<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>

<style>
    .pending-badge {
        position: absolute;
        top: var(--spacing-md);
        left: var(--spacing-md);
        padding: 6px 12px;
        border-radius: var(--radius-full);
        font-size: 12px;
        font-weight: 700;
    }
    
    .badge-waiting {
        background: linear-gradient(135deg, #FFF3E0, #FFE0B2);
        color: #E65100;
    }
    
    .badge-applying {
        background: linear-gradient(135deg, #FCE4EC, #F8BBD0);
        color: #C2185B;
    }
    
</style>

<div class="content-section">
    <div class="page-header">
        <h1 class="page-title">⏳ 신청 중인 모임</h1>
        <p class="page-description">참여 신청 중이거나 개설 대기 중인 모임입니다</p>
    </div>

    <div class="subsection-header">
        <h3 class="subsection-title">참여 신청 중</h3>
        <span class="count-badge">${myInfo.requestJoin}</span>
    </div>
    
    <div class="group-grid-3x3">
        <c:choose>
            <c:when test="${not empty requestJoinGroup}">
                <c:forEach var="requestJoinGroupDTO" items="${requestJoinGroup}">
                    <div class="group-card-large">
                        <div class="card-image-area">
                            <div class="pending-badge badge-waiting">승인 대기</div>
                            <c:choose>
                                <c:when test="${not empty requestJoinGroupDTO.savePath}">
                                    <img src="<%=cp%>/img/group/${requestJoinGroupDTO.savePath}" alt="${requestJoinGroupDTO.groupTitle}">
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${requestJoinGroupDTO.topicType eq '1'}">📖</c:when>
                                        <c:when test="${requestJoinGroupDTO.topicType eq '2'}">🌐</c:when>
                                        <c:when test="${requestJoinGroupDTO.topicType eq '3'}">💻</c:when>
                                        <c:when test="${requestJoinGroupDTO.topicType eq '4'}">🚀</c:when>
                                        <c:when test="${requestJoinGroupDTO.topicType eq '5'}">📜</c:when>
                                        <c:when test="${requestJoinGroupDTO.topicType eq '6'}">📝</c:when>
                                        <c:when test="${requestJoinGroupDTO.topicType eq '7'}">🎨</c:when>
                                        <c:otherwise>📌</c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="card-body">
                            <div class="card-title">${requestJoinGroupDTO.groupTitle}</div>
                            <div class="card-info-list">
                                <div class="info-item"><span>📅</span><span>신청일: ${requestJoinGroupDTO.joinDate}</span></div>
                                <div class="info-item"><span>👥</span><span>${requestJoinGroupDTO.currentMemberCount}/${requestJoinGroupDTO.headCount}명</span></div>
                            </div>
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--spacing-sm);">
                                <button class="btn btn-outline btn-sm" onclick="viewGroup('${requestJoinGroupDTO.groupApplyCode}')">상세보기</button>
                                <button class="btn btn-accent btn-sm" onclick="cancelApplication('${requestJoinGroupDTO.groupApplyCode}')">신청 취소</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">⏳</div>
                    <div class="empty-state-text">참여 신청 중인 모임이 없습니다</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="subsection-header">
        <h3 class="subsection-title">개설 대기 중</h3>
        <span class="count-badge">${myInfo.requestApply}</span>
    </div>
    
    <div class="group-grid-3x3">
        <c:choose>
            <c:when test="${not empty requestApplyGroup}">
                <div class="group-card-large">
                    <div class="card-image-area">
                        <div class="pending-badge badge-applying">개설 신청중</div>
                        <c:choose>
                            <c:when test="${not empty requestApplyGroup.savePath}">
                                <img src="<%=cp%>/img/group/${requestApplyGroup.savePath}" alt="${requestApplyGroup.groupTitle}">
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${requestApplyGroup.topicType eq '1'}">📖</c:when>
                                    <c:when test="${requestApplyGroup.topicType eq '2'}">🌐</c:when>
                                    <c:when test="${requestApplyGroup.topicType eq '3'}">💻</c:when>
                                    <c:when test="${requestApplyGroup.topicType eq '4'}">🚀</c:when>
                                    <c:when test="${requestApplyGroup.topicType eq '5'}">📜</c:when>
                                    <c:when test="${requestApplyGroup.topicType eq '6'}">📝</c:when>
                                    <c:when test="${requestApplyGroup.topicType eq '7'}">🎨</c:when>
                                    <c:otherwise>📌</c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="card-body">
                        <div class="card-title">${requestApplyGroup.groupTitle}</div>
                        <div class="card-info-list">
                            <div class="info-item"><span>📍</span><span>${requestApplyGroup.onOff}</span></div>
                            <div class="info-item"><span>📅</span><span>신청일: ${requestApplyGroup.createdDate}</span></div>
                        </div>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: var(--spacing-sm);">
                            <button class="btn btn-outline btn-sm" onclick="viewGroup('${requestApplyGroup.groupApplyCode}')">상세보기</button>
                            <button class="btn btn-accent btn-sm" onclick="cancelApplication('${requestApplyGroup.groupApplyCode}')">신청 취소</button>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">📝</div>
                    <div class="empty-state-text">개설 대기 중인 모임이 없습니다</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <div style="margin-top: var(--spacing-xl); padding: var(--spacing-lg); background: var(--color-primary-lighter); border-radius: var(--radius-md); color: var(--color-text-secondary);">
        <strong>📌 참고:</strong> 신청/개설 대기 모임은 승인 여부에 따라 목록에서 자동으로 이동됩니다.
    </div>
</div>

<script>
    function viewGroup(groupApplyCode) {
        window.location.href = 'group_detail.jsp?id=' + groupApplyCode;
    }
    
    function cancelApplication(groupApplyCode) {
        if(confirm('참여 신청을 취소하시겠습니까?')) {
            alert('참여 신청이 취소되었습니다.');
        }
    }
</script>
