<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>모임 홈 - 공모자들</title>
    <style>
        /* ================================================
           공통 변수 및 리셋 스타일
           ================================================ */
        :root {
            /* 컬러 시스템 */
            --color-base: #F8F8F8;
            --color-white: #FFFFFF;
            
            /* 포인트 컬러 - 연두색 계열 */
            --color-primary: #A8D5A1;
            --color-primary-light: #C8E6C3;
            --color-primary-lighter: #E8F5E6;
            --color-primary-dark: #8BC683;
            --color-primary-darker: #6BAF61;
            
            /* 서브 포인트 - 라벤더 */
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
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background: var(--color-base);
            color: var(--color-text-primary);
            line-height: 1.6;
        }

        /* ================================================
           네비게이션 바
           ================================================ */
        .navbar {
            background: var(--color-white);
            height: var(--header-height);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            max-width: var(--max-width);
            height: 100%;
            margin: 0 auto;
            padding: 0 var(--spacing-lg);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .nav-left {
            display: flex;
            align-items: center;
            gap: var(--spacing-xl);
        }

        .logo-tab {
            font-size: 20px;
            font-weight: 800;
            color: var(--color-primary-dark);
            cursor: pointer;
        }

        .nav-tabs {
            display: flex;
            gap: var(--spacing-md);
        }

        .tab {
            padding: 10px 18px;
            color: var(--color-text-secondary);
            text-decoration: none;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 15px;
            transition: all var(--transition-base);
        }

        .tab:hover {
            background: var(--color-primary-lighter);
            color: var(--color-primary-dark);
        }

        .tab.active {
            background: var(--color-primary);
            color: white;
        }

        .profile-btn {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            padding: 10px 18px;
            background: var(--color-primary-lighter);
            color: var(--color-primary-dark);
            text-decoration: none;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            transition: all var(--transition-base);
        }

        .profile-btn:hover {
            background: var(--color-primary);
            color: white;
        }

        /* ================================================
           메인 컨테이너
           ================================================ */
        .container {
            max-width: var(--max-width);
            margin: 0 auto;
            padding: var(--spacing-2xl) var(--spacing-lg);
        }

        /* ================================================
           모임 헤더
           ================================================ */
        .group-header {
            background: linear-gradient(135deg, var(--color-primary) 0%, var(--color-primary-dark) 100%);
            color: white;
            padding: var(--spacing-2xl);
            border-radius: var(--radius-lg);
            margin-bottom: var(--spacing-xl);
            box-shadow: var(--shadow-lg);
        }

        .group-header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-xl);
        }

        .group-title-area {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
        }

        .group-title {
            font-size: 32px;
            font-weight: 800;
        }

        .group-level {
            background: rgba(255, 255, 255, 0.25);
            padding: 8px 18px;
            border-radius: var(--radius-full);
            font-size: 14px;
            font-weight: 700;
            backdrop-filter: blur(10px);
        }

        .group-actions {
            display: flex;
            gap: var(--spacing-sm);
        }

        .btn-header {
            padding: 12px 20px;
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.5);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            transition: all var(--transition-base);
            backdrop-filter: blur(10px);
        }

        .btn-header:hover {
            background: white;
            color: var(--color-primary-dark);
            border-color: white;
            transform: translateY(-2px);
        }

        .group-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: var(--spacing-lg);
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.15);
            padding: var(--spacing-lg);
            border-radius: var(--radius-md);
            text-align: center;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .stat-value {
            font-size: 32px;
            font-weight: 800;
            margin-bottom: var(--spacing-xs);
        }

        .stat-label {
            font-size: 13px;
            opacity: 0.95;
            font-weight: 500;
        }

        /* ================================================
           메인 그리드
           ================================================ */
        .main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: var(--spacing-xl);
        }

        /* ================================================
           섹션 공통 스타일
           ================================================ */
        .section {
            background: white;
            border-radius: var(--radius-lg);
            padding: var(--spacing-xl);
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-lg);
            padding-bottom: var(--spacing-md);
            border-bottom: 2px solid var(--color-border-light);
        }

        .section-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--color-text-primary);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .btn-more {
            padding: 8px 16px;
            background: var(--color-primary-lighter);
            color: var(--color-primary-dark);
            border: none;
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .btn-more:hover {
            background: var(--color-primary);
            color: white;
        }

        /* ================================================
           공지사항
           ================================================ */
        .notice-item {
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-sm);
            cursor: pointer;
            transition: all var(--transition-base);
            border-left: 3px solid transparent;
        }

        .notice-item:hover {
            background: var(--color-primary-lighter);
            border-left-color: var(--color-primary);
            transform: translateX(4px);
        }

        .notice-title {
            font-size: 15px;
            font-weight: 600;
            color: var(--color-text-primary);
            margin-bottom: var(--spacing-xs);
        }

        .notice-meta {
            font-size: 12px;
            color: var(--color-text-tertiary);
        }

        /* ================================================
           투표 섹션
           ================================================ */
        .vote-item {
            padding: var(--spacing-lg);
            border: 2px solid var(--color-border-light);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-md);
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .vote-item:hover {
            border-color: var(--color-primary);
            background: var(--color-primary-lighter);
        }

        .vote-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-sm);
        }

        .vote-title {
            font-size: 15px;
            font-weight: 700;
            color: var(--color-text-primary);
        }

        .vote-badge {
            padding: 4px 12px;
            background: var(--color-accent-light);
            color: var(--color-accent-dark);
            border-radius: var(--radius-full);
            font-size: 11px;
            font-weight: 700;
        }

        .vote-info {
            font-size: 13px;
            color: var(--color-text-secondary);
        }

        /* ================================================
           도전과제
           ================================================ */
        .challenge-item {
            display: flex;
            gap: var(--spacing-md);
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-sm);
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .challenge-item:hover {
            background: var(--color-secondary-lighter);
        }

        .challenge-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, var(--color-secondary-light), var(--color-secondary));
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }

        .challenge-content {
            flex: 1;
        }

        .challenge-title {
            font-size: 15px;
            font-weight: 600;
            color: var(--color-text-primary);
            margin-bottom: var(--spacing-xs);
        }

        .challenge-meta {
            font-size: 12px;
            color: var(--color-text-tertiary);
        }

        /* ================================================
           알림
           ================================================ */
        .notification-item {
            display: flex;
            gap: var(--spacing-md);
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-sm);
            transition: all var(--transition-base);
        }

        .notification-item:hover {
            background: var(--color-base);
        }

        .notification-icon {
            width: 40px;
            height: 40px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }

        .notification-icon.icon-notice {
            background: var(--color-primary-lighter);
        }

        .notification-icon.icon-vote {
            background: var(--color-secondary-lighter);
        }

        .notification-icon.icon-challenge {
            background: var(--color-accent-light);
        }

        .notification-content {
            flex: 1;
        }

        .notification-text {
            font-size: 14px;
            color: var(--color-text-primary);
            margin-bottom: var(--spacing-xs);
        }

        .notification-time {
            font-size: 11px;
            color: var(--color-text-tertiary);
        }

        /* ================================================
           내 한줄소개
           ================================================ */
        .my-intro {
            padding: var(--spacing-lg);
            background: var(--color-primary-lighter);
            border-radius: var(--radius-md);
            border-left: 4px solid var(--color-primary);
            margin-bottom: var(--spacing-md);
        }

        .intro-label {
            font-size: 12px;
            color: var(--color-primary-dark);
            font-weight: 700;
            margin-bottom: var(--spacing-sm);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .intro-text {
            color: var(--color-text-primary);
            line-height: 1.6;
            font-size: 14px;
        }

        .btn-edit-intro {
            padding: 10px 20px;
            background: var(--color-primary);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            transition: all var(--transition-base);
            width: 100%;
        }

        .btn-edit-intro:hover {
            background: var(--color-primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* ================================================
           반응형
           ================================================ */
        @media (max-width: 1024px) {
            .main-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .nav-tabs {
                display: none;
            }

            .group-header {
                padding: var(--spacing-lg);
            }

            .group-title {
                font-size: 24px;
            }

            .group-header-top {
                flex-direction: column;
                gap: var(--spacing-md);
                align-items: flex-start;
            }

            .group-actions {
                flex-wrap: wrap;
                width: 100%;
            }

            .btn-header {
                flex: 1;
                min-width: calc(50% - var(--spacing-xs));
            }

            .group-stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .section {
                padding: var(--spacing-lg);
            }
        }
    </style>
    <script>
        function goToBoard() {
            window.location.href = 'board.jsp';
        }

        function goToMembers() {
            window.location.href = 'member_list.jsp';
        }

        function goToManage() {
            window.location.href = 'group_edit.jsp';
        }
        
        function goToLevel() {
            window.location.href = 'level.jsp';
        }

        function viewPost(postId) {
            window.location.href = 'board_detail.jsp?id=' + postId;
        }

        function participateVote(voteId) {
            window.location.href = 'vote_detail.jsp?id=' + voteId;
        }

        function viewChallenge(challengeId) {
            window.location.href = 'challenge_detail.jsp?id=' + challengeId;
        }

        function editIntro() {
            const newIntro = prompt('한줄 자기소개를 수정하세요:', '알고리즘 공부를 체계적으로 하고 싶어서 가입했습니다!');
            if (newIntro !== null && newIntro.trim()) {
                document.querySelector('.intro-text').textContent = newIntro;
                alert('자기소개가 수정되었습니다.');
            }
        }
    </script>
</head>
<body>
    <!-- 네비게이션 바 -->
    <nav class="navbar">
        <div class="nav-container">
            <div class="nav-left">
                <div class="logo-tab">🌱 공모자들</div>
                <div class="nav-tabs">
                    <a href="?page=notice" class="tab">공지사항</a>
                    <a href="?page=groups" class="tab">모임구경</a>
                    <a href="?page=creategroup" class="tab">모임 개설</a>
                    <a href="?page=mygroups" class="tab active">내 모임</a>
                </div>
            </div>
            <div class="nav-right">
                <a href="mypage.jsp" class="profile-btn">
                    <span>👤</span>
                    <span>마이페이지</span>
                </a>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- 모임 헤더 -->
        <div class="group-header">
            <div class="group-header-top">
                <div class="group-title-area">
                    <h1 class="group-title">알고리즘 정복 스터디</h1>
                    <span class="group-level">Lv.3</span>
                </div>
                <div class="group-actions">
                    <button class="btn-header" onclick="goToBoard()">📋 게시판</button>
                    <button class="btn-header" onclick="goToMembers()">👥 모임원</button>
                    <button class="btn-header" onclick="goToLevel()">🎚 레벨</button>
                    <button class="btn-header" onclick="goToManage()">⚙️ 관리</button>
                </div>
            </div>
            <div class="group-stats">
                <div class="stat-card">
                    <div class="stat-value">7/10</div>
                    <div class="stat-label">모임원</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">85%</div>
                    <div class="stat-label">전체 출석률</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">78%</div>
                    <div class="stat-label">도전과제 달성률</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">12회</div>
                    <div class="stat-label">누적 활동</div>
                </div>
            </div>
        </div>

        <div class="main-grid">
            <!-- 왼쪽 컬럼 -->
            <div>
                <!-- 공지사항 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">📢 공지사항</h2>
                        <button class="btn-more" onclick="goToBoard()">더보기 →</button>
                    </div>
                    <div class="notice-item" onclick="viewPost(1)">
                        <div class="notice-title">📢 이번 주 스터디 일정 안내</div>
                        <div class="notice-meta">코딩마스터 · 2024-10-10</div>
                    </div>
                    <div class="notice-item" onclick="viewPost(2)">
                        <div class="notice-title">🎉 모임 레벨 3 달성!</div>
                        <div class="notice-meta">운영진 · 2024-10-08</div>
                    </div>
                    <div class="notice-item" onclick="viewPost(3)">
                        <div class="notice-title">📚 필수 문제 업데이트 안내</div>
                        <div class="notice-meta">코딩마스터 · 2024-10-05</div>
                    </div>
                </div>

                <!-- 투표 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">🗳️ 진행 중인 투표</h2>
                    </div>
                    <div class="vote-item" onclick="participateVote(1)">
                        <div class="vote-header">
                            <div class="vote-title">10월 3주차 정기 모임 일정 투표</div>
                            <span class="vote-badge">진행중</span>
                        </div>
                        <div class="vote-info">📅 2024-10-17 ~ 2024-10-19 | 👥 5/7명 참여</div>
                    </div>
                    <div class="vote-item" onclick="participateVote(2)">
                        <div class="vote-header">
                            <div class="vote-title">다음 스터디 주제 선정</div>
                            <span class="vote-badge">진행중</span>
                        </div>
                        <div class="vote-info">📅 2024-10-15 ~ 2024-10-20 | 👥 3/7명 참여</div>
                    </div>
                </div>

                <!-- 도전과제 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">🏆 진행 중인 도전과제</h2>
                    </div>
                    <div class="challenge-item" onclick="viewChallenge(1)">
                        <div class="challenge-icon">📝</div>
                        <div class="challenge-content">
                            <div class="challenge-title">일일 알고리즘 문제 풀기</div>
                            <div class="challenge-meta">진행률: 15/30일 | 참여자: 6명</div>
                        </div>
                    </div>
                    <div class="challenge-item" onclick="viewChallenge(2)">
                        <div class="challenge-icon">💪</div>
                        <div class="challenge-content">
                            <div class="challenge-title">한 달 동안 매일 코드 리뷰하기</div>
                            <div class="challenge-meta">진행률: 8/30일 | 참여자: 4명</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 오른쪽 컬럼 -->
            <div>
                <!-- 알림 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">🔔 알림</h2>
                    </div>
                    <div class="notification-item">
                        <div class="notification-icon icon-notice">📢</div>
                        <div class="notification-content">
                            <div class="notification-text">새로운 공지사항이 등록되었습니다.</div>
                            <div class="notification-time">10분 전</div>
                        </div>
                    </div>
                    <div class="notification-item">
                        <div class="notification-icon icon-vote">🗳️</div>
                        <div class="notification-content">
                            <div class="notification-text">10월 3주차 정기 모임 투표가 시작되었습니다.</div>
                            <div class="notification-time">1시간 전</div>
                        </div>
                    </div>
                    <div class="notification-item">
                        <div class="notification-icon icon-challenge">🏆</div>
                        <div class="notification-content">
                            <div class="notification-text">도전과제 인증 알림: 오늘의 문제를 풀어보세요!</div>
                            <div class="notification-time">3시간 전</div>
                        </div>
                    </div>
                </div>

                <!-- 내 한줄소개 -->
                <div class="section">
                    <div class="section-header">
                        <h2 class="section-title">✍️ 내 한줄소개</h2>
                    </div>
                    <div class="my-intro">
                        <div class="intro-label">나의 소개</div>
                        <div class="intro-text">알고리즘 공부를 체계적으로 하고 싶어서 가입했습니다!</div>
                    </div>
                    <button class="btn-edit-intro" onclick="editIntro()">수정하기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>