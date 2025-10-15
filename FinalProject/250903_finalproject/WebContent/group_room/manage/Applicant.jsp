<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 모임 참여 신청자 리스트 화면 -->
<%@ page language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>공모자들 - 참여 신청자 관리</title>

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

            max-width: 1200px;

            margin: 30px auto;

            padding: 0 20px;

        }



        .page-header {

            background: white;

            padding: 30px;

            border-radius: 12px;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

            margin-bottom: 20px;

        }

        .header-top {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 15px;

        }

        .page-title {

            font-size: 28px;

            color: #2d5a29;

            font-weight: bold;

        }

        .applicant-count {

            font-size: 18px;

            color: #666;

            background: #fff3e0;

            padding: 8px 20px;

            border-radius: 20px;

            font-weight: 600;

        }

        .page-subtitle {

            color: #666;

            font-size: 14px;

        }

        .info-alert {

            background: #e3f2fd;

            border-left: 4px solid #2196f3;

            padding: 15px;

            margin-top: 15px;

            border-radius: 4px;

        }

        .info-alert p {

            color: #1565c0;

            font-size: 14px;

            line-height: 1.6;

        }



        .applicant-container {

            background: white;

            border-radius: 12px;

            padding: 30px;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

        }



        .applicant-list {

            display: grid;

            gap: 20px;

        }

        .applicant-card {

            background: #f8faf8;

            border: 2px solid #e0e0e0;

            border-radius: 12px;

            padding: 25px;

            transition: all 0.3s;

        }

        .applicant-card:hover {

            border-color: #8bc683;

            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);

        }

        

        .applicant-header {

            display: flex;

            align-items: center;

            gap: 20px;

            margin-bottom: 20px;

            padding-bottom: 20px;

            border-bottom: 2px solid #e0e0e0;

        }

        .applicant-avatar {

            width: 70px;

            height: 70px;

            border-radius: 50%;

            background: #8bc683;

            color: white;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 32px;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);

            flex-shrink: 0;

        }

        .applicant-info {

            flex: 1;

        }

        .applicant-name-row {

            display: flex;

            align-items: center;

            gap: 10px;

            margin-bottom: 8px;

        }

        .applicant-name {

            font-size: 20px;

            font-weight: 600;

            color: #333;

        }

        .applicant-badge {

            padding: 4px 10px;

            border-radius: 12px;

            font-size: 11px;

            font-weight: 600;

            background: #fff3e0;

            color: #f57c00;

        }

        .applicant-meta {

            display: flex;

            gap: 20px;

            color: #666;

            font-size: 14px;

        }

        .applicant-meta-item {

            display: flex;

            align-items: center;

            gap: 5px;

        }

        .applicant-actions {

            display: flex;

            gap: 10px;

        }

        

        .applicant-body {

            display: grid;

            gap: 20px;

        }

        

        .info-section {

            background: white;

            padding: 20px;

            border-radius: 8px;

            border: 1px solid #e0e0e0;

        }

        .info-section-title {

            font-size: 15px;

            font-weight: 600;

            color: #2d5a29;

            margin-bottom: 12px;

            display: flex;

            align-items: center;

            gap: 8px;

        }

        .info-content {

            color: #666;

            line-height: 1.6;

            font-size: 14px;

        }

        

        .profile-preview {

            display: grid;

            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));

            gap: 15px;

        }

        .profile-item {

            display: flex;

            flex-direction: column;

            gap: 5px;

        }

        .profile-label {

            font-size: 12px;

            color: #999;

            font-weight: 600;

        }

        .profile-value {

            font-size: 14px;

            color: #333;

        }

        

        .activity-history {

            display: flex;

            flex-direction: column;

            gap: 10px;

        }

        .history-item {

            padding: 12px;

            background: #f8faf8;

            border-radius: 6px;

            display: flex;

            justify-content: space-between;

            align-items: center;

        }

        .history-group {

            font-weight: 600;

            color: #333;

        }

        .history-period {

            font-size: 12px;

            color: #999;

        }

        .history-stats {

            font-size: 13px;

            color: #666;

        }

        .stat-good {

            color: #4CAF50;

            font-weight: 600;

        }

        .stat-warning {

            color: #ff9800;

            font-weight: 600;

        }

        

        .question-answer {

            display: flex;

            flex-direction: column;

            gap: 15px;

        }

        .qa-item {

            padding: 15px;

            background: #f8faf8;

            border-radius: 8px;

            border-left: 4px solid #8bc683;

        }

        .question {

            font-weight: 600;

            color: #2d5a29;

            margin-bottom: 8px;

        }

        .answer {

            color: #666;

            line-height: 1.6;

        }

        

        .btn {

            padding: 12px 24px;

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

        .btn-approve {

            background: #4CAF50;

            color: white;

            flex: 1;

        }

        .btn-approve:hover {

            background: #45a049;

            transform: translateY(-2px);

            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);

        }

        .btn-reject {

            background: #f44336;

            color: white;

            flex: 1;

        }

        .btn-reject:hover {

            background: #d32f2f;

            transform: translateY(-2px);

            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);

        }

        .btn-profile {

            background: #2d5a29;

            color: white;

        }

        .btn-profile:hover {

            background: #1f4019;

        }



        .empty-state {

            text-align: center;

            padding: 80px 20px;

            color: #999;

        }

        .empty-state-icon {

            font-size: 80px;

            margin-bottom: 20px;

        }

        .empty-state-text {

            font-size: 18px;

            margin-bottom: 10px;

        }

        .empty-state-sub {

            font-size: 14px;

            color: #bbb;

        }



        @media (max-width: 768px) {

            .applicant-header {

                flex-direction: column;

                text-align: center;

            }

            .applicant-info {

                text-align: center;

            }

            .applicant-name-row {

                justify-content: center;

            }

            .applicant-meta {

                flex-direction: column;

                gap: 5px;

            }

            .applicant-actions {

                width: 100%;

            }

            .btn {

                flex: 1;

            }

            .profile-preview {

                grid-template-columns: 1fr;

            }

        }

    </style>

    <script>

        function approveApplicant(applicantId, applicantName) {

            if(confirm(applicantName + '님의 가입을 승인하시겠습니까?')) {

                alert(applicantName + '님의 가입이 승인되었습니다.\n환영 메시지가 자동으로 발송됩니다.');

                // 실제로는 서버에 승인 요청

                location.reload();

            }

        }



        function rejectApplicant(applicantId, applicantName) {

            const reason = prompt(applicantName + '님의 가입을 거절하시겠습니까?\n거절 사유를 입력해주세요 (선택사항):');

            if(reason !== null) {

                alert(applicantName + '님의 가입이 거절되었습니다.');

                // 실제로는 서버에 거절 요청

                location.reload();

            }

        }



        function viewApplicantProfile(applicantId) {

            window.location.href = 'member_profile.jsp?id=' + applicantId;

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

        <div class="page-header">

            <div class="header-top">

                <h1 class="page-title">📋 참여 신청자 관리</h1>

                <div class="applicant-count">대기 중 3명</div>

            </div>

            <p class="page-subtitle">알고리즘 정복 스터디의 가입 신청자 목록입니다</p>

            <div class="info-alert">

                <p>💡 <strong>신청자 승인 안내:</strong> 신청자의 프로필과 답변을 확인한 후 승인 또는 거절할 수 있습니다. 승인 시 자동으로 환영 메시지가 발송됩니다.</p>

            </div>

        </div>



        <div class="applicant-container">

            <div class="applicant-list">

                <!-- 신청자 1 -->

                <div class="applicant-card">

                    <div class="applicant-header">

                        <div class="applicant-avatar">👤</div>

                        <div class="applicant-info">

                            <div class="applicant-name-row">

                                <span class="applicant-name">백엔드개발자</span>

                                <span class="applicant-badge">신규 신청</span>

                            </div>

                            <div class="applicant-meta">

                                <div class="applicant-meta-item">

                                    <span>📅</span>

                                    <span>신청일: 2024-10-12</span>

                                </div>

                                <div class="applicant-meta-item">

                                    <span>📍</span>

                                    <span>서울 강남구</span>

                                </div>

                                <div class="applicant-meta-item">

                                    <span>🎂</span>

                                    <span>20대</span>

                                </div>

                            </div>

                        </div>

                        <div class="applicant-actions">

                            <button class="btn btn-profile" onclick="viewApplicantProfile(1)">상세 프로필</button>

                        </div>

                    </div>



                    <div class="applicant-body">

                        <div class="info-section">

                            <div class="info-section-title">✍️ 한줄 자기소개</div>

                            <div class="info-content">

                                알고리즘 공부를 체계적으로 하고 싶어서 신청했습니다. 함께 성장하는 스터디 문화를 만들고 싶습니다!

                            </div>

                        </div>



                        <div class="info-section">

                            <div class="info-section-title">📊 활동 이력</div>

                            <div class="activity-history">

                                <div class="history-item">

                                    <div>

                                        <div class="history-group">자바 스프링 스터디</div>

                                        <div class="history-period">2024.03 ~ 2024.08 (6개월)</div>

                                    </div>

                                    <div class="history-stats">

                                        출석률: <span class="stat-good">95%</span>

                                    </div>

                                </div>

                                <div class="history-item">

                                    <div>

                                        <div class="history-group">코딩테스트 준비반</div>

                                        <div class="history-period">2024.01 ~ 2024.02 (2개월)</div>

                                    </div>

                                    <div class="history-stats">

                                        출석률: <span class="stat-good">88%</span>

                                    </div>

                                </div>

                            </div>

                        </div>



                        <div class="info-section">

                            <div class="info-section-title">❓ 가입 질문 답변</div>

                            <div class="question-answer">

                                <div class="qa-item">

                                    <div class="question">Q1. 어떤 프로그래밍 언어를 주로 사용하시나요?</div>

                                    <div class="answer">Java와 Python을 주로 사용합니다. 최근에는 Java로 백엔드 개발을 공부하고 있습니다.</div>

                                </div>

                                <div class="qa-item">

                                    <div class="question">Q2. 알고리즘 공부 경험이 있으신가요?</div>

                                    <div class="answer">백준에서 실버 티어이고, 프로그래머스 레벨 2 문제까지 풀어봤습니다. 더 체계적으로 공부하고 싶습니다.</div>

                                </div>

                                <div class="qa-item">

                                    <div class="question">Q3. 이 스터디를 통해 이루고 싶은 목표는 무엇인가요?</div>

                                    <div class="answer">코딩테스트 실력을 늘려서 내년 상반기 취업을 목표로 하고 있습니다. 꾸준히 참여하겠습니다!</div>

                                </div>

                            </div>

                        </div>



                        <div class="applicant-actions" style="margin-top: 20px;">

                            <button class="btn btn-approve" onclick="approveApplicant(1, '백엔드개발자')">

                                ✅ 승인

                            </button>

                            <button class="btn btn-reject" onclick="rejectApplicant(1, '백엔드개발자')">

                                ❌ 거절

                            </button>

                        </div>

                    </div>

                </div>



                <!-- 신청자 2 -->

                <div class="applicant-card">

                    <div class="applicant-header">

                        <div class="applicant-avatar">👤</div>

                        <div class="applicant-info">

                            <div class="applicant-name-row">

                                <span class="applicant-name">프론트개발러</span>

                                <span class="applicant-badge">신규 신청</span>

                            </div>

                            <div class="applicant-meta">

                                <div class="applicant-meta-item">

                                    <span>📅</span>

                                    <span>신청일: 2024-10-11</span>

                                </div>

                                <div class="applicant-meta-item">

                                    <span>📍</span>

                                    <span>서울 강남구</span>

                                </div>

                                <div class="applicant-meta-item">

                                    <span>🎂</span>

                                    <span>20대</span>

                                </div>

                            </div>

                        </div>

                        <div class="applicant-actions">

                            <button class="btn btn-profile" onclick="viewApplicantProfile(2)">상세 프로필</button>

                        </div>

                    </div>



                    <div class="applicant-body">

                        <div class="info-section">

                            <div class="info-section-title">✍️ 한줄 자기소개</div>

                            <div class="info-content">

                                프론트엔드 개발자이지만 알고리즘 실력을 키우고 싶어서 지원했습니다!

                            </div>

                        </div>



                        <div class="info-section">

                            <div class="info-section-title">📊 활동 이력</div>

                            <div class="activity-history">

                                <div class="history-item">

                                    <div>

                                        <div class="history-group">React 스터디</div>

                                        <div class="history-period">2024.06 ~ 현재 (4개월)</div>

                                    </div>

                                    <div class="history-stats">

                                        출석률: <span class="stat-good">92%</span>

                                    </div>

                                </div>

                            </div>

                        </div>



                        <div class="info-section">

                            <div class="info-section-title">❓ 가입 질문 답변</div>

                            <div class="question-answer">

                                <div class="qa-item">

                                    <div class="question">Q1. 어떤 프로그래밍 언어를 주로 사용하시나요?</div>

                                    <div class="answer">JavaScript/TypeScript를 주로 사용하고, Python도 조금 할 수 있습니다.</div>

                                </div>

                                <div class="qa-item">

                                    <div class="question">Q2. 알고리즘 공부 경험이 있으신가요?</div>

                                    <div class="answer">학부 때 자료구조 수업을 들었고, 최근에 다시 공부를 시작했습니다. 백준 브론즈 티어입니다.</div>

                                </div>

                                <div class="qa-item">

                                    <div class="question">Q3. 이 스터디를 통해 이루고 싶은 목표는 무엇인가요?</div>

                                    <div class="answer">알고리즘적 사고력을 키워서 더 효율적인 코드를 작성하고 싶습니다.</div>

                                </div>

                            </div>

                        </div>



                        <div class="applicant-actions" style="margin-top: 20px;">

                            <button class="btn btn-approve" onclick="approveApplicant(2, '프론트개발러')">

                                ✅ 승인

                            </button>

                            <button class="btn btn-reject" onclick="rejectApplicant(2, '프론트개발러')">

                                ❌ 거절

                            </button>

                        </div>

                    </div>

                </div>



                <!-- 신청자 3 -->

                <div class="applicant-card">

                    <div class="applicant-header">

                        <div class="applicant-avatar">👤</div>

                        <div class="applicant-info">

                            <div class="applicant-name-row">

                                <span class="applicant-name">알고리즘마스터</span>

                                <span class="applicant-badge">신규 신청</span>

                            </div>

                            <div class="applicant-meta">

                                <div class="applicant-meta-item">

                                    <span>📅</span>

                                    <span>신청일: 2024-10-10</span>

                                </div>

                                <div class="applicant-meta-item">

                                    <span>📍</span>

                                    <span>서울 역삼동</span>

                                </div>

                                <div class="applicant-meta-item">

                                    <span>🎂</span>

                                    <span>20대</span>

                                </div>

                            </div>

                        </div>

                        <div class="applicant-actions">

                            <button class="btn btn-profile" onclick="viewApplicantProfile(3)">상세 프로필</button>

                        </div>

                    </div>



                    <div class="applicant-body">

                        <div class="info-section">

                            <div class="info-section-title">✍️ 한줄 자기소개</div>

                            <div class="info-content">

                                매일 1문제씩 풀고 있습니다. 함께 공부하면서 동기부여 받고 싶어요!

                            </div>

                        </div>



                        <div class="info-section">

                            <div class="info-section-title">📊 활동 이력</div>

                            <div class="activity-history">

                                <div class="history-item">

                                    <div>

                                        <div class="history-group">첫 모임입니다</div>

                                        <div class="history-period">-</div>

                                    </div>

                                    <div class="history-stats">

                                        <span style="color: #999;">활동 이력 없음</span>

                                    </div>

                                </div>

                            </div>

                        </div>



                        <div class="info-section">

                            <div class="info-section-title">❓ 가입 질문 답변</div>

                            <div class="question-answer">

                                <div class="qa-item">

                                    <div class="question">Q1. 어떤 프로그래밍 언어를 주로 사용하시나요?</div>

                                    <div class="answer">C++을 주로 사용합니다.</div>

                                </div>

                                <div class="qa-item">

                                    <div class="question">Q2. 알고리즘 공부 경험이 있으신가요?</div>

                                    <div class="answer">백준 골드 5 티어입니다. 꾸준히 공부하고 있습니다.</div>

                                </div>

                                <div class="qa-item">

                                    <div class="question">Q3. 이 스터디를 통해 이루고 싶은 목표는 무엇인가요?</div>

                                    <div class="answer">혼자 공부하다보니 지칠 때가 많아서 함께 공부할 동료를 찾고 있습니다.</div>

                                </div>

                            </div>

                        </div>



                        <div class="applicant-actions" style="margin-top: 20px;">

                            <button class="btn btn-approve" onclick="approveApplicant(3, '알고리즘마스터')">

                                ✅ 승인

                            </button>

                            <button class="btn btn-reject" onclick="rejectApplicant(3, '알고리즘마스터')">

                                ❌ 거절

                            </button>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</body>

</html>