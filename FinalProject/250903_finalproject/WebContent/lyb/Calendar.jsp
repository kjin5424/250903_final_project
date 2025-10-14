<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 마이페이지</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }
        .navbar {
            background: #a8d5a1;
            display: flex;
            align-items: center;
            padding: 0 20px;
            height: 48px;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            gap: 4px;
        }
        .nav-left {
            display: flex;
            align-items: center;
            gap: 4px;
            flex: 1;
        }
        .nav-right {
            display: flex;
            align-items: center;
            margin-left: auto;
        }
        .logo-tab {
            background: #8bc683;
            color: white;
            padding: 0 20px;
            height: 36px;
            border-radius: 8px 8px 0 0;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }
        .tab {
            background: #8bc683;
            color: white;
            border: none;
            padding: 0 24px;
            height: 36px;
            border-radius: 8px 8px 0 0;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        .tab.active {
            background: #f5f7fa;
            color: #2d5a29;
            height: 40px;
        }
        .profile-btn {
            background: #2d5a29;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .container {
            max-width: 1400px;
            margin: 30px auto;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 300px 1fr;
            gap: 20px;
        }

        .sidebar {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            height: fit-content;
            position: sticky;
            top: 80px;
        }
        .profile-section {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 30px;
            border-bottom: 2px solid #f0f0f0;
        }
        .profile-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #8bc683;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            margin: 0 auto 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .profile-name {
            font-size: 20px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 5px;
        }
        .profile-email {
            font-size: 13px;
            color: #999;
        }
        .profile-stats {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 20px;
        }
        .stat-box {
            text-align: center;
            padding: 15px;
            background: #f8faf8;
            border-radius: 8px;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #2d5a29;
        }
        .stat-label {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }

        .menu-section {
            margin-bottom: 25px;
        }
        .menu-title {
            font-size: 13px;
            color: #999;
            font-weight: 600;
            margin-bottom: 10px;
            text-transform: uppercase;
        }
        .menu-item {
            padding: 12px 15px;
            margin-bottom: 5px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 10px;
            color: #666;
            text-decoration: none;
        }
        .menu-item:hover {
            background: #f0f8f0;
            color: #2d5a29;
        }
        .menu-item.active {
            background: #e8f5e9;
            color: #2d5a29;
            font-weight: 600;
        }
        .menu-badge {
            margin-left: auto;
            background: #ff6b6b;
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
        }

        .main-content {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            min-height: 600px;
        }
        .page-title {
            font-size: 28px;
            color: #2d5a29;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .page-subtitle {
            color: #666;
            margin-bottom: 30px;
        }

        .tab-content {
            display: none;
        }
        .tab-content.active {
            display: block;
        }

        .group-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .group-card {
            background: #f8faf8;
            border-radius: 12px;
            padding: 20px;
            transition: all 0.3s;
            border: 2px solid transparent;
            cursor: pointer;
            position: relative;
        }
        .group-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            border-color: #8bc683;
        }
        .group-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
        }
        .badge-owner {
            background: #ffd54f;
            color: #f57c00;
        }
        .badge-member {
            background: #e3f2fd;
            color: #1565c0;
        }
        .group-image {
            width: 100%;
            height: 150px;
            border-radius: 8px;
            object-fit: cover;
            background: #e0e0e0;
            margin-bottom: 15px;
        }
        .group-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        .group-meta {
            font-size: 13px;
            color: #999;
            margin-bottom: 5px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .group-actions {
            display: flex;
            gap: 8px;
            margin-top: 15px;
        }
        .btn-small {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            flex: 1;
        }
        .btn-primary-small {
            background: #4CAF50;
            color: white;
        }
        .btn-primary-small:hover {
            background: #45a049;
        }
        .btn-outline-small {
            background: white;
            color: #666;
            border: 1px solid #ddd;
        }
        .btn-outline-small:hover {
            background: #f5f7fa;
        }
        .btn-danger-small {
            background: #f44336;
            color: white;
        }

        /* 캘린더 스타일 */
        .calendar-container {
            margin-top: 20px;
        }
        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding: 20px;
            background: #f8faf8;
            border-radius: 12px;
        }
        .calendar-nav {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .calendar-nav button {
            padding: 10px 20px;
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .calendar-nav button:hover {
            background: #8bc683;
            color: white;
            border-color: #8bc683;
        }
        .calendar-current {
            font-size: 22px;
            font-weight: bold;
            color: #2d5a29;
        }
        .calendar-legend {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
        }
        .legend-color {
            width: 16px;
            height: 16px;
            border-radius: 4px;
        }
        .legend-meeting {
            background: #4CAF50;
        }
        .legend-challenge {
            background: #ff9800;
        }
        .legend-vote {
            background: #2196f3;
        }

        .calendar-grid {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 2px;
            background: #e0e0e0;
            border-radius: 12px;
            overflow: hidden;
        }
        .calendar-day-header {
            background: #2d5a29;
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: 600;
            font-size: 14px;
        }
        .calendar-day-header.sunday {
            color: #ff6b6b;
        }
        .calendar-day-header.saturday {
            color: #64b5f6;
        }
        .calendar-cell {
            background: white;
            padding: 10px;
            min-height: 120px;
            position: relative;
            transition: all 0.3s;
        }
        .calendar-cell:hover {
            background: #f8faf8;
        }
        .calendar-cell.other-month {
            background: #fafafa;
            opacity: 0.5;
        }
        .calendar-cell.today {
            background: #e8f5e9;
            border: 2px solid #4CAF50;
        }
        .calendar-date {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .calendar-cell.sunday .calendar-date {
            color: #ff6b6b;
        }
        .calendar-cell.saturday .calendar-date {
            color: #2196f3;
        }
        .calendar-events {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }
        .calendar-event {
            padding: 4px 6px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .calendar-event:hover {
            transform: scale(1.05);
            z-index: 10;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }
        .event-meeting {
            background: #4CAF50;
            color: white;
        }
        .event-challenge {
            background: #ff9800;
            color: white;
        }
        .event-vote {
            background: #2196f3;
            color: white;
        }
        .event-more {
            color: #999;
            font-size: 10px;
            margin-top: 2px;
            text-align: center;
        }

        .schedule-list {
            margin-top: 30px;
        }
        .schedule-date-group {
            margin-bottom: 25px;
        }
        .schedule-date-header {
            font-size: 16px;
            font-weight: 600;
            color: #2d5a29;
            margin-bottom: 10px;
            padding-bottom: 8px;
            border-bottom: 2px solid #e0e0e0;
        }
        .schedule-item {
            display: flex;
            gap: 15px;
            padding: 15px;
            background: #f8faf8;
            border-radius: 8px;
            margin-bottom: 10px;
            transition: all 0.3s;
            cursor: pointer;
        }
        .schedule-item:hover {
            background: #e8f5e9;
            transform: translateX(5px);
        }
        .schedule-time {
            font-weight: 600;
            color: #2d5a29;
            min-width: 80px;
        }
        .schedule-content {
            flex: 1;
        }
        .schedule-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        .schedule-group {
            font-size: 13px;
            color: #999;
        }
        .schedule-type {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        .empty-state-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        @media (max-width: 1024px) {
            .container {
                grid-template-columns: 1fr;
            }
            .sidebar {
                position: relative;
                top: 0;
            }
            .calendar-grid {
                gap: 1px;
            }
            .calendar-cell {
                min-height: 80px;
                padding: 5px;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 25px 20px;
            }
            .group-grid {
                grid-template-columns: 1fr;
            }
            .calendar-header {
                flex-direction: column;
                gap: 15px;
            }
            .calendar-day-header {
                padding: 10px 5px;
                font-size: 12px;
            }
            .calendar-cell {
                min-height: 60px;
                padding: 3px;
            }
            .calendar-date {
                font-size: 12px;
            }
            .calendar-event {
                font-size: 9px;
                padding: 2px 4px;
            }
        }
    </style>
    
    <!-- 용량 너무 커서 서버가 안 돼서 잦바스크립트 하일 따로 만들어서 불러오는 형식으로 했슴다 -->
</head>

<!-- 상단바 -->
<body>
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab">
                <span>로고 들어갈 자리</span>
            </div>
            <a href="?page=notice" class="tab">공지사항</a>
            <a href="?page=groups" class="tab">모임구경</a>
            <a href="?page=creategroup" class="tab">모임 개설</a>
            <a href="?page=mygroups" class="tab">내 모임</a>
        </div>
        <div class="nav-right">
            <a href="mypage.jsp" class="profile-btn active">
                <span>👤</span>
                <span>마이페이지</span>
            </a>
        </div>
    </nav>

    <div class="container">
        <aside class="sidebar">
            <div class="profile-section">
                <div class="profile-avatar">👤</div>
                <div class="profile-name">스터디러버</div>
                <div class="profile-email">study@example.com</div>
                <div class="profile-stats">
                    <div class="stat-box">
                        <div class="stat-value">3</div>
                        <div class="stat-label">참여 모임</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-value">1</div>
                        <div class="stat-label">운영 모임</div>
                    </div>
                </div>
            </div>

            <div class="menu-section">
                <div class="menu-title">모임 관리</div>
                <a class="menu-item active" onclick="showTab('my-groups')">
                    <span>📚</span>
                    <span>내 모임</span>
                </a>
                <a class="menu-item" onclick="showTab('calendar')">
                    <span>📅</span>
                    <span>내 일정</span>
                </a>
            </div>
        </aside>

        <main class="main-content">
            <!-- 내 모임 탭 -->
            <div id="my-groups" class="tab-content active">
                <h1 class="page-title">📚 내 모임</h1>
                <p class="page-subtitle">현재 참여 중이거나 운영 중인 모임입니다</p>

                <h3 style="margin-top: 30px; margin-bottom: 15px; color: #666;">운영 중인 모임 (1)</h3>
                <div class="group-grid">
                    <div class="group-card" onclick="viewGroup(1)">
                        <span class="group-badge badge-owner">👑 모임장</span>
                        <img src="https://via.placeholder.com/300x150" alt="모임 이미지" class="group-image">
                        <div class="group-title">알고리즘 정복 스터디</div>
                        <div class="group-meta">
                            <span>👥</span>
                            <span>7/10명</span>
                        </div>
                        <div class="group-meta">
                            <span>📍</span>
                            <span>강남동 • 온라인/오프라인</span>
                        </div>
                        <div class="group-meta">
                            <span>📊</span>
                            <span>평균 출석률 85%</span>
                        </div>
                        <div class="group-actions">
                            <button class="btn-small btn-primary-small" onclick="event.stopPropagation(); location.href='group_edit.jsp'">⚙️ 관리</button>
                            <button class="btn-small btn-outline-small" onclick="event.stopPropagation(); viewGroup(1)">👀 보기</button>
                        </div>
                    </div>
                </div>

                <h3 style="margin-top: 40px; margin-bottom: 15px; color: #666;">참여 중인 모임 (2)</h3>
                <div class="group-grid">
                    <div class="group-card" onclick="viewGroup(2)">
                        <span class="group-badge badge-member">참여 중</span>
                        <img src="https://via.placeholder.com/300x150" alt="모임 이미지" class="group-image">
                        <div class="group-title">영어 회화 스터디</div>
                        <div class="group-meta">
                            <span>👥</span>
                            <span>5/7명</span>
                        </div>
                        <div class="group-meta">
                            <span>📍</span>
                            <span>온라인</span>
                        </div>
                        <div class="group-meta">
                            <span>📊</span>
                            <span>나의 출석률 92%</span>
                        </div>
                        <div class="group-actions">
                            <button class="btn-small btn-primary-small" onclick="event.stopPropagation(); viewGroup(2)">참여하기</button>
                            <button class="btn-small btn-danger-small" onclick="event.stopPropagation(); leaveGroup(2)">탈퇴</button>
                        </div>
                    </div>

                    <div class="group-card" onclick="viewGroup(3)">
                        <span class="group-badge badge-member">참여 중</span>
                        <img src="https://via.placeholder.com/300x150" alt="모임 이미지" class="group-image">
                        <div class="group-title">자바 스프링 부트 스터디</div>
                        <div class="group-meta">
                            <span>👥</span>
                            <span>8/10명</span>
                        </div>
                        <div class="group-meta">
                            <span>📍</span>
                            <span>역삼동 • 오프라인</span>
                        </div>
                        <div class="group-meta">
                            <span>📊</span>
                            <span>나의 출석률 78%</span>
                        </div>
                        <div class="group-actions">
                            <button class="btn-small btn-primary-small" onclick="event.stopPropagation(); viewGroup(3)">참여하기</button>
                            <button class="btn-small btn-danger-small" onclick="event.stopPropagation(); leaveGroup(3)">탈퇴</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 캘린더 탭 -->
            <div id="calendar" class="tab-content">
                <h1 class="page-title">📅 내 일정</h1>
                <p class="page-subtitle">참여 중인 모임의 일정이 자동으로 표시됩니다</p>

                <div class="calendar-container">
                    <div class="calendar-header">
                        <div class="calendar-nav">
                            <button onclick="changeMonth(-1)">◀ 이전</button>
                            <div class="calendar-current" id="currentMonth">2024년 10월</div>
                            <button onclick="changeMonth(1)">다음 ▶</button>
                            <button onclick="goToToday()">오늘</button>
                        </div>
                        <div class="calendar-legend">
                            <div class="legend-item">
                                <div class="legend-color legend-meeting"></div>
                                <span>정기 모임</span>
                            </div>
                            <div class="legend-item">
                                <div class="legend-color legend-challenge"></div>
                                <span>도전 과제</span>
                            </div>
                            <div class="legend-item">
                                <div class="legend-color legend-vote"></div>
                                <span>투표</span>
                            </div>
                        </div>
                    </div>

                    <div class="calendar-grid" id="calendarGrid">
                        <!-- JavaScript로 동적 생성 -->
                        
                    </div>
                </div>

                <div class="schedule-list">
                    <h2 style="font-size: 20px; color: #2d5a29; margin-bottom: 20px;">📋 상세 일정</h2>
                    <div id="scheduleList">
                        <!-- JavaScript로 동적 생성 -->
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>