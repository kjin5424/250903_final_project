<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String cp = request.getContextPath();
%>

<style>
    /* 그룹 카드 - 이미지 영역 포함 */
    .group-card-large {
        position: relative;
        background: var(--color-white);
        border: 2px solid var(--color-border-light);
        border-radius: var(--radius-lg);
        overflow: hidden;
        transition: all var(--transition-base);
        cursor: pointer;
    }
    
    .group-card-large:hover {
        border-color: var(--color-primary);
        box-shadow: var(--shadow-md);
        transform: translateY(-2px);
    }
    
    /* 큰 이미지 영역 */
    .card-image-area {
        position: relative;
        width: 100%;
        height: 180px;
        background: linear-gradient(135deg, var(--color-primary-lighter), var(--color-secondary-lighter));
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 64px;
    }
    
    .card-image-area img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    /* 배지 */
    .card-badge-overlay {
        position: absolute;
        top: var(--spacing-md);
        left: var(--spacing-md);
        padding: 6px 12px;
        border-radius: var(--radius-full);
        font-size: 12px;
        font-weight: 700;
    }
    
    .badge-owner {
        background: linear-gradient(135deg, #FFD54F, #FFC107);
        color: #F57C00;
    }
    
    .badge-member {
        background: var(--color-secondary);
        color: var(--color-text-inverse);
    }
    
    .card-notification-btn {
        background: rgba(255, 255, 255, 0.9);
        border: none;
        width: 32px;
        height: 32px;
        align-items: center;
        justify-content: center;
        font-size: 16px;
        cursor: pointer;
        transition: all var(--transition-base);
    }
    
    .card-notification-btn:hover {
        border: 2px solid var(--color-border);
        border-radius: var(--radius-full);
        border-color: var(--color-primary);
        background: white;
    }
    
    /* 카드 본문 */
    .card-body {
        padding: var(--spacing-lg);
    }
    
    .card-title-section {
        display: flex;
        justify-content: space-between;
    }

    .card-title {
        font-size: 16px;
        font-weight: 700;
        color: var(--color-text-primary);
        margin-bottom: var(--spacing-sm);
    }
    
    .card-info-list {
        display: flex;
        flex-wrap: wrap;
        gap: var(--spacing-sm);
        font-size: 13px;
        color: var(--color-text-secondary);
        margin-bottom: var(--spacing-md);
    }
    
    .info-item {
        display: flex;
        align-items: center;
        gap: 4px;
    }
    
    .card-actions {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: var(--spacing-sm);
    }
    
    /* 알림 패널 */
    .notification-panel {
        display: none;
        padding: var(--spacing-md);
        background: var(--color-base);
        border-top: 1px solid var(--color-border-light);
    }
    
    .notification-panel.show {
        display: block;
    }
    
    .notification-item {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: var(--spacing-xs) 0;
        border-bottom: 1px solid var(--color-border-light);
    }
    
    .notification-item:last-child {
        border-bottom: none;
    }
    
    .notification-label {
        font-size: 13px;
        color: var(--color-text-secondary);
        display: flex;
        align-items: center;
        gap: var(--spacing-xs);
    }
    
    /* 토글 스위치 */
    .toggle-switch {
        position: relative;
        width: 40px;
        height: 22px;
    }
    
    .toggle-switch input {
        opacity: 0;
        width: 0;
        height: 0;
    }
    
    .toggle-slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: var(--color-border);
        border-radius: var(--radius-full);
        transition: var(--transition-base);
    }
    
    .toggle-slider:before {
        position: absolute;
        content: "";
        height: 16px;
        width: 16px;
        left: 3px;
        bottom: 3px;
        background-color: white;
        border-radius: 50%;
        transition: var(--transition-base);
    }
    
    input:checked + .toggle-slider {
        background-color: var(--color-primary-dark);
    }
    
    input:checked + .toggle-slider:before {
        transform: translateX(18px);
    }
</style>

