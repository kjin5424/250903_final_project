<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
    
    // 선택된 카테고리 파라미터 받기
    String selectedCategory = request.getParameter("category");
    if (selectedCategory == null) selectedCategory = "all";
    
    // 현재 페이지
    String currentPage = "groups";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 구경 - 공모자들</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
/* ================================================
   공통 변수 및 리셋 스타일
   ================================================ */
:root {
    /* 컬러 시스템 - 60:30:10 비율 */
    --color-base: #F8F8F8;
    --color-white: #FFFFFF;
    
    /* 포인트 컬러 - 연두색 계열 (30%) */
    --color-primary: #A8D5A1;
    --color-primary-light: #C8E6C3;
    --color-primary-lighter: #E8F5E6;
    --color-primary-dark: #8BC683;
    --color-primary-darker: #6BAF61;
    
    /* 서브 포인트 - 라벤더 (10%) */
    --color-secondary: #D4C5F9;
    --color-secondary-light: #E6DDF9;
    --color-secondary-lighter: #F5F1FF;
    --color-secondary-dark: #B8A3E8;
    
    /* 액센트 - 체리 */
    --color-accent: #FF6B7A;
    --color-accent-light: #FFB3BA;
    --color-accent-dark: #E55563;
    
    /* 텍스트 컬러 */
    --color-text-primary: #2D3436;
    --color-text-secondary: #636E72;
    --color-text-tertiary: #B2BEC3;
    --color-text-inverse: #FFFFFF;
    
    /* 경계선 */
    --color-border: #E0E0E0;
    --color-border-light: #F0F0F0;
    
    /* 그림자 */
    --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.04);
    --shadow-md: 0 4px 8px rgba(0, 0, 0, 0.06);
    --shadow-lg: 0 8px 16px rgba(0, 0, 0, 0.08);
    --shadow-xl: 0 12px 24px rgba(0, 0, 0, 0.1);
    
    /* 간격 */
    --spacing-xs: 4px;
    --spacing-sm: 8px;
    --spacing-md: 16px;
    --spacing-lg: 24px;
    --spacing-xl: 32px;
    --spacing-2xl: 48px;
    
    /* 둥근 모서리 */
    --radius-sm: 6px;
    --radius-md: 10px;
    --radius-lg: 16px;
    --radius-xl: 24px;
    --radius-full: 9999px;
    
    /* 트랜지션 */
    --transition-fast: 150ms ease;
    --transition-base: 250ms ease;
    --transition-slow: 350ms ease;
    
    /* 레이아웃 */
    --max-width: 1400px;
    --header-height: 70px;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, 'Segoe UI', 
                 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Helvetica Neue', sans-serif;
    background-color: var(--color-base);
    color: var(--color-text-primary);
    line-height: 1.6;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
}

/* ================================================
   타이포그래피
   ================================================ */
h1, h2, h3, h4, h5, h6 {
    font-weight: 700;
    line-height: 1.3;
    color: var(--color-text-primary);
}

h1 { font-size: 32px; }
h2 { font-size: 28px; }
h3 { font-size: 24px; }
h4 { font-size: 20px; }
h5 { font-size: 18px; }
h6 { font-size: 16px; }

p {
    margin-bottom: var(--spacing-md);
    color: var(--color-text-secondary);
}

a {
    color: inherit;
    text-decoration: none;
    transition: color var(--transition-fast);
}

a:hover {
    color: var(--color-primary-dark);
}

/* ================================================
   상단 메뉴바 스타일
   ================================================ */
.navbar {
    position: sticky;
    top: 0;
    z-index: 1000;
    background: var(--color-white);
    box-shadow: var(--shadow-sm);
    border-bottom: 1px solid var(--color-border-light);
}

.navbar-inner {
    max-width: var(--max-width);
    margin: 0 auto;
    padding: 0 var(--spacing-lg);
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: var(--header-height);
    gap: var(--spacing-xl);
}

/* 로고 영역 */
.navbar-logo {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    flex-shrink: 0;
    text-decoration: none;
}

