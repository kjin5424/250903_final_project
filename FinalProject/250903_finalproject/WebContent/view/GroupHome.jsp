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
<title>GroupHome.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<script>
	var cp = "<%=cp %>";
	var groupId = ${groupId};
</script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/grouphome.js"></script>
</head>
<body>

<!--
메인메뉴(리스트) 혹은 마이페이지에서 넘어오는 모임 홈 화면
모임 번호를 갖고 올 것임.

공지, 게시판, 투표, 도전과제
모임원 리스트
-->


<div>

	<!-- 상단 메뉴 -->
	<div>
	</div>
	
	<!-- 좌측 메뉴 -->
	<div>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		
		<!-- 모임 이름이나 그림, 신청버튼, 신고버튼(하단 메뉴 가능) 등.. -->
		<h2>선택한 공부 모임</h2>
		<hr>
		
		<!-- 공지 -->
		<div class="import" id="notice">
			<c:import url="/WEB-INF/view/NoticeSample.jsp"></c:import>
		</div>
		
		<!-- 게시판 -->
		<div class="import" id="bulletin">
			<c:import url="/WEB-INF/view/BulletinSample.jsp"></c:import>
		</div>
		
		<!-- 투표 -->
		<div class="import">
			<c:import url="/WEB-INF/view/VoteSample.jsp"></c:import>
		</div>
		
		<!-- 도전과제 -->
		<div class="import">
			<c:import url="/WEB-INF/view/ChallengeSample.jsp"></c:import>
		</div>
		
	</div>
	
	<!-- 하단 영역 -->
	<div>
	</div>

</div>

</body>
</html>