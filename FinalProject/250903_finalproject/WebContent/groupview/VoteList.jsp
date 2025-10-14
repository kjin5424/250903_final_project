<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
<<<<<<< HEAD
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>투표 리스트 프로토타입</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="<%=cp%>/css/votelist.css" />
</head>
<body>
<!-- 투표 리스트(진행중 + 종료된) -->
<!-- 투표는 추가 페이지 없이 컨트롤러로 해결 -->
=======
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>투표 프로토타입</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="<%=cp%>/css/votelist.css" />
</head>
<body>
>>>>>>> refs/heads/develop

	<!-- 상단 메뉴바 -->
	<header class="top-bar">
		<h1 class="font-bold text-lg">투표 시스템</h1>
		<nav class="top-nav">
			<a href="#">홈</a> <a href="#">투표</a> <a href="#">통계</a> <a href="#">설정</a>
		</nav>
	</header>

	<!-- 좌측 메뉴바 + 본문 -->
	<div class="layout">
		<aside class="side-bar">
			<ul>
				<li><a href="#">대시보드</a></li>
				<li><a href="#">진행중 투표</a></li>
				<li><a href="#">종료된 투표</a></li>
				<li><a href="#">설정</a></li>
			</ul>
		</aside>

		<main class="content-area p-4">
			<div class="max-w-md mx-auto">

				<!-- 진행중인 투표 -->
				<div class="card">
					<div class="flex justify-between mb-2">
						<span class="font-bold">진행중인 투표</span> <span>yy-mm-dd ~
							yy-mm-dd</span>
					</div>
					<div class="text-sm text-gray-600 mb-2">
						<span>총: 12명</span> | <span>투표자: 5명</span>
					</div>
					<div class="text-sm text-gray-600 mb-2">date hh ~ hh</div>
					<div class="mb-2">
						<div class="flex justify-between mb-1">
							<span>참여</span> <span>4명 (80%)</span>
						</div>
						<div class="progress-bar bg-blue-500" style="width: 80%;"></div>
					</div>
					<div class="mb-4">
						<div class="flex justify-between mb-1">
							<span>미참</span> <span>1명 (20%)</span>
						</div>
						<div class="progress-bar bg-gray-300" style="width: 20%;"></div>
					</div>
					<button class="w-full bg-blue-500 text-white py-2 rounded"
						id="submit-btn">제출</button>
				</div>

				<!-- 종료된 투표 -->
				<div class="card">
					<div class="flex justify-between mb-2">
						<span class="font-bold">종료된 투표</span> <span>yy-mm-dd ~
							yy-mm-dd</span>
					</div>
					<div class="text-sm text-gray-600 mb-2">
						<span>총: 12명</span> | <span>투표자: 10명</span>
					</div>
					<div class="text-sm text-gray-600 mb-2">date hh ~ hh</div>
					<div class="mb-2">
						<div class="flex justify-between mb-1">
							<span>참여</span> <span>8명 (80%)</span>
						</div>
						<div class="progress-bar bg-blue-500" style="width: 80%;"></div>
					</div>
					<div>
						<div class="flex justify-between mb-1">
							<span>미참</span> <span>2명 (20%)</span>
						</div>
						<div class="progress-bar bg-gray-300" style="width: 20%;"></div>
					</div>
				</div>

				<!-- 종료된 투표 2 -->
				<div class="card">
					<div class="flex justify-between mb-2">
						<span class="font-bold">종료된 투표</span> <span>yy-mm-dd ~
							yy-mm-dd</span>
					</div>
					<div class="text-sm text-gray-600 mb-2">
						<span>총: 12명</span> | <span>투표자: 11명</span>
					</div>
					<div class="text-sm text-gray-600 mb-2">date hh ~ hh</div>

					<div class="mb-2">
						<div class="flex justify-between mb-1">
							<span>참여</span> <span>10명 (91%)</span>
						</div>
						<div class="progress-bar bg-blue-500" style="width: 91%;"></div>
					</div>

					<div>
						<div class="flex justify-between mb-1">
							<span>미참</span> <span>1명 (9%)</span>
						</div>
						<div class="progress-bar bg-gray-300" style="width: 9%;"></div>
					</div>
				</div>

				<!-- 페이지네이션 -->
				<div class="pagination">
					<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a>
					<a href="#">5</a>
				</div>

			</div>
		</main>
	</div>

	<!-- 하단 메뉴바 -->
	<footer class="bottom-bar">
		<p>© 2025 투표 시스템 | Made by Developer</p>
	</footer>

	<script src="script.js"></script>
</body>
</html>
