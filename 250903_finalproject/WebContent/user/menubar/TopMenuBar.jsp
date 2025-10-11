<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		// 현재 페이지 파라미터 받기 (기본값: meetings)
		String currentPage = request.getParameter("page");
		if (currentPage == null || currentPage.isEmpty()) 
		{
			currentPage = "meetings";
		}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: #f5f7fa;
}
.navbar {
	background: #a8d5a1;
	display: flex;
	align-items: center;
	padding: 0 20px;
	height: 48px;
	position: sticky;
	top: 0;
	z-index: 1000;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	gap: 4px;
}
.nav-left {
	display: flex;
	align-items: center;
	gap: 4px;
	flex: 1;
}
.nav-right {
	display: flex;
	align-items: center;
	margin-left: auto;
}
.logo-tab {
	background: #8bc683;
	color: white;
	padding: 0 20px;
	height: 36px;
	border-radius: 8px 8px 0 0;
	display: flex;
	align-items: center;
	gap: 8px;
	font-weight: bold;
	font-size: 16px;
	cursor: pointer;
	transition: all 0.2s ease;
}
.logo-tab:hover {
	background: #7ab872;
}
.logo-icon {
	font-size: 20px;
}
.tab {
	background: #8bc683;
	color: white;
	border: none;
	padding: 0 24px;
	height: 36px;
	border-radius: 8px 8px 0 0;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.2s ease;
	position: relative;
	display: flex;
	align-items: center;
	text-decoration: none;
	white-space: nowrap;
}
.tab:hover:not(.active) {
	background: #7ab872;
}
.tab.active {
	background: #f5f7fa;
	color: #2d5a29;
	height: 40px;
}
.tab.active::before {
	content: '';
	position: absolute;
	bottom: 0;
	left: -8px;
	width: 8px;
	height: 8px;
	background: radial-gradient(circle at 0 0, transparent 8px, #f5f7fa 8px);
}
.tab.active::after {
	content: '';
	position: absolute;
	bottom: 0;
	right: -8px;
	width: 8px;
	height: 8px;
	background: radial-gradient(circle at 100% 0, transparent 8px, #f5f7fa 8px);
}
.login-btn {
	background: #2d5a29;
	color: white;
	border: none;
	padding: 8px 20px;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.2s ease;
	text-decoration: none;
	display: flex;
	align-items: center;
	gap: 6px;
}
.login-btn:hover {
	background: #1f4019;
	transform: translateY(-1px);
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}
/* 페이지 컨텐츠 */
.content {
	padding: 40px 30px;
	max-width: 1200px;
	margin: 0 auto;
}
.welcome-card {
	background: white;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}
.welcome-card h1 {
	color: #2d5a29;
	margin-bottom: 15px;
}
.welcome-card p {
	color: #666;
	line-height: 1.6;
}
/* 반응형 */
@media (max-width: 768px) {
	.navbar {
		height: auto;
		flex-wrap: wrap;
		padding: 10px;
		gap: 4px;
	}
	.nav-left {
		width: 100%;
		flex-wrap: wrap;
	}
	.nav-right {
		width: 100%;
		justify-content: center;
		margin-top: 4px;
	}
	.logo-tab {
		width: 100%;
		justify-content: center;
		border-radius: 6px;
		height: 42px;
	}
	.tab 
	{
		flex: 1;
		min-width: calc(50% - 4px);
		border-radius: 6px;
		height: 42px;
		justify-content: center;
	}
	
	.tab.active 
	{
		height: 42px;
	}
	
	.tab.active::before, .tab.active::after 
	{
		display: none;
	}
	
	.login-btn 
	{
		width: 100%;
		justify-content: center;
	}
}
</style>
</head>
<body>
	
	
	<nav class="navbar">
		<div class="nav-left">
			<div class="logo-tab">
				<span class="logo-icon">
				<a href="?page=main" class="tab <%= "main".equals(currentPage) ? "active" : "" %>"> 로고 들어갈 자리</a>
				</span>
			</div>
			<a href="Notice.jsp" class="tab <%= "Notice".equals(currentPage) ? "active" : "" %>">공지사항</a>
			<a href="?page=groups" class="tab <%= "groups".equals(currentPage) ? "active" : "" %>">모임구경</a>
			<a href="?page=creategroup" class="tab <%= "creategroup".equals(currentPage) ? "active" : "" %>">모임 개설</a>
			<a href="?page=mygroups" class="tab <%= "mygroups".equals(currentPage) ? "active" : "" %>">내 모임</a>
		</div>
		<div class="nav-right">
			<a href="../login/UserLogin.jsp" class="login-btn">
				<span>🔐</span>
				<span>로그인</span>
			</a>
		</div>
	</nav>
	
</body>
</html>