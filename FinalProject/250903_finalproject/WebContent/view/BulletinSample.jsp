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
<title>BulletinBoard.jsp</title>
</head>
<body>

<span>최근 게시글</span>
<table>
	<%-- contetnId는 게시판 최신 글 세 개(적다면 줄도록..) --%>
	<%-- contentId배열, <c:forEach> 사용하면 될듯 --%>
	<tr>
		<td data-groupId="${groupId }" data-contentId="321">
		첫 번째 게시글</td>
	</tr>
	<tr>
		<td data-groupId="${groupId }" data-contentId="654">
		두 번째 게시글</td>
	</tr>
	<tr>
		<td data-groupId="${groupId }" data-contentId="987">
		세 번째 게시글</td>
	</tr>
</table>
<a href="bulletinlist.action?groupId=${groupId}">
	<button>게시판 바로 가기</button>
</a>

</body>
</html>