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
<title>비정기 투표 수정</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<%=cp%>/css/topsidecontent.css" />
<link rel="stylesheet" href="<%=cp%>/css/css_vote/votecreate.css">
</head>
<body>
	<!-- 상단 메뉴바 -->
	<div class="topmenubar">
		<c:import url="/WEB-INF/view/common/TopMenuBar.jsp"></c:import>
	</div>

	<!-- 좌측 메뉴바 + 본문 -->
	<div class="container">
		<div class="sidebar">
			<c:import url="/WEB-INF/view/group_room/SideBar.jsp"></c:import>
		</div>

		<div class="main">
			<div class="input-group">
				<label for="date">일자</label> <input type="date" id="date"
					name="date" value="2025-10-24">
			</div>
			<div class="input-group">
				<label for="start-time">시작 시간</label> <input type="time"
					id="start-time" name="start-time" value="20:00">
			</div>
			<!-- 나중에 시간 분 선택 가능하게.. -->
			<div class="input-group">
				<label for="progress-time">진행 시간</label> <input type="text"
					id="progress-time" name="progress-time" value="120(분)">
			</div>
			<div class="input-group">
				<label for="location">지역</label> <input type="text" id="location"
					name="location" value="서울 마포구...">
			</div>
			<div class="button-group">
				<button type="button" class="btn-submit">수정 하기</button>
				<a href="VoteList.jsp">
				<button type="button" class="btn-back">돌아가기</button></a>
			</div>
		</div>
	</div>
</body>
</html>