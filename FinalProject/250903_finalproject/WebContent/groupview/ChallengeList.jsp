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
<title>도전 과제 리스트</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="<%=cp%>/groupview/challengelist.css" />
</head>
<body>
	<div class="container">
		<div class="header">도전 과제 리스트</div>
		<table class="table">
			<thead>
				<tr>
					<th>과제</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>영단어 마스터</td>
					<td>userA</td>
					<td>yy-mm-dd</td>
				</tr>
				<tr>
					<td>한자 마스터</td>
					<td>userA</td>
					<td>yy-mm-dd</td>
				</tr>
				<tr>
					<td>일어 마스터</td>
					<td>userD</td>
					<td>yy-mm-dd</td>
				</tr>
				<tr>
					<td>영단어 마스터</td>
					<td>userD</td>
					<td>yy-mm-dd</td>
				</tr>
				<tr>
					<td>영단어 마스터</td>
					<td>userD</td>
					<td>yy-mm-dd</td>
				</tr>
				<tr>
					<td>영단어 마스터</td>
					<td>userD</td>
					<td>yy-mm-dd</td>
				</tr>
				<tr>
					<td>영단어 마스터</td>
					<td>userD</td>
					<td>yy-mm-dd</td>
				</tr>
				<tr>
					<td>영단어 마스터</td>
					<td>userD</td>
					<td>yy-mm-dd</td>
				</tr>
			</tbody>
		</table>
		<div class="write-button">
			<button>글쓰기</button>
		</div>
		<div class="pagination">
			<span>1</span> <span>/</span> <span>2</span> <span>/</span> <span>3</span>
			<span>/</span> <span>4</span> <span>/</span> <span>5</span>
		</div>
	</div>
</body>
</html>