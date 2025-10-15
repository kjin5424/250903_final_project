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
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #E9D9FF;
            padding: 40px 30px;
        }

        .header {
            background-color: #BFFCC6;
            padding: 20px;
            border-radius: 15px;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .container {
            background-color: #fff;
            padding: 25px;
            border-radius: 20px;
            max-width: 1200px;
            margin: 0 auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        /* 섹션 공통 스타일 */
        .section {
            margin-bottom: 30px;
            padding: 20px;
            border-radius: 10px;
            background-color: #F5F5F5;
        }

        .section-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #BFFCC6;
            color: #333;
        }

        /* 문의 정보 */
        .inquiry-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-bottom: 15px;
        }

        .info-item {
            display: flex;
            align-items: center;
        }

        .info-label {
            font-weight: bold;
            min-width: 100px;
            color: #666;
        }

        .info-value {
            color: #333;
        }

        /* 회원 링크 */
        .user-link {
            color: #1976D2;
            text-decoration: none;
            font-weight: 500;
        }

        .user-link:hover {
            text-decoration: underline;
        }

        /* 문의 내용 박스 */
        .inquiry-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #E0E0E0;
            line-height: 1.6;
            min-height: 150px;
        }

        /* 답변 이력 */
        .answer-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .answer-item {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #BFFCC6;
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            padding-bottom: 8px;
            border-bottom: 1px solid #E0E0E0;
        }

        .answer-author {
            font-weight: bold;
            color: #333;
        }

        .answer-date {
            font-size: 13px;
            color: #666;
        }

        .answer-content {
            color: #333;
            line-height: 1.6;
        }

        .no-answer {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        /* 답변 작성 폼 */
        .answer-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 2px solid #BFFCC6;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #333;
        }

        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            font-family: Arial, sans-serif;
            resize: vertical;
            min-height: 120px;
            box-sizing: border-box;
        }

        textarea:focus {
            outline: none;
            border-color: #BFFCC6;
        }

        /* 버튼 */
        .button-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }

        .button {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
        }

        .btn-submit {
            background-color: #BFFCC6;
            color: #333;
        }

        .btn-submit:hover {
            background-color: #A8EBB0;
        }

        .btn-back {
            background-color: #E6D6FF;
            color: #333;
        }

        .btn-back:hover {
            background-color: #D5C5EE;
        }

        /* 상태 뱃지 */
        .status-badge {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-waiting {
            background-color: #FFF4E6;
            color: #E65100;
        }

        .status-answered {
            background-color: #E8F5E9;
            color: #2E7D32;
        }

        /* 문의 유형 */
        .inquiry-type {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            background-color: #E1F5FE;
            color: #01579B;
            display: inline-block;
        }

        /* 답변 수 표시 */
        .answer-count {
            color: #1976D2;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="header">문의 상세 정보</div>
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
                <div class="inquiry-content" style="min-height: auto; padding: 12px;">
                    유료 모임 환불 문의드립니다
                </div>
            </div>

            <div class="form-group">
                <div class="form-label">문의 내용</div>
                <div class="inquiry-content">
                    안녕하세요.<br><br>
                    지난주에 가입한 모임의 취지가 저와 맞지 않아 탈퇴하려고 합니다.<br>
                    모임에 가입한지 3일밖에 안 됐는데 가능한가요?<br><br>
                    모임명: 프리미엄 독서 모임<br><br>
                    빠른 답변 부탁드립니다.<br>
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
                        안녕하세요. 문의 주셔서 감사합니다.<br><br>
                        회원탈퇴를 원하시는걸까요? 모임탈퇴를 원하시는걸까요? <br>
                        질의에 대한 답변 부탁드립니다.<br><br>
                        감사합니다.
                    </div>
                </div>

                <div class="answer-item">
                    <div class="answer-header">
                        <span class="answer-author">관리자 (admin_service01)</span>
                        <span class="answer-date">2024-10-03 10:20:15</span>
                    </div>
                    <div class="answer-content">
                        추가 안내드립니다.<br><br>
                        요청하신 부분 반영되었습니다.<br><br>
                        서비스 이용에 불편을 드려 죄송합니다.<br>
                        더 나은 서비스로 보답하겠습니다.<br><br>
                        감사합니다.
                    </div>
                </div>
            </div>

            <!-- 답변이 없을 때 표시 -->
            <!-- <div class="no-answer">
                아직 답변이 등록되지 않았습니다.
            </div> -->
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
                // 실제로는 서버에 답변 등록 요청을 보내야 합니다
                console.log('답변 내용:', content);
                
                alert('답변이 등록되었습니다.');
                
                // 페이지 새로고침 (실제로는 서버 응답 후 처리)
                location.reload();
            }
        }
    </script>
</body>
</html>