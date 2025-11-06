<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=cp %>/css/cssAuthorization/FindUserId.css">
<script type="text/javascript" src="<%=cp%>/js/jsAuthorization/FindUserId.js"></script>
<title>아이디찾기 - 공모자들</title>
</head>
<body>
	<%
		// 에러 메시지 파라미터 받기
		String error = request.getParameter("error");
		String errorMessage = "";

		if ("invalid".equals(error)) {
			errorMessage = "등록되지 않은 이메일입니다.";
		} else if ("required".equals(error)) {
			errorMessage = "이메일을 입력해주세요.";
		} else if ("session".equals(error)) {
			errorMessage = "세션이 만료되었습니다. 다시 로그인해주세요.";
		}
	%>

	<div class="login-container">
		<div class="logo-section">
			<div class="logo">🤝</div>
			<h1 class="logo-title">공모자들</h1>
			<p class="logo-subtitle">함께 모이는 즐거움</p>
		</div>

		<div class="login-box">
			<h2 class="login-title">아이디 찾기</h2>

			<div
				class='error-message <%=(error != null && !errorMessage.isEmpty()) ? "show" : ""%>'>
				<span class="error-text"><%=(error != null && !errorMessage.isEmpty()) ? "⚠️ " + errorMessage : ""%></span>
				<span class="error-close" onclick="closeErrorMessage()">×</span>
			</div>

			<form action="UserMain.jsp" id="FindUserIdForm"
				onsubmit="return validateLogin(event)">
				<div class="form-group">
					<label class="form-label" for="userEmail">이메일</label>
					<div class="form-input-wrapper">
						<input type="text" id="userEmail" name="userEmail" class="form-input"
							placeholder="가입시 등록한 이메일을 입력하세요" autocomplete="useremail" required>
						<span class="input-icon"><b>@</b></span>
					</div>
				</div>

				<div class="form-options">
					<div class="find-links">
						<a href="loginpage.do" class="find-link">로그인</a> <span
							class="divider">|</span> <a href="findpwpage.do"
							class="find-link">비밀번호 찾기</a>
					</div>
				</div>

				<button type="submit" class="btn-login">이메일로 아이디 전송</button>
			</form>

			<div class="signup-section">
				아직 회원이 아니신가요? <a href="signuppage.do" class="signup-link">회원가입</a>
			</div>
		</div>
	</div>

</body>
</html>