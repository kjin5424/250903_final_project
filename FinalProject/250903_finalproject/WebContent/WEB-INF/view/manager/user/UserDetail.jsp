<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!-- 유저의 탈퇴 사유를 관리자가 변경할 수 있어야 함 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 회원 상세</title>
    <style>
/* ================================================
   관리자 페이지 공통 스타일 적용형 (회원 상세용)
   ================================================ */

:root {
    --color-primary: #BFFCC6;
    --color-primary-dark: #2E7D32;
    --color-primary-lighter: #E9FBEF;
    --color-secondary: #E6D6FF;
    --color-secondary-dark: #6B4FB6;
    --color-secondary-lighter: #F4EFFF;
    --color-accent: #FFB3BA;
    --color-accent-dark: #E65100;
    --color-text-primary: #333;
    --color-text-secondary: #666;
    --color-border: #ddd;
    --color-border-light: #eee;
    --color-white: #fff;
    --radius-md: 8px;
    --radius-lg: 16px;
    --radius-full: 999px;
    --spacing-xs: 4px;
    --spacing-sm: 8px;
    --spacing-md: 12px;
    --spacing-lg: 20px;
    --spacing-xl: 32px;
    --transition-base: 0.2s ease;
    --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 8px rgba(0, 0, 0, 0.08);
}

/* 기본 세팅 */
body {
    margin: 0;
    font-family: "Segoe UI", Arial, sans-serif;
    background-color: var(--color-secondary-lighter);
    padding: var(--spacing-xl) var(--spacing-lg);
    color: var(--color-text-primary);
}

/* 페이지 헤더 */
.header {
    padding: var(--spacing-lg);
    border-radius: var(--radius-lg);
    font-size: 28px;
    font-weight: 800;
    text-align: center;
    color: var(--color-text-primary);
    box-shadow: var(--shadow-md);
    margin-bottom: var(--spacing-xl);
}

/* 컨테이너 */
.container {
    background: var(--color-white);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-sm);
    padding: var(--spacing-xl);
    max-width: 1400px;
    margin: 0 auto;
}

/* ===============================
   회원 기본 정보 영역
   =============================== */
.member-info {
    background: var(--color-primary-lighter);
    padding: var(--spacing-lg);
    border-radius: var(--radius-lg);
    margin-bottom: var(--spacing-xl);
    box-shadow: var(--shadow-sm);
}

.member-info-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: var(--spacing-md);
}

.profile-section {
    grid-column: 1 / -1;
    display: flex;
    align-items: center;
    gap: var(--spacing-lg);
    background: var(--color-white);
    padding: var(--spacing-md);
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-sm);
}

.profile-img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: var(--color-secondary);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32px;
}

.info-item {
    display: flex;
    align-items: center;
    font-size: 15px;
}

.info-label {
    font-weight: 700;
    color: var(--color-text-secondary);
    margin-right: var(--spacing-sm);
    min-width: 100px;
}

/* ===============================
   탭 메뉴
   =============================== */
.tab-menu {
    display: flex;
    gap: var(--spacing-sm);
    border-bottom: 2px solid var(--color-secondary);
    margin-bottom: var(--spacing-md);
}

.tab-button {
    padding: 12px 20px;
    font-weight: 700;
    background: transparent;
    border: none;
    border-bottom: 3px solid transparent;
    cursor: pointer;
    transition: all var(--transition-base);
}

.tab-button:hover {
    background: var(--color-secondary-lighter);
}

.tab-button.active {
    border-bottom-color: var(--color-primary);
    background: var(--color-secondary-lighter);
    color: var(--color-primary-dark);
}

/* 탭 내용 */
.tab-content {
    display: none;
    animation: fadeIn 0.2s ease;
}

.tab-content.active {
    display: block;
}

/* ===============================
   테이블 공통
   =============================== */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: var(--spacing-md);
    font-size: 14px;
}

