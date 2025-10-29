<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 - 공모자들</title>
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
	padding: 40px 20px;
}

.signup-container {
	max-width: 600px;
	margin: 0 auto;
}

.header {
	text-align: center;
	margin-bottom: 40px;
}

.logo {
	font-size: 50px;
	margin-bottom: 15px;
}

.page-title {
	font-size: 32px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 8px;
}

.page-subtitle {
	font-size: 15px;
	color: #666;
}

.signup-box {
	background: white;
	border-radius: 16px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	padding: 40px;
}

.form-group {
	margin-bottom: 24px;
}

.form-label {
	display: block;
	font-size: 14px;
	font-weight: 600;
	color: #333;
	margin-bottom: 8px;
}

.required {
	color: #ff6b6b;
	margin-left: 4px;
}

.input-with-button {
	display: flex;
	gap: 10px;
}

.form-input {
	flex: 1;
	padding: 12px 16px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	font-family: inherit;
	transition: all 0.2s ease;
}

.form-input:focus {
	outline: none;
	border-color: #a8d5a1;
	box-shadow: 0 0 0 3px rgba(168, 213, 161, 0.1);
}

.form-input:disabled {
	background: #f5f5f5;
	cursor: not-allowed;
}

.form-input.error {
	border-color: #ff6b6b;
}

.form-input.success {
	border-color: #4caf50;
}

.btn-check {
	padding: 12px 20px;
	background: #8bc683;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
	white-space: nowrap;
}

.btn-check:hover {
	background: #7ab872;
}

.btn-check:disabled {
	background: #ccc;
	cursor: not-allowed;
}

.btn-address {
	padding: 12px 20px;
	background: #2d5a29;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
	white-space: nowrap;
}

.btn-address:hover {
	background: #1f4019;
}

.btn-random {
	padding: 12px 20px;
	background: #ffc107;
	color: #333;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
	white-space: nowrap;
}

.btn-random:hover {
	background: #ffb300;
}

.form-help {
	font-size: 12px;
	color: #666;
	margin-top: 6px;
	line-height: 1.5;
}

.form-help.error {
	color: #ff6b6b;
}

.form-help.success {
	color: #4caf50;
}

.ssn-input-group {
	display: flex;
	align-items: center;
	gap: 10px;
}

.ssn-input {
	flex: 1;
}

.ssn-divider {
	font-size: 18px;
	font-weight: bold;
	color: #999;
}

.password-strength {
	margin-top: 8px;
}

.strength-bar {
	height: 6px;
	background: #e0e0e0;
	border-radius: 3px;
	overflow: hidden;
	margin-bottom: 6px;
}

.strength-fill {
	height: 100%;
	width: 0;
	transition: all 0.3s ease;
	border-radius: 3px;
}

.strength-fill.weak {
	width: 33%;
	background: #ff6b6b;
}

.strength-fill.medium {
	width: 66%;
	background: #ffc107;
}

.strength-fill.strong {
	width: 100%;
	background: #4caf50;
}

.strength-text {
	font-size: 12px;
	color: #666;
}

.terms-section {
	background: #f8faf9;
	border: 2px solid #e8f5e6;
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 24px;
}

.terms-title {
	font-weight: 600;
	color: #333;
	margin-bottom: 12px;
}

.term-item {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 10px;
}

.term-checkbox {
	width: 18px;
	height: 18px;
	cursor: pointer;
	accent-color: #2d5a29;
}

.term-label {
	font-size: 14px;
	color: #333;
	cursor: pointer;
	user-select: none;
}

.term-link {
	color: #2d5a29;
	text-decoration: none;
	margin-left: 6px;
}

.term-link:hover {
	text-decoration: underline;
}

.btn-submit {
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
	margin-top: 10px;
}

.btn-submit:hover {
	background: #1f4019;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(45, 90, 41, 0.3);
}