<div class="content-section">
    <div class="page-header">
        <h1 class="page-title">📚 내 모임</h1>
        <p class="page-description">현재 참여 중이거나 운영 중인 모임입니다</p>
    </div>

    <!-- 운영 중인 모임 -->
    <div class="subsection-header">
        <h3 class="subsection-title">운영 중인 모임</h3>
        <span class="count-badge">${myInfo.myGroup}</span>
    </div>
    
    <div class="group-grid-3x3">
        <c:choose>
            <c:when test="${not empty myGroup}">
                <c:forEach var="myGroupDTO" items="${myGroup}" varStatus="status">
                    <div class="group-card-large" onclick="viewGroup('${myGroupDTO.groupApplyCode}')">
                        <!-- 이미지 영역 -->
                        <div class="card-image-area">
                            <div class="card-badge-overlay badge-owner">👑 모임장</div>
                            <c:choose>
                                <c:when test="${not empty myGroupDTO.savePath}">
                                    <img src="<%=cp%>/img/group/${myGroupDTO.savePath}" alt="${myGroupDTO.groupTitle}">
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${myGroupDTO.topicType eq '1'}"> 📖 </c:when>
                                        <c:when test="${myGroupDTO.topicType eq '2'}"> 🌐 </c:when>
                                        <c:when test="${myGroupDTO.topicType eq '3'}"> 💻 </c:when>
                                        <c:when test="${myGroupDTO.topicType eq '4'}"> 🚀 </c:when>
                                        <c:when test="${myGroupDTO.topicType eq '5'}"> 📜 </c:when>
                                        <c:when test="${myGroupDTO.topicType eq '6'}"> 📝 </c:when>
                                        <c:when test="${myGroupDTO.topicType eq '7'}"> 🎨 </c:when>
                                        <c:otherwise> ? </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- 카드 본문 -->
                        <div class="card-body">
                            <div class="card-title-section">
	                            <div class="card-title">${myGroupDTO.groupTitle}</div>
	                            <button class="card-notification-btn" onclick="event.stopPropagation(); toggleNotification('owner-${status.index}')">🔔</button>
                            </div>
                            
                            <div class="card-info-list">
                                <div class="info-item">
                                    <span>👥</span>
                                    <span>${myGroupDTO.currentMemberCount}/${myGroupDTO.headCount}명</span>
                                </div>
                                <div class="info-item">
                                    <span>📍</span>
                                    <span>${myGroupDTO.onOff}</span>
                                </div>
                                <div class="info-item">
                                    <span>📊</span>
                                    <span>출석률 ${myGroupDTO.totalAttendance}%</span>
                                </div>
                            </div>
                            
                            <div class="card-actions">
                                <button class="btn btn-primary btn-sm" onclick="event.stopPropagation(); location.href='managelist.do?groupApplyCode=${myGroupDTO.groupApplyCode}'">⚙️ 관리</button>
                                <button class="btn btn-outline btn-sm" onclick="event.stopPropagation(); viewGroup('${myGroupDTO.groupApplyCode}')">👀 보기</button>
                            </div>
                        </div>
                        
                        <!-- 알림 패널 -->
                        <div class="notification-panel" id="notification-owner-${status.index}">
                            <div class="notification-item">
                                <label class="notification-label"><span>💬</span><span>새 게시글 알림</span></label>
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="notification-item">
                                <label class="notification-label"><span>📝</span><span>댓글 알림</span></label>
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="notification-item">
                                <label class="notification-label"><span>🗳️</span><span>투표 알림</span></label>
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="notification-item">
                                <label class="notification-label"><span>📅</span><span>일정 알림</span></label>
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">📚</div>
                    <div class="empty-state-text">운영 중인 모임이 없습니다</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- 참여 중인 모임 -->
    <div class="subsection-header">
        <h3 class="subsection-title">참여 중인 모임</h3>
        <span class="count-badge">${myInfo.joinGroup}</span>
    </div>
    
    <div class="group-grid-3x3">
        <c:choose>
            <c:when test="${not empty joinGroup}">
                <c:forEach var="joinGroupDTO" items="${joinGroup}" varStatus="status">
                    <div class="group-card-large" onclick="viewGroup('${joinGroupDTO.groupApplyCode}')">
                        <div class="card-image-area">
                            <div class="card-badge-overlay badge-member">참여중</div>
                            
                            <c:choose>
                                <c:when test="${not empty joinGroupDTO.savePath}">
                                    <img src="<%=cp%>/img/group/${joinGroupDTO.savePath}" alt="${joinGroupDTO.groupTitle}">
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${joinGroupDTO.topicType eq '1'}"> 📖 </c:when>
                                        <c:when test="${joinGroupDTO.topicType eq '2'}"> 🌐 </c:when>
                                        <c:when test="${joinGroupDTO.topicType eq '3'}"> 💻 </c:when>
                                        <c:when test="${joinGroupDTO.topicType eq '4'}"> 🚀 </c:when>
                                        <c:when test="${joinGroupDTO.topicType eq '5'}"> 📜 </c:when>
                                        <c:when test="${joinGroupDTO.topicType eq '6'}"> 📝 </c:when>
                                        <c:when test="${joinGroupDTO.topicType eq '7'}"> 🎨 </c:when>
                                        <c:otherwise>📌</c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="card-body">
                            <div class="card-title-section">
                          		<div class="card-title">${joinGroupDTO.groupTitle}</div>
	                            <button class="card-notification-btn" onclick="event.stopPropagation(); toggleNotification('join-${status.index}')">🔔</button>
                            </div>
                            <div class="card-info-list">
                                <div class="info-item">
                                    <span>👥</span>
                                    <span>${joinGroupDTO.currentMemberCount}/${joinGroupDTO.headCount}명</span>
                                </div>
                                <div class="info-item">
                                    <span>📍</span>
                                    <span>${joinGroupDTO.onOff}</span>
                                </div>
                                <div class="info-item">
                                    <span>📊</span>
                                    <span>출석률 ${fn:substring(joinGroupDTO.totalAttendance, 0, 4)}%</span>
                                </div>
                            </div>
                            
                            <div class="card-actions">
                                <button class="btn btn-primary btn-sm" onclick="event.stopPropagation(); viewGroup('${joinGroupDTO.groupApplyCode}')">참여하기</button>
                                <button class="btn btn-ghost btn-sm" onclick="event.stopPropagation(); leaveGroup('${joinGroupDTO.groupApplyCode}')">탈퇴</button>
                            </div>
                        </div>
                        
                        <div class="notification-panel" id="notification-join-${status.index}">
                            <div class="notification-item">
                                <label class="notification-label"><span>💬</span><span>새 게시글 알림</span></label>
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="notification-item">
                                <label class="notification-label"><span>📝</span><span>댓글 알림</span></label>
                                <label class="toggle-switch">
                                    <input type="checkbox">
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="notification-item">
                                <label class="notification-label"><span>🗳️</span><span>투표 알림</span></label>
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                            <div class="notification-item">
                                <label class="notification-label"><span>📅</span><span>일정 알림</span></label>
                                <label class="toggle-switch">
                                    <input type="checkbox" checked>
                                    <span class="toggle-slider"></span>
                                </label>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">👥</div>
                    <div class="empty-state-text">참여 중인 모임이 없습니다</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script>
    function toggleNotification(id) {
        const element = document.getElementById('notification-' + id);
        if (element) {
            element.classList.toggle('show');
        }
    }
    
    function viewGroup(groupApplyCode) {
        window.location.href = '<%=cp %>/home.do?groupApplyCode=' + groupApplyCode;
    }
    
    function leaveGroup(groupApplyCode) {
        if(confirm('정말 이 모임을 탈퇴하시겠습니까?\n탈퇴 후 당일 재가입은 불가능합니다.')) {
            alert('탈퇴가 완료되었습니다.');
        }
    }
</script>
