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
<title>도전 과제 리스트</title>
<link rel="stylesheet" href="challengelist.css" />
<link rel="stylesheet" href="topsidecontent.css" />
</head>
<body>
	<!-- 상단 메뉴바 -->
	<div class="topmenubar">
		<c:import url="/common/TopMenuBar.jsp"></c:import>
	</div>

	<div class="container">
		<!-- 사이드바 -->
		<div class="sidebar">
			<c:import url="SideBar.jsp"></c:import>
		</div>


		<!-- 날짜 10/10이라 가정 -->
		<div class="main">
			<table class="table">
				<thead>
					<tr>
						<th>과제</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>단위</th>
						<th>과제기간</th>
					</tr>
				</thead>
				<tbody>
					<tr class="ready">
						<td><a href="ChallengeDetail.jsp">영단어 마스터</a></td>
						<td>userA</td>
						<td>2025-10-10</td>
						<td>일간과제</td>
						<td>2025-10-15 ~ 2025-10-21</td>
					</tr>
					<tr class="started">
						<td><a href="ChallengeDetail.jsp">한자 마스터</a></td>
						<td>userA</td>
						<td>2025-09-20</td>
						<td>월간과제</td>
						<td>2025-10-06 ~ 2025-11-09</td>
					</tr>
					<tr class="ended">
						<td><a href="ChallengeDetail.jsp">일어 마스터</a></td>
						<td>userD</td>
						<td>2025-09-15</td>
						<td>일간과제</td>
						<td>2025-09-22 ~ 2025-09-28</td>
					</tr>
					<tr class="ended">
						<td><a href="ChallengeDetail.jsp">영단어 마스터</a></td>
						<td>userD</td>
						<td>2025-09-04</td>
						<td>일간과제</td>
						<td>2025-09-06 ~ 2025-09-12</td>
					</tr>
					<tr class="ended">
						<td><a href="ChallengeDetail.jsp">불어 마스터</a></td>
						<td>userD</td>
						<td>2025-09-04</td>
						<td>월간과제</td>
						<td>2025-09-07 ~ 2025-10-11</td>
					</tr>
					<tr class="ended">
						<td><a href="ChallengeDetail.jsp">아랍어 마스터</a></td>
						<td>userA</td>
						<td>2025-09-01</td>
						<td>일간과제</td>
						<td>2025-09-08 ~ 2025-09-14</td>
					</tr>
					<tr class="ended">
						<td><a href="ChallengeDetail.jsp">일어 마스터</a></td>
						<td>userA</td>
						<td>2025-08-27</td>
						<td>월간과제</td>
						<td>2025-09-01 ~ 2025-10-05</td>
					</tr>
					<tr class="ended">
						<td><a href="ChallengeDetail.jsp">영단어 마스터</a></td>
						<td>userD</td>
						<td>2025-08-27</td>
						<td>일간과제</td>
						<td>2025-09-01 ~ 2025-09-07</td>
					</tr>
				</tbody>
			</table>
			<div class="write-button">
				<a href="CreateChallenge.jsp">
				<button>도전과제 작성하기</button></a>
			</div>
			<div class="pagination">
				<span>1</span> <span>/</span> <span>2</span> <span>/</span> <span>3</span>
				<span>/</span> <span>4</span> <span>/</span> <span>5</span>
			</div>
		</div>
	</div>
</body>
</html>