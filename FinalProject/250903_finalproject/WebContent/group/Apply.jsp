<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 가입 신청 화면 생성 -->
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 가입 신청</title>
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
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 페이지 헤더 */
        .page-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .page-title {
            font-size: 32px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 10px;
        }
        .page-subtitle {
            font-size: 16px;
            color: #666;
        }

        /* 모임 정보 카드 */
        .group-info-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }
        .group-header {
            display: flex;
            align-items: center;
            gap: 20px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            margin-bottom: 20px;
        }
        .group-image {
            width: 100px;
            height: 100px;
            border-radius: 12px;
            background: #e0e0e0;
            flex-shrink: 0;
        }
        .group-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }
        .group-meta {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            font-size: 14px;
            color: #666;
        }
        .group-meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* 안내 박스 */
        .info-box {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .info-box-title {
            font-weight: 600;
            color: #1565c0;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .info-box-content {
            color: #1565c0;
            line-height: 1.6;
            font-size: 14px;
        }
        .info-box-content ul {
            margin-top: 10px;
            padding-left: 20px;
        }
        .info-box-content li {
            margin-bottom: 5px;
        }

        /* 신청서 컨테이너 */
        .application-form {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        .section {
            margin-bottom: 35px;
            padding-bottom: 35px;
            border-bottom: 2px solid #f0f0f0;
        }
        .section:last-of-type {
            border-bottom: none;
        }
        .section-title {
            font-size: 20px;
            color: #2d5a29;
            font-weight: bold;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* 폼 요소 */
        .form-group {
            margin-bottom: 25px;
        }
        .form-label {
            display: block;
            font-size: 15px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        .required {
            color: #f44336;
            margin-left: 4px;
        }
        .form-input {
            width: 100%;
            padding: 14px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
            font-family: inherit;
        }
        .form-input:focus {
            outline: none;
            border-color: #8bc683;
            box-shadow: 0 0 0 3px rgba(139, 198, 131, 0.1);
        }
        .form-textarea {
            min-height: 120px;
            resize: vertical;
        }
        .form-help {
            font-size: 13px;
            color: #999;
            margin-top: 8px;
        }
        .char-count {
            text-align: right;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }

        /* 질문 답변 */
        .question-item {
            background: #f8faf8;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #8bc683;
            margin-bottom: 20px;
        }
        .question-text {
            font-weight: 600;
            color: #2d5a29;
            margin-bottom: 12px;
            line-height: 1.5;
        }

        /* 가입 가능 횟수 */
        .limit-notice {
            background: #fff3e0;
            border-left: 4px solid #ff9800;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        .limit-notice-title {
            font-weight: 600;
            color: #f57c00;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .limit-notice-content {
            color: #f57c00;
            font-size: 14px;
            line-height: 1.6;
        }
        .limit-bar {
            background: #ffe0b2;
            height: 10px;
            border-radius: 5px;
            overflow: hidden;
            margin-top: 10px;
        }
        .limit-fill {
            height: 100%;
            background: #ff9800;
            transition: width 0.3s;
        }
        .limit-text {
            font-size: 12px;
            color: #f57c00;
            margin-top: 5px;
        }

        /* 버튼 */
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 40px;
        }
        .btn {
            flex: 1;
            padding: 16px 32px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
        }
        .btn-primary {
            background: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }
        .btn-secondary {
            background: #e0e0e0;
            color: #666;
        }
        .btn-secondary:hover {
            background: #d0d0d0;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px 15px;
            }
            .application-form {
                padding: 25px 20px;
            }
            .group-header {
                flex-direction: column;
                text-align: center;
            }
            .button-group {
                flex-direction: column;
            }
        }
    </style>
    <script>
        function updateCharCount(textareaId, countId, maxLength) {
            const textarea = document.getElementById(textareaId);
            const count = document.getElementById(countId);
            const currentLength = textarea.value.length;
            count.textContent = `${currentLength} / ${maxLength}자`;
            
            if (currentLength > maxLength) {
                count.style.color = '#f44336';
            } else {
                count.style.color = '#999';
            }
        }

        function submitApplication() {
            const intro = document.getElementById('selfIntro').value.trim();
            const isIntroRequired = <%= true %>; // 실제로는 서버에서 받아온 값
            
            if (isIntroRequired && !intro) {
                alert('한줄 자기소개는 필수 항목입니다.');
                document.getElementById('selfIntro').focus();
                return false;
            }

            // 가입 질문 답변 확인
            const questions = document.querySelectorAll('.question-answer');
            for (let q of questions) {
                if (!q.value.trim()) {
                    alert('모든 질문에 답변해주세요.');
                    q.focus();
                    return false;
                }
            }

            if (confirm('이 모임에 가입 신청하시겠습니까?')) {
                // 실제로는 서버로 데이터 전송
                alert('가입 신청이 완료되었습니다!\n모임장의 승인을 기다려주세요.');
                window.location.href = 'group_detail.jsp?id=1';
                return true;
            }
            return false;
        }

        function cancelApplication() {
            if (confirm('가입 신청을 취소하시겠습니까?')) {
                window.history.back();
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
            <a href="?page=groups" class="tab active">모임구경</a>
            <a href="?page=creategroup" class="tab">모임 개설</a>
            <a href="?page=mygroups" class="tab">내 모임</a>
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
            <h1 class="page-title">📝 모임 가입 신청</h1>
            <p class="page-subtitle">아래 정보를 작성하여 모임에 가입 신청하세요</p>
        </div>

        <!-- 모임 정보 -->
        <div class="group-info-card">
            <div class="group-header">
                <img src="https://via.placeholder.com/100" alt="모임 이미지" class="group-image">
                <div>
                    <h2 class="group-title">알고리즘 정복 스터디</h2>
                    <div class="group-meta">
                        <div class="group-meta-item">
                            <span>👥</span>
                            <span>7/10명</span>
                        </div>
                        <div class="group-meta-item">
                            <span>📍</span>
                            <span>강남동</span>
                        </div>
                        <div class="group-meta-item">
                            <span>⏰</span>
                            <span>월/수/금 19:00~21:00</span>
                        </div>
                        <div class="group-meta-item">
                            <span>🎯</span>
                            <span>난이도: 중</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 안내 박스 -->
        <div class="info-box">
            <div class="info-box-title">
                <span>ℹ️</span>
                <span>가입 신청 안내</span>
            </div>
            <div class="info-box-content">
                <ul>
                    <li>가입 신청 후 모임장의 승인을 기다려주세요.</li>
                    <li>승인이 완료되면 알림으로 안내해드립니다.</li>
                    <li>신청서 작성 내용은 모임장에게만 공개됩니다.</li>
                    <li>신청을 취소하려면 마이페이지에서 취소할 수 있습니다.</li>
                </ul>
            </div>
        </div>

        <!-- 가입 가능 횟수 -->
        <div class="limit-notice">
            <div class="limit-notice-title">
                <span>⚠️</span>
                <span>가입 가능 횟수</span>
            </div>
            <div class="limit-notice-content">
                현재 2개 모임에 참여 중입니다. 최대 3개까지 가입할 수 있습니다.
                <div class="limit-bar">
                    <div class="limit-fill" style="width: 66.6%;"></div>
                </div>
                <div class="limit-text">남은 가입 가능 횟수: 1개</div>
            </div>
        </div>

        <!-- 신청서 작성 -->
        <form class="application-form" onsubmit="return submitApplication()">
            <!-- 한줄 자기소개 -->
            <div class="section">
                <h3 class="section-title">
                    <span>✍️</span>
                    <span>한줄 자기소개</span>
                </h3>
                <div class="form-group">
                    <label class="form-label">
                        자기소개
                        <span class="required">*</span>
                    </label>
                    <textarea 
                        id="selfIntro" 
                        class="form-input form-textarea"
                        placeholder="간단한 자기소개를 작성해주세요 (50자 이내)"
                        maxlength="50"
                        oninput="updateCharCount('selfIntro', 'introCount', 50)"
                    ></textarea>
                    <div class="char-count" id="introCount">0 / 50자</div>
                    <p class="form-help">모임원들에게 보여지는 한줄 소개입니다.</p>
                </div>
            </div>

            <!-- 가입 질문 -->
            <div class="section">
                <h3 class="section-title">
                    <span>❓</span>
                    <span>가입 질문</span>
                </h3>
                <p class="form-help" style="margin-bottom: 20px;">
                    모임장이 설정한 질문에 답변해주세요. 답변은 모임장에게만 공개됩니다.
                </p>

                <div class="question-item">
                    <div class="question-text">Q1. 어떤 프로그래밍 언어를 주로 사용하시나요?</div>
                    <textarea 
                        class="form-input form-textarea question-answer"
                        placeholder="답변을 입력해주세요"
                        style="min-height: 80px;"
                    ></textarea>
                </div>

                <div class="question-item">
                    <div class="question-text">Q2. 알고리즘 공부 경험이 있으신가요?</div>
                    <textarea 
                        class="form-input form-textarea question-answer"
                        placeholder="답변을 입력해주세요"
                        style="min-height: 80px;"
                    ></textarea>
                </div>

                <div class="question-item">
                    <div class="question-text">Q3. 이 스터디를 통해 이루고 싶은 목표는 무엇인가요?</div>
                    <textarea 
                        class="form-input form-textarea question-answer"
                        placeholder="답변을 입력해주세요"
                        style="min-height: 80px;"
                    ></textarea>
                </div>
            </div>

            <!-- 모임 규칙 확인 -->
            <div class="section">
                <h3 class="section-title">
                    <span>📜</span>
                    <span>모임 규칙</span>
                </h3>
                <div style="background: #f8faf8; padding: 20px; border-radius: 8px; line-height: 1.8; color: #666;">
                    <p><strong style="color: #333;">다음 규칙을 확인하고 동의해주세요:</strong></p>
                    <br>
                    1. 매주 최소 3문제 이상 풀이하고 공유하기<br>
                    2. 무단 결석 금지 (사전 공지 필수)<br>
                    3. 다른 사람의 풀이를 존중하고 건설적인 피드백 제공하기<br>
                    4. 질문은 언제든 환영! 모르는 것은 부끄러운 게 아닙니다<br>
                    5. 상호 존중과 배려하는 분위기 만들기<br>
                    <br>
                    <label style="display: flex; align-items: center; gap: 10px; cursor: pointer;">
                        <input type="checkbox" id="agreeRules" required style="width: 18px; height: 18px;">
                        <span style="color: #333; font-weight: 600;">위 규칙을 확인했으며 이를 준수하겠습니다.</span>
                    </label>
                </div>
            </div>

            <!-- 버튼 -->
            <div class="button-group">
                <button type="submit" class="btn btn-primary">
                    ✅ 가입 신청하기
                </button>
                <button type="button" class="btn btn-secondary" onclick="cancelApplication()">
                    취소
                </button>
            </div>
        </form>
    </div>
</body>
</html>