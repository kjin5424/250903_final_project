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
<title>VoteSample.jsp</title>
</head>
<body>

<span>최근 투표</span>
<span>20xx년 xx월 xx일 (ㅇ)요일 19:00 ~ 22:00</span>
<!-- 여기 submit 안되는중.. -->
<form id="voteForm" method="get" action="vote.action?groupId=${groupId }&voteNum=741&sendPage=grouphome" >
	<table>
		<tr>
			<td>참여<input type="radio" name="voteResult" value="0"></td>
		</tr>
		<tr>
			<td>미참<input type="radio" name="voteResult" value="1"></td>
		</tr>
	</table>
	<button type="button" id="voteSubmit">제출</button>
</form>
<a href="votelist.action?groupId=${groupId }">
	<button>투표 더보기</button>
</a>

</body>
</html>