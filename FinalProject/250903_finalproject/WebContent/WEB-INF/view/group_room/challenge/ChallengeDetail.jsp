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
<title>도전 과제</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<%=cp %>/css_temp/challengedetail.css" />
<link rel="stylesheet" href="<%=cp %>/css_temp/topsidecontent.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js_temp/ChallengeDetail.js"></script>
</head>

<body>
	<!-- 상단 메뉴바 -->
	<div class="topmenubar">
		<c:import url="/WEB-INF/view/common/TopMenuBar.jsp"></c:import>
	</div>
	
	<!-- 메인 컨텐츠 -->
	<div class="container">
		<!-- 사이드바 -->
		<div class="sidebar">
			<c:import url="/WEB-INF/view/group_room/challenge/SideBar.jsp"></c:import>
		</div>

		<!-- 본문 -->
		<div class="main">
			<h1 style="font-size: 1.5rem; font-weight: bold;">도전 과제 제목</h1>

			<div class="btn-group">
				<a href="ChallengeModify.jsp">
				<button class="btn-yellow">수정</button></a>
				<button class="btn-red">삭제</button>
				<button class="btn-gray">신고</button>
			</div>

			<h2
				style="font-size: 1.125rem; font-weight: 600; margin-top: 24px; margin-bottom: 8px;">
				도전 과제 시작 날짜(yy-mm-dd)</h2>
			<table>
				<thead>
					<tr>
						<th>일차</th>
						<th>내용</th>
						<th>확인</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1일차(yy-mm-dd)</td>
						<td>영단어 외우기</td>
						<td style="text-align: center;"><input type="checkbox"
							class="checkbox" checked></td>
					</tr>
					<tr>
						<td>2일차(yy-mm-dd+1)</td>
						<td>영단어 외우기</td>
						<td style="text-align: center;"><input type="checkbox"
							class="checkbox" checked></td>
					</tr>
					<tr>
						<td>3일차(yy-mm-dd+2)</td>
						<td>영단어 외우기</td>
						<td style="text-align: center;"><input type="checkbox"
							class="checkbox" checked></td>
					</tr>
					<tr>
						<td>4일차(yy-mm-dd+3)</td>
						<td>영단어 외우기</td>
						<td style="text-align: center;"><input type="checkbox"
							class="checkbox"></td>
					</tr>
					<tr>
						<td>5일차(yy-mm-dd+4)</td>
						<td>영단어 외우기</td>
						<td style="text-align: center;"><input type="checkbox"
							class="checkbox"></td>
					</tr>
					<tr>
						<td>6일차(yy-mm-dd+5)</td>
						<td>외운 영단어 복기</td>
						<td style="text-align: center;"><input type="checkbox"
							class="checkbox"></td>
					</tr>
					<tr>
						<td>7일차(yy-mm-dd+6)</td>
						<td>영어 책 읽기(30p이상)</td>
						<td style="text-align: center;"><input type="checkbox"
							class="checkbox"></td>
					</tr>
				</tbody>
			</table>

			<div style="margin-bottom: 1.5rem;">
				<p>참가자 : 8 명</p>
				<p>달성자 : 5 명</p>
				<p>달성률 : 62.5 %</p>
			</div>

			<h2 id="participantTitle" class="toggle-button">참가자 리스트 ▼(펼치기)</h2>

			<table id="participantTable" class="hidden">
				<thead>
					<tr>
						<th>참가자</th>
						<th>달성여부</th>
						<th>달성일</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><strong>userA</strong></td>
						<td>달성</td>
						<td>yy-mm-dd</td>
					</tr>
					<tr>
						<td><strong>userB</strong></td>
						<td>달성</td>
						<td>yy-mm-dd</td>
					</tr>
					<tr>
						<td><strong>userC</strong></td>
						<td>미달성</td>
						<td>-</td>
					</tr>
					<tr>
						<td><strong>userD</strong></td>
						<td>달성</td>
						<td>yy-mm-dd</td>
					</tr>
				</tbody>
			</table>

			<!-- 인증(댓)글 작성 부분 -->
			<div class="comment-box">
				<textarea rows="3" placeholder="인증 소감을 작성해보세요"></textarea>
				<div class="comment-actions">
					<button class="btn-gray">이미지</button>
					<button class="btn-blue">등록</button>
				</div>
			</div>

			<!-- 인증(댓)글 부분 -->
			<div class="comment-section">
				<p class="comment-count">댓글 2개</p>

				<div class="comment-list">
					<div class="comment-item">
						<div class="left">
							<p class="username">userB</p>
							<p class="content">
								가뿐해요<br>여러분도 해보세요
							</p>
						</div>
						<div class="right">
							<p class="date">yy-mm-dd</p>
							<button class="btn-red">삭제</button>
							<button class="btn-red">신고</button>
						</div>
					</div>

					<div class="comment-item">
						<div class="left">
							<p class="username">userC</p>
							<p class="content">힘들었지만 뿌듯해요!</p>
						</div>
						<div class="right">
							<p class="date">yy-mm-dd</p>
							<button class="btn-red">삭제</button>
							<button class="btn-red">신고</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</body>
</html>
