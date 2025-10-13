<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice.jsp</title>
</head>
<body>

<span>공지 사항</span>
<table>
	<%-- contetnId는 모임장이 정한 공지 세 개(적다면 줄도록..) --%>
	<%-- contentId배열, <c:forEach> 사용하면 될듯 --%>
	<tr>
		<td data-groupId="${groupId }" data-contentId="123">첫 번째 공지</td>
	</tr>
	<tr>
		<td data-groupId="${groupId }" data-contentId="246">두 번째 공지</td>
	</tr>
	<tr>
		<td data-groupId="${groupId }" data-contentId="369">세 번째 공지</td>
	</tr>
</table>
<a href="noticelist.action?groupId=${groupId}">
	<button>공지 바로 가기</button>
</a>

</body>
</html>