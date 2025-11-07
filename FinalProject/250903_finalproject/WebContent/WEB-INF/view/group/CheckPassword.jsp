<%@ page isELIgnored="false"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<%@ page language="java"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>공모자들 - 비공개 모임</title>
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
	text-decoration: none;
	display: flex;
	align-items: center;
}

.tab.active {
	background: #f5f7fa;
	color: #2d5a29;
	height: 40px;
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
	text-decoration: none;
	display: flex;
	align-items: center;
	gap: 6px;
}

.container {
	max-width: 600px;
	margin: 50px auto;
	padding: 0 20px;
}

.back-btn {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 10px 20px;
	background: white;
	border: 1px solid #ddd;
	border-radius: 8px;
	color: #666;
	cursor: pointer;
	margin-bottom: 20px;
	transition: all 0.2s;
	font-size: 14px;
}

.back-btn:hover {
	background: #f5f7fa;
	border-color: #8bc683;
	color: #2d5a29;
}

.password-card {
	background: white;
	border-radius: 12px;
	padding: 50px 40px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.lock-icon {
	width: 80px;
	height: 80px;
	background: linear-gradient(135deg, #8bc683 0%, #6ba562 100%);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 40px;
	margin: 0 auto 25px;
	box-shadow: 0 4px 12px rgba(139, 198, 131, 0.3);
}

.password-title {
	font-size: 24px;
	font-weight: bold;
	color: #2d5a29;
	text-align: center;
	margin-bottom: 10px;
}

.password-subtitle {
	font-size: 14px;
	color: #666;
	text-align: center;
	margin-bottom: 30px;
	line-height: 1.6;
}

.group-info-box {
	background: #f8faf8;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 30px;
	border-left: 4px solid #8bc683;
}

.group-name {
	font-size: 18px;
	font-weight: 600;
	color: #2d5a29;
	margin-bottom: 10px;
}

.group-meta {
	font-size: 13px;
	color: #666;
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
}

.badge {
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: 600;
	background: #e3f2fd;
	color: #1565c0;
}

.badge.category {
	background: #f3e5f5;
	color: #7b1fa2;
}

.form-group {
	margin-bottom: 25px;
}

.form-label {
	display: block;
	font-size: 14px;
	font-weight: 600;
	color: #333;
	margin-bottom: 10px;
}

.password-input-wrapper {
	position: relative;
}

.form-input {
	width: 100%;
	padding: 14px 45px 14px 15px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 15px;
	transition: all 0.3s;
	font-family: inherit;
}

.form-input:focus {
	outline: none;
	border-color: #8bc683;
	box-shadow: 0 0 0 3px rgba(139, 198, 131, 0.1);
}

.form-input.error {
	border-color: #f44336;
	animation: shake 0.5s;
}

@
keyframes shake { 0%, 100% {
	transform: translateX(0);
}

25%
{
transform


:translateX(-10px)


;
}
75%
{
transform


:translateX(10px)


;
}
}
.toggle-password {
	position: absolute;
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
	font-size: 18px;
	color: #999;
	user-select: none;
}

.toggle-password:hover {
	color: #2d5a29;
}

.error-message {
	color: #f44336;
	font-size: 13px;
	margin-top: 8px;
	display: none;
}

.error-message.show {
	display: block;
}

.button-group {
	display: flex;
	gap: 10px;
	margin-top: 25px;
}

.btn {
	flex: 1;
	padding: 14px 28px;
	border: none;
	border-radius: 8px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
}

.btn-primary {
	background: #4CAF50;
	color: white;
}

.btn-primary:hover {
	background: #45a049;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
}

.btn-primary:active {
	transform: translateY(0);
}

.btn-outline {
	background: white;
	color: #2d5a29;
	border: 2px solid #2d5a29;
}

.btn-outline:hover {
	background: #2d5a29;
	color: white;
}

.help-text {
	font-size: 12px;
	color: #999;
	text-align: center;
	margin-top: 20px;
	line-height: 1.6;
}

@media ( max-width :768px) {
	.container {
		margin: 30px auto;
	}
	.password-card {
		padding: 40px 25px;
	}
	.button-group {
		flex-direction: column;
	}
}
</style>

<script>
        function togglePassword() {
            const passwordInput = document.getElementById('passwordInput');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.textContent = '👁️';
            } else {
                passwordInput.type = 'password';
                toggleIcon.textContent = '👁️‍🗨️';
            }
        }

        function validatePassword() {
            const passwordInput = document.getElementById('passwordInput');
            const errorMessage = document.getElementById('errorMessage');
            const password = passwordInput.value.trim();
            const groupCode = '<%=request.getParameter("groupCode")%>';

            if (!password) {
                passwordInput.classList.add('error');
                errorMessage.textContent = '비밀번호를 입력해주세요.';
                errorMessage.classList.add('show');
                passwordInput.focus();
                return false;
            }

            // 서버로 비밀번호 검증 요청
            fetch('<%=cp%>/checkpassword.do', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'groupCode=' + encodeURIComponent(groupCode) + '&password=' + encodeURIComponent(password)
            })
            .then(response => response.json())
            .then(response => {
    // 응답 상태가 200 OK가 아니면 에러 처리 (선택 사항이지만 안전함)
    if (!response.ok) {
        throw new Error('HTTP status ' + response.status);
    }
    
    // 응답 텍스트를 먼저 확인
    return response.text().then(text => {
        console.log("Raw Response Text: ", text); // 👈 응답 원본 로그 출력
        
        try {
            return JSON.parse(text); // 텍스트를 JSON 객체로 수동 파싱 시도
        } catch (e) {
            console.error("JSON Parsing Error on Text:", text); // 👈 파싱 실패 시 원본 출력
            throw e; // 다시 catch 블록으로 에러 던짐
        }
    });
})
            .then(data => {
                if (data.success) {
                    // 비밀번호 일치 시 상세 페이지로 이동
                	window.location.href = '<%=cp%>/grouplistdetail.do?groupCode=' + groupCode;
                } else {
                    passwordInput.classList.add('error');
                    errorMessage.textContent = '비밀번호가 일치하지 않습니다.';
                    errorMessage.classList.add('show');
                    passwordInput.value = '';
                    passwordInput.focus();

                    setTimeout(() => {
                        passwordInput.classList.remove('error');
                    }, 500);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                errorMessage.textContent = '오류가 발생했습니다. 다시 시도해주세요.';
                errorMessage.classList.add('show');
            });
        }

        function goBack() {
            window.location.href = '<%=cp%>/mainpage.do';
        }

        document.addEventListener('DOMContentLoaded', function() {
            const passwordInput = document.getElementById('passwordInput');
            const errorMessage = document.getElementById('errorMessage');

            passwordInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    validatePassword();
                }
            });

            passwordInput.addEventListener('input', function() {
                passwordInput.classList.remove('error');
                errorMessage.classList.remove('show');
            });

            passwordInput.focus();
        });
        
    </script>
