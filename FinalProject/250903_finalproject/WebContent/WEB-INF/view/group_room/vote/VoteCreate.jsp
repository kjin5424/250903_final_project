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
<title>비정기 투표 등록</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<%=cp%>/css/css_vote/votecreate.css">
<link rel="stylesheet" href="<%=cp%>/css/topsidecontent.css" />
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(function()
{
	$("input[name='on_off']").change(function()
	{
		if ($(this).val()=="online")
		{
			$(".input-location").css("display", "none");
			$(".input-uri").css("display", "block");
		}
		else if ($(this).val()=="offline")
		{
			$(".input-uri").css("display", "none");
			$(".input-location").css("display", "block");
		}
	});
});
</script>
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
			<form>
				<div class="input-group">
					<label for="date">일자</label> <input type="date" id="date"
						name="date">
				</div>
				<div class="input-group">
					<label for="start-time">시작 시간</label> <input type="time"
						id="start-time" name="start-time">
				</div>
				<div class="input-group">
					<label for="progress-time">진행 시간</label> <input type="text"
						id="progress-time" name="progress-time">
				</div>

				<div class="input-group input-radio">
					<label for="offline"> <input type="radio" name="on_off"
						id="offline" value="offline" /> 오프라인
					</label> <label for="online"> <input type="radio" name="on_off"
						id="online" value="online" /> 온라인
					</label>
				</div>

				<div class="input-group input-location">
					<label for="location">지역</label> <input type="text" id="location"
						name="location" placeholder="지역 입력">
				</div>
				<div class="input-group input-uri">
					<label for="uri">링크</label> <input type="text" id="uri" name="uri"
						placeholder="온라인 주소 입력">
				</div>
				<div class="button-group">
					<button type="submit" class="btn-submit">등록 하기</button>
					<a href="VoteList.jsp">
					<button type="button" class="btn-back">돌아가기</button></a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>