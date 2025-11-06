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
<link rel="stylesheet" href="<%=cp%>/css/cssAuthorization/SignUp.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jsAuthorization/SignUp.js"></script>
<title>회원가입 - 공모자들</title>
</head>
<body>
	<div class="signup-container">
		<div class="header">
			<div class="logo">🤝</div>
			<h1 class="page-title">회원가입</h1>
			<p class="page-subtitle">공모자들과 함께 시작하세요</p>
		</div>

		<div class="signup-box">
			<form action="signUp.do" id="signupForm">
				<!-- 아이디 -->
				<div class="form-group">
					<label class="form-label"> 아이디<span class="required">*</span>
					</label>
					<div class="input-with-button">
						<input type="text" id="userId" name="userId" class="form-input"
							placeholder="4-20자의 영문, 숫자" maxlength="20" required>
						<button type="button" class="btn-check" id="check-id">중복확인</button>
					</div>
					<p class="form-help" id="userIdHelp">영문, 숫자 조합 4-20자</p>
					<p class="form-help" id="validIdCheck"></p>
				</div>

				<!-- 비밀번호 -->
				<div class="form-group">
					<label class="form-label"> 비밀번호<span class="required">*</span>
					</label> <input type="password" id="password" name="password"
						class="form-input" placeholder="8-20자의 영문, 숫자, 특수문자(!)"
						maxlength="20" required>
					<div class="password-strength" id="passwordStrength"
						style="display: none;">
						<div class="strength-bar">
							<div class="strength-fill" id="strengthFill"></div>
						</div>
						<p class="strength-text" id="strengthText"></p>
					</div>
					<p class="form-help" id="password-help">영문, 숫자, 특수문자(~,!,@,#,$) 조합 8-20자</p>
				</div>

				<!-- 비밀번호 확인 -->
				<div class="form-group">
					<label class="form-label"> 비밀번호 확인<span class="required">*</span>
					</label> <input type="password" id="passwordConfirm" name="passwordConfirm"
						class="form-input" placeholder="비밀번호를 다시 입력하세요" maxlength="20"
						required>
					<p class="form-help" id="passwordConfirmHelp"></p>
				</div>

				<!-- 닉네임 -->
				<div class="form-group">
					<label class="form-label"> 닉네임<span class="required">*</span>
					</label>
					<div class="input-with-button">
						<input type="text" id="nickname" name="nickname"
							class="form-input" placeholder="2-12자의 닉네임" maxlength="12"
							required>
						<button type="button" class="btn-random"
							onclick="generateRandomNickname()">🎲 랜덤생성</button>
						<button type="button" class="btn-check" id="check-nickname">중복확인</button>
					</div>
					<p class="form-help" id="nicknameHelp">2-12자의 한글, 영문, 숫자</p>
					<p class="form-help" id="validNicknameCheck"></p>
				</div>

				<!-- 이메일 -->
				<div class="form-group">
					<label class="form-label"> 이메일<span class="required">*</span>
					</label> <input type="email" id="email" name="email" class="form-input"
						placeholder="example@email.com" required>
					<p class="form-help" id="emailHelp">이메일 형식으로 입력해주세요</p>
				</div>

				<!-- 이름 -->
				<div class="form-group">
					<label class="form-label"> 이름<span class="required">*</span>
					</label> <input type="text" id="userName" name="userName"
						class="form-input" placeholder="실명을 입력하세요" required>
					<p class="form-help" id="userNameHelp"></p>
				</div>

				<!-- 주민등록번호 -->
				<div class="form-group">
					<label class="form-label"> 주민등록번호<span class="required">*</span>
					</label>
					<div class="ssn-input-group">
						<input type="text" id="ssnFront" name="ssn1"
							class="form-input ssn-input" placeholder="000000" maxlength="6"
							pattern="[0-9]{6}" required> <span
							class="ssn-divider">-</span> <input type="password" id="ssnBack"
							name="ssn2" class="form-input ssn-input" placeholder="0000000"
							maxlength="7" pattern="[0-9]{7}" required>
					</div>
					<p class="form-help" id="ssnHelp">주민등록번호는 안전하게 암호화되어 저장됩니다</p>
				</div>

				<!-- 주소 -->
				<div class="form-group">
					<label class="form-label"> 주소<span class="required">*</span>
					</label>
					<input type="text" id="zipCode" name="zipCode" class="form-input"
						placeholder="우편번호" readonly required><br>
					
					<div class="input-with-button">
						<input type="text" id="address" name="address" class="form-input"
							placeholder="주소 검색 버튼을 클릭하세요" readonly required>
						<button type="button" class="btn-address" id="check-addr"
							>🔍 주소검색</button>
					</div>
				</div>

				<!-- 약관 동의 -->
				<div class="terms-section">
					<div class="terms-title">약관 동의</div>
					<div class="term-item">
						<input type="checkbox" id="agreeAll" class="term-checkbox"
							onchange="toggleAllTerms(this)"> <label
							for="agreeAll" class="term-label">전체 동의</label>
					</div>
					<hr
						style="margin: 10px 0; border: none; border-top: 1px solid #e0e0e0;">
					<div class="term-item">
						<input type="checkbox" id="agreeService" class="term-checkbox"
							onchange="updateAgreeAll()" required> <label
							for="agreeService" class="term-label"> [필수] 이용약관 동의 <a
							href="#" class="term-link"
							onclick="showTerms('service'); return false;">보기</a>
						</label>
					</div>
					<div class="term-item">
						<input type="checkbox" id="agreePrivacy" class="term-checkbox"
							onchange="updateAgreeAll()" required> <label
							for="agreePrivacy" class="term-label"> [필수] 개인정보 수집 및 이용
							동의 <a href="#" class="term-link"
							onclick="showTerms('privacy'); return false;">보기</a>
						</label>
					</div>
					<div class="term-item">
						<input type="checkbox" id="agreeMarketing" class="term-checkbox"
							onchange="updateAgreeAll()"> <label
							for="agreeMarketing" class="term-label"> [선택] 마케팅 정보 수신
							동의 </label>
					</div>
				</div>

				<button type="submit" class="btn-submit" id="submitBtn" disabled>
					회원가입</button>
			</form>

			<div class="login-link-section">
				이미 계정이 있으신가요? <a href="loginpage.do" class="login-link">로그인</a>
			</div>
		</div>
	</div>

</body>
</html>