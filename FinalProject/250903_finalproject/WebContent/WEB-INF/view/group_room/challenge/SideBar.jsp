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
<title>SideBar.jsp</title>
</head>
<body>

	<h2>메뉴</h2>
	<ul>
		<li><a href="#">모임 홈</a></li>
		<li><a href="#">게시글</a>
		<li><a href="<%=cp %>/group_room/challenge/ChallengeList.jsp">도전 과제</a></li>
		<li><a href="<%=cp %>/group_room/vote/VoteList.jsp">투표 리스트</a></li>
		<li><a href="<%=cp %>/group_room/vote/RegularVoteList.jsp">정기 투표 설정</a></li>
		<li><a href="#">내 정보</a></li>
		<li><a href="#">설정</a></li>
	</ul>

</body>
</html>