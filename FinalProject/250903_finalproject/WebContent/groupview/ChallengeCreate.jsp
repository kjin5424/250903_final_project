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
<title>Challenge Form</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="<%=cp%>/groupview/challengecreate.css">
</head>
<body>
	<div class="container">
		<div class="input-field">
			<label for="title" class="block text-gray-700">제목</label> <input
				type="text" id="title" placeholder="제목을 입력하세요"
				class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
		</div>

		<div class="radio-group">
			<label class="flex items-center"> <input type="radio"
				name="challenge" value="weekly" class="mr-2"> 주간 도전과제
			</label> <label class="flex items-center"> <input type="radio"
				name="challenge" value="monthly" class="mr-2"> 월간 도전과제
			</label>
		</div>

		<div class="input-field">
			<label for="week1" class="block text-gray-700">1주차</label> <input
				type="text" id="week1" placeholder="내용을 입력하세요"
				class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
		</div>

		<div class="input-field">
			<label for="week2" class="block text-gray-700">2주차</label> <input
				type="text" id="week2" placeholder="내용을 입력하세요"
				class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
		</div>

		<div class="input-field">
			<label for="week3" class="block text-gray-700">3주차</label> <input
				type="text" id="week3" placeholder="내용을 입력하세요"
				class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
		</div>

		<div class="input-field">
			<label for="week4" class="block text-gray-700">4주차</label> <input
				type="text" id="week4" placeholder="내용을 입력하세요"
				class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
		</div>

		<div class="input-field">
			<label for="week5" class="block text-gray-700">5주차</label> <input
				type="text" id="week5" placeholder="내용을 입력하세요"
				class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
		</div>

		<div class="button-group">
			<button
				class="px-4 py-2 bg-gray-200 text-gray-700 rounded-md hover:bg-gray-300">다시
				작성</button>
			<button
				class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">등록
				하기</button>
		</div>
	</div>
</body>
</html>
