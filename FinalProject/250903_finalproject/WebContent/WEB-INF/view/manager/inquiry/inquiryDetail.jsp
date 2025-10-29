<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 문의 상세</title>
    <style>
        /* ================================================
        	  마이페이지 스타일 기반
           ================================================ */

        :root {
            --max-width: 1200px;
            --spacing-xs: 4px;
            --spacing-sm: 8px;
            --spacing-md: 16px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 48px;

            --radius-sm: 4px;
            --radius-md: 8px;
            --radius-lg: 16px;
            --radius-full: 9999px;

            --color-white: #fff;
            --color-base: #f9f9f9;
            --color-border-light: #e0e0e0;
            --color-primary: #4f46e5;
            --color-primary-dark: #3730a3;
            --color-primary-lighter: #c7d2fe;
            --color-secondary-lighter: #dbeafe;
            --color-accent: #f43f5e;
            --color-text-primary: #111827;
            --color-text-secondary: #6b7280;
            --color-text-tertiary: #9ca3af;

            --shadow-sm: 0 1px 3px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
            --transition-base: 0.3s;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: var(--color-base);
            margin: 0;
            padding: var(--spacing-2xl) 0;
            color: var(--color-text-primary);
        }

        .container {
            max-width: var(--max-width);
            margin: 0 auto;
            padding: 0 var(--spacing-lg);
            display: grid;
            grid-template-columns: 1fr;
            gap: var(--spacing-xl);
        }

        .header {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: var(--spacing-xl);
            text-align: center;
        }

        .section {
            background: var(--color-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: var(--spacing-xl);
        }

        .section-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: var(--spacing-lg);
            color: var(--color-primary-dark);
            border-bottom: 2px solid var(--color-primary-lighter);
            padding-bottom: var(--spacing-sm);
        }

        .inquiry-info,
        .answer-list {
            display: flex;
            flex-direction: column;
            gap: var(--spacing-md);
        }

        .info-item {
            display: flex;
            gap: var(--spacing-md);
            font-size: 15px;
        }

        .info-label {
            font-weight: 600;
            width: 100px;
            color: var(--color-text-secondary);
        }

        .info-value,
        .inquiry-type,
        .answer-count {
            font-weight: 500;
            color: var(--color-text-primary);
        }

        .user-link {
            color: var(--color-primary);
            text-decoration: none;
        }

        .user-link:hover {
            text-decoration: underline;
        }

        .status-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: var(--radius-full);
            font-size: 12px;
            font-weight: 600;
            color: white;
        }

        .status-answered {
            background: var(--color-accent);
        }

        .form-group {
            margin-top: var(--spacing-lg);
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-weight: 600;
            margin-bottom: var(--spacing-sm);
        }

        .inquiry-content {
            background: var(--color-base);
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            font-size: 15px;
            line-height: 1.6;
            white-space: pre-wrap;
        }

        /* 답변 리스트 */
        .answer-item {
            background: var(--color-base);
            border-radius: var(--radius-md);
            padding: var(--spacing-md);
            margin-bottom: var(--spacing-md);
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: var(--spacing-sm);
            font-size: 14px;
            font-weight: 600;
            color: var(--color-text-secondary);
        }

        .answer-content {
            font-size: 15px;
            line-height: 1.6;
            color: var(--color-text-primary);
            white-space: pre-wrap;
        }

        /* 답변 작성 */
        .answer-form textarea {
            width: 100%;
            min-height: 120px;
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            border: 1px solid var(--color-border-light);
            resize: vertical;
            font-size: 15px;
            font-family: inherit;
        }

        .button-group {
            margin-top: var(--spacing-md);
            display: flex;
            gap: var(--spacing-md);
        }

        .button {
            padding: 10px 24px;
            border: none;
            border-radius: var(--radius-md);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
            text-decoration: none;
        }

        .btn-submit {
            background: var(--color-primary);
            color: white;
        }

        .btn-submit:hover {
            background: var(--color-primary-dark);
            transform: translateY(-2px);
        }

        .btn-back {
            background: var(--color-border-light);
            color: var(--color-text-primary);
        }

        .btn-back:hover {
            background: var(--color-text-secondary);
            color: white;
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 var(--spacing-md);
            }

            .section-title {
                font-size: 20px;
            }
        }

    </style>
