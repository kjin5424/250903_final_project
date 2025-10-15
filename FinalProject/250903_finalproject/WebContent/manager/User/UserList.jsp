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
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.container {
	background-color: #fff;
	padding: 25px;
	border-radius: 20px;
	max-width: 1400px;
	margin: 0 auto;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
}

.search-filter {
	margin-bottom: 25px;
	display: flex;
	gap: 10px;
	align-items: center;
}

.search-filter label {
	font-weight: bold;
	margin-right: 5px;
}

input, select {
	padding: 8px 10px;
	border-radius: 8px;
	border: 1px solid #ccc;
	font-size: 14px;
}

.search-filter input {
	width: 200px;
}

.button {
	padding: 8px 16px;
	background-color: #BFFCC6;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-weight: bold;
	font-size: 14px;
}

.button:hover {
	background-color: #A8EBB0;
}

.result-count {
	margin-bottom: 15px;
	font-size: 14px;
	color: #666;
}

table {
	width: 100%;
	border-collapse: collapse;
	overflow: hidden;
	border-radius: 10px;
}

th, td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #eee;
}

th {
	background-color: #BFFCC6;
	font-weight: bold;
	color: #333;
}

tbody tr:nth-child(odd) {
	background-color: #E6D6FF;
}

tbody tr:nth-child(even) {
	background-color: #F0E8FF;
}

tbody tr {
	cursor: pointer;
}

tbody tr:hover {
	background-color: #D5C5EE;
}

td a {
	text-decoration: none;
	color: #333;
	display: block;
}

.status-active {
	color: #2E7D32;
	font-weight: bold;
}

.status-suspended {
	color: #D32F2F;
	font-weight: bold;
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