.logo-text {
    font-size: 22px;
    font-weight: 800;
    background: linear-gradient(135deg, var(--color-primary-dark), var(--color-primary));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.logo-icon {
    font-size: 28px;
}

/* 메뉴 탭 영역 */
.navbar-menu {
    display: flex;
    align-items: center;
    gap: var(--spacing-xs);
    flex: 1;
    justify-content: center;
    max-width: 700px;
}

.menu-tab {
    position: relative;
    padding: 12px 20px;
    font-size: 15px;
    font-weight: 600;
    color: var(--color-text-secondary);
    text-decoration: none;
    border-radius: var(--radius-md);
    transition: all var(--transition-base);
    white-space: nowrap;
}

.menu-tab:hover {
    color: var(--color-primary-dark);
    background: var(--color-primary-lighter);
}

.menu-tab.active {
    color: var(--color-primary-dark);
    background: var(--color-primary-lighter);
}

.menu-tab.active::after {
    content: '';
    position: absolute;
    bottom: -1px;
    left: 50%;
    transform: translateX(-50%);
    width: 60%;
    height: 3px;
    background: linear-gradient(90deg, var(--color-primary), var(--color-primary-dark));
    border-radius: 2px 2px 0 0;
}

.menu-icon {
    font-size: 18px;
    margin-right: 4px;
}

/* 사용자 액션 영역 */
.navbar-actions {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    flex-shrink: 0;
}

.login-button {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    padding: 10px 20px;
    background: var(--color-primary);
    color: white;
    border: none;
    border-radius: var(--radius-md);
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all var(--transition-base);
    text-decoration: none;
}

.login-button:hover {
    background: var(--color-primary-dark);
    transform: translateY(-1px);
    box-shadow: var(--shadow-md);
    color: white;
}

.profile-button {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 42px;
    height: 42px;
    background: var(--color-primary-lighter);
    border: 2px solid var(--color-primary);
    border-radius: var(--radius-full);
    cursor: pointer;
    transition: all var(--transition-base);
    position: relative;
}

.profile-button:hover {
    transform: scale(1.05);
    box-shadow: var(--shadow-md);
}

.profile-icon {
    font-size: 20px;
    color: var(--color-primary-dark);
}

/* 모바일 메뉴 토글 */
.mobile-menu-toggle {
    display: none;
    flex-direction: column;
    gap: 4px;
    width: 32px;
    height: 32px;
    background: transparent;
    border: none;
    cursor: pointer;
    padding: 6px;
}

.toggle-bar {
    width: 100%;
    height: 3px;
    background: var(--color-text-secondary);
    border-radius: 2px;
    transition: all var(--transition-base);
}

.mobile-menu-toggle.active .toggle-bar:nth-child(1) {
    transform: translateY(7px) rotate(45deg);
}

.mobile-menu-toggle.active .toggle-bar:nth-child(2) {
    opacity: 0;
}

.mobile-menu-toggle.active .toggle-bar:nth-child(3) {
    transform: translateY(-7px) rotate(-45deg);
}

/* 드롭다운 메뉴 */
.navbar-dropdown {
    position: relative;
}

.dropdown-menu {
    position: absolute;
    top: calc(100% + var(--spacing-sm));
    right: 0;
    min-width: 220px;
    background: var(--color-white);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-lg);
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px);
    transition: all var(--transition-base);
    z-index: 100;
}

.dropdown-menu.show {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.dropdown-item {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    padding: 12px 16px;
    color: var(--color-text-secondary);
    text-decoration: none;
    font-size: 14px;
    transition: all var(--transition-fast);
}

.dropdown-item:hover {
    background: var(--color-primary-lighter);
    color: var(--color-primary-dark);
}

.dropdown-divider {
    height: 1px;
    background: var(--color-border-light);
    margin: var(--spacing-xs) 0;
}

/* ================================================
   메인 컨텐츠
   ================================================ */
.content {
    max-width: var(--max-width);
    margin: 0 auto;
    padding: var(--spacing-2xl) var(--spacing-lg);
}

/* 페이지 헤더 */
.page-header {
    text-align: center;
    margin-bottom: var(--spacing-2xl);
    padding: var(--spacing-xl) 0;
}

.page-title {
    font-size: 36px;
    font-weight: 800;
    color: var(--color-text-primary);
    margin-bottom: var(--spacing-md);
}

.page-subtitle {
    font-size: 16px;
    color: var(--color-text-secondary);
    max-width: 600px;
    margin: 0 auto;
}

/* 카테고리 필터 섹션 */
.category-filter-section {
    background: var(--color-white);
    padding: var(--spacing-xl);
    margin-bottom: var(--spacing-xl);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-sm);
}

