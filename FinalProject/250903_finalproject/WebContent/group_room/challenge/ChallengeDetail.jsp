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
<title>도전 과제</title>
<script src="https://cdn.tailwindcss.com"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script src="<%=cp%>/group/challenge/challenge.js"></script>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap">
<!-- 폰트는 제거 가능. -->
<link rel="stylesheet" href="<%=cp%>/group_room/challenge/challenge.css">
</head>
<body class="p-6">

	<div class="max-w-2xl mx-auto bg-white p-6 rounded-lg shadow-md">
		<h1 class="text-2xl font-bold">도전 과제 제목</h1>
		<div class="flex space-x-2">
			<button
				class="bg-yellow-400 text-white px-3 py-1 rounded hover:bg-yellow-500">수정</button>
			<button
				class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">삭제</button>
			<button
				class="bg-gray-500 text-white px-3 py-1 rounded hover:bg-gray-600">신고</button>
		</div>

		<h2 class="text-lg font-semibold mb-2">도전 과제 수행 가능 일자</h2>
		<table class="w-full mb-6 border-collapse">
			<thead>
				<tr class="bg-gray-100">
					<th class="border p-2">일차</th>
					<th class="border p-2">내용</th>
					<th class="border p-2">확인</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="border p-2">1일차</td>
					<td class="border p-2">영단어 외우기</td>
					<td class="border p-2 text-center"><input type="checkbox"
						class="checkbox" checked></td>
				</tr>
				<tr>
					<td class="border p-2">2일차</td>
					<td class="border p-2">영단어 외우기</td>
					<td class="border p-2 text-center"><input type="checkbox"
						class="checkbox" checked></td>
				</tr>
				<tr>
					<td class="border p-2">3일차</td>
					<td class="border p-2">영단어 외우기</td>
					<td class="border p-2 text-center"><input type="checkbox"
						class="checkbox" checked></td>
				</tr>
				<tr>
					<td class="border p-2">4일차</td>
					<td class="border p-2">영단어 외우기</td>
					<td class="border p-2 text-center"><input type="checkbox"
						class="checkbox"></td>
				</tr>
				<tr>
					<td class="border p-2">5일차</td>
					<td class="border p-2">영단어 외우기</td>
					<td class="border p-2 text-center"><input type="checkbox"
						class="checkbox"></td>
				</tr>
				<tr>
					<td class="border p-2">6일차</td>
					<td class="border p-2">외운 영단어 복기</td>
					<td class="border p-2 text-center"><input type="checkbox"
						class="checkbox"></td>
				</tr>
				<tr>
					<td class="border p-2">7일차</td>
					<td class="border p-2">영어 책 읽기(30p이상)</td>
					<td class="border p-2 text-center"><input type="checkbox"
						class="checkbox"></td>
				</tr>
			</tbody>
		</table>

		<div class="mb-6">
			<p>참가자 : 8 명</p>
			<p>달성자 : 5 명</p>
			<p>달성률 : 62.5 %</p>
		</div>

		<!-- 참가자 리스트 토글 텍스트 -->
		<h2 id="participantTitle"
			class="text-lg font-bold cursor-pointer mb-2">참가자 리스트 ▼(펼치기)</h2>

		<!-- 참가자 리스트 테이블 (초기 숨김 상태) -->
		<table id="participantTable"
			class="min-w-full border-collapse border border-gray-300 hidden mb-6">
			<thead>
				<tr class="bg-gray-100">
					<th class="border border-gray-300 px-4 py-2">참가자</th>
					<th class="border border-gray-300 px-4 py-2">달성여부</th>
					<th class="border border-gray-300 px-4 py-2">달성일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="border border-gray-300 px-4 py-2 font-bold">userA</td>
					<td class="border border-gray-300 px-4 py-2">달성</td>
					<td class="border border-gray-300 px-4 py-2">yy-mm-dd</td>
				</tr>
				<tr>
					<td class="border border-gray-300 px-4 py-2 font-bold">userB</td>
					<td class="border border-gray-300 px-4 py-2">달성</td>
					<td class="border border-gray-300 px-4 py-2">yy-mm-dd</td>
				</tr>
				<tr>
					<td class="border border-gray-300 px-4 py-2 font-bold">userC</td>
					<td class="border border-gray-300 px-4 py-2">미달성</td>
					<td class="border border-gray-300 px-4 py-2">-</td>
				</tr>
				<tr>
					<td class="border border-gray-300 px-4 py-2 font-bold">userD</td>
					<td class="border border-gray-300 px-4 py-2">달성</td>
					<td class="border border-gray-300 px-4 py-2">yy-mm-dd</td>
				</tr>
			</tbody>
		</table>

		<!-- 댓글 입력 영역 -->
		<div class="relative mb-4">
			<textarea class="w-full p-2 border rounded" rows="3"
				placeholder="인증 소감을 작성해보세요"></textarea>
			<button
				class="absolute bottom-2 right-2 bg-blue-500 text-white px-3 py-1 rounded">등록</button>
		</div>

		<div class="mb-4">
			<p class="font-semibold">댓글 1개</p>
			<div class="flex justify-between items-center border p-2 rounded">
				<div>
					<p class="font-bold">userB</p>
					<p>
						가뿐해요<br>여러분도 해보세요
					</p>
				</div>
				<div class="flex items-center">
					<p class="mr-2">yy-mm-dd</p>
					<button class="bg-red-500 text-white px-2 py-1 rounded">신고</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