</head>
<body>
	<nav class="navbar">
		<div class="nav-left">
			<div class="logo-tab">
				<span>로고</span>
			</div>
			<a href="?page=notice" class="tab">공지사항</a> <a href="?page=groups"
				class="tab active">모임구경</a> <a href="?page=creategroup" class="tab">모임
				개설</a> <a href="?page=mygroups" class="tab">내 모임</a>
		</div>
		<div class="nav-right">
			<a href="login.jsp" class="login-btn">🔐 로그인</a>
		</div>
	</nav>

	<div class="container">
		<button class="back-btn" onclick="goBack()">← 모임q 목록으로</button>

		<div class="password-card">
			<div class="lock-icon">🔒</div>

			<h1 class="password-title">비공개 모임</h1>
			<p class="password-subtitle">
				이 모임은 비공개 모임입니다.<br> 비밀번호를 입력하여 모임 정보를 확인하세요.
			</p>

			<div class="group-info-box">
				<div class="group-name">📚 ${groupTitle}</div>
				<div class="group-meta">
					<span class="badge">🔒 비공개</span> <span class="badge category">${topic}</span>
				</div>
			</div>

			<form onsubmit="event.preventDefault(); validatePassword();">
				<div class="form-group">
					<label class="form-label" for="passwordInput">비밀번호</label>
					<div class="password-input-wrapper">
						<input type="password" id="passwordInput" class="form-input"
							placeholder="비밀번호를 입력하세요" autocomplete="off"> <span
							class="toggle-password" id="toggleIcon"
							onclick="togglePassword()">👁️‍🗨️</span>
					</div>
					<div class="error-message" id="errorMessage"></div>
				</div>

				<div class="button-group">
					<button type="submit" class="btn btn-primary">🔓 확인</button>
					<button type="button" class="btn btn-outline" onclick="goBack()">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
