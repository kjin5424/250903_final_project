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
   관리자 페이지 공통 스타일 적용형 (회원 목록)
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
    background-color: var(--color-secondary-lighter); /* 연보라 배경 */
    padding: var(--spacing-xl) var(--spacing-lg);
    color: var(--color-text-primary);
}

/* 페이지 헤더 */
.header {
    background: var(--color-white); /* 배경 흰색으로 변경 */
    padding: var(--spacing-lg);
    border-radius: var(--radius-lg);
    font-size: 28px;
    font-weight: 800;
    text-align: center;
    color: var(--color-primary-dark); /* 진녹색 제목 */
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
    border: 1px solid var(--color-primary); /* 연한 초록색 테두리 */
    background: var(--color-primary-lighter); /* 연한 초록색 배경 */
    border-radius: var(--radius-md);
    flex-wrap: wrap;
}

.search-filter label {
    font-weight: 700;
    color: var(--color-primary-dark);
}

.search-filter input[type="text"],
.search-filter select {
    width: 260px;
    height: 40px;
    padding: 0 10px;
    border: 1px solid var(--color-border);
    border-radius: var(--radius-md);
    font-size: 14px;
    transition: border-color 0.2s;
}

.search-filter input[type="text"]:focus,
.search-filter select:focus {
    border-color: var(--color-secondary-dark); /* 포커스 시 보조색(보라) */
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
    /* 검색 버튼 스타일 */
    background: var(--color-primary-dark); /* 진녹색 배경 */
    color: white;
}

.button:hover {
    transform: translateY(-1px);
    box-shadow: var(--shadow-sm);
    opacity: 0.9;
    background: var(--color-secondary-dark); /* 호버 시 보조색(진보라) */
}

/* 검색 결과 수 */
.result-count {
    font-size: 16px;
    font-weight: 600;
    margin-bottom: var(--spacing-md);
    padding-left: var(--spacing-sm);
    color: var(--color-text-primary);
}

.result-count strong {
    color: var(--color-primary-dark);
}


/* ===============================
   테이블 공통 (회원 상세용 스타일 재활용)
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
    background: var(--color-secondary); /* 헤더 배경을 연보라로 변경 */
    font-weight: 700;
    color: var(--color-secondary-dark); /* 글씨를 진보라로 변경 */
}

tbody tr:hover {
    background: var(--color-secondary-lighter);
    cursor: pointer;
}

/* ===============================
   상태 배지 (회원 목록 전용)
   =============================== */
.status-active { /* 정상 */
    display: inline-block;
    padding: 6px 12px;
    border-radius: var(--radius-full);
    font-size: 12px;
    font-weight: 700;
    background: var(--color-primary-lighter); /* 연한 초록 */
    color: var(--color-primary-dark); /* 진녹색 */
}

.status-suspended { /* 정지 */
    display: inline-block;
    padding: 6px 12px;
    border-radius: var(--radius-full);
    font-size: 12px;
    font-weight: 700;
    background: var(--color-accent); /* 연한 빨강 */
    color: var(--color-accent-dark); /* 진빨강 */
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
        min-width: 800px; /* 모바일에서 테이블이 너무 작아지는 것 방지 */
    }
}
    </style>
</head>
<body>
	<div class="header">관리자 회원 목록 조회</div>
	<div class="container">
		<div class="search-filter">
			<label>아이디</label> <input type="text" id="searchId"
				placeholder="아이디 검색"> 
            <label>활동 정지 여부</label> 
            <select id="statusFilter">
				<option value="">전체</option>
				<option value="N">정상</option>
				<option value="Y">정지</option>
			</select>

			<button class="button" onclick="searchMembers()">검색</button>
		</div>

		<div class="result-count">
			검색 결과: <strong>총 4명</strong>
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
					<td><span class="status-active">정상</span></td>
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
					<td><span class="status-active">정상</span></td>
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
					<td><span class="status-suspended">정지</span></td>
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
					<td><span class="status-suspended">정지</span></td>
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