<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 회원 상세</title>
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
            max-width: 1400px;
            margin: 0 auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        /* 회원 기본 정보 */
        .member-info {
            background-color: #F5F5F5;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .member-info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }

        .info-item {
            display: flex;
            align-items: center;
        }

        .info-label {
            font-weight: bold;
            margin-right: 10px;
            min-width: 120px;
        }

        .profile-section {
            grid-column: 1 / -1;
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 10px;
            background-color: #fff;
            border-radius: 8px;
        }

        .profile-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #E6D6FF;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
        }

        /* 탭 메뉴 */
        .tab-menu {
            display: flex;
            gap: 5px;
            margin-bottom: 20px;
            border-bottom: 2px solid #E6D6FF;
        }

        .tab-button {
            padding: 12px 24px;
            background-color: transparent;
            border: none;
            border-bottom: 3px solid transparent;
            cursor: pointer;
            font-size: 15px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .tab-button:hover {
            background-color: #F0E8FF;
        }

        .tab-button.active {
            border-bottom-color: #BFFCC6;
            background-color: #F0E8FF;
        }

        /* 탭 컨텐츠 */
        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* 테이블 공통 스타일 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #BFFCC6;
            font-weight: bold;
        }

        tbody tr:nth-child(odd) {
            background-color: #E6D6FF;
        }

        tbody tr:nth-child(even) {
            background-color: #F0E8FF;
        }

        tbody tr:hover {
            background-color: #D5C5EE;
            cursor: pointer;
        }

        /* 버튼 */
        .action-buttons {
            margin-top: 20px;
            display: flex;
            gap: 10px;
            justify-content: center;
        }

        .button {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
        }

        .btn-suspend {
            background-color: #FFB3BA;
        }

        .btn-withdraw {
            background-color: #FFDFBA;
        }

        .btn-back {
            background-color: #BFFCC6;
        }

        .button:hover {
            opacity: 0.8;
        }

        /* 상태 표시 */
        .status-badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-pending {
            background-color: #FFF4E6;
            color: #E65100;
        }

        .status-completed {
            background-color: #E8F5E9;
            color: #2E7D32;
        }

        .status-rejected {
            background-color: #FFEBEE;
            color: #C62828;
        }

        /* 링크 스타일 */
        .link-text {
            color: #1976D2;
            text-decoration: none;
        }

        .link-text:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">회원 상세 정보</div>
    <div class="container">
        <!-- 회원 기본 정보 -->
        <div class="member-info">
            <div class="member-info-grid">
                <div class="profile-section">
                    <div class="profile-img">👤</div>
                    <div>
                        <h3 style="margin: 0;">홍길동 (user001)</h3>
                        <p style="margin: 5px 0; color: #666;">홍길동123</p>
                    </div>
                </div>
                
                <div class="info-item">
                    <span class="info-label">이메일:</span>
                    <span>hong@example.com</span>
                </div>
                <div class="info-item">
                    <span class="info-label">주민등록번호:</span>
                    <span>900101-*******</span>
                </div>
                <div class="info-item">
                    <span class="info-label">주소:</span>
                    <span>서울시 강남구 테헤란로 123</span>
                </div>
                <div class="info-item">
                    <span class="info-label">성별:</span>
                    <span>남</span>
                </div>
                <div class="info-item">
                    <span class="info-label">연령대:</span>
                    <span>30대</span>
                </div>
                <div class="info-item">
                    <span class="info-label">활동 정지 여부:</span>
                    <span style="color: #2E7D32; font-weight: bold;">정상</span>
                </div>
                <div class="info-item">
                    <span class="info-label">가입일:</span>
                    <span>2024-01-15</span>
                </div>
            </div>
        </div>

        <!-- 탭 메뉴 -->
        <div class="tab-menu">
            <button class="tab-button active" onclick="showTab('meeting')">가입 모임 내역</button>
            <button class="tab-button" onclick="showTab('report')">신고 내역</button>
            <button class="tab-button" onclick="showTab('inquiry')">문의 내역</button>
            <button class="tab-button" onclick="showTab('login')">로그인 이력</button>
        </div>

        <!-- 탭 1: 가입 모임 내역 -->
        <div id="meeting-tab" class="tab-content active">
            <h3>가입 모임 내역 (총 3개)</h3>
            <table>
                <thead>
                    <tr>
                        <th>모임 이름</th>
                        <th>활동기간</th>
                        <th>역할</th>
                        <th>탈퇴사유</th>
                        <th>상세보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Java 스터디</td>
                        <td>2024-01-20 ~ 현재</td>
                        <td>모임장</td>
                        <td>-</td>
                        <td><a href="memberMeetingPosts.jsp?userId=user001&meetingId=M001" class="link-text">작성글 보기</a></td>
                    </tr>
                    <tr>
                        <td>웹 개발 모임</td>
                        <td>2024-02-01 ~ 2024-08-15</td>
                        <td>모임원</td>
                        <td>개인 사정</td>
                        <td><a href="memberMeetingPosts.jsp?userId=user001&meetingId=M002" class="link-text">작성글 보기</a></td>
                    </tr>
                    <tr>
                        <td>알고리즘 연구회</td>
                        <td>2024-03-10 ~ 현재</td>
                        <td>모임원</td>
                        <td>-</td>
                        <td><a href="memberMeetingPosts.jsp?userId=user001&meetingId=M003" class="link-text">작성글 보기</a></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 탭 2: 신고 내역 -->
        <div id="report-tab" class="tab-content">
            <h3>신고 받은 내역 (총 1건)</h3>
            <table>
                <thead>
                    <tr>
                        <th>신고 구분</th>
                        <th>신고 일자</th>
                        <th>신고 내용</th>
                        <th>신고 처리 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>욕설/비방</td>
                        <td>2024-07-15</td>
                        <td>부적절한 댓글 작성</td>
                        <td><span class="status-badge status-completed">처리완료</span></td>
                    </tr>
                </tbody>
            </table>

            <h3 style="margin-top: 30px;">신고 한 내역 (총 2건)</h3>
            <table>
                <thead>
                    <tr>
                        <th>신고 구분</th>
                        <th>신고 일자</th>
                        <th>신고 내용</th>
                        <th>피신고 대상</th>
                        <th>신고 처리 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>스팸/광고</td>
                        <td>2024-06-10</td>
                        <td>무분별한 광고 게시글</td>
                        <td>user123</td>
                        <td><span class="status-badge status-completed">처리완료</span></td>
                    </tr>
                    <tr>
                        <td>허위정보</td>
                        <td>2024-08-20</td>
                        <td>거짓 정보 유포</td>
                        <td>user456</td>
                        <td><span class="status-badge status-pending">처리중</span></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 탭 3: 문의 내역 -->
        <div id="inquiry-tab" class="tab-content">
            <h3>문의 내역 (총 3건)</h3>
            <table>
                <thead>
                    <tr>
                        <th>문의 번호</th>
                        <th>문의 유형</th>
                        <th>제목</th>
                        <th>문의 일자</th>
                        <th>답변 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Q001</td>
                        <td>서비스 이용</td>
                        <td>모임 개설 방법 문의</td>
                        <td>2024-02-05</td>
                        <td><span class="status-badge status-completed">답변완료</span></td>
                    </tr>
                    <tr>
                        <td>Q002</td>
                        <td>결제/환불</td>
                        <td>유료 모임 환불 문의</td>
                        <td>2024-05-12</td>
                        <td><span class="status-badge status-completed">답변완료</span></td>
                    </tr>
                    <tr>
                        <td>Q003</td>
                        <td>기술 지원</td>
                        <td>로그인 오류 문의</td>
                        <td>2024-09-01</td>
                        <td><span class="status-badge status-pending">처리중</span></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 탭 4: 로그인 이력 -->
        <div id="login-tab" class="tab-content">
            <h3>로그인 이력 (최근 10건)</h3>
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>로그인 일시</th>
                        <th>IP 주소</th>
                        <th>접속 기기</th>
                        <th>브라우저</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>2024-10-03 14:25:30</td>
                        <td>192.168.1.100</td>
                        <td>Windows PC</td>
                        <td>Chrome</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>2024-10-02 09:15:20</td>
                        <td>192.168.1.100</td>
                        <td>Android</td>
                        <td>Chrome Mobile</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>2024-10-01 18:40:15</td>
                        <td>192.168.1.100</td>
                        <td>Windows PC</td>
                        <td>Chrome</td>
                    </tr>
                    <tr>
                        <td>4</td>
                        <td>2024-09-30 22:30:45</td>
                        <td>192.168.1.100</td>
                        <td>iPhone</td>
                        <td>Safari</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>2024-09-29 16:20:10</td>
                        <td>192.168.1.100</td>
                        <td>Windows PC</td>
                        <td>Chrome</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 액션 버튼 -->
        <div class="action-buttons">
            <button class="button btn-suspend" onclick="suspendMember()">활동 정지</button>
            <button class="button btn-withdraw" onclick="withdrawMember()">모임 탈퇴</button>
            <button class="button btn-back" onclick="history.back()">목록으로</button>
        </div>
    </div>

    <script>
        function showTab(tabName) {
            // 모든 탭 버튼의 active 클래스 제거
            var buttons = document.querySelectorAll('.tab-button');
            buttons.forEach(function(btn) {
                btn.classList.remove('active');
            });

            // 모든 탭 컨텐츠 숨김
            var contents = document.querySelectorAll('.tab-content');
            contents.forEach(function(content) {
                content.classList.remove('active');
            });

            // 선택된 탭 활성화
            event.target.classList.add('active');
            document.getElementById(tabName + '-tab').classList.add('active');
        }

        function suspendMember() {
            if(confirm('이 회원을 활동 정지 처리하시겠습니까?')) {
                alert('활동 정지 처리되었습니다.');
                // 실제로는 서버에 요청을 보내야 합니다
            }
        }

        function withdrawMember() {
            if(confirm('이 회원을 모든 모임에서 탈퇴 처리하시겠습니까?')) {
                alert('모임 탈퇴 처리되었습니다.');
                // 실제로는 서버에 요청을 보내야 합니다
            }
        }
    </script>
</body>
</html>