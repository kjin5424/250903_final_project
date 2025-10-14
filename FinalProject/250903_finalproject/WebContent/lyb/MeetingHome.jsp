<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!-- 모임 홈 화면 생성 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 홈</title>
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
        }

        /* 모임 헤더 */
        .group-header {
            background: linear-gradient(135deg, #2d5a29 0%, #4a8a42 100%);
            color: white;
            padding: 40px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        .group-header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .group-title-area {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .group-title {
            font-size: 32px;
            font-weight: bold;
        }
        .group-level {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
        .group-actions {
            display: flex;
            gap: 10px;
        }
        .btn-header {
            padding: 10px 20px;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid white;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-header:hover {
            background: white;
            color: #2d5a29;
        }
        .group-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
        }
        .stat-card {
            background: rgba(255, 255, 255, 0.15);
            padding: 20px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .stat-label {
            font-size: 13px;
            opacity: 0.9;
        }

        /* 메인 그리드 */
        .main-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        /* 공지사항 */
        .notice-section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d5a29;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-more {
            font-size: 13px;
            color: #666;
            background: none;
            border: none;
            cursor: pointer;
            padding: 5px 10px;
        }
        .btn-more:hover {
            color: #2d5a29;
            text-decoration: underline;
        }
        .notice-item {
            padding: 15px;
            background: #fff8e1;
            border-left: 4px solid #ffd54f;
            border-radius: 6px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .notice-item:hover {
            background: #fff3e0;
            transform: translateX(5px);
        }
        .notice-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        .notice-meta {
            font-size: 12px;
            color: #999;
        }

        /* 진행중인 투표 */
        .vote-section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        .vote-card {
            background: #f8faf8;
            padding: 20px;
            border-radius: 8px;
            border: 2px solid #e0e0e0;
            margin-bottom: 15px;
            transition: all 0.3s;
        }
        .vote-card:hover {
            border-color: #8bc683;
        }
        .vote-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        .vote-title {
            font-size: 16px;
            font-weight: 600;
            color: #333;
        }
        .vote-status {
            padding: 5px 12px;
            background: #4CAF50;
            color: white;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .vote-status.closed {
            background: #999;
        }
        .vote-info {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            font-size: 14px;
            color: #666;
        }
        .vote-info-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .vote-progress {
            margin-bottom: 10px;
        }
        .vote-progress-bar {
            height: 8px;
            background: #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
        }
        .vote-progress-fill {
            height: 100%;
            background: #4CAF50;
            transition: width 0.3s;
        }
        .vote-progress-text {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        .btn-vote {
            width: 100%;
            padding: 10px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-vote:hover {
            background: #45a049;
        }
        .btn-vote:disabled {
            background: #e0e0e0;
            color: #999;
            cursor: not-allowed;
        }

        /* 최근 게시글 */
        .recent-posts {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        .post-preview {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: all 0.3s;
        }
        .post-preview:hover {
            background: #f8faf8;
        }
        .post-preview:last-child {
            border-bottom: none;
        }
        .post-category-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            margin-right: 8px;
        }
        .badge-activity {
            background: #4CAF50;
            color: white;
        }
        .badge-question {
            background: #2196f3;
            color: white;
        }
        .badge-free {
            background: #9c27b0;
            color: white;
        }
        .post-preview-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        .post-preview-meta {
            font-size: 12px;
            color: #999;
        }

        /* 도전 과제 */
        .challenge-section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        .challenge-card {
            background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .challenge-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .challenge-progress {
            margin-bottom: 15px;
        }
        .challenge-progress-text {
            font-size: 14px;
            margin-bottom: 8px;
        }
        .challenge-progress-bar {
            height: 10px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 5px;
            overflow: hidden;
        }
        .challenge-progress-fill {
            height: 100%;
            background: white;
            transition: width 0.3s;
        }
        .challenge-info {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
        }
        .btn-challenge {
            width: 100%;
            padding: 10px;
            background: white;
            color: #f57c00;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
        }

        /* 알림 패널 */
        .notification-panel {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 20px;
        }
        .notification-item {
            padding: 12px;
            background: #f8faf8;
            border-radius: 6px;
            margin-bottom: 10px;
            display: flex;
            gap: 10px;
            align-items: flex-start;
        }
        .notification-icon {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex-shrink: 0;
        }
        .icon-notice {
            background: #fff3e0;
        }
        .icon-vote {
            background: #e3f2fd;
        }
        .icon-challenge {
            background: #fce4ec;
        }
        .notification-content {
            flex: 1;
        }
        .notification-text {
            font-size: 13px;
            color: #333;
            line-height: 1.5;
        }
        .notification-time {
            font-size: 11px;
            color: #999;
            margin-top: 3px;
        }

        /* 모임원 한줄소개 */
        .intro-section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        .my-intro {
            padding: 15px;
            background: #e8f5e9;
            border-radius: 8px;
            border-left: 4px solid #4CAF50;
            margin-bottom: 15px;
        }
        .intro-label {
            font-size: 12px;
            color: #2d5a29;
            font-weight: 600;
            margin-bottom: 8px;
        }
        .intro-text {
            color: #333;
            line-height: 1.6;
        }
        .btn-edit-intro {
            padding: 8px 15px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
        }

        @media (max-width: 1024px) {
            .main-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .group-header {
                padding: 25px 20px;
            }
            .group-title {
                font-size: 24px;
            }
            .group-header-top {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
            .group-stats {
                grid-template-columns: repeat(2, 1fr);
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
        
        function goToLevel()
		{
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
                <div class="notice-section">
                    <div class="section-header">
                        <h2 class="section-title">📢 공지사항</h2>
                        <button class="btn-more" onclick="goToBoard()">더보기 →</button>
                    </div>
                    <div class="notice-item" onclick="viewPost(1)">
                        <div class="notice-title">📢 이번 주 스터디 일정 안내</div>
                        <div class="notice-meta">코딩마스터 · 2024-10-10</div>
                    </div>
                    <div class="notice-item" onclick="viewPost(2)">
                        <div class="notice-title">🎉 모임 레벨 3 달성! 축하합니다</div>
                        <div class="notice-meta">코딩마스터 · 2024-10-08</div>
                    </div>
                    <div class="notice-item" onclick="viewPost(3)">
                        <div class="notice-title">⚠️ 모임 규칙 안내 (필독)</div>
                        <div class="notice-meta">코딩마스터 · 2024-10-05</div>
                    </div>
                </div>

                <!-- 진행중인 투표 -->
                <div class="vote-section">
                    <div class="section-header">
                        <h2 class="section-title">🗳️ 진행중인 투표</h2>
                    </div>
                    <div class="vote-card">
                        <div class="vote-header">
                            <div class="vote-title">10월 3주차 정기 모임</div>
                            <div class="vote-status">진행중</div>
                        </div>
                        <div class="vote-info">
                            <div class="vote-info-item">
                                <span>📅</span>
                                <span>10/17 (목) 19:00~21:00</span>
                            </div>
                            <div class="vote-info-item">
                                <span>📍</span>
                                <span>온라인</span>
                            </div>
                        </div>
                        <div class="vote-progress">
                            <div class="vote-progress-bar">
                                <div class="vote-progress-fill" style="width: 71%;"></div>
                            </div>
                            <div class="vote-progress-text">참여: 5명 / 미참여: 2명</div>
                        </div>
                        <button class="btn-vote" onclick="participateVote(1)">투표하기</button>
                    </div>

                    <div class="vote-card">
                        <div class="vote-header">
                            <div class="vote-title">10월 4주차 정기 모임</div>
                            <div class="vote-status closed">대기중</div>
                        </div>
                        <div class="vote-info">
                            <div class="vote-info-item">
                                <span>📅</span>
                                <span>10/24 (목) 19:00~21:00</span>
                            </div>
                            <div class="vote-info-item">
                                <span>📍</span>
                                <span>오프라인 (강남동)</span>
                            </div>
                        </div>
                        <div class="vote-progress">
                            <div class="vote-progress-bar">
                                <div class="vote-progress-fill" style="width: 0%;"></div>
                            </div>
                            <div class="vote-progress-text">투표 시작 전입니다</div>
                        </div>
                        <button class="btn-vote" disabled>투표 대기중</button>
                    </div>
                </div>

                <!-- 최근 게시글 -->
                <div class="recent-posts">
                    <div class="section-header">
                        <h2 class="section-title">📝 최근 게시글</h2>
                        <button class="btn-more" onclick="goToBoard()">더보기 →</button>
                    </div>
                    <div class="post-preview" onclick="viewPost(4)">
                        <div>
                            <span class="post-category-badge badge-activity">활동</span>
                            <span class="post-preview-title">백준 1234번 풀이 공유합니다</span>
                        </div>
                        <div class="post-preview-meta">개발자지망생 · 2024-10-12</div>
                    </div>
                    <div class="post-preview" onclick="viewPost(5)">
                        <div>
                            <span class="post-category-badge badge-question">질문</span>
                            <span class="post-preview-title">DP 문제 접근 방법 질문드립니다</span>
                        </div>
                        <div class="post-preview-meta">알고리즘초보 · 2024-10-11</div>
                    </div>
                    <div class="post-preview" onclick="viewPost(6)">
                        <div>
                            <span class="post-category-badge badge-free">자유</span>
                            <span class="post-preview-title">오늘 스터디 너무 재밌었어요!</span>
                        </div>
                        <div class="post-preview-meta">자바마스터 · 2024-10-10</div>
                    </div>
                </div>
            </div>

            <!-- 오른쪽 컬럼 -->
            <div>
                <!-- 도전 과제 -->
                <div class="challenge-section">
                    <div class="section-header">
                        <h2 class="section-title">🏆 진행중인 도전과제</h2>
                    </div>
                    <div class="challenge-card">
                        <div class="challenge-title">일주일 알고리즘 챌린지</div>
                        <div class="challenge-progress">
                            <div class="challenge-progress-text">Day 4/7 진행중</div>
                            <div class="challenge-progress-bar">
                                <div class="challenge-progress-fill" style="width: 57%;"></div>
                            </div>
                        </div>
                        <div class="challenge-info">
                            <span>참여: 6명</span>
                            <span>평균 달성률: 78%</span>
                        </div>
                        <button class="btn-challenge" onclick="viewChallenge(1)">인증하기</button>
                    </div>
                </div>

                <!-- 알림 -->
                <div class="notification-panel">
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
                <div class="intro-section">
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