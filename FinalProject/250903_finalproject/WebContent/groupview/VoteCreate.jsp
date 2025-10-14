<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비정기 투표 등록</title>
<script src="https://cdn.tailwindcss.com"></script>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<%=cp%>/groupview/votecreate.css">
</head>
<body>
	<div class="container">
		<div class="input-group">
			<label for="date">일자</label> <input type="date" id="date" name="date">
		</div>
		<div class="input-group">
			<label for="start-time">시작 시간</label> <input type="time"
				id="start-time" name="start-time">
		</div>
		<!-- 나중에 시간 분 선택 가능하게.. -->
		<div class="input-group">
			<label for="progress-time">진행 시간</label> <input type="text"
				id="progress-time" name="progress-time">
		</div>
		<div class="input-group">
			<label for="location">지역</label> <input type="text" id="location"
				name="location" placeholder="지역 입력">
		</div>
		<div class="button-group">
			<button type="button">다시 작성</button>
			<button type="button">등록 하기</button>
		</div>
	</div>
</body>
</html>