th, td {
    padding: var(--spacing-md);
    text-align: center;
    border-bottom: 1px solid var(--color-border-light);
}

th {
    background: var(--color-primary-lighter);
    font-weight: 700;
    color: var(--color-primary-dark);
}

tbody tr:hover {
    background: var(--color-secondary-lighter);
    cursor: pointer;
}

/* ===============================
   상태 배지
   =============================== */
.status-badge {
    display: inline-block;
    padding: 6px 12px;
    border-radius: var(--radius-full);
    font-size: 12px;
    font-weight: 700;
}

.status-pending {
    background: #fff3e0;
    color: #f57c00;
}

.status-completed {
    background: var(--color-primary-lighter);
    color: var(--color-primary-dark);
}

.status-rejected {
    background: #ffebee;
    color: #c62828;
}

/* ===============================
   버튼 영역
   =============================== */
.action-buttons {
    display: flex;
    justify-content: center;
    gap: var(--spacing-md);
    margin-top: var(--spacing-lg);
}

.button {
    padding: 10px 24px;
    border: none;
    border-radius: var(--radius-md);
    font-weight: 700;
    cursor: pointer;
    transition: all var(--transition-base);
    font-size: 14px;
}

.btn-suspend {
    background: var(--color-accent);
    color: white;
}

.btn-withdraw {
    background: #FFDFBA;
    color: #444;
}

.btn-back {
    background: var(--color-primary);
    color: #222;
}

.button:hover {
    transform: translateY(-1px);
    box-shadow: var(--shadow-sm);
    opacity: 0.9;
}

/* 링크 스타일 */
.link-text {
    color: var(--color-secondary-dark);
    text-decoration: none;
}

.link-text:hover {
    text-decoration: underline;
}

/* 애니메이션 */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

/* 반응형 */
@media (max-width: 1024px) {
    .member-info-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .member-info-grid {
        grid-template-columns: 1fr;
    }

    .tab-menu {
        flex-wrap: wrap;
    }

    .action-buttons {
        flex-direction: column;
    }

    .button {
        width: 100%;
    }
}
    </style>
