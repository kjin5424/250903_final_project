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

/* ===============================
   검색 필터 입력 영역 크기 보정
   =============================== */
.search-filter {
    display: flex;
    align-items: center;
    gap: var(--spacing-md);
    margin-bottom: var(--spacing-lg);
    flex-wrap: wrap; /* 화면 줄어들면 자동 줄바꿈 */
}

.search-filter label {
    font-weight: 600;
    color: var(--color-text-secondary);
}

.search-filter input[type="text"],
.search-filter select {
    width: 260px; /* 기존보다 넓게 */
    height: 40px; /* 높이 통일 */
    padding: 0 10px;
    border: 1px solid var(--color-border);
    border-radius: var(--radius-md);
    font-size: 14px;
    transition: border-color 0.2s;
}

.search-filter input[type="text"]:focus,
.search-filter select:focus {
    border-color: var(--color-primary-dark);
    outline: none;
}

.search-filter .button {
    height: 40px; /* 버튼 높이도 통일 */
    padding: 0 20px;
    font-size: 14px;
}
</style>
</head>
<body>
	<!-- 본문 컨텐츠 -->
	<div class="main-content">
		<div class="header">관리자 전체모임조회</div>
		<div class="container">
			<div class="search-filter">
				<input type="text" id="searchCode" placeholder="모임 코드 검색"> <select
					id="statusFilter">
					<option value="">전체</option>
					<option value="hidden">미노출</option>
					<option value="deleted">삭제</option>
					<option value="failed">개설 실패</option>
				</select>
				<button class="button">검색</button>
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
					<tr>
						<td>M001</td>
						<td>요리 스터디모임</td>
						<td>김철수</td>
						<td>활동중</td>
						<td><a href="meetingDetail.jsp?code=M001">상세보기</a></td>
					</tr>
					<tr>
						<td>M002</td>
						<td>독서 스터디모임</td>
						<td>이영희</td>
						<td>미노출</td>
						<td><a href="meetingDetail.jsp?code=M002">상세보기</a></td>
					</tr>
					<tr>
						<td>M003</td>
						<td>사진 스터디모임</td>
						<td>박민수</td>
						<td>삭제</td>
						<td><a href="meetingDetail.jsp?code=M003">상세보기</a></td>
					</tr>
					<tr>
						<td>M004</td>
						<td>재즈 스터디모임</td>
						<td>박재즈</td>
						<td>활동중</td>
						<td><a href="meetingDetail.jsp?code=M004">상세보기</a></td>
					</tr>
					<tr>
						<td>M005</td>
						<td>코딩 스터디모임</td>
						<td>김코딩</td>
						<td>미노출</td>
						<td><a href="meetingDetail.jsp?code=M005">상세보기</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>