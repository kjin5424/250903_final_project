<%@page import="com.test.mybatis.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String cp = request.getContextPath();

	// 현재 페이지 파라미터 받기 (기본값: meetings)
	/* 
	String currentPage = request.getParameter("page");
	if (currentPage == null || currentPage.isEmpty())
	{
		currentPage = "meetings";
	}
	*/
%>

<link rel="stylesheet" href="css_new/common_sample.css">
<link rel="stylesheet" href="css_new/topmenubar_sample.css">
<link rel="stylesheet" href="css_new/board_sample.css">

<nav class="navbar">
	<div class="navbar-inner">
		<!-- 로고 -->
		<a href="<%=cp%>/start.do" class="navbar-logo">
			<span class="logo-icon">🌱</span>
               <span class="logo-text">공모자들</span>
		</a>

		<!-- 메뉴 탭 -->
		<div class="navbar-menu">
               <a href="<%=cp%>/notice/Notice.jsp" class="menu-tab">
                   <span class="menu-icon">📢</span>
                   공지사항
               </a>
               <a href="<%=cp%>/group/GroupList.jsp" class="menu-tab active">
                   <span class="menu-icon">👥</span>
                   모임구경
               </a>
               <a href="beforegroupcreate.do" class="menu-tab">
                   <span class="menu-icon">➕</span>
                   모임 개설
               </a>
               <a href="?page=mygroups" class="menu-tab">
                   <span class="menu-icon">📚</span>
                   내 모임
               </a>
               <a href="<%=cp%>/mypage.do" class="menu-tab">
                   <span class="menu-icon">⚙️</span>
                   마이페이지
               </a>
           </div>
		<div class="navbar-actions">
			<%
			UserDTO user = (UserDTO) session.getAttribute("user");
			if (user == null)
			{
			%>
			<!-- 로그인 버튼 -->
			<a href="loginpage.do" class="login-button"> 
				<span class="login-icon">🔐</span> 
				<span>로그인</span>
			</a>
			<%
			} else
			{
			%>
			<!-- 로그인 버튼 -->
			<div class="navbar-dropdown">
                <div class="profile-button dropdown-trigger">
                    <span class="profile-icon">👤</span>
                </div>
                <div class="dropdown-menu">
                    <a href="<%=cp%>/user/Profile/MyProfile.jsp" class="dropdown-item">
                        <span>👤</span>
                        <span>내 프로필</span>
                    </a>
                    <a href="#" class="dropdown-item">
                        <span>⚙️</span>
                        <span>설정</span>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="logout.do" class="dropdown-item">
                        <span>🚪</span>
                        <span>로그아웃</span>
                    </a>
                </div>
            </div>
			<%
			}
			%>
			
			<!-- 모바일 메뉴 토글 -->
            <button class="mobile-menu-toggle">
                <span class="toggle-bar"></span>
                <span class="toggle-bar"></span>
                <span class="toggle-bar"></span>
            </button>
		</div>
	</div>
</nav>