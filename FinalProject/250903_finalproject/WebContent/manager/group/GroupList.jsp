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
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background-color: #E9D9FF;
	display: flex;
}

/* 왼쪽 색감 사이드바 */
.sidebar {
	width: 80px;
	background-color: #E0CFFF;
	height: 100vh;
	border-top-right-radius: 25px;
	padding-top: 20px;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.05);
}

.bar {
	width: 60%;
	height: 40px;
	margin: 12px auto;
	border-radius: 10px;
}

.bar-green {
	background-color: #BFFCC6;
}

.bar-purple {
	background-color: #E6D6FF;
}

/* 본문 컨텐츠 영역 */
.main-content {
	flex: 1;
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
	max-width: 1000px;
	margin: 0 auto;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
}

.search-filter {
	margin-bottom: 25px;
	text-align: center;
}

input, select {
	padding: 8px 10px;
	border-radius: 8px;
	border: 1px solid #ccc;
	margin-right: 10px;
	font-size: 14px;
}

.button {
	padding: 8px 16px;
	background-color: #BFFCC6;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-weight: bold;
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
}

tbody tr:nth-child(odd) {
	background-color: #E6D6FF;
}

tbody tr:nth-child(even) {
	background-color: #F0E8FF;
}

td a {
	text-decoration: none;
	color: #333;
}

td a:hover {
	text-decoration: underline;
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