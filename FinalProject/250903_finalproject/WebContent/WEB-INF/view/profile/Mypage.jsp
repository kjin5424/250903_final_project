<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 마이페이지</title>
    
    <!-- CSS Import -->
    <link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css">
    <link rel="stylesheet" href="<%=cp%>/css_new/topmenubar_sample.css">
    <link rel="stylesheet" href="<%=cp%>/css_new/mypage_sample.css">
    
    <style>
    	.page-header {
	        display: flex;
	        justify-content: space-between;
	        align-items: baseline;
	        margin-bottom: var(--spacing-xl);
	        padding-bottom: var(--spacing-md);
	        border-bottom: 2px solid var(--color-border-light);
	    }
	    
	    .page-title {
	        font-size: 28px;
	        font-weight: 700;
	        color: var(--color-text-primary);
	    }
	    
	    .page-description {
	        font-size: 14px;
	        color: var(--color-text-tertiary);
	    }
	    
        .subsection-header {
	        display: flex;
	        align-items: center;
	        gap: var(--spacing-sm);
	        margin-top: var(--spacing-2xl);
	        margin-bottom: var(--spacing-lg);
	    }
	    
	    .subsection-title {
	        font-size: 18px;
	        font-weight: 700;
	        color: var(--color-text-primary);
	    }
	    
	    .count-badge {
	        display: inline-flex;
	        align-items: center;
	        justify-content: center;
	        min-width: 24px;
	        height: 24px;
	        padding: 0 8px;
	        background: var(--color-primary);
	        color: white;
	        border-radius: var(--radius-full);
	        font-size: 13px;
	        font-weight: 700;
	    }
	    
	    /* 3x3 그리드 */
	    .group-grid-3x3 {
	        display: grid;
	        grid-template-columns: repeat(3, 1fr);
	        gap: var(--spacing-lg);
	    }
	    
	    @media (max-width: 1200px) {
	        .group-grid-3x3 {
	            grid-template-columns: repeat(2, 1fr);
	        }
	    }
	    
	    @media (max-width: 768px) {
	        .group-grid-3x3 {
	            grid-template-columns: 1fr;
	        }
	    }
    
        .profile-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: var(--spacing-md);
            margin-top: var(--spacing-lg);
            padding-top: var(--spacing-lg);
            border-top: 1px solid var(--color-border-light);
        }
        
        .stat-box {
            text-align: center;
            padding: var(--spacing-md);
            background: var(--color-base);
            border-radius: var(--radius-md);
        }
        
        .page-header {
	        display: flex;
	        justify-content: space-between;
	        align-items: baseline;
	        margin-bottom: var(--spacing-xl);
	        padding-bottom: var(--spacing-md);
	        border-bottom: 2px solid var(--color-border-light);
	    }
	    
	    .page-title {
	        font-size: 28px;
	        font-weight: 700;
	        color: var(--color-text-primary);
	    }
	    
	    .page-description {
	        font-size: 14px;
	        color: var(--color-text-tertiary);
	    }
    </style>
    
    <script>
        function showTab(tabId) {
            // 모든 탭 숨기기
            const tabs = document.querySelectorAll('.tab-content');
            tabs.forEach(tab => {
                tab.classList.remove('active');
                tab.style.display = 'none';  // 명시적으로 숨김
            });
            
            // 모든 메뉴 비활성화
            const menus = document.querySelectorAll('.menu-item');
            menus.forEach(menu => menu.classList.remove('active'));
            
            // 선택된 탭만 표시
            const selectedTab = document.getElementById(tabId);
            if (selectedTab) {
                selectedTab.classList.add('active');
                selectedTab.style.display = 'block';
            }
            
            // 메뉴 활성화
            const menuToActivate = document.querySelector(`.menu-item[data-target="${tabId}"]`);
            if (menuToActivate) menuToActivate.classList.add('active');
        }
        
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const tabParam = urlParams.get('tab');
            showTab(tabParam || 'my-groups');
        }
    </script>
</head>
<body>
    <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

    <div class="mypage-layout">
        <!-- 사이드바 -->
        <jsp:include page="MyPageSidebar.jsp" />

        <!-- 메인 컨텐츠 -->
        <div class="mypage-content">
            <!-- 내 모임 탭 -->
            <div id="my-groups" class="tab-content" style="display:none;">
                <jsp:include page="/WEB-INF/view/profile/MyPageGroups.jsp" />
            </div>

            <!-- 신청 중인 모임 탭 -->
            <div id="pending-groups" class="tab-content" style="display:none;">
                <jsp:include page="/WEB-INF/view/profile/MyPagePendingGroups.jsp" />
            </div>

            <!-- 이전 모임 탭 -->
            <div id="past-groups" class="tab-content" style="display:none;">
                <jsp:include page="/WEB-INF/view/profile/MyPagePastGroups.jsp" />
            </div>

            <!-- 알림 탭 -->
            <div id="notifications" class="tab-content" style="display:none;">
                <jsp:include page="/WEB-INF/view/profile/MyPageNotifications.jsp" />
            </div>

            <!-- 즐겨찾기 탭 -->
            <div id="favorites" class="tab-content" style="display:none;">
                <jsp:include page="/WEB-INF/view/profile/MyPageFavorites.jsp" />
            </div>

            <!-- 내 일정 탭 -->
            <div id="calendar" class="tab-content" style="display:none;">
                <jsp:include page="/WEB-INF/view/profile/MyPageCalendar.jsp" />
            </div>
        </div>
    </div>
</body>
</html>