.btn-submit:disabled {
	background: #ccc;
	cursor: not-allowed;
	transform: none;
}

.login-link-section {
	text-align: center;
	margin-top: 24px;
	font-size: 14px;
	color: #666;
}

.login-link {
	color: #2d5a29;
	font-weight: 600;
	text-decoration: none;
	margin-left: 6px;
}

.login-link:hover {
	text-decoration: underline;
}

/* 반응형 */
@media (max-width: 768px) {
	.signup-box {
		padding: 30px 24px;
	}
	
	.input-with-button {
		flex-direction: column;
	}
	
	.btn-check,
	.btn-address,
	.btn-random {
		width: 100%;
	}
}
</style>
</head>
<body>
	<div class="signup-container">
		<div class="header">
			<div class="logo">🤝</div>
			<h1 class="page-title">회원가입</h1>
			<p class="page-subtitle">공모자들과 함께 시작하세요</p>
		</div>
		
		<div class="signup-box">
			<form id="signupForm" onsubmit="return validateSignup(event)">
				<!-- 아이디 -->
				<div class="form-group">
					<label class="form-label">
						아이디<span class="required">*</span>
					</label>
					<div class="input-with-button">
						<input 
							type="text" 
							id="userId" 
							name="userId" 
							class="form-input" 
							placeholder="4-20자의 영문, 숫자"
							maxlength="20"
							required
						>
						<button type="button" class="btn-check" onclick="checkUserIdDuplicate()">
							중복확인
						</button>
					</div>
					<p class="form-help" id="userIdHelp">영문, 숫자 조합 4-20자</p>
				</div>
				
				<!-- 비밀번호 -->
				<div class="form-group">
					<label class="form-label">
						비밀번호<span class="required">*</span>
					</label>
					<input 
						type="password" 
						id="password" 
						name="password" 
						class="form-input" 
						placeholder="8-20자의 영문, 숫자, 특수문자(!)"
						maxlength="20"
						required
					>
					<div class="password-strength" id="passwordStrength" style="display: none;">
						<div class="strength-bar">
							<div class="strength-fill" id="strengthFill"></div>
						</div>
						<p class="strength-text" id="strengthText"></p>
					</div>
					<p class="form-help">영문, 숫자, 특수문자(!) 조합 8-20자</p>
				</div>
				
				<!-- 비밀번호 확인 -->
				<div class="form-group">
					<label class="form-label">
						비밀번호 확인<span class="required">*</span>
					</label>
					<input 
						type="password" 
						id="passwordConfirm" 
						name="passwordConfirm" 
						class="form-input" 
						placeholder="비밀번호를 다시 입력하세요"
						maxlength="20"
						required
					>
					<p class="form-help" id="passwordConfirmHelp"></p>
				</div>
				
				<!-- 닉네임 -->
				<div class="form-group">
					<label class="form-label">
						닉네임<span class="required">*</span>
					</label>
					<div class="input-with-button">
						<input 
							type="text" 
							id="nickname" 
							name="nickname" 
							class="form-input" 
							placeholder="2-12자의 닉네임"
							maxlength="12"
							required
						>
						<button type="button" class="btn-random" onclick="generateRandomNickname()">
							🎲 랜덤생성
						</button>
						<button type="button" class="btn-check" onclick="checkNicknameDuplicate()">
							중복확인
						</button>
					</div>
					<p class="form-help" id="nicknameHelp">2-12자의 한글, 영문, 숫자</p>
				</div>
				
				<!-- 이메일 -->
				<div class="form-group">
					<label class="form-label">
						이메일<span class="required">*</span>
					</label>
					<input 
						type="email" 
						id="email" 
						name="email" 
						class="form-input" 
						placeholder="example@email.com"
						required
					>
					<p class="form-help" id="emailHelp">이메일 형식으로 입력해주세요</p>
				</div>
				
				<!-- 이름 -->
				<div class="form-group">
					<label class="form-label">
						이름<span class="required">*</span>
					</label>
					<input 
						type="text" 
						id="userName" 
						name="userName" 
						class="form-input" 
						placeholder="실명을 입력하세요"
						required
					>
				</div>
				
				<!-- 주민등록번호 -->
				<div class="form-group">
					<label class="form-label">
						주민등록번호<span class="required">*</span>
					</label>
					<div class="ssn-input-group">
						<input 
							type="text" 
							id="ssnFront" 
							name="ssnFront" 
							class="form-input ssn-input" 
							placeholder="000000"
							maxlength="6"
							pattern="[0-9]{6}"
							required
						>
						<span class="ssn-divider">-</span>
						<input 
							type="password" 
							id="ssnBack" 
							name="ssnBack" 
							class="form-input ssn-input" 
							placeholder="0000000"
							maxlength="7"
							pattern="[0-9]{7}"
							required
						>
					</div>
					<p class="form-help" id="ssnHelp">주민등록번호는 안전하게 암호화되어 저장됩니다</p>
				</div>
				
				<!-- 주소 -->
				<div class="form-group">
					<label class="form-label">
						주소<span class="required">*</span>
					</label>
					<div class="input-with-button">
						<input 
							type="text" 
							id="address" 
							name="address" 
							class="form-input" 
							placeholder="주소 검색 버튼을 클릭하세요"
							readonly
							required
						>
						<button type="button" class="btn-address" onclick="openAddressPopup()">
							🔍 주소검색
						</button>
					</div>
				</div>
				
				<!-- 약관 동의 -->
				<div class="terms-section">
					<div class="terms-title">약관 동의</div>
					<div class="term-item">
						<input 
							type="checkbox" 
							id="agreeAll" 
							class="term-checkbox"
							onchange="toggleAllTerms(this)"
						>
						<label for="agreeAll" class="term-label">전체 동의</label>
					</div>
					<hr style="margin: 10px 0; border: none; border-top: 1px solid #e0e0e0;">
					<div class="term-item">
						<input 
							type="checkbox" 
							id="agreeService" 
							class="term-checkbox"
							onchange="updateAgreeAll()"
							required
						>
						<label for="agreeService" class="term-label">
							[필수] 이용약관 동의
							<a href="#" class="term-link" onclick="showTerms('service'); return false;">보기</a>
						</label>
					</div>
					<div class="term-item">
						<input 
							type="checkbox" 
							id="agreePrivacy" 
							class="term-checkbox"
							onchange="updateAgreeAll()"
							required
						>
						<label for="agreePrivacy" class="term-label">
							[필수] 개인정보 수집 및 이용 동의
							<a href="#" class="term-link" onclick="showTerms('privacy'); return false;">보기</a>
						</label>
					</div>
					<div class="term-item">
						<input 
							type="checkbox" 
							id="agreeMarketing" 
							class="term-checkbox"
							onchange="updateAgreeAll()"
						>
						<label for="agreeMarketing" class="term-label">
							[선택] 마케팅 정보 수신 동의
						</label>
					</div>
				</div>
				
				<button type="submit" class="btn-submit" id="submitBtn" disabled>
					회원가입
				</button>
			</form>
			
			<div class="login-link-section">
				이미 계정이 있으신가요?
				<a href="loginpage.do" class="login-link">로그인</a>
			</div>
		</div>
	</div>
	
	<script>
		// 중복 확인 상태 추적
		let userIdChecked = false;
		let nicknameChecked = false;
		
		// 아이디 중복 확인
		function checkUserIdDuplicate() {
			const userId = document.getElementById('userId').value.trim();
			const help = document.getElementById('userIdHelp');
			const input = document.getElementById('userId');
			
			if (!userId) {
				alert('아이디를 입력해주세요.');
				return;
			}
			
			// 아이디 형식 검증
			const idPattern = /^[a-zA-Z0-9]{4,20}$/;
			if (!idPattern.test(userId)) {
				help.textContent = '아이디는 4-20자의 영문, 숫자만 사용 가능합니다.';
				help.className = 'form-help error';
				input.classList.add('error');
				return;
			}
			
			// 서버로 중복 확인 요청 (자바에서 구현 예정)
			// TODO: 서버 API 호출
			
			// 임시 처리
			if (userId === 'test') {
				help.textContent = '이미 사용 중인 아이디입니다.';
				help.className = 'form-help error';
				input.classList.add('error');
				input.classList.remove('success');
				userIdChecked = false;
			} else {
				help.textContent = '사용 가능한 아이디입니다.';
				help.className = 'form-help success';
				input.classList.remove('error');
				input.classList.add('success');
				userIdChecked = true;
			}
			
			checkFormValid();
		}
		
		// 닉네임 중복 확인
		function checkNicknameDuplicate() {
			const nickname = document.getElementById('nickname').value.trim();
			const help = document.getElementById('nicknameHelp');
			const input = document.getElementById('nickname');
			
			if (!nickname) {
				alert('닉네임을 입력해주세요.');
				return;
			}
			
			// 닉네임 형식 검증
			const nicknamePattern = /^[가-힣a-zA-Z0-9]{2,12}$/;
			if (!nicknamePattern.test(nickname)) {
				help.textContent = '닉네임은 2-12자의 한글, 영문, 숫자만 사용 가능합니다.';
				help.className = 'form-help error';
				input.classList.add('error');
				return;
			}
			
			// 서버로 중복 확인 요청 (자바에서 구현 예정)
			// TODO: 서버 API 호출
			
			// 임시 처리
			help.textContent = '사용 가능한 닉네임입니다.';
			help.className = 'form-help success';
			input.classList.remove('error');
			input.classList.add('success');
			nicknameChecked = true;
			
			checkFormValid();
		}
		
		// 랜덤 닉네임 생성
		function generateRandomNickname() {
			const adjectives = ['행복한', '즐거운', '신나는', '활기찬', '밝은', '재밌는', '멋진'];
			const nouns = ['토끼', '고양이', '강아지', '판다', '코알라', '펭귄', '여우'];
			const numbers = Math.floor(Math.random() * 100);
			
			const randomNickname = adjectives[Math.floor(Math.random() * adjectives.length)] + 
			                       nouns[Math.floor(Math.random() * nouns.length)] + 
			                       numbers;
			
			document.getElementById('nickname').value = randomNickname;
			nicknameChecked = false;
			document.getElementById('nickname').classList.remove('success', 'error');
			document.getElementById('nicknameHelp').textContent = '중복 확인을 해주세요.';
			document.getElementById('nicknameHelp').className = 'form-help';
		}
		
		// 비밀번호 강도 체크
		document.getElementById('password').addEventListener('input', function() {
			const password = this.value;
			const strengthDiv = document.getElementById('passwordStrength');
			const fill = document.getElementById('strengthFill');
			const text = document.getElementById('strengthText');
			
			if (password.length === 0) {
				strengthDiv.style.display = 'none';
				return;
			}
			
			strengthDiv.style.display = 'block';
			
			// 비밀번호 유효성 검사 (영문, 숫자, ! 만 허용)
			const validPattern = /^[a-zA-Z0-9!]*$/;
			if (!validPattern.test(password)) {
				text.textContent = '영문, 숫자, 특수문자(!)만 사용 가능합니다.';
				fill.className = 'strength-fill';
				return;
			}
			
			let strength = 0;
			if (password.length >= 8) strength++;
			if (/[a-zA-Z]/.test(password)) strength++;
			if (/[0-9]/.test(password)) strength++;
			if (/[!]/.test(password)) strength++;
			
			fill.className = 'strength-fill';
			if (strength <= 2) {
				fill.classList.add('weak');
				text.textContent = '약함';
			} else if (strength === 3) {
				fill.classList.add('medium');
				text.textContent = '보통';
			} else {
				fill.classList.add('strong');
				text.textContent = '강함';
			}
		});
		
		// 비밀번호 확인
		document.getElementById('passwordConfirm').addEventListener('input', function() {
			const password = document.getElementById('password').value;
			const passwordConfirm = this.value;
			const help = document.getElementById('passwordConfirmHelp');
			
			if (passwordConfirm.length === 0) {
				help.textContent = '';
				this.classList.remove('error', 'success');
				return;
			}
			
			if (password === passwordConfirm) {
				help.textContent = '비밀번호가 일치합니다.';
				help.className = 'form-help success';
				this.classList.remove('error');
				this.classList.add('success');
			} else {
				help.textContent = '비밀번호가 일치하지 않습니다.';
				help.className = 'form-help error';
				this.classList.remove('success');
				this.classList.add('error');
			}
		});
		
		// 이메일 유효성 및 중복 검사
		document.getElementById('email').addEventListener('blur', function() {
			const email = this.value.trim();
			const help = document.getElementById('emailHelp');
			
			if (!email) return;
			
			const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
			if (!emailPattern.test(email)) {
				help.textContent = '올바른 이메일 형식이 아닙니다.';
				help.className = 'form-help error';
				this.classList.add('error');
				return;
			}
			
			// 서버로 중복 확인 요청 (자바에서 구현 예정)
			// TODO: 이메일 중복 확인 API 호출
			// 만약 중복이면 아이디 찾기 페이지로 이동 여부 물어보기
			
			this.classList.remove('error');
			help.textContent = '사용 가능한 이메일입니다.';
			help.className = 'form-help success';
		});
		
		// 주민등록번호 유효성 검사
		document.getElementById('ssnBack').addEventListener('blur', function() {
			const ssnFront = document.getElementById('ssnFront').value;
			const ssnBack = this.value;
			const help = document.getElementById('ssnHelp');
			
			if (ssnFront.length !== 6 || ssnBack.length !== 7) {
				help.textContent = '주민등록번호를 정확히 입력해주세요.';
				help.className = 'form-help error';
				return;
			}
			
			// 서버로 중복 확인 요청 (자바에서 구현 예정)
			// TODO: 주민등록번호 중복 확인 API 호출
			// 만약 중복이면 아이디 찾기 페이지로 이동 여부 물어보기
			
			help.textContent = '주민등록번호는 안전하게 암호화되어 저장됩니다.';
			help.className = 'form-help';
		});
		
		// 주소 검색 팝업
		function openAddressPopup() {
			const popup = window.open(
				'<%=cp %>/common/AddressPopup.jsp',
				'addressPopup',
				'width=500,height=600,scrollbars=yes,resizable=yes'
			);
			popup.focus();
		}
		
		// 주소 팝업에서 호출할 함수
		function setAddress(address) {
			document.getElementById('address').value = address;
		}
		
		// 약관 전체 동의
		function toggleAllTerms(checkbox) {
			const checkboxes = ['agreeService', 'agreePrivacy', 'agreeMarketing'];
			checkboxes.forEach(id => {
				document.getElementById(id).checked = checkbox.checked;
			});
			checkFormValid();
		}
		
		// 약관 개별 체크시 전체 동의 업데이트
		function updateAgreeAll() {
			const service = document.getElementById('agreeService').checked;
			const privacy = document.getElementById('agreePrivacy').checked;
			const marketing = document.getElementById('agreeMarketing').checked;
			
			document.getElementById('agreeAll').checked = service && privacy && marketing;
			checkFormValid();
		}
		
		// 약관 보기
		function showTerms(type) {
			const title = type === 'service' ? '이용약관' : '개인정보 처리방침';
			alert(title + ' 내용을 보여줄 팝업 (구현 예정)');
		}
		
		// 폼 유효성 전체 체크
		function checkFormValid() {
			const service = document.getElementById('agreeService').checked;
			const privacy = document.getElementById('agreePrivacy').checked;
			const submitBtn = document.getElementById('submitBtn');
			
			// 필수 약관과 중복확인이 모두 완료되었는지 체크
			if (userIdChecked && nicknameChecked && service && privacy) {
				submitBtn.disabled = false;
			} else {
				submitBtn.disabled = true;
			}
		}
		
		// 아이디/닉네임 변경시 중복확인 상태 초기화
		document.getElementById('userId').addEventListener('input', function() {
			userIdChecked = false;
			this.classList.remove('success', 'error');
			document.getElementById('userIdHelp').textContent = '영문, 숫자 조합 4-20자';
			document.getElementById('userIdHelp').className = 'form-help';
			checkFormValid();
		});
		
		document.getElementById('nickname').addEventListener('input', function() {
			nicknameChecked = false;
			this.classList.remove('success', 'error');
			document.getElementById('nicknameHelp').textContent = '2-12자의 한글, 영문, 숫자';
			document.getElementById('nicknameHelp').className = 'form-help';
			checkFormValid();
		});
		
		// 회원가입 폼 제출
		function validateSignup(event) {
			event.preventDefault();
			
			// 최종 유효성 검사
			const password = document.getElementById('password').value;
			const passwordConfirm = document.getElementById('passwordConfirm').value;
			const ssnFront = document.getElementById('ssnFront').value;
			const ssnBack = document.getElementById('ssnBack').value;
			const address = document.getElementById('address').value;
			
			// 비밀번호 유효성
			const passwordPattern = /^[a-zA-Z0-9!]{8,20}$/;
			if (!passwordPattern.test(password)) {
				alert('비밀번호는 8-20자의 영문, 숫자, 특수문자(!)만 사용 가능합니다.');
				return false;
			}
			
			if (password !== passwordConfirm) {
				alert('비밀번호가 일치하지 않습니다.');
				return false;
			}
			
			// 주민등록번호 유효성
			if (ssnFront.length !== 6 || ssnBack.length !== 7) {
				alert('주민등록번호를 정확히 입력해주세요.');
				return false;
			}
			
			// 주소 확인
			if (!address) {
				alert('주소를 입력해주세요.');
				return false;
			}
			
			// 중복확인 체크
			if (!userIdChecked) {
				alert('아이디 중복확인을 해주세요.');
				return false;
			}
			
			if (!nicknameChecked) {
				alert('닉네임 중복확인을 해주세요.');
				return false;
			}
			
			// 필수 약관 확인
			const service = document.getElementById('agreeService').checked;
			const privacy = document.getElementById('agreePrivacy').checked;
			
			if (!service || !privacy) {
				alert('필수 약관에 동의해주세요.');
				return false;
			}
			
			// 모든 검증 통과 - 서버로 전송
			if (confirm('회원가입을 진행하시겠습니까?')) {
				// 실제로는 서버로 데이터 전송
				submitSignup();
			}
			
			return false;
		}
		
		// 회원가입 처리
		function submitSignup() {
			// 서버로 회원가입 데이터 전송 (자바에서 구현 예정)
			// TODO: 회원가입 API 호출
			
			const formData = {
				userId: document.getElementById('userId').value,
				password: document.getElementById('password').value,
				nickname: document.getElementById('nickname').value,
				email: document.getElementById('email').value,
				userName: document.getElementById('userName').value,
				ssnFront: document.getElementById('ssnFront').value,
				ssnBack: document.getElementById('ssnBack').value,
				address: document.getElementById('address').value,
				marketing: document.getElementById('agreeMarketing').checked
			};
			
			console.log('회원가입 데이터:', formData);
			
			alert('회원가입이 완료되었습니다!');
			window.location.href = '<%=cp %>/user/login/UserLogin.jsp';
		}
	</script>
</body>
</html>