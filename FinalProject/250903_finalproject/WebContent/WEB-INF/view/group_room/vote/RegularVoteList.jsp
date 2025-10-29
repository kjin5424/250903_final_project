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
<title>정기 투표 리스트</title>
<link rel="stylesheet"
	href="<%=cp%>/group_room/challenge/topsidecontent.css" />
<link rel="stylesheet" href="votelist.css" />
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
		
			<div class="card">
				<div class="card-header">
					<span class="title">등록된 정기 투표</span>
				</div>

				<div class="meta"><span>우리 정기 모임</span></div>
				<div class="meta"><span>장소 : 서울 마포구 ...</span></div>
				<div class="meta">
					<span>수 | 20:00</span>
				</div>

				<div class="button-group">
					<button id="delete-btn">삭제</button>
					<a href="RegularVoteModify.jsp">
					<button id="edit-btn">수정</button></a>
				</div>
			</div>
			
			<div class="card">
				<div class="card-header">
					<span class="title">등록된 정기 투표</span>
				</div>

				<div class="meta"><span>저기 정기 모임</span></div>
				<div class="meta"><span>장소 : 서울 강서구 ...</span></div>
				<div class="meta">
					<span>토 | 19:00</span>
				</div>

				<div class="button-group">
					<button id="delete-btn">삭제</button>
					<a href="RegularVoteModify.jsp">
					<button id="edit-btn">수정</button></a>
				</div>
			</div>
			
			<div class="create-vote-wrapper">
				<a href="RegularVoteWrite.jsp">
				<button class="create-vote-btn">+ 새 투표 만들기</button></a>
			</div>
			
		</div>
	</div>

</body>
</html>