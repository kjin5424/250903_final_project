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
<title>ChallengeSample.jsp</title>
</head>
<body>

<span>도전과제</span>
<table>
	<tr>
		<td>첫 번째 도전과제</td>
	</tr>
	<tr>
		<td>두 번째 도전과제</td>
	</tr>
	<tr>
		<td>세 번째 도전과제</td>
	</tr>
</table>
<a href="challenge.action?groupId=${groupId }">
	<button>투표 더보기</button>
</a>

</body>
</html>