.filter-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: var(--spacing-lg);
}

.filter-title {
    font-size: 18px;
    font-weight: 700;
    color: var(--color-text-primary);
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
}

.filter-icon {
    font-size: 24px;
}

/* 카테고리 태그 */
.category-tags {
    display: flex;
    flex-wrap: wrap;
    gap: var(--spacing-md);
}

.category-tag {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    padding: 14px 24px;
    background: var(--color-base);
    border: 2px solid transparent;
    border-radius: var(--radius-md);
    color: var(--color-text-secondary);
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: all var(--transition-base);
    text-decoration: none;
}

.category-tag:hover {
    background: var(--color-primary-lighter);
    border-color: var(--color-primary-light);
    color: var(--color-primary-dark);
    transform: translateY(-2px);
}

.category-tag.active {
    background: linear-gradient(135deg, var(--color-primary), var(--color-primary-dark));
    color: white;
    border-color: var(--color-primary-dark);
    box-shadow: var(--shadow-md);
}

.category-tag-icon {
    font-size: 20px;
}

/* 카테고리 섹션 */
.category-section {
    margin-bottom: var(--spacing-2xl);
}

.category-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: var(--spacing-lg);
    padding-bottom: var(--spacing-md);
    border-bottom: 3px solid var(--color-primary-lighter);
}

.category-title-wrapper {
    display: flex;
    align-items: center;
    gap: var(--spacing-md);
}

.category-title {
    font-size: 28px;
    font-weight: 800;
    color: var(--color-text-primary);
}

.category-count {
    background: var(--color-primary);
    color: white;
    padding: 6px 16px;
    border-radius: var(--radius-full);
    font-size: 14px;
    font-weight: 700;
}

.view-all-btn {
    padding: 10px 20px;
    background: var(--color-primary-lighter);
    color: var(--color-primary-dark);
    border: none;
    border-radius: var(--radius-md);
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all var(--transition-base);
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: var(--spacing-sm);
}

.view-all-btn:hover {
    background: var(--color-primary);
    color: white;
}

/* 모임 카드 컨테이너 */
.meetings-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: var(--spacing-lg);
    margin-bottom: var(--spacing-xl);
}

/* 모임 카드 */
.meeting-card {
    background: var(--color-white);
    border-radius: var(--radius-lg);
    overflow: hidden;
    box-shadow: var(--shadow-sm);
    transition: all var(--transition-base);
    cursor: pointer;
    display: flex;
    flex-direction: column;
    height: 100%;
    opacity: 0;
}

.meeting-card:hover {
    transform: translateY(-8px);
    box-shadow: var(--shadow-lg);
}

/* 카드 이미지 영역 */
.meeting-image {
    position: relative;
    width: 100%;
    height: 180px;
    background: linear-gradient(135deg, var(--color-primary-lighter), var(--color-secondary-lighter));
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 64px;
    overflow: hidden;
}

/* 모임 상태 배지 */
.meeting-status {
    position: absolute;
    top: var(--spacing-md);
    right: var(--spacing-md);
    padding: 6px 14px;
    background: var(--color-white);
    border-radius: var(--radius-full);
    font-size: 12px;
    font-weight: 700;
    box-shadow: var(--shadow-md);
}

.meeting-status.recruiting {
    color: var(--color-primary-dark);
    background: var(--color-primary-lighter);
}

.meeting-status.full {
    color: var(--color-text-tertiary);
    background: var(--color-border-light);
}

