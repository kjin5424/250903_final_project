<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디찾기 - 공모자들</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, #f5f7fa 0%, #e8f5e6 100%);
	min-height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 20px;
}

.login-container {
	width: 100%;
	max-width: 440px;
}

.logo-section {
	text-align: center;
	margin-bottom: 40px;
}

.logo {
	font-size: 60px;
	margin-bottom: 20px;
	animation: bounce 2s ease-in-out infinite;
}

@
keyframes bounce { 0%, 100% {
	transform: translateY(0);
}

50%
{
transform


:

 

translateY


(-10
px
);


	

}
}
.logo-title {
	font-size: 32px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 8px;
}

.logo-subtitle {
	font-size: 15px;
	color: #666;
}

.login-box {
	background: white;
	border-radius: 16px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	padding: 40px;
}

.login-title {
	font-size: 24px;
	font-weight: bold;
	color: #333;
	margin-bottom: 30px;
	text-align: center;
}

.form-group {
	margin-bottom: 20px;
}

.form-label {
	display: block;
	font-size: 14px;
	font-weight: 600;
	color: #333;
	margin-bottom: 8px;
}

.form-input-wrapper {
	position: relative;
}

.form-input {
	width: 100%;
	padding: 14px 16px;
	padding-left: 45px;
	border: 2px solid #e0e0e0;
	border-radius: 10px;
	font-size: 15px;
	font-family: inherit;
	transition: all 0.2s ease;
}

.form-input:focus {
	outline: none;
	border-color: #a8d5a1;
	box-shadow: 0 0 0 3px rgba(168, 213, 161, 0.1);
}

.input-icon {
	position: absolute;
	left: 16px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 18px;
	color: #999;
}

.form-input:focus+.input-icon {
	color: #2d5a29;
}

.form-options {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 24px;
}

.checkbox-wrapper {
	display: flex;
	align-items: center;
	gap: 8px;
}

.divider {
	color: #ddd;
}

.btn-login {
	width: 100%;
	padding: 16px;
	background: #2d5a29;
	color: white;
	border: none;
	border-radius: 10px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	margin-bottom: 16px;
}

.btn-login:hover {
	background: #1f4019;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(45, 90, 41, 0.3);
}

.btn-login:active {
	transform: translateY(0);
}

.social-login {
	margin-top: 30px;
	padding-top: 30px;
	border-top: 1px solid #e0e0e0;
}

.social-login-title {
	text-align: center;
	font-size: 14px;
	color: #999;
	margin-bottom: 20px;
}

.find-links {
	display: flex;
	gap: 12px;
	font-size: 14px;
}

.find-link {
	color: #666;
	text-decoration: none;
	transition: color 0.2s ease;
}

.find-link:hover {
	color: #2d5a29;
}



.signup-section {
	text-align: center;
	margin-top: 24px;
	font-size: 14px;
	color: #666;
}

.signup-link {
	color: #2d5a29;
	font-weight: 600;
	text-decoration: none;
	margin-left: 6px;
	transition: color 0.2s ease;
}

.signup-link:hover {
	color: #1f4019;
	text-decoration: underline;
}

.error-message {
	background: #ffebee;
	border-left: 4px solid #ff6b6b;
	padding: 12px 16px;
	border-radius: 8px;
	padding: 12px 40px 12px 16px; /* 오른쪽 공간 확보 */
	margin-bottom: 20px;
	font-size: 14px;
	color: #d32f2f;
	display: none;
	position: relative;
}

.error-message.show {
	display: block;
	animation: shake 0.5s ease;
}

.error-close {
	position: absolute;
	right: 12px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 18px;
	color: #d32f2f;
	cursor: pointer;
	font-weight: bold;
	transition: color 0.2s ease;
}

.error-close:hover {
	color: #a30000;
}

@
keyframes shake { 0%, 100% {
	transform: translateX(0);
}

25%
{
transform
:
translateX


(-10
px
);

 

}
75%
{
transform


:

 

translateX


(10
px
);

 

}
}

/* 반응형 */
@media ( max-width : 480px) {
	.login-box {
		padding: 30px 24px;
	}
	.logo-title {
		font-size: 28px;
	}
	.social-buttons {
		flex-direction: column;
	}
	.form-options {
		flex-direction: column;
		align-items: flex-start;
		gap: 12px;
	}
}
</style>
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
						<a href="UserLogin.jsp" class="find-link">로그인</a> <span
							class="divider">|</span> <a href="FindUserPassword.jsp"
							class="find-link">비밀번호 찾기</a>
					</div>
				</div>

				<button type="submit" class="btn-login">이메일로 아이디 전송</button>
			</form>

			<div class="signup-section">
				아직 회원이 아니신가요? <a href="signup.jsp" class="signup-link">회원가입</a>
			</div>
		</div>
	</div>

	<script>
		// 아이디 찾기 폼 유효성 검사
		function validateLogin(event) {
			if (event) {
				event.preventDefault();
			}

			const userEmail = document.getElementById('userEmail').value.trim();
			const errorMsg = document.querySelector('.error-message');

			if (userEmail == "") {
				showError('아이디와 비밀번호를 모두 입력해주세요.');
				return false;
			}

			// 아이디 찾기 
			processFindUserEmail(userEmail);

			return false;
		}

		// 에러 메시지 표시
		function showError(message) {
			const errorMsg = document.querySelector('.error-message');
			const errorText = document.querySelector('.error-text');
			
			errorText.textContent = '⚠️ ' + message;
			errorMsg.classList.add('show');
		}

		// 에러 메시지 제거
		function closeErrorMessage() {
			const errorMsg = document.querySelector('.error-message');
			errorMsg.classList.remove('show');
		}

		// 아이디 찾기 처리
		function processFindUserEmail(userEmail) {

			// 일반 사용자 아이디찾기
			if (userEmail === 'user123@gmail.com') {
				alert('이메일로 아이디 전송 완료!');
				window.location.href = 'UserLogin.jsp';
				return;
			}

			// 이메일 검증 실패
			showError('올바르지 않은 이메일입니다.');
		}

		// Enter 키 처리
		document.getElementById('userEmail').addEventListener(
		'keypress',
		function(e) {
			if (e.key === 'Enter') {
				document.getElementById('FindUserIdForm').dispatchEvent(
						new Event('submit'));
			}
		});

		// 페이지 로드시 이메일 입력란에 포커스
		window.addEventListener('load', function() {
			document.getElementById('userEmail').focus();
		});
	</script>
</body>
</html>