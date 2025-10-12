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
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
</head>
<body>

<span>도전과제</span>
<table>
	<tr></tr>
	<tr></tr>
	<tr></tr>
</table>
<a href="challenge.action?groupId=${param.groupId }">
	<button>투표 더보기</button>
</a>
</body>
</html>