<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 모임 목록</title>
<style>
/* ================================================
   관리자 페이지 공통 스타일 적용형 (모임 목록)
   ================================================ */

:root {
    --color-primary: #BFFCC6;       /* 메인 색상 (연한 민트/초록) */
    --color-primary-dark: #2E7D32;  /* 메인 색상 어둡게 (진녹색) */
    --color-primary-lighter: #E9FBEF; /* 메인 색상 밝게 */
    --color-secondary: #E6D6FF;     /* 보조 색상 (연보라) */
    --color-secondary-dark: #6B4FB6; /* 보조 색상 어둡게 */
    --color-secondary-lighter: #F4EFFF;
    --color-accent: #FFB3BA;        /* 강조/경고 색상 (연빨강) */
    --color-accent-dark: #C62828;
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
    font-family: "Segoe UI", 'Noto Sans KR', Arial, sans-serif;
    background-color: var(--color-secondary-lighter);
    padding: var(--spacing-xl) var(--spacing-lg);
    color: var(--color-text-primary);
}

/* 페이지 헤더 */
.header {
    background: var(--color-white);
    padding: var(--spacing-lg);
    border-radius: var(--radius-lg);
    font-size: 28px;
    font-weight: 800;
    text-align: center;
    color: var(--color-primary-dark);
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
   검색 필터 입력 영역
   =============================== */
.search-filter {
    display: flex;
    align-items: center;
    gap: var(--spacing-md);
    margin-bottom: var(--spacing-lg);
    padding: var(--spacing-md);
    border: 1px solid var(--color-primary);
    background: var(--color-primary-lighter);
    border-radius: var(--radius-md);
    flex-wrap: wrap;
}

.search-filter label {
    font-weight: 700;
    color: var(--color-primary-dark);
}

.search-filter input[type="text"],
.search-filter select {
    flex: 1; /* 너비를 유동적으로 변경 */
    min-width: 180px; /* 최소 너비 지정 */
    height: 40px;
    padding: 0 10px;
    border: 1px solid var(--color-border);
    border-radius: var(--radius-md);
    font-size: 14px;
    transition: border-color 0.2s;
}

.search-filter input[type="text"]:focus,
.search-filter select:focus {
    border-color: var(--color-secondary-dark);
    outline: none;
}

/* 검색 버튼 */
.button {
    padding: 10px 24px;
    border: none;
    border-radius: var(--radius-md);
    font-weight: 700;
    cursor: pointer;
    transition: all var(--transition-base);
    font-size: 14px;
    height: 40px;
    background: var(--color-primary-dark);
    color: white;
}

.button:hover {
    transform: translateY(-1px);
    box-shadow: var(--shadow-sm);
    opacity: 0.9;
    background: var(--color-secondary-dark);
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
    background: var(--color-secondary);
    font-weight: 700;
    color: var(--color-secondary-dark);
}

tbody tr:hover {
    background: var(--color-secondary-lighter);
    cursor: pointer;
}

/* ===============================
   상태 배지 (모임 목록 전용)
   =============================== */
.status-badge {
    display: inline-block;
    padding: 6px 12px;
    border-radius: var(--radius-full);
    font-size: 12px;
    font-weight: 700;
}

.status-active { /* 활동중 */
    background: var(--color-primary-lighter);
    color: var(--color-primary-dark);
}

.status-hidden { /* 미노출 */
    background: #fff3e0;
    color: #f57c00;
}

.status-deleted, .status-failed { /* 삭제, 개설 실패 */
    background: var(--color-accent);
    color: var(--color-accent-dark);
}

/* 링크 스타일 */
.link-text {
    color: var(--color-secondary-dark);
    text-decoration: none;
    font-weight: 600;
}

.link-text:hover {
    text-decoration: underline;
    color: var(--color-primary-dark);
}

/* 반응형 */
@media (max-width: 768px) {
    .search-filter {
        flex-direction: column;
        align-items: stretch;
    }
    
    .search-filter input[type="text"],
    .search-filter select,
    .search-filter .button {
        width: 100%;
        min-width: unset;
    }

    .container {
        padding: var(--spacing-lg);
    }
    
    table {
        overflow-x: auto;
        display: block;
    }
    
    table thead, table tbody, table tr {
        display: block;
    }
    
    table tbody {
        min-width: 600px; /* 모바일에서 테이블이 너무 작아지는 것 방지 */
    }
}
</style>
</head>
<body>
	<div class="main-content">
		<div class="header">관리자 전체 모임 조회</div>
		<div class="container">
			<div class="search-filter">
				<label for="searchCode">모임명</label>
				<input type="text" id="searchCode" placeholder="모임 코드 또는 모임명 검색"> 
				<label for="statusFilter">상태</label>
                <select id="statusFilter">
					<option value="">전체</option>
					<option value="active">활동중</option>
					<option value="hidden">미노출</option>
					<option value="deleted">삭제</option>
					<option value="failed">개설 실패</option>
				</select>
				<button class="button" onclick="searchMeetings()">검색</button>
			</div>

			<table>
				<thead>
					<tr>
						<th>모임 코드</th>
						<th>모임명</th>
						<th>모임장</th>
						<th>상태</th>
						<th>관리</th>
					</tr>
				</thead>
				<tbody>
					<tr onclick="location.href='meetingDetail.jsp?code=M001'">
						<td>M001</td>
						<td onclick="location.href='/groupdetail.do';">요리 스터디모임</td>
						<td><a href="#" class="link-text" onclick="event.stopPropagation(); goToUserDetail('user001')">김철수</a></td>
						<td><span class="status-badge status-active">활동중</span></td>
						<td><a href="meetingDetail.jsp?code=M001" class="link-text">상세보기</a></td>
					</tr>
					<tr onclick="location.href='meetingDetail.jsp?code=M002'">
						<td>M002</td>
						<td>독서 스터디모임</td>
						<td><a href="#" class="link-text" onclick="event.stopPropagation(); goToUserDetail('user002')">이영희</a></td>
						<td><span class="status-badge status-hidden">미노출</span></td>
						<td><a href="meetingDetail.jsp?code=M002" class="link-text">상세보기</a></td>
					</tr>
					<tr onclick="location.href='meetingDetail.jsp?code=M003'">
						<td>M003</td>
						<td>사진 스터디모임</td>
						<td><a href="#" class="link-text" onclick="event.stopPropagation(); goToUserDetail('user003')">박민수</a></td>
						<td><span class="status-badge status-deleted">삭제</span></td>
						<td><a href="meetingDetail.jsp?code=M003" class="link-text">상세보기</a></td>
					</tr>
					<tr onclick="location.href='meetingDetail.jsp?code=M004'">
						<td>M004</td>
						<td>재즈 스터디모임</td>
						<td><a href="#" class="link-text" onclick="event.stopPropagation(); goToUserDetail('user004')">박재즈</a></td>
						<td><span class="status-badge status-active">활동중</span></td>
						<td><a href="meetingDetail.jsp?code=M004" class="link-text">상세보기</a></td>
					</tr>
					<tr onclick="location.href='meetingDetail.jsp?code=M005'">
						<td>M005</td>
						<td>코딩 스터디모임</td>
						<td><a href="#" class="link-text" onclick="event.stopPropagation(); goToUserDetail('user005')">김코딩</a></td>
						<td><span class="status-badge status-hidden">미노출</span></td>
						<td><a href="meetingDetail.jsp?code=M005" class="link-text">상세보기</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

    <script>
		function searchMeetings() {
			var searchCode = document.getElementById('searchCode').value;
			var statusFilter = document.getElementById('statusFilter').value;

			console.log('검색 조건:', { code: searchCode, status: statusFilter });
			alert('모임 검색 기능은 서버 연동 후 작동합니다.');
		}
        
        // 모임장 아이디 클릭 시 회원 상세 페이지로 이동하는 더미 함수
        function goToUserDetail(memberId) {
             // 경로와 실제 파일명은 환경에 맞게 조정이 필요합니다.
            location.href = '<%=cp%>/manager/memberDetail.jsp?id=' + memberId;
        }
	</script>
</body>
</html>