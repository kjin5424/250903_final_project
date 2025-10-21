<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 회원 목록</title>
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
	<div class="header">관리자 회원 목록 조회</div>
	<div class="container">
		<div class="search-filter">
			<label>아이디</label> <input type="text" id="searchId"
				placeholder="아이디 검색"> <label>활동 정지 여부</label> <select
				id="statusFilter">
				<option value="">전체</option>
				<option value="N">정상</option>
				<option value="Y">정지</option>
			</select>

			<button class="button" onclick="searchMembers()">검색</button>
		</div>

		<div class="result-count">
			검색 결과: <strong>총 3명</strong>
		</div>

		<table>
			<thead>
				<tr>
					<th>아이디</th>
					<th>닉네임</th>
					<th>이메일</th>
					<th>이름</th>
					<th>주민등록번호</th>
					<th>주소</th>
					<th>성별</th>
					<th>연령대</th>
					<th>활동 정지 여부</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody>
				<tr onclick="location.href='memberDetail.jsp?id=user001'">
					<td>user001</td>
					<td>홍길동123</td>
					<td>hong@example.com</td>
					<td>홍길동</td>
					<td>900101</td>
					<td>서울시 강남구</td>
					<td>남</td>
					<td>30대</td>
					<td class="status-active">정상</td>
					<td>2024-01-15</td>
				</tr>
				<tr onclick="location.href='memberDetail.jsp?id=user002'">
					<td>user002</td>
					<td>김영희</td>
					<td>kim@example.com</td>
					<td>김영희</td>
					<td>950315</td>
					<td>서울시 마포구</td>
					<td>여</td>
					<td>20대</td>
					<td class="status-active">정상</td>
					<td>2024-02-20</td>
				</tr>
				<tr onclick="location.href='memberDetail.jsp?id=user003'">
					<td>user003</td>
					<td>이철수99</td>
					<td>lee@example.com</td>
					<td>이철수</td>
					<td>880520</td>
					<td>경기도 성남시</td>
					<td>남</td>
					<td>30대</td>
					<td class="status-suspended">정지</td>
					<td>2023-11-10</td>
				</tr>
				<tr onclick="location.href='memberDetail.jsp?id=user004'">
					<td>user004</td>
					<td>이남자</td>
					<td>wow@example.com</td>
					<td>이남자</td>
					<td>860820</td>
					<td>인천시 남동구</td>
					<td>남</td>
					<td>30대</td>
					<td class="status-suspended">정지</td>
					<td>2023-01-10</td>
				</tr>
			</tbody>
		</table>
	</div>

	<script>
		function searchMembers()
		{
			var searchId = document.getElementById('searchId').value;
			var statusFilter = document.getElementById('statusFilter').value;

			// 실제로는 서버에 요청을 보내야 합니다
			console.log('검색 조건:',
			{
				id : searchId,
				status : statusFilter
			});

			alert('검색 기능은 서버 연동 후 작동합니다.');
		}
	</script>
</body>
</html>