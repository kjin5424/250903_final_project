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
<title>도전과제 작성 화면</title>
<link rel="stylesheet" href="<%=cp %>/css_temp/createchallenge.css" />
<link rel="stylesheet" href="<%=cp %>/css_temp/topsidecontent.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js_temp/CreateChallenge.js"></script>
</head>
<body>
	<div class="topmenubar">
		<c:import url="/WEB-INF/view/common/TopMenuBar.jsp"></c:import>
	</div>

	<div class="container">
		<div class="sidebar">
			<c:import url="/WEB-INF/view/group_room/challenge/SideBar.jsp"></c:import>
		</div>

		<div class="main">
			<div class="input-field">
				<label for="title">제목</label> <input type="text" id="title"
					placeholder="제목을 입력하세요">
			</div>

			<div class="input-field">
				<label for="startdate">시작 날짜</label> <input type="date" id="date">
			</div>

			<div class="radio-group">
				<label><input type="radio" name="challenge" value="daily">
					일일 도전과제(7일)</label>
				<label><input type="radio" name="challenge"	value="weekly">
					주간 도전과제(5주)</label>
			</div>

			<div class="input-day">
				<div class="input-field">
					<label for="week1">1일차</label> <input type="text" id="day1"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week1">2일차</label> <input type="text" id="day2"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week1">3일차</label> <input type="text" id="day3"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week1">4일차</label> <input type="text" id="day4"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week1">5일차</label> <input type="text" id="day5"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week1">6일차</label> <input type="text" id="day6"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week1">7일차</label> <input type="text" id="day7"
						placeholder="내용을 입력하세요">
				</div>
			</div>

			<div class="input-week">
				<div class="input-field">
					<label for="week1">1주차</label> <input type="text" id="week1"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week2">2주차</label> <input type="text" id="week2"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week3">3주차</label> <input type="text" id="week3"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week4">4주차</label> <input type="text" id="week4"
						placeholder="내용을 입력하세요">
				</div>
				<div class="input-field">
					<label for="week5">5주차</label> <input type="text" id="week5"
						placeholder="내용을 입력하세요">
				</div>
			</div>

			<div class="button-group">
				<button class="btn-reset">다시 작성</button>
				<button class="btn-submit">등록 하기</button>
			</div>

		</div>

	</div>
</body>
</html>
