<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String cp = request.getContextPath();
    
    // 현재 페이지 파라미터 받기 (기본값: meetings)
    String currentPage = request.getParameter("page");
    if (currentPage == null || currentPage.isEmpty()) {
        currentPage = "meetings";
    }
    
%>

<link rel="stylesheet" href="<%=cp%>/css/topmenubar.css">

<div class="top-menu-bar">
	<nav class="navbar">
		<div class="nav-left">
			<!-- 로고 -->
			<a href="?page=main" class="logo-tab"> <span class="logo-icon">🎯</span>
				<span>공모자들</span>
			</a>

			<!-- 메뉴 탭 -->
			<a href="<%=cp%>/notice/Notice.jsp"
				class="nav-tab <%= "notice".equals(currentPage) ? "active" : "" %>">
				공지사항 </a> <a href="<%=cp%>/group/GroupList.jsp"
				class="nav-tab <%= "groups".equals(currentPage) ? "active" : "" %>">
				모임구경 </a> <a href="?page=creategroup"
				class="nav-tab <%= "creategroup".equals(currentPage) ? "active" : "" %>">
				모임 개설 </a> <a href="?page=mygroups"
				class="nav-tab <%= "mygroups".equals(currentPage) ? "active" : "" %>">
				내 모임 </a> <a href="?page=mypage"
				class="nav-tab <%= "mypage".equals(currentPage) ? "active" : "" %>">
				마이 페이지 </a>
		</div>

		<div class="nav-right">
			<!-- 로그인 버튼 -->
			<%
            	String userCode = (String)session.getAttribute("userCode");
            	if ("".equals(userCode) || userCode==null)
            	{
            %>
				<a href="loginpage.do" class="user-btn">
				<span>🔐</span> <span>로그인</span> </a>
			<%
            	}
            	else
            	{
            %>
				<a href="logout.do" class="user-btn">
				<span>🔐</span> <span>로그아웃</span>	</a>
			<%
            	}
			%>

			<!-- 프로필 버튼 -->
			<a href="<%=cp%>/user/Profile/MyProfile.jsp" class="user-btn primary">
				<span>👤</span> <span>프로필</span>
			</a>
		</div>
	</nav>
</div>