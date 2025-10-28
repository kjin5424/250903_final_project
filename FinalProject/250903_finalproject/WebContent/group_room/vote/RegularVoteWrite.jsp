<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정기 투표 작성 화면</title>
<link rel="stylesheet"
	href="<%=cp%>/group_room/challenge/topsidecontent.css" />
<link rel="stylesheet" href="votecreate.css" />
</head>
<body>

	<!-- 상단 메뉴바 -->
	<div class="topmenubar">
		<c:import url="/common/TopMenuBar.jsp"></c:import>
	</div>

	<!-- 좌측 메뉴바 + 본문 -->
	<div class="container">
		<!-- 사이드바 -->
		<div class="sidebar">
			<c:import url="/group_room/challenge/SideBar.jsp"></c:import>
		</div>

		<!-- 본문 -->
		<div class="main">

			<div class="input-group">
				<label for="dayofweek">요일</label>
				<select id="dayofweek" name="dayofweek">
					<option value="0">일</option>
					<option value="1">월</option>
					<option value="2">화</option>
					<option value="3">수</option>
					<option value="4">목</option>
					<option value="5">금</option>
					<option value="6">토</option>
				</select>
			</div>
			<div class="input-group">
				<label for="start-time">시작 시간</label> <input type="time"
					id="start-time" name="start-time">
			</div>

			<div class="input-group">
				<label for="location">지역</label> <input type="text" id="location"
					name="location" placeholder="지역 입력">
			</div>
			<div class="button-group">
				<a href="RegularVoteList.jsp">
				<button type="button">목록으로</button></a>
				<button type="button">등록 하기</button>
			</div>
			
		</div>
	</div>

</body>
</html>