<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 모임장이 조회 하는 프로필 화면 생성 -->
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 프로필 - 공모자들</title>
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 프로필 헤더 */
        .profile-header {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        .profile-top {
            display: flex;
            align-items: center;
            gap: 30px;
            padding-bottom: 30px;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 30px;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: linear-gradient(135deg, #a8d5a1, #8bc683);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            border: 4px solid #e8f5e6;
            flex-shrink: 0;
        }
        .profile-info {
            flex: 1;
        }
        .profile-name {
            font-size: 28px;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }
        .profile-meta {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
            font-size: 14px;
        }
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #666;
        }
        .meta-icon {
            font-size: 16px;
        }
        
        .profile-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary {
            background: #2d5a29;
            color: white;
        }
        .btn-primary:hover {
            background: #1f4019;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(45, 90, 41, 0.3);
        }
        .btn-danger {
            background: #f44336;
            color: white;
        }
        .btn-danger:hover {
            background: #d32f2f;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        /* 활동 통계 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        .stat-card {
            text-align: center;
            padding: 20px;
            background: #f8faf8;
            border-radius: 10px;
            border: 2px solid #e8f5e6;
        }
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 8px;
        }
        .stat-label {
            font-size: 13px;
            color: #666;
        }

        /* 섹션 */
        .section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e8f5e6;
        }

        /* 모임 이력 */
        .history-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .history-item {
            padding: 20px;
            background: #f8faf8;
            border-radius: 10px;
            border-left: 4px solid #8bc683;
            transition: all 0.3s;
        }
        .history-item:hover {
            background: #e8f5e9;
            transform: translateX(5px);
        }
        .history-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .history-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .role-badge {
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
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
        .history-period {
            font-size: 13px;
            color: #999;
        }
        .history-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-top: 15px;
        }
        .stat-item {
            text-align: center;
            padding: 10px;
            background: white;
            border-radius: 6px;
        }
        .stat-item-value {
            font-size: 18px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 4px;
        }
        .stat-item-label {
            font-size: 12px;
            color: #666;
        }

        /* 활동 내역 */
        .activity-empty {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        .activity-empty-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }

        /* 비공개 상태 */
        .private-notice {
            text-align: center;
            padding: 60px 20px;
            background: #f8faf8;
            border-radius: 10px;
            border: 2px dashed #e0e0e0;
        }
        .private-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }
        .private-text {
            font-size: 16px;
            color: #666;
            margin-bottom: 5px;
        }
        .private-subtext {
            font-size: 14px;
            color: #999;
        }

        @media (max-width: 768px) {
            .profile-top {
                flex-direction: column;
                text-align: center;
            }
            .profile-meta {
                grid-template-columns: 1fr;
            }
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .history-stats {
                grid-template-columns: 1fr;
            }
            .profile-actions {
                flex-direction: column;
            }
            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
    <script>
        function sendMessage() {
            //alert('쪽지 기능');
        }

        function reportMember() {
            if(confirm('이 회원을 신고하시겠습니까?')) {
                // 신고 페이지로 이동 또는 모달 표시
                window.location.href = 'report.jsp?memberId=user123';
            }
        }

        function goBack() {
            window.history.back();
        }
    </script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab">
                <span>로고 들어갈 자리</span>
            </div>
            <a href="?page=notice" class="tab">공지사항</a>
            <a href="?page=groups" class="tab">모임구경</a>
            <a href="?page=creategroup" class="tab">모임 개설</a>
            <a href="?page=mygroups" class="tab active">내 모임</a>
        </div>
        <div class="nav-right">
            <a href="mypage.jsp" class="profile-btn">
                <span>👤</span>
                <span>마이페이지</span>
            </a>
        </div>
    </nav>

    <div class="container">
        <!-- 프로필 헤더 -->
        <div class="profile-header">
            <div class="profile-top">
                <div class="profile-avatar">👤</div>
                <div class="profile-info">
                    <h1 class="profile-name">행복한토끼99</h1>
                    <div class="profile-meta">
                        <div class="meta-item">
                            <span class="meta-icon">📅</span>
                            <span>가입일: 2024년 3월</span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-icon">📍</span>
                            <span>서울시 강남구</span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-icon">🎂</span>
                            <span>20대</span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-icon">👥</span>
                            <span>활동 모임: 3개</span>
                        </div>
                    </div>
                    <div class="profile-actions">
                        <button class="btn btn-primary" onclick="sendMessage()">
                            ✉️ 쪽지 보내기
                        </button>
                        <button class="btn btn-danger" onclick="reportMember()">
                            🚨 신고하기
                        </button>
                    </div>
                </div>
            </div>

            <!-- 활동 통계 -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">3</div>
                    <div class="stat-label">참여 모임</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">1</div>
                    <div class="stat-label">운영 모임</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">89%</div>
                    <div class="stat-label">평균 출석률</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">8개월</div>
                    <div class="stat-label">활동 기간</div>
                </div>
            </div>
        </div>

        <!-- 운영 중인 모임 -->
        <div class="section">
            <h2 class="section-title">🎯 운영 중인 모임</h2>
            <div class="history-list">
                <div class="history-item">
                    <div class="history-header">
                        <div class="history-title">
                            <span>알고리즘 정복 스터디</span>
                            <span class="role-badge badge-owner">모임장</span>
                        </div>
                        <div class="history-period">2024-09-15 ~ 현재</div>
                    </div>
                    <div class="history-stats">
                        <div class="stat-item">
                            <div class="stat-item-value">92%</div>
                            <div class="stat-item-label">출석률</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-value">5/5</div>
                            <div class="stat-item-label">도전과제</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-value">12회</div>
                            <div class="stat-item-label">누적 활동</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 참여 중인 모임 -->
        <div class="section">
            <h2 class="section-title">📚 참여 중인 모임</h2>
            <div class="history-list">
                <div class="history-item">
                    <div class="history-header">
                        <div class="history-title">
                            <span>영어 회화 스터디</span>
                            <span class="role-badge badge-member">모임원</span>
                        </div>
                        <div class="history-period">2024-07-20 ~ 현재</div>
                    </div>
                    <div class="history-stats">
                        <div class="stat-item">
                            <div class="stat-item-value">88%</div>
                            <div class="stat-item-label">출석률</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-value">3/4</div>
                            <div class="stat-item-label">도전과제</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-value">15회</div>
                            <div class="stat-item-label">누적 활동</div>
                        </div>
                    </div>
                </div>

                <div class="history-item">
                    <div class="history-header">
                        <div class="history-title">
                            <span>자바 스프링 부트 스터디</span>
                            <span class="role-badge badge-member">모임원</span>
                        </div>
                        <div class="history-period">2024-06-10 ~ 현재</div>
                    </div>
                    <div class="history-stats">
                        <div class="stat-item">
                            <div class="stat-item-value">85%</div>
                            <div class="stat-item-label">출석률</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-value">4/5</div>
                            <div class="stat-item-label">도전과제</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-value">20회</div>
                            <div class="stat-item-label">누적 활동</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 이전 모임 이력 -->
        <div class="section">
            <h2 class="section-title">📜 이전 모임 이력</h2>
            <div class="history-list">
                <div class="history-item">
                    <div class="history-header">
                        <div class="history-title">
                            <span>코딩테스트 준비반</span>
                            <span class="role-badge badge-member">모임원</span>
                        </div>
                        <div class="history-period">2024-01-15 ~ 2024-05-30</div>
                    </div>
                    <div class="history-stats">
                        <div class="stat-item">
                            <div class="stat-item-value">95%</div>
                            <div class="stat-item-label">출석률</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-value">7/7</div>
                            <div class="stat-item-label">도전과제</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-item-value">자진탈퇴</div>
                            <div class="stat-item-label">탈퇴 사유</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 비공개 설정 예시 (조건부 표시) -->
        <!-- 
        <div class="section">
            <h2 class="section-title">📚 참여 중인 모임</h2>
            <div class="private-notice">
                <div class="private-icon">🔒</div>
                <div class="private-text">비공개 프로필</div>
                <div class="private-subtext">이 회원은 모임 이력을 비공개로 설정했습니다</div>
            </div>
        </div>
        -->
    </div>
</body>
</html>