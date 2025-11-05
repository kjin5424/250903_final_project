<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String cp = request.getContextPath();
%>
<%
	// 에러 메시지 파라미터 받기
	String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=cp%>/css/cssAuthorization/Login.css">
<script type="text/javascript" src="<%=cp%>/js/jsAuthorization/Login.js"></script>
<title>로그인 - 공모자들</title>
</head>
<body>

	<div class="login-container">
		<div class="logo-section">
			<div class="logo">🤝</div>
			<h1 class="logo-title">공모자들</h1>
			<p class="logo-subtitle">함께 모이는 즐거움</p>
		</div>

		<div class="login-box">
			<h2 class="login-title">로그인</h2>

			<div class='error-message <%=(error != null ? "show" : "")%>'>
				<span class="error-text"><%=(error != null) ? " 아이디 혹은 비밀번호가 잘못됐습니다." : ""%></span>
				<span class="error-close" onclick="closeErrorMessage()">×</span>
			</div>

			<form action="login.do" id="loginForm" method="post"
				onsubmit="return validateLogin(event)">
				<div class="form-group">
					<label class="form-label" for="userId">아이디</label>
					<div class="form-input-wrapper">
						<input type="text" id="userId" name="userId" class="form-input"
							placeholder="아이디를 입력하세요" autocomplete="username" required>
						<span class="input-icon">👤</span>
					</div>
				</div>

				<div class="form-group">
					<label class="form-label" for="password">비밀번호</label>
					<div class="form-input-wrapper">
						<input type="password" id="password" name="password"
							class="form-input" placeholder="비밀번호를 입력하세요"
							autocomplete="current-password" required> <span
							class="input-icon">🔒</span>
					</div>
				</div>

				<div class="form-options">
					<label class="checkbox-wrapper"> <input type="checkbox"
						id="rememberMe" name="rememberMe" class="checkbox-input">
						<span class="checkbox-label">로그인 상태 유지</span>
					</label>
					<div class="find-links">
						<a href="findidpage.do" class="find-link">아이디 찾기</a> <span
							class="divider">|</span> <a href="findpwpage.do"
							class="find-link">비밀번호 찾기</a>
					</div>
				</div>

				<button type="submit" class="btn-login">로그인</button>
			</form>

			<div class="signup-section">
				아직 회원이 아니신가요? <a href="signuppage.do" class="signup-link">회원가입</a>
			</div>
			
		</div><!-- .login-box -->
	</div><!-- login-container -->
	
</body>
</html>