</head>
<body>
    <div class="header">관리자 문의 상세 정보</div>
    <div class="container">
        <!-- 회원 문의 이력 -->
        <div class="section">
            <div class="section-title">회원 문의 이력</div>
            <div class="inquiry-info">
                <div class="info-item">
                    <span class="info-label">문의번호:</span>
                    <span class="info-value">INQ007</span>
                </div>
                <div class="info-item">
                    <span class="info-label">문의 유형:</span>
                    <span class="inquiry-type">결제/환불</span>
                </div>
                <div class="info-item">
                    <span class="info-label">접수자:</span>
                    <a href="memberDetail.jsp?id=user004" class="user-link">user004 (김영희)</a>
                </div>
                <div class="info-item">
                    <span class="info-label">접수 일자:</span>
                    <span class="info-value">2024-10-02 14:30:25</span>
                </div>
                <div class="info-item">
                    <span class="info-label">답변 상태:</span>
                    <span class="status-badge status-answered">답변완료</span>
                </div>
                <div class="info-item">
                    <span class="info-label">답변 수:</span>
                    <span class="answer-count">2건</span>
                </div>
            </div>

            <div class="form-group">
                <div class="form-label">문의 제목</div>
                <div class="inquiry-content">유료 모임 환불 문의드립니다</div>
            </div>

            <div class="form-group">
                <div class="form-label">문의 내용</div>
                <div class="inquiry-content">
안녕하세요.

지난주에 가입한 모임의 취지가 저와 맞지 않아 탈퇴하려고 합니다.
모임에 가입한지 3일밖에 안 됐는데 가능한가요?

모임명: 프리미엄 독서 모임

빠른 답변 부탁드립니다.
감사합니다.
                </div>
            </div>
        </div>

        <!-- 관리자 답변 이력 -->
        <div class="section">
            <div class="section-title">관리자 답변 이력</div>
            <div class="answer-list">
                <div class="answer-item">
                    <div class="answer-header">
                        <span class="answer-author">관리자 (admin_service01)</span>
                        <span class="answer-date">2024-10-02 16:15:40</span>
                    </div>
                    <div class="answer-content">
안녕하세요. 문의 주셔서 감사합니다.

회원탈퇴를 원하시는걸까요? 모임탈퇴를 원하시는걸까요?
질의에 대한 답변 부탁드립니다.

감사합니다.
                    </div>
                </div>

                <div class="answer-item">
                    <div class="answer-header">
                        <span class="answer-author">관리자 (admin_service01)</span>
                        <span class="answer-date">2024-10-03 10:20:15</span>
                    </div>
                    <div class="answer-content">
추가 안내드립니다.

요청하신 부분 반영되었습니다.

서비스 이용에 불편을 드려 죄송합니다.
더 나은 서비스로 보답하겠습니다.

감사합니다.
                    </div>
                </div>
            </div>
        </div>

        <!-- 답변 작성 -->
        <div class="section">
            <div class="section-title">답변 작성</div>
            <div class="answer-form">
                <div class="form-group">
                    <label class="form-label">답변 내용</label>
                    <textarea id="answerContent" placeholder="답변 내용을 입력하세요.&#10;&#10;※ 회원에게는 관리자 닉네임, 작성 일자, 답변 내용이 전달됩니다."></textarea>
                </div>

                <div class="button-group">
                    <button class="button btn-submit" onclick="submitAnswer()">답변 등록</button>
                    <button class="button btn-back" onclick="history.back()">목록으로</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function submitAnswer() {
            var content = document.getElementById('answerContent').value.trim();
            if(content === '') {
                alert('답변 내용을 입력해주세요.');
                return;
            }
            if(confirm('답변을 등록하시겠습니까?\n\n답변은 회원에게 즉시 전달됩니다.')) {
                console.log('답변 내용:', content);
                alert('답변이 등록되었습니다.');
                location.reload();
            }
        }
    </script>
</body>
</html>