</head>
<body>
    <div class="header">관리자 회원 상세 정보</div>
    <div class="container">
        <!-- 회원 기본 정보 -->
        <div class="member-info">
            <div class="member-info-grid">
                <div class="profile-section">
                    <div class="profile-img">👤</div>
                    <div>
                        <h3 style="margin: 0;">${userInfo.userName } (${userInfo.userId })</h3>
                        <p style="margin: 5px 0; color: #666;">${userInfo.nickname }</p>
                    </div>
                </div>
                
                <div class="info-item">
                    <span class="info-label">이메일:</span>
                    <span>${userInfo.email }</span>
                </div>
                <div class="info-item">
                    <span class="info-label">주민등록번호:</span>
                    <span>${userInfo.ssn1 }-*******</span>
                </div>
                <div class="info-item">
                    <span class="info-label">주소:</span>
                    <span>${userInfo.address }</span>
                </div>
                <div class="info-item">
                    <span class="info-label">성별:</span>
                    <span>${userInfo.gender }</span>
                </div>
                <div class="info-item">
                    <span class="info-label">연령대:</span>
                    <span>${userInfo.age }</span>
                </div>
                <!-- 
                <div class="info-item">
                    <span class="info-label">활동 정지 여부:</span>
                    <span style="color: #2E7D32; font-weight: bold;">정상</span>
                </div>
                 -->
                <div class="info-item">
                    <span class="info-label">가입일:</span>
                    <span>${userInfo.createdDate }</span>
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
            <h3>가입 모임 내역 (총 ${fn:length(groupList) }개)</h3>
            <table>
                <thead>
                    <tr>
                        <th>모임 이름</th>
                        <th>활동기간</th>
                        <th>역할</th>
                        <th>탈퇴사유</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="groupJoinDTO" items="${groupList }">
                    	<tr>
                    		<td>${groupJoinDTO.groupTitle }</td>
                    		<td>
                    			${groupJoinDTO.joinDate } ~
                    			<c:if test="${not empty groupJoinDTO.quitDate }">
                    				${groupJoinDTO.quitDate }
                    			</c:if> 
                    			<c:if test="${empty groupJoinDTO.quitDate }">
                    				현재
                    			</c:if>
                    		</td>
                    		<td>	${groupJoinDTO.position }</td>
                    		<td>
                    			<c:if test="${not empty groupJoinDTO.quitReason }">
	                    			${groupJoinDTO.quitReason }
                    			</c:if>
                    			<c:if test="${empty groupJoinDTO.quitReason }">
                    				-
                    			</c:if>
                    		</td>
                    	</tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 탭 2: 신고 내역 -->
        <div id="report-tab" class="tab-content">
            <h3>신고 받은 내역 (총 ${fn:length(reportedList) }건)</h3>
            <table>
                <thead>
                    <tr>
                        <th>신고 대상</th>
                        <th>신고 일자</th>
                        <th>신고 내용</th>
                        <th>신고 처리 상태</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="reportedDTO" items="${reportedList }">
                		<tr>
                			<td>${reportedDTO.content }</td>
                			<td>${reportedDTO.createdDate}</td>
                			<td>${reportedDTO.reportType}</td>
                			<td>
                				<c:if test="${not empty reportedDTO.processType }">
	                				<span class="status-badge status-completed">처리완료</span>
                				</c:if>
                				<c:if test="${empty reportedDTO.processType }">
                					<span class="status-badge status-pending">처리중</span>
                				</c:if>
                			</td>
                		</tr>
                	</c:forEach>
                </tbody>
            </table>

            <h3 style="margin-top: 30px;">신고 한 내역 (총 ${fn:length(reportList) }건)</h3>
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
                    <c:forEach var="reportDTO" items="${reportList }">
                    	<tr>
                    		<td>${reportDTO.content }</td>
                    		<td>${reportDTO.createdDate }</td>
                    		<td>${reportDTO.reportType }</td>
                    		<td>${reportDTO.reporteeCode }</td>
                    		<td>${reportDTO.processType }</td>
                    	</tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 탭 3: 문의 내역 -->
        <div id="inquiry-tab" class="tab-content">
            <h3>문의 내역 (총 ${fn:length(inquiryList) }건)</h3>
            <table>
                <thead>
                    <tr>
                        <th>문의 번호</th>
                        <th>내용</th>
                        <th>문의 일자</th>
                        <th>답변 상태</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="inquiryDTO"  items="${inquiryList }">
                		<tr>
                			<td>${inquiryDTO.inquiryCode }</td>
                			<td>${inquiryDTO.content }</td>
                			<td>${inquiryDTO.createdDate }</td>
                			<td>
                				<c:if test="${not empty inquiryDTO.inquiryCode }">
                					<span class="status-badge status-completed">답변완료</span>
                				</c:if>
                				<c:if test="${empty inquiryDTO.inquiryCode }">
                					<span class="status-badge status-pending">처리중</span>
                				</c:if> 
                			</td>
                		</tr>
                	</c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 탭 4: 로그인 이력 -->
        <div id="login-tab" class="tab-content">
            <h3>로그인 이력 (${fn:length(loginLogList) }건)</h3>
            <table>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>로그인 일시</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach var="loginLogDTO" items="${loginLogList }">
                	<tr>
                		<td>${loginLogDTO.loginLogCode }</td>
                		<td>${loginLogDTO.createdDate }</td>
                	</tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- 액션 버튼 -->
		<div class="action-buttons">
		    <button class="button btn-suspend" onclick="suspendMember()">활동 정지</button>
		    <button class="button btn-withdraw" onclick="withdrawMember()">모임 탈퇴</button>
		   <button class="button btn-back" onclick="location.href='userlist.do'">목록으로</button>
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