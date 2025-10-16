<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 모임 활동 내역 확인 화면 생성-->
<!-- 마이페이지 화면 생성 -->
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



        /* 메인 컨테이너 */

        .container {

            max-width: 1400px;

            margin: 30px auto;

            padding: 0 20px;

            display: grid;

            grid-template-columns: 300px 1fr;

            gap: 20px;

        }



        /* 사이드바 */

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



        /* 메인 컨텐츠 */

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



        /* 탭 컨텐츠 */

        .tab-content {

            display: none;

        }

        .tab-content.active {

            display: block;

        }



        /* 모임 카드 */

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

        .badge-pending {

            background: #fff3e0;

            color: #e65100;

        }

        .badge-waiting {

            background: #fce4ec;

            color: #c2185b;

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

        .btn-danger-small:hover {

            background: #d32f2f;

        }



        /* 알림 목록 */

        .notification-list {

            margin-top: 20px;

        }

        .notification-item {

            padding: 20px;

            border-bottom: 1px solid #f0f0f0;

            display: flex;

            gap: 15px;

            transition: background 0.3s;

        }

        .notification-item:hover {

            background: #f8faf8;

        }

        .notification-item.unread {

            background: #e8f5e9;

        }

        .notification-icon {

            width: 40px;

            height: 40px;

            border-radius: 50%;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 20px;

            flex-shrink: 0;

        }

        .notification-icon.notice {

            background: #e3f2fd;

        }

        .notification-icon.vote {

            background: #fff3e0;

        }

        .notification-icon.comment {

            background: #f3e5f5;

        }

        .notification-content {

            flex: 1;

        }

        .notification-title {

            font-size: 15px;

            font-weight: 600;

            color: #333;

            margin-bottom: 5px;

        }

        .notification-message {

            font-size: 14px;

            color: #666;

            line-height: 1.5;

        }

        .notification-time {

            font-size: 12px;

            color: #999;

            margin-top: 5px;

        }



        /* 즐겨찾기 */

        .favorite-item {

            display: flex;

            align-items: center;

            padding: 15px;

            border: 2px solid #f0f0f0;

            border-radius: 8px;

            margin-bottom: 10px;

            transition: all 0.3s;

        }

        .favorite-item:hover {

            border-color: #8bc683;

            background: #f8faf8;

        }

        .favorite-icon {

            font-size: 24px;

            margin-right: 15px;

        }

        .favorite-info {

            flex: 1;

        }

        .favorite-name {

            font-size: 16px;

            font-weight: 600;

            color: #333;

        }

        .favorite-status {

            font-size: 13px;

            color: #666;

            margin-top: 3px;

        }

        .favorite-actions {

            display: flex;

            gap: 8px;

        }



        /* 프로필 설정 폼 */

        .settings-section {

            margin-bottom: 30px;

            padding-bottom: 30px;

            border-bottom: 2px solid #f0f0f0;

        }

        .settings-section:last-child {

            border-bottom: none;

        }

        .section-title {

            font-size: 18px;

            color: #2d5a29;

            margin-bottom: 20px;

            font-weight: 600;

        }

        .form-group {

            margin-bottom: 20px;

        }

        .form-label {

            display: block;

            font-size: 14px;

            font-weight: 600;

            color: #333;

            margin-bottom: 8px;

        }

        .form-input {

            width: 100%;

            padding: 12px;

            border: 2px solid #e0e0e0;

            border-radius: 8px;

            font-size: 14px;

            transition: all 0.3s;

        }

        .form-input:focus {

            outline: none;

            border-color: #8bc683;

            box-shadow: 0 0 0 3px rgba(139, 198, 131, 0.1);

        }

        .form-input:disabled {

            background: #f5f7fa;

            cursor: not-allowed;

        }

        .toggle-switch {

            display: flex;

            align-items: center;

            gap: 10px;

            margin-bottom: 15px;

        }

        .switch {

            position: relative;

            width: 50px;

            height: 26px;

        }

        .switch input {

            opacity: 0;

            width: 0;

            height: 0;

        }

        .slider {

            position: absolute;

            cursor: pointer;

            top: 0;

            left: 0;

            right: 0;

            bottom: 0;

            background-color: #ccc;

            transition: .4s;

            border-radius: 26px;

        }

        .slider:before {

            position: absolute;

            content: "";

            height: 20px;

            width: 20px;

            left: 3px;

            bottom: 3px;

            background-color: white;

            transition: .4s;

            border-radius: 50%;

        }

        input:checked + .slider {

            background-color: #4CAF50;

        }

        input:checked + .slider:before {

            transform: translateX(24px);

        }

        .btn-save {

            padding: 12px 30px;

            background: #4CAF50;

            color: white;

            border: none;

            border-radius: 8px;

            font-size: 15px;

            font-weight: 600;

            cursor: pointer;

            transition: all 0.3s;

        }

        .btn-save:hover {

            background: #45a049;

            transform: translateY(-2px);

            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);

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

        .empty-state-text {

            font-size: 16px;

        }



        @media (max-width: 1024px) {

            .container {

                grid-template-columns: 1fr;

            }

            .sidebar {

                position: relative;

                top: 0;

            }

        }



        @media (max-width: 768px) {

            .main-content {

                padding: 25px 20px;

            }

            .group-grid {

                grid-template-columns: 1fr;

            }

        }

    </style>

    <script>

        function showTab(tabId) {

            // 모든 탭 숨기기

            const tabs = document.querySelectorAll('.tab-content');

            tabs.forEach(tab => tab.classList.remove('active'));

            

            // 모든 메뉴 비활성화

            const menus = document.querySelectorAll('.menu-item');

            menus.forEach(menu => menu.classList.remove('active'));

            

            // 선택된 탭 표시

            document.getElementById(tabId).classList.add('active');

            event.target.classList.add('active');

        }



        function viewGroup(groupId) {

            window.location.href = 'group_detail.jsp?id=' + groupId;

        }



        function cancelApplication(groupId) {

            if(confirm('참여 신청을 취소하시겠습니까?')) {

                alert('참여 신청이 취소되었습니다.');

            }

        }



        function leaveGroup(groupId) {

            if(confirm('정말 이 모임을 탈퇴하시겠습니까?\n탈퇴 후 당일 재가입은 불가능합니다.')) {

                // 탈퇴 사유 입력 모달 표시 (실제 구현 필요)

                alert('탈퇴가 완료되었습니다.');

            }

        }



        function removeFavorite(groupId) {

            if(confirm('즐겨찾기에서 삭제하시겠습니까?')) {

                alert('즐겨찾기에서 삭제되었습니다.');

            }

        }



        function saveProfile() {

            alert('프로필이 저장되었습니다!');

        }



        window.onload = function() {

            showTab('my-groups');

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

        <!-- 사이드바 -->

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

                <a class="menu-item" onclick="showTab('pending-groups')">

                    <span>⏳</span>

                    <span>신청 중인 모임</span>

                    <span class="menu-badge">2</span>

                </a>

                <a class="menu-item" onclick="showTab('past-groups')">

                    <span>📜</span>

                    <span>이전 모임</span>

                </a>

            </div>



            <div class="menu-section">

                <div class="menu-title">활동</div>

                <a class="menu-item" onclick="showTab('notifications')">

                    <span>🔔</span>

                    <span>알림</span>

                    <span class="menu-badge">5</span>

                </a>

                <a class="menu-item" onclick="showTab('favorites')">

                    <span>⭐</span>

                    <span>즐겨찾기</span>

                </a>

                <a class="menu-item" onclick="showTab('calendar')">

                    <span>📅</span>

                    <span>내 일정</span>

                </a>

            </div>



            <div class="menu-section">

                <div class="menu-title">설정</div>

                <a class="menu-item" onclick="showTab('profile-settings')">

                    <span>⚙️</span>

                    <span>프로필 설정</span>

                </a>

                <a class="menu-item" onclick="showTab('notification-settings')">

                    <span>🔕</span>

                    <span>알림 설정</span>

                </a>

            </div>

        </aside>



        <!-- 메인 컨텐츠 -->

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



            <!-- 신청 중인 모임 탭 -->

            <div id="pending-groups" class="tab-content">

                <h1 class="page-title">⏳ 신청 중인 모임</h1>

                <p class="page-subtitle">참여 신청 중이거나 개설 대기 중인 모임입니다</p>



                <h3 style="margin-top: 30px; margin-bottom: 15px; color: #666;">참여 신청 중 (2)</h3>

                <div class="group-grid">

                    <div class="group-card">

                        <span class="group-badge badge-pending">승인 대기</span>

                        <img src="https://via.placeholder.com/300x150" alt="모임 이미지" class="group-image">

                        <div class="group-title">토익 900+ 목표반</div>

                        <div class="group-meta">

                            <span>📅</span>

                            <span>신청일: 2024-10-08</span>

                        </div>

                        <div class="group-meta">

                            <span>👥</span>

                            <span>6/10명</span>

                        </div>

                        <div class="group-actions">

                            <button class="btn-small btn-outline-small" onclick="viewGroup(4)">상세보기</button>

                            <button class="btn-small btn-danger-small" onclick="cancelApplication(4)">신청 취소</button>

                        </div>

                    </div>



                    <div class="group-card">

                        <span class="group-badge badge-pending">승인 대기</span>

                        <img src="https://via.placeholder.com/300x150" alt="모임 이미지" class="group-image">

                        <div class="group-title">프론트엔드 개발 스터디</div>

                        <div class="group-meta">

                            <span>📅</span>

                            <span>신청일: 2024-10-09</span>

                        </div>

                        <div class="group-meta">

                            <span>👥</span>

                            <span>4/7명</span>

                        </div>

                        <div class="group-actions">

                            <button class="btn-small btn-outline-small" onclick="viewGroup(5)">상세보기</button>

                            <button class="btn-small btn-danger-small" onclick="cancelApplication(5)">신청 취소</button>

                        </div>

                    </div>

                </div>



                <h3 style="margin-top: 40px; margin-bottom: 15px; color: #666;">개설 대기 중 (1)</h3>

                <div class="group-grid">

                    <div class="group-card">

                        <span class="group-badge badge-waiting">개설 신청중</span>