/* 카드 정보 영역 */
.meeting-info {
    padding: var(--spacing-lg);
    display: flex;
    flex-direction: column;
    flex: 1;
}

.meeting-title {
    font-size: 20px;
    font-weight: 700;
    color: var(--color-text-primary);
    margin-bottom: var(--spacing-sm);
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.meeting-description {
    font-size: 14px;
    color: var(--color-text-secondary);
    margin-bottom: var(--spacing-md);
    line-height: 1.6;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    flex: 1;
}

/* 메타 정보 */
.meeting-meta {
    display: flex;
    flex-direction: column;
    gap: var(--spacing-sm);
    padding-top: var(--spacing-md);
    border-top: 1px solid var(--color-border-light);
    margin-bottom: var(--spacing-md);
}

.meta-item {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    font-size: 13px;
    color: var(--color-text-secondary);
}

.meta-icon {
    font-size: 16px;
    color: var(--color-primary-dark);
}

/* 태그 */
.meeting-tags {
    display: flex;
    flex-wrap: wrap;
    gap: var(--spacing-sm);
}

.tag {
    padding: 6px 12px;
    background: var(--color-primary-lighter);
    color: var(--color-primary-dark);
    border-radius: var(--radius-full);
    font-size: 12px;
    font-weight: 600;
}

.tag.secondary {
    background: var(--color-secondary-lighter);
    color: var(--color-secondary-dark);
}

/* 진행바 */
.progress-container {
    width: 100%;
    background: var(--color-border-light);
    border-radius: var(--radius-full);
    overflow: hidden;
    height: 8px;
}

.progress-bar {
    height: 100%;
    background: linear-gradient(90deg, var(--color-primary), var(--color-primary-dark));
    border-radius: var(--radius-full);
    transition: width var(--transition-slow);
}

/* 애니메이션 */
@keyframes slideInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* ================================================
   반응형
   ================================================ */
@media (max-width: 1024px) {
    .navbar-menu {
        gap: 2px;
    }
    
    .menu-tab {
        padding: 10px 14px;
        font-size: 14px;
    }
}

@media (max-width: 768px) {
    .navbar-inner {
        padding: 0 var(--spacing-md);
        height: 60px;
    }
    
    .mobile-menu-toggle {
        display: flex;
    }
    
    .navbar-menu {
        position: fixed;
        top: 60px;
        left: 0;
        right: 0;
        flex-direction: column;
        background: var(--color-white);
        padding: var(--spacing-lg);
        box-shadow: var(--shadow-lg);
        transform: translateY(-100%);
        opacity: 0;
        visibility: hidden;
        transition: all var(--transition-base);
        max-width: 100%;
        gap: var(--spacing-xs);
        z-index: 999;
    }
    
    .navbar-menu.active {
        transform: translateY(0);
        opacity: 1;
        visibility: visible;
    }
    
    .menu-tab {
        width: 100%;
        text-align: center;
        padding: 14px 20px;
    }
    
    .menu-tab.active::after {
        display: none;
    }
    
    .content {
        padding: var(--spacing-lg) var(--spacing-md);
    }
    
    .page-title {
        font-size: 28px;
    }
    
    .category-filter-section {
        padding: var(--spacing-lg);
    }
    
    .category-tags {
        gap: var(--spacing-sm);
    }
    
    .category-tag {
        padding: 10px 16px;
        font-size: 14px;
    }
    
    .category-title {
        font-size: 24px;
    }
    
    .meetings-container {
        grid-template-columns: 1fr;
    }
}
</style>
</head>
<body>
    <!-- 상단 메뉴바 -->
    <nav class="navbar">
        <div class="navbar-inner">
            <!-- 로고 영역 -->
            <a href="#" class="navbar-logo">
                <span class="logo-icon">🌱</span>
                <span class="logo-text">공모자들</span>
            </a>
            
            <!-- 메뉴 탭 영역 -->
            <div class="navbar-menu">
                <a href="<%=cp%>/notice/Notice.jsp" class="menu-tab">
                    <span class="menu-icon">📢</span>
                    공지사항
                </a>
                <a href="<%=cp%>/group/GroupList.jsp" class="menu-tab active">
                    <span class="menu-icon">👥</span>
                    모임구경
                </a>
                <a href="beforegroupcreate.do" class="menu-tab">
                    <span class="menu-icon">➕</span>
                    모임 개설
                </a>
                <a href="?page=mygroups" class="menu-tab">
                    <span class="menu-icon">📚</span>
                    내 모임
                </a>
                <a href="<%=cp%>/mypage.do" class="menu-tab">
                    <span class="menu-icon">⚙️</span>
                    마이페이지
                </a>
            </div>
            
            <!-- 사용자 액션 영역 -->
            <div class="navbar-actions">
                <!-- 로그인 버튼 (로그인 전) -->
                <a href="#" class="login-button">
                    <span class="login-icon">🔐</span>
                    <span>로그인</span>
                </a>
                
                <!-- 프로필 버튼 (로그인 후 - 주석 처리) -->
                <!-- 
                <div class="navbar-dropdown">
                    <div class="profile-button">
                        <span class="profile-icon">👤</span>
                    </div>
                    <div class="dropdown-menu">
                        <a href="#" class="dropdown-item">
                            <span>👤</span>
                            <span>내 프로필</span>
                        </a>
                        <a href="#" class="dropdown-item">
                            <span>⚙️</span>
                            <span>설정</span>
                        </a>
                        <div class="dropdown-divider"></div>
                        <a href="#" class="dropdown-item">
                            <span>🚪</span>
                            <span>로그아웃</span>
                        </a>
                    </div>
                </div>
                -->
                
                <!-- 모바일 메뉴 토글 -->
                <button class="mobile-menu-toggle">
                    <span class="toggle-bar"></span>
                    <span class="toggle-bar"></span>
                    <span class="toggle-bar"></span>
                </button>
            </div>
        </div>
    </nav>
    
    <!-- 메인 컨텐츠 -->
    <div class="content">
        <!-- 페이지 헤더 -->
        <div class="page-header">
            <h1 class="page-title">함께 성장하는 스터디 모임</h1>
            <p class="page-subtitle">
                다양한 분야의 스터디 모임을 찾아보고, 함께 공부하며 성장하세요!
            </p>
        </div>
        
        <!-- 카테고리 필터 섹션 -->
        <div class="category-filter-section">
            <div class="filter-header">
                <div class="filter-title">
                    <span class="filter-icon">🏷️</span>
                    <span>카테고리</span>
                </div>
            </div>
            <div class="category-tags">
                <a href="?category=all" class="category-tag <%= "all".equals(selectedCategory) ? "active" : "" %>">
                    <span class="category-tag-icon">📚</span>
                    <span>전체</span>
                </a>
                <a href="?category=reading" class="category-tag <%= "reading".equals(selectedCategory) ? "active" : "" %>">
                    <span class="category-tag-icon">📖</span>
                    <span>독서</span>
                </a>
                <a href="?category=language" class="category-tag <%= "language".equals(selectedCategory) ? "active" : "" %>">
                    <span class="category-tag-icon">🌐</span>
                    <span>어학</span>
                </a>
                <a href="?category=it" class="category-tag <%= "it".equals(selectedCategory) ? "active" : "" %>">
                    <span class="category-tag-icon">💻</span>
                    <span>IT</span>
                </a>
                <a href="?category=startup" class="category-tag <%= "startup".equals(selectedCategory) ? "active" : "" %>">
                    <span class="category-tag-icon">🚀</span>
                    <span>창업·취업</span>
                </a>
                <a href="?category=license" class="category-tag <%= "license".equals(selectedCategory) ? "active" : "" %>">
                    <span class="category-tag-icon">📜</span>
                    <span>자격증</span>
                </a>
                <a href="?category=exam" class="category-tag <%= "exam".equals(selectedCategory) ? "active" : "" %>">
                    <span class="category-tag-icon">✏️</span>
                    <span>시험</span>
                </a>
                <a href="?category=project" class="category-tag <%= "project".equals(selectedCategory) ? "active" : "" %>">
                    <span class="category-tag-icon">🔧</span>
                    <span>프로젝트</span>
                </a>
            </div>
        </div>
        
        <!-- IT/개발 카테고리 -->
        <div class="category-section">
            <div class="category-header">
                <div class="category-title-wrapper">
                    <h2 class="category-title">💻 IT/개발</h2>
                    <span class="category-count">8</span>
                </div>
                <a href="#" class="view-all-btn">
                    <span>전체보기</span>
                    <span>→</span>
                </a>
            </div>
            <div class="meetings-container">
                <!-- 모임 카드 1 -->
                <div class="meeting-card" data-group-id="1">
                    <div class="meeting-image">
                        ☕
                        <span class="meeting-status recruiting">모집중</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">자바 스프링 스터디</h3>
                        <p class="meeting-description">
                            백엔드 개발을 위한 스프링 프레임워크 완벽 정복! 초급부터 실전 프로젝트까지
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>4/8명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>매주 월, 수 20:00</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>온라인</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">Java</span>
                            <span class="tag">Spring</span>
                            <span class="tag secondary">백엔드</span>
                        </div>
                    </div>
                </div>
                
                <!-- 모임 카드 2 -->
                <div class="meeting-card" data-group-id="2">
                    <div class="meeting-image">
                        ⚛️
                        <span class="meeting-status recruiting">모집중</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">React 프론트엔드</h3>
                        <p class="meeting-description">
                            React와 TypeScript로 만드는 모던 웹 애플리케이션
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>5/6명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>매주 수 20:00</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>온라인</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">React</span>
                            <span class="tag">TypeScript</span>
                        </div>
                    </div>
                </div>
                
                <!-- 모임 카드 3 -->
                <div class="meeting-card" data-group-id="3">
                    <div class="meeting-image">
                        🤖
                        <span class="meeting-status recruiting">모집중</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">AI/ML 입문반</h3>
                        <p class="meeting-description">
                            파이썬으로 시작하는 머신러닝 기초부터 실전까지
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>7/10명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>매주 화, 목 20:00</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>온라인</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">Python</span>
                            <span class="tag secondary">AI</span>
                        </div>
                    </div>
                </div>
                
                <!-- 모임 카드 4 -->
                <div class="meeting-card" data-group-id="4">
                    <div class="meeting-image">
                        🗄️
                        <span class="meeting-status full">마감</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">데이터베이스 심화</h3>
                        <p class="meeting-description">
                            MySQL, PostgreSQL 성능 최적화와 고급 쿼리 작성
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>6/6명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>매주 목 19:30</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>강남역</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">Database</span>
                            <span class="tag">SQL</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 어학 카테고리 -->
        <div class="category-section">
            <div class="category-header">
                <div class="category-title-wrapper">
                    <h2 class="category-title">🌐 어학</h2>
                    <span class="category-count">5</span>
                </div>
                <a href="#" class="view-all-btn">
                    <span>전체보기</span>
                    <span>→</span>
                </a>
            </div>
            <div class="meetings-container">
                <!-- 모임 카드 5 -->
                <div class="meeting-card" data-group-id="5">
                    <div class="meeting-image">
                        🇺🇸
                        <span class="meeting-status recruiting">모집중</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">영어 회화 스터디</h3>
                        <p class="meeting-description">
                            원어민과 함께하는 실전 영어 회화 연습
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>8/12명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>매주 토 14:00</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>온라인</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">English</span>
                            <span class="tag secondary">회화</span>
                        </div>
                    </div>
                </div>
                
                <!-- 모임 카드 6 -->
                <div class="meeting-card" data-group-id="6">
                    <div class="meeting-image">
                        🇯🇵
                        <span class="meeting-status recruiting">모집중</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">JLPT N2 합격반</h3>
                        <p class="meeting-description">
                            일본어 능력시험 N2 단기 합격 목표 스터디
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>3/8명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>매주 화, 목 19:00</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>온라인</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">Japanese</span>
                            <span class="tag secondary">JLPT</span>
                        </div>
                    </div>
                </div>
                
                <!-- 모임 카드 7 -->
                <div class="meeting-card" data-group-id="7">
                    <div class="meeting-image">
                        🇨🇳
                        <span class="meeting-status recruiting">모집중</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">HSK 6급 준비반</h3>
                        <p class="meeting-description">
                            중국어 고급 과정, 실전 문제 풀이 중심
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>5/8명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>매주 월, 수 20:00</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>홍대입구역</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">Chinese</span>
                            <span class="tag secondary">HSK</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 독서 카테고리 -->
        <div class="category-section">
            <div class="category-header">
                <div class="category-title-wrapper">
                    <h2 class="category-title">📖 독서</h2>
                    <span class="category-count">6</span>
                </div>
                <a href="#" class="view-all-btn">
                    <span>전체보기</span>
                    <span>→</span>
                </a>
            </div>
            <div class="meetings-container">
                <!-- 모임 카드 8 -->
                <div class="meeting-card" data-group-id="8">
                    <div class="meeting-image">
                        📚
                        <span class="meeting-status recruiting">모집중</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">자기계발 도서 모임</h3>
                        <p class="meeting-description">
                            매주 한 권씩 읽고 함께 토론하는 독서 모임
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>6/10명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>매주 일 15:00</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>온라인</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">자기계발</span>
                            <span class="tag secondary">토론</span>
                        </div>
                    </div>
                </div>
                
                <!-- 모임 카드 9 -->
                <div class="meeting-card" data-group-id="9">
                    <div class="meeting-image">
                        🎭
                        <span class="meeting-status recruiting">모집중</span>
                    </div>
                    <div class="meeting-info">
                        <h3 class="meeting-title">고전문학 독서모임</h3>
                        <p class="meeting-description">
                            세계 고전을 함께 읽고 깊이 있게 토론하는 모임
                        </p>
                        <div class="meeting-meta">
                            <div class="meta-item">
                                <span class="meta-icon">👥</span>
                                <span>4/8명</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📅</span>
                                <span>격주 토 16:00</span>
                            </div>
                            <div class="meta-item">
                                <span class="meta-icon">📍</span>
                                <span>온라인</span>
                            </div>
                        </div>
                        <div class="meeting-tags">
                            <span class="tag">고전</span>
                            <span class="tag secondary">문학</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    $(document).ready(function() {
        // 모바일 메뉴 토글
        $('.mobile-menu-toggle').click(function() {
            $(this).toggleClass('active');
            $('.navbar-menu').toggleClass('active');
        });
        
        // 스크롤 시 헤더 스타일 변경
        $(window).scroll(function() {
            if ($(this).scrollTop() > 50) {
                $('.navbar').addClass('scrolled');
            } else {
                $('.navbar').removeClass('scrolled');
            }
        });
        
        // 프로필 드롭다운
        $('.profile-button').click(function(e) {
            e.stopPropagation();
            $('.dropdown-menu').toggleClass('show');
        });
        
        // 드롭다운 외부 클릭 시 닫기
        $(document).click(function() {
            $('.dropdown-menu').removeClass('show');
        });
        
        // 카드 클릭 시 상세 페이지로 이동
        $('.meeting-card').click(function() {
            const groupId = $(this).data('group-id');
            alert('모임 ' + groupId + ' 상세 페이지로 이동합니다.');
            // 실제로는: location.href = 'GroupDetail.jsp?id=' + groupId;
        });
        
        // 카드 애니메이션
        $('.meeting-card').each(function(index) {
            $(this).css({
                'animation': 'slideInUp 0.5s ease forwards',
                'animation-delay': (index * 0.05) + 's'
            });
        });
        
        // 카테고리 필터 (선택사항 - 실제로는 서버에서 처리)
        $('.category-tag').click(function(e) {
            // 페이지 이동하지 않고 클라이언트에서 필터링하려면:
            // e.preventDefault();
            // $('.category-tag').removeClass('active');
            // $(this).addClass('active');
            // const category = $(this).data('category');
            // ... 필터링 로직
        });
    });
    </script>
</body>
</html>