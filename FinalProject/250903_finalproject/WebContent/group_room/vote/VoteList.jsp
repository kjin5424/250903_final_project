<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>투표 리스트(정기+비정기)</title>
<link rel="stylesheet" href="<%=cp%>/group_room/challenge/topsidecontent.css" />
<link rel="stylesheet" href="votelist.css" />
</head>
<body>
	<!-- 상단 메뉴바 -->
	<div class="topmenubar">
		<c:import url="/common/TopMenuBar.jsp"></c:import>
	</div>

	<!-- 좌측 메뉴바 + 본문 -->
	<div class="container">
		<div class="sidebar">
			<c:import url="/group_room/challenge/SideBar.jsp"></c:import>
		</div>

		<div class="main">
			<!-- 진행중인 투표 -->
			<div class="card">
				<div class="card-header">
					<span class="title">진행중인 투표</span> <span class="date-range">2025-10-14
						~ 2025-10-16</span>
				</div>

				<div class="meta">
					<span>총: 12명</span> | <span>투표자: 5명</span>
				</div>
				<div class="meta">2025-10-17 20:00 ~ 22:00</div>
				<div class="meta">장소 : 서울 마포구 ...</div>

				<div class="progress-section">
					<div class="progress-label">
						<span>참여<input type="radio" name="vote" value="1"></span>
						<span>4명 (80%)</span>
					</div>
					<div class="progress-bar blue" style="width: 80%;"></div>
				</div>

				<div class="progress-section">
					<div class="progress-label">
						<span>미참<input type="radio" name="vote" value="0"></span>
						<span>1명 (20%)</span>
					</div>
					<div class="progress-bar gray" style="width: 20%;"></div>
				</div>

				<div class="button-group">
					<button id="delete-btn">삭제</button>
					<a href="VoteModify.jsp">
					<button id="edit-btn">수정</button></a>
					<button id="submit-btn">제출</button>
				</div>
			</div>

			<!-- 종료된 투표 -->
			<div class="card">
				<div class="card-header">
					<span class="title">종료된 투표</span> <span class="date-range">2025-10-01
						~ 2025-10-03</span>
				</div>

				<div class="meta">
					<span>총: 12명</span> | <span>투표자: 10명</span>
				</div>
				<div class="meta">2025-10-04 14:00 ~ 17:00</div>
				<div class="meta">장소 : 서울 마포구 ...</div>

				<div class="progress-section">
					<div class="progress-label">
						<span>참여</span> <span>8명 (80%)</span>
					</div>
					<div class="progress-bar blue" style="width: 80%;"></div>
				</div>

				<div class="progress-section">
					<div class="progress-label">
						<span>미참</span> <span>2명 (20%)</span>
					</div>
					<div class="progress-bar gray" style="width: 20%;"></div>
				</div>
			</div>

			<!-- 종료된 투표 2 -->
			<div class="card">
				<div class="card-header">
					<span class="title">종료된 투표</span> <span class="date-range">2025-09-23
						~ 2025-09-25</span>
				</div>

				<div class="meta">
					<span>총: 12명</span> | <span>투표자: 11명</span>
				</div>
				<div class="meta">2025-09-26 19:00 ~ 21:00</div>
				<div class="meta">장소 : 서울 마포구 ...</div>

				<div class="progress-section">
					<div class="progress-label">
						<span>참여</span> <span>10명 (91%)</span>
					</div>
					<div class="progress-bar blue" style="width: 91%;"></div>
				</div>

				<div class="progress-section">
					<div class="progress-label">
						<span>미참</span> <span>1명 (9%)</span>
					</div>
					<div class="progress-bar gray" style="width: 9%;"></div>
				</div>
			</div>

			<div class="create-vote-wrapper">
				<a href="VoteCreate.jsp">
				<button class="create-vote-btn">+ 새 투표 만들기</button></a>
			</div>

			<!-- 페이지네이션 -->
			<div class="pagination">
				<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a>
				<a href="#">5</a>
			</div>

		</div>

	</div>
</body>
</html>
