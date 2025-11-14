<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String cp = request.getContextPath();
%>

<aside class="mypage-sidebar">
    <!-- 프로필 섹션 -->
    <div class="sidebar-profile">
        <div class="profile-avatar-wrapper">
            <c:choose>
                <c:when test="${not empty myInfo.savePath}">
                    <img src="<%=cp%>/img/profile/${myInfo.savePath}" alt="프로필 이미지" class="profile-avatar">
                </c:when>
                <c:otherwise>
                    <div class="profile-avatar-icon">
                        ${fn:substring(myInfo.nickname, 0, 1)}
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div class="profile-name">${myInfo.nickname}</div>
        <div class="profile-email">${myInfo.email}</div>
        
        <div class="profile-stats">
            <div class="stat-box">
                <div class="stat-value">${myInfo.joinGroup}</div>
                <div class="stat-label">참여 모임</div>
            </div>
            <div class="stat-box">
                <div class="stat-value">${myInfo.myGroup}</div>
                <div class="stat-label">운영 모임</div>
            </div>
        </div>
    </div>

    <!-- 메뉴 섹션 -->
    <div class="sidebar-menu">
        <!-- 모임 관리 -->
        <div class="menu-section">
            <div class="menu-section-title">모임 관리</div>
            <a class="menu-item" data-target="my-groups" onclick="showTab('my-groups')">
                <span class="menu-icon">📚</span>
                <span>내 모임</span>
            </a>
            <a class="menu-item" data-target="pending-groups" onclick="showTab('pending-groups')">
                <span class="menu-icon">⏳</span>
                <span>신청 중인 모임</span>
                <c:if test="${myInfo.requestJoin > 0 || myInfo.requestApply > 0}">
                    <span class="menu-badge">${myInfo.requestJoin + myInfo.requestApply}</span>
                </c:if>
            </a>
            <a class="menu-item" data-target="past-groups" onclick="showTab('past-groups')">
                <span class="menu-icon">📜</span>
                <span>이전 모임</span>
            </a>
        </div>

        <!-- 활동 -->
        <div class="menu-section">
            <div class="menu-section-title">활동</div>
            <a class="menu-item" data-target="notifications" onclick="showTab('notifications')">
                <span class="menu-icon">🔔</span>
                <span>알림</span>
                <span class="menu-badge">5</span>
            </a>
            <a class="menu-item" data-target="favorites" onclick="showTab('favorites')">
                <span class="menu-icon">❤️</span>
                <span>즐겨찾기</span>
            </a>
            <a class="menu-item" data-target="calendar" onclick="showTab('calendar')">
                <span class="menu-icon">📅</span>
                <span>내 일정</span>
            </a>
        </div>
    </div>
</aside>
