<%@page import="com.test.mybatis.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	request.setAttribute("cp", cp); 
	
	UserDTO temp = (UserDTO)request.getAttribute("userDTO");
	
	int year = Integer.parseInt(temp.getSsn1().substring(0, 2));
	int month = Integer.parseInt(temp.getSsn1().substring(2, 4));
	int day = Integer.parseInt(temp.getSsn1().substring(4));
	int ssn2 = Integer.parseInt(temp.getSsn1().substring(0, 1));
	
	String[] createdDateArr = temp.getCreatedDate().split("-");
	String createdDate = createdDateArr[0] + "년 " + createdDateArr[1] + "월 " + createdDateArr[2] + "일";
	
	String birth = "";
	
	if(ssn2>2)
	{
		birth = "20" + year + "년 " + month + "월 " + day + "일";
	}
	else
	{
		birth = "19" + year + "년 " + month + "월 " + day + "일";
	}
	
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>프로필 - 공모자들</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: #f5f7fa;
	padding: 40px 20px;
}

.container {
	max-width: 1000px;
	margin: 0 auto;
}

.header {
	text-align: center;
	margin-bottom: 40px;
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

/* 비밀번호 확인 모달 오버레이 */
.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 1000;
}

.modal-overlay.hidden {
	display: none;
}

.password-modal {
	background: white;
	border-radius: 16px;
	padding: 40px;
	max-width: 400px;
	width: 90%;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.modal-title {
	font-size: 24px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 10px;
	text-align: center;
}

.modal-description {
	font-size: 14px;
	color: #666;
	text-align: center;
	margin-bottom: 30px;
	line-height: 1.6;
}

.modal-input {
	width: 100%;
	padding: 14px 16px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 15px;
	margin-bottom: 20px;
}

.modal-input:focus {
	outline: none;
	border-color: #a8d5a1;
}

.modal-buttons {
	display: flex;
	gap: 10px;
}

.modal-btn {
	flex: 1;
	padding: 14px;
	border: none;
	border-radius: 8px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
}

.modal-btn-cancel {
	background: #f0f0f0;
	color: #666;
}

.modal-btn-confirm {
	background: #2d5a29;
	color: white;
}

.modal-btn:hover {
	transform: translateY(-2px);
}

/* 탭 네비게이션 */
.tab-navigation {
	background: white;
	border-radius: 12px;
	padding: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	margin-bottom: 20px;
	display: flex;
	gap: 8px;
	overflow-x: auto;
}

.tab-btn {
	flex: 1;
	min-width: 120px;
	padding: 12px 20px;
	background: transparent;
	border: none;
	border-radius: 8px;
	font-size: 15px;
	font-weight: 600;
	color: #666;
	cursor: pointer;
	transition: all 0.2s ease;
	white-space: nowrap;
}

.tab-btn:hover {
	background: #f8faf9;
}

.tab-btn.active {
	background: #2d5a29;
	color: white;
}

/* 프로필 컨테이너 */
.profile-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	padding: 40px;
	display: none;
}

.profile-container.active {
	display: block;
}

/* 프로필 헤더 */
.profile-header {
	display: flex;
	align-items: center;
	gap: 30px;
	padding-bottom: 30px;
	border-bottom: 2px solid #f0f0f0;
	margin-bottom: 30px;
}

.profile-image-section {
	text-align: center;
}

.profile-image {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	background: linear-gradient(135deg, #a8d5a1, #8bc683);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 60px;
	margin-bottom: 15px;
	border: 4px solid #e8f5e6;
	position: relative;
	overflow: hidden;
}

.profile-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.image-upload-btn {
	display: flex;
	gap: 8px;
	justify-content: center;
}

.btn-small {
	padding: 6px 14px;
	border: none;
	border-radius: 6px;
	font-size: 13px;
	font-weight: 500;
	cursor: pointer;
	transition: all 0.2s ease;
}

.btn-upload {
	background: #8bc683;
	color: white;
}

.btn-delete {
	background: #ff6b6b;
	color: white;
}

.btn-small:hover {
	transform: translateY(-1px);
}

.profile-info-section {
	flex: 1;
}

.profile-name {
	font-size: 28px;
	font-weight: bold;
	color: #333;
	margin-bottom: 10px;
}

.profile-meta {
	display: flex;
	flex-direction: column;
	gap: 8px;
	font-size: 14px;
	color: #666;
}

/* 섹션 */
.section {
	margin-bottom: 40px;
}

.section-title {
	font-size: 20px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 20px;
	padding-bottom: 10px;
	border-bottom: 2px solid #e8f5e6;
}

.info-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
}

.info-item {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.info-label {
	font-size: 14px;
	font-weight: 600;
	color: #666;
}

.info-value {
	font-size: 15px;
	color: #333;
	padding: 12px 16px;
	background: #f8faf9;
	border-radius: 8px;
	border: 2px solid #e8f5e6;
}

.info-value.readonly {
	color: #999;
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

.btn-send {
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

.btn-send:hover {
	background: #1f4019;
}

.form-help {
	font-size: 12px;
	color: #666;
	margin-top: 6px;
}

.form-help.success {
	color: #4caf50;
}

.form-help.error {
	color: #ff6b6b;
}

/* 토글 스위치 */
.toggle-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 16px;
	background: #f8faf9;
	border-radius: 10px;
	border: 2px solid #e8f5e6;
	margin-bottom: 15px;
}

.toggle-info {
	flex: 1;
}

.toggle-title {
	font-size: 15px;
	font-weight: 600;
	color: #333;
	margin-bottom: 4px;
}

.toggle-description {
	font-size: 13px;
	color: #666;
}

.toggle-switch {
	position: relative;
	width: 56px;
	height: 28px;
}

.toggle-input {
	opacity: 0;
	width: 0;
	height: 0;
}

.toggle-slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	transition: .4s;
	border-radius: 28px;
}

.toggle-slider:before {
	position: absolute;
	content: "";
	height: 20px;
	width: 20px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	transition: .4s;
	border-radius: 50%;
}

.toggle-input:checked + .toggle-slider {
	background-color: #2d5a29;
}

.toggle-input:checked + .toggle-slider:before {
	transform: translateX(28px);
}

/* 프로필 미리보기 */
.preview-box {
	background: #fff9e6;
	border: 2px solid #ffc107;
	border-radius: 10px;
	padding: 20px;
	margin-top: 20px;
}

.preview-title {
	font-weight: 600;
	color: #f57c00;
	margin-bottom: 15px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.preview-content {
	background: white;
	padding: 20px;
	border-radius: 8px;
}

.preview-item {
	display: flex;
	justify-content: space-between;
	padding: 10px 0;
	border-bottom: 1px solid #f0f0f0;
}

.preview-item:last-child {
	border-bottom: none;
}

.preview-label {
	font-weight: 600;
	color: #666;
}

.preview-value {
	color: #333;
}

.preview-value.hidden {
	color: #999;
	font-style: italic;
}

/* 문의/탈퇴 버튼 */
.action-buttons {
	display: flex;
	gap: 12px;
	margin-top: 30px;
}

.btn-action {
	flex: 1;
	padding: 14px 24px;
	border: none;
	border-radius: 8px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
	text-decoration: none;
	text-align: center;
}

.btn-inquiry {
	background: #8bc683;
	color: white;
}

.btn-withdraw {
	background: #ff6b6b;
	color: white;
}

.btn-action:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

/* 저장 버튼 */
.save-button-container {
	text-align: center;
	margin-top: 40px;
	padding-top: 30px;
	border-top: 2px solid #f0f0f0;
}

.btn-save {
	padding: 16px 60px;
	background: #2d5a29;
	color: white;
	border: none;
	border-radius: 10px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
}

.btn-save:hover {
	background: #1f4019;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(45, 90, 41, 0.3);
}

/* 문의 내역 테이블 */
.inquiry-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

.inquiry-table th {
	background: #f8faf9;
	padding: 12px;
	text-align: left;
	font-weight: 600;
	color: #2d5a29;
	border-bottom: 2px solid #e8f5e6;
}

.inquiry-table td {
	padding: 12px;
	border-bottom: 1px solid #f0f0f0;
	color: #333;
}

.inquiry-status {
	display: inline-block;
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: 600;
}

.status-pending {
	background: #fff3e0;
	color: #f57c00;
}

.status-answered {
	background: #e8f5e9;
	color: #388e3c;
}

.btn-view {
	padding: 6px 14px;
	background: #8bc683;
	color: white;
	border: none;
	border-radius: 6px;
	font-size: 13px;
	font-weight: 500;
	cursor: pointer;
}

/* 회원탈퇴 섹션 */
.withdraw-section {
	background: #ffebee;
	border: 2px solid #ff6b6b;
	border-radius: 10px;
	padding: 30px;
	margin-top: 30px;
}

.withdraw-title {
	font-size: 20px;
	font-weight: bold;
	color: #d32f2f;
	margin-bottom: 15px;
}

.withdraw-warning {
	background: white;
	padding: 20px;
	border-radius: 8px;
	margin-bottom: 20px;
}

.warning-list {
	list-style: none;
	padding: 0;
}

.warning-list li {
	padding: 8px 0;
	color: #666;
	font-size: 14px;
}

.warning-list li::before {
	content: "⚠️ ";
	margin-right: 8px;
}

.withdraw-reason {
	margin-bottom: 20px;
}

.reason-options {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.reason-option {
	display: flex;
	align-items: center;
	gap: 10px;
	padding: 12px;
	background: white;
	border-radius: 8px;
	cursor: pointer;
}

.reason-option input[type="radio"] {
	width: 18px;
	height: 18px;
	cursor: pointer;
}

.btn-withdraw-confirm {
	width: 100%;
	padding: 16px;
	background: #d32f2f;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
}

.btn-withdraw-confirm:hover {
	background: #b71c1c;
}

/* 반응형 */
@media (max-width: 768px) {
	body {
		padding: 20px 10px;
	}
	
	.profile-header {
		flex-direction: column;
		text-align: center;
	}
	
	.info-grid {
		grid-template-columns: 1fr;
	}
	
	.input-with-button {
		flex-direction: column;
	}
	
	.btn-check,
	.btn-send {
		width: 100%;
	}
	
	.tab-navigation {
		overflow-x: auto;
	}
	
	.action-buttons {
		flex-direction: column;
	}
}
</style>
</head>
<body>
	<!-- 상단바 -->
	<%-- <div id="topMenu">
		<jsp:include page="/common/TopMenuBar.jsp" />
	</div>
	 --%>
	<%
		// 세션에서 사용자 정보 가져오기
		String userId = "user123"; // 실제로는 session.getAttribute()
		boolean isAuthenticated = false; // 비밀번호 확인 여부
		
		// 파라미터로 인증 상태 확인
		String auth = request.getParameter("auth");
		if ("true".equals(auth)) {
			isAuthenticated = true;
		}
	%>
	
	<!-- 비밀번호 확인 모달 -->
	<div class="modal-overlay <%= isAuthenticated ? "hidden" : "" %>" id="passwordModal">
		<div class="password-modal">
			<h2 class="modal-title">🔒 본인 확인</h2>
			<p class="modal-description">
				개인정보 보호를 위해<br>
				비밀번호를 다시 한 번 입력해주세요.
			</p>
			<input 
				type="password" 
				class="modal-input" 
				id="confirmPassword"
				placeholder="비밀번호 입력"
			>
			<div class="modal-buttons">
				<button class="modal-btn modal-btn-cancel" onclick="goBack()">취소</button>
				<button class="modal-btn modal-btn-confirm" onclick="verifyPassword()">확인</button>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="header">
			<h1 class="page-title">내 프로필</h1>
			<p class="page-subtitle">개인정보를 관리하고 프로필을 설정하세요</p>
		</div>
		
		<!-- 탭 네비게이션 -->
		<div class="tab-navigation">
			<button class="tab-btn active" onclick="showTab('basic')">기본 정보</button>
			<button class="tab-btn" onclick="showTab('settings')">설정</button>
			<!-- <button class="tab-btn" onclick="showTab('privacy')">공개 범위</button> -->
			<button class="tab-btn" onclick="showTab('inquiry')">문의 내역</button>
			<button class="tab-btn" onclick="showTab('account')">계정 관리</button>
		</div>
		
		<!-- 기본 정보 탭 -->
		<div class="profile-container active" id="tab-basic">
			<!-- 프로필 헤더 -->
			<div class="profile-header">
				<div class="profile-image-section">
					<div class="profile-image" id="profileImage">
						<c:if test="${not empty userDTO.savePath }">
							<img src="${userDTO.savePath }" alt="" />
						</c:if>
						<c:if test="${empty userDTO.savePath }">
							👤
						</c:if>
					</div>
					<div class="image-upload-btn">
						<button class="btn-small btn-upload" onclick="uploadImage()">업로드</button>
						<button class="btn-small btn-delete" onclick="deleteImage()">삭제</button>
					</div>
					<input type="file" id="imageInput" accept="image/*" style="display: none;">
				</div>
				
				<div class="profile-info-section">
					<h2 class="profile-name">${userDTO.userName  }</h2>
					<div class="profile-meta">
						<div>📧 ${userDTO.email }</div>
						<div>🎂 <%=birth %></div>
						<div>📅 가입일: <%=createdDate %></div>
					</div>
				</div>
			</div>
			
			<!-- 읽기 전용 정보 -->
			<div class="section">
				<h3 class="section-title">기본 정보 (변경 불가)</h3>
				<div class="info-grid">
					<div class="info-item">
						<span class="info-label">이름</span>
						<div class="info-value readonly">${userDTO.userName }</div>
					</div>
					<div class="info-item">
						<span class="info-label">생년월일</span>
						<div class="info-value readonly"><%=birth %></div>
					</div>
					<div class="info-item">
						<span class="info-label">가입일</span>
						<div class="info-value readonly"><%=createdDate %></div>
					</div>
					<div class="info-item">
						<span class="info-label">회원 ID</span>
						<div class="info-value readonly">${userDTO.userId }</div>
					</div>
				</div>
			</div>
			
			<!-- 수정 가능 정보 -->
			<div class="section">
				<h3 class="section-title">수정 가능 정보</h3>
				
				<div class="form-group">
					<label class="form-label">닉네임</label>
					<div class="input-with-button">
						<input 
							type="text" 
							class="form-input" 
							id="nickname"
							value="${userDTO.nickname }"
							placeholder="닉네임 입력"
						>
						<button class="btn-check" onclick="checkNickname()">중복확인</button>
					</div>
					<p class="form-help" id="nicknameHelp">2-12자의 한글, 영문, 숫자</p>
				</div>
				
				<div class="form-group">
					<label class="form-label">비밀번호 변경</label>
					<input 
						type="password" 
						class="form-input" 
						id="newPassword"
						placeholder="새 비밀번호 (영문, 숫자, ! 만 사용 가능)"
					>
					<p class="form-help">8-20자의 영문, 숫자, 특수문자(!) 조합</p>
				</div>
				
				<div class="form-group">
					<label class="form-label">비밀번호 확인</label>
					<input 
						type="password" 
						class="form-input" 
						id="confirmNewPassword"
						placeholder="새 비밀번호 확인"
					>
					<p class="form-help" id="passwordHelp"></p>
				</div>
				
				<div class="form-group">
					<label class="form-label">이메일</label>
					<div class="input-with-button">
						<input 
							type="email" 
							class="form-input" 
							id="email"
							value="${userDTO.email }"
						>
						<button class="btn-send" onclick="sendEmailCode()">인증코드 발송</button>
					</div>
					<p class="form-help" id="emailHelp">이메일 변경 시 인증이 필요합니다</p>
				</div>
				
				<div class="form-group" id="emailCodeSection" style="display: none;">
					<label class="form-label">인증코드</label>
					<div class="input-with-button">
						<input 
							type="text" 
							class="form-input" 
							id="emailCode"
							placeholder="이메일로 받은 인증코드 입력"
						>
						<button class="btn-check" onclick="verifyEmailCode()">인증확인</button>
					</div>
					<p class="form-help">인증코드는 5분간 유효합니다</p>
				</div>
				
				<div class="form-group">
					<label class="form-label">주소</label>
					<div class="input-with-button">
						<input 
							type="text" 
							class="form-input" 
							id="address"
							value="${userDTO.address }"
							readonly
						>
						<button class="btn-check" onclick="openAddressPopup()">주소검색</button>
					</div>
					<p class="form-help">시/군/구 - 읍/면/동까지 입력됩니다</p>
				</div>
			</div>
			
			<div class="save-button-container">
				<button class="btn-save" onclick="saveProfile()">변경사항 저장</button>
			</div>
		</div>
		
		<!-- 설정 탭 -->
		<div class="profile-container" id="tab-settings">
			<div class="section">
				<h3 class="section-title">알림 설정</h3>
				
				<div class="toggle-item">
					<div class="toggle-info">
						<div class="toggle-title">이메일 수신 동의</div>
						<div class="toggle-description">서비스 소식, 이벤트 정보를 이메일로 받습니다</div>
					</div>
					<label class="toggle-switch">
						<input type="checkbox" class="toggle-input" checked>
						<span class="toggle-slider"></span>
					</label>
				</div>
			</div>
			
			<div class="save-button-container">
				<button class="btn-save" onclick="saveSettings()">설정 저장</button>
			</div>
		</div>
		
		<!-- 공개 범위 탭 -->
		<!-- 
		<div class="profile-container" id="tab-privacy">
			<div class="section">
				<h3 class="section-title">프로필 공개 설정</h3>
				
				<div style="background: #fff9e6; padding: 16px; border-radius: 8px; margin-bottom: 20px; border-left: 4px solid #ffc107;">
					<p style="font-size: 14px; color: #666; line-height: 1.6;">
						<strong style="color: #f57c00;">ℹ️ 안내:</strong><br>
						참여 신청한 모임 또는 참여 중인 모임의 모임장에게는<br>
						설정과 관계없이 항상 공개됩니다.
					</p>
				</div>
				
				<div class="toggle-item">
					<div class="toggle-info">
						<div class="toggle-title">모임 참여 이력 공개</div>
						<div class="toggle-description">내가 참여한 모임 목록을 다른 사용자에게 공개합니다</div>
					</div>
					<label class="toggle-switch">
						<input type="checkbox" class="toggle-input" id="showParticipatedMeetings" onchange="updatePreview()" checked>
						<span class="toggle-slider"></span>
					</label>
				</div>
				
				<div class="toggle-item">
					<div class="toggle-info">
						<div class="toggle-title">모임 운영 이력 공개</div>
						<div class="toggle-description">내가 운영하는 모임 목록을 다른 사용자에게 공개합니다</div>
					</div>
					<label class="toggle-switch">
						<input type="checkbox" class="toggle-input" id="showManagedMeetings" onchange="updatePreview()" checked>
						<span class="toggle-slider"></span>
					</label>
				</div>
			</div>
			
			프로필 미리보기
			<div class="preview-box">
				<div class="preview-title">
					<span>👁️</span>
					<span>다른 사용자에게 보이는 내 프로필 미리보기</span>
				</div>
				<div class="preview-content" id="profilePreview">
					<div class="preview-item">
						<span class="preview-label">닉네임</span>
						<span class="preview-value">행복한토끼99</span>
					</div>
					
					<div class="preview-item">
						<span class="preview-label">가입일</span>
						<span class="preview-value">2024년 1월</span>
					</div>
					
					<div class="preview-item">
						<span class="preview-label">참여 중인 모임</span>
						<span class="preview-value" id="previewParticipated">3개 모임</span>
					</div>
					
					<div class="preview-item">
						<span class="preview-label">운영 중인 모임</span>
						<span class="preview-value" id="previewManaged">1개 모임</span>
					</div>
				</div>
			</div>
			
			<div class="save-button-container">
			<button class="btn-save" onclick="savePrivacy()">설정 저장</button>
		</div>
	</div>
	 -->
	 
	<!-- 문의 내역 탭 -->
	<div class="profile-container" id="tab-inquiry">
		<div class="section">
			<h3 class="section-title">나의 문의 내역</h3>
			
			<table class="inquiry-table">
				<thead>
					<tr>
						<th style="width: 80px;">번호</th>
						<th>제목</th>
						<th style="width: 120px;">아이디</th>
						<!-- <th style="width: 100px;">제목</th> -->
						<th style="width: 100px;">작성일</th> 
					</tr>
				</thead>
				
			<!-- <tbody>
					<tr>
						<td>3</td>
						<td>회원탈퇴는 어떻게 하나요?</td>
						<td>2025-01-10</td>
						<td><span class="inquiry-status status-answered">답변완료</span></td>
					</tr>
					<tr>
						<td>2</td>
						<td>모임 생성 방법 문의</td>
						<td>2025-01-05</td>
						<td><span class="inquiry-status status-answered">답변완료</span></td>
					</tr>
					<tr>
						<td>1</td>
						<td>결제 오류 관련 문의</td>
						<td>2024-12-28</td>
						<td><span class="inquiry-status status-pending">답변대기</span></td>
					</tr>
				</tbody> -->

			<tbody>
		    <c:forEach var="inq" items="${inquiries}">
		        <tr>
		            <td>${inq.inquiryCode}</td> <!-- 문의번호 -->
		            <td>
		                <a href="${cp}/inquirydetail.do?inquiryCode=${inq.inquiryCode}">
		                    ${inq.content}
		                </a>
		            </td> <!-- 제목 클릭 시 상세 페이지 이동 -->
		            <td>${inq.userCode}</td>    <!-- 사용자 아이디 -->
		            <td><fmt:formatDate value="${inq.createdDate}" pattern="yyyy-MM-dd"/></td>
		        </tr>
		    </c:forEach>
		</tbody>
					
					
		</table>
		</div>
					
		<!-- <div class="action-buttons">
			<a href="inquiry/write.do" class="btn-action btn-inquiry">새 문의하기</a>
		</div> -->
		
		    <div style="margin-top:20px; text-align:right;">
        <a href="${cp}/inquiry/write.do" class="btn-action btn-inquiry">문의하기</a>
    </div>
    
	</div>
	
	<!-- 계정 관리 탭 -->
	<div class="profile-container" id="tab-account">
		<div class="withdraw-section">
			<h3 class="withdraw-title">⚠️ 회원 탈퇴</h3>
			
			<div class="withdraw-warning">
				<ul class="warning-list">
					<li>탈퇴 후 30일간 재가입이 제한됩니다.</li>
					<li>모든 활동 내역 및 작성한 게시글이 삭제됩니다.</li>
					<li>참여 중인 모임은 자동으로 탈퇴 처리됩니다.</li>
					<li>운영 중인 모임이 있다면 모임장을 위임해야 합니다.</li>
					<li>탈퇴 후에는 복구가 불가능합니다.</li>
				</ul>
			</div>
			
			<div class="withdraw-reason">
				<label class="form-label">탈퇴 사유 선택 (필수)</label>
				<div class="reason-options">
					<label class="reason-option">
						<input type="radio" name="withdrawReason" value="1">
						<span>더 이상 서비스를 이용하지 않음</span>
					</label>
					<label class="reason-option">
						<input type="radio" name="withdrawReason" value="2">
						<span>원하는 모임을 찾을 수 없음</span>
					</label>
					<label class="reason-option">
						<input type="radio" name="withdrawReason" value="3">
						<span>서비스 이용이 불편함</span>
					</label>
					<label class="reason-option">
						<input type="radio" name="withdrawReason" value="4">
						<span>개인정보 보호를 위해</span>
					</label>
					<label class="reason-option">
						<input type="radio" name="withdrawReason" value="5">
						<span>기타</span>
					</label>
				</div>
			</div>
			
			<div class="form-group">
				<label class="form-label">추가 의견 (선택)</label>
				<textarea 
					class="form-input" 
					id="withdrawComment"
					style="min-height: 100px; resize: none; width: 100%;"
					placeholder="서비스 개선을 위해 의견을 남겨주세요"
				></textarea>
			</div>
			
			<button class="btn-withdraw-confirm" onclick="confirmWithdraw()">
				회원 탈퇴하기
			</button>
		</div>
	</div>
</div>

<%-- <!-- 하단바 -->
<jsp:include page="/common/UnderMenuBar.jsp"></jsp:include>
 --%>
<script>
	// 비밀번호 확인
	function verifyPassword() {
		const password = document.getElementById('confirmPassword').value;
		
		if (!password) {
			alert('비밀번호를 입력해주세요.');
			return;
		}
		
		// 실제로는 서버로 비밀번호 확인 요청
		// 임시로 바로 인증 처리
		window.location.href = '?auth=true';
	}
	
	function goBack() {
		window.history.back();
	}
	
	// 탭 전환
	function showTab(tabName) {
		// 모든 탭 버튼 비활성화
		document.querySelectorAll('.tab-btn').forEach(btn => {
			btn.classList.remove('active');
		});
		
		// 모든 탭 컨테이너 숨김
		document.querySelectorAll('.profile-container').forEach(container => {
			container.classList.remove('active');
		});
		
		// 선택한 탭 활성화
		event.target.classList.add('active');
		document.getElementById('tab-' + tabName).classList.add('active');
	}
	
	// 프로필 이미지 업로드
	function uploadImage() {
		document.getElementById('imageInput').click();
	}
	
	document.getElementById('imageInput').addEventListener('change', function(e) {
		const file = e.target.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById('profileImage').innerHTML = 
					'<img src="' + e.target.result + '" alt="프로필">';
			};
			reader.readAsDataURL(file);
		}
	});
	
	function deleteImage() {
		if (confirm('프로필 사진을 삭제하시겠습니까?')) {
			document.getElementById('profileImage').innerHTML = '👤';
			document.getElementById('imageInput').value = '';
		}
	}
	
	// 닉네임 중복 확인
	function checkNickname() {
		const nickname = document.getElementById('nickname').value.trim();
		const help = document.getElementById('nicknameHelp');
		
		if (!nickname) {
			alert('닉네임을 입력해주세요.');
			return;
		}
		
		const nicknamePattern = /^[가-힣a-zA-Z0-9]{2,12}$/;
		if (!nicknamePattern.test(nickname)) {
			help.textContent = '닉네임은 2-12자의 한글, 영문, 숫자만 사용 가능합니다.';
			help.className = 'form-help error';
			return;
		}
		
		// 서버로 중복 확인 요청
		// TODO: 서버 API 호출
		
		// 임시 처리
		help.textContent = '사용 가능한 닉네임입니다.';
		help.className = 'form-help success';
	}
	
	// 비밀번호 확인
	document.getElementById('confirmNewPassword').addEventListener('input', function() {
		const password = document.getElementById('newPassword').value;
		const confirmPassword = this.value;
		const help = document.getElementById('passwordHelp');
		
		if (!confirmPassword) {
			help.textContent = '';
			return;
		}
		
		if (password === confirmPassword) {
			help.textContent = '비밀번호가 일치합니다.';
			help.className = 'form-help success';
		} else {
			help.textContent = '비밀번호가 일치하지 않습니다.';
			help.className = 'form-help error';
		}
	});
	
	// 비밀번호 유효성 검사
	document.getElementById('newPassword').addEventListener('input', function() {
		const password = this.value;
		const help = document.getElementById('passwordHelp');
		
		if (!password) return;
		
		const passwordPattern = /^[a-zA-Z0-9!]{8,20}$/;
		if (!passwordPattern.test(password)) {
			help.textContent = '비밀번호는 8-20자의 영문, 숫자, 특수문자(!)만 사용 가능합니다.';
			help.className = 'form-help error';
		}
	});
	
	// 이메일 인증코드 발송
	function sendEmailCode() {
		const email = document.getElementById('email').value.trim();
		const help = document.getElementById('emailHelp');
		
		if (!email) {
			alert('이메일을 입력해주세요.');
			return;
		}
		
		const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		if (!emailPattern.test(email)) {
			help.textContent = '올바른 이메일 형식이 아닙니다.';
			help.className = 'form-help error';
			return;
		}
		
		// 서버로 인증코드 발송 요청
		// TODO: 서버 API 호출
		
		alert('인증코드가 이메일로 발송되었습니다.');
		document.getElementById('emailCodeSection').style.display = 'block';
		help.textContent = '인증코드를 입력해주세요.';
		help.className = 'form-help';
	}
	
	// 이메일 인증코드 확인
	function verifyEmailCode() {
		const code = document.getElementById('emailCode').value.trim();
		const help = document.getElementById('emailHelp');
		
		if (!code) {
			alert('인증코드를 입력해주세요.');
			return;
		}
		
		// 서버로 인증코드 확인 요청
		// TODO: 서버 API 호출
		
		// 임시 처리
		alert('이메일 인증이 완료되었습니다.');
		help.textContent = '이메일 인증 완료';
		help.className = 'form-help success';
	}
	
	// 주소 검색 팝업
	function openAddressPopup() {
		window.open(
			'address_popup.jsp',
			'addressPopup',
			'width=500,height=600,scrollbars=yes,resizable=yes'
		);
	}
	
	// 주소 설정 (팝업에서 호출)
	function setAddress(address) {
		document.getElementById('address').value = address;
	}
	
	// 프로필 미리보기 업데이트
	function updatePreview() {
		const showParticipated = document.getElementById('showParticipatedMeetings').checked;
		const showManaged = document.getElementById('showManagedMeetings').checked;
		
		const participatedEl = document.getElementById('previewParticipated');
		const managedEl = document.getElementById('previewManaged');
		
		if (showParticipated) {
			participatedEl.textContent = '3개 모임';
			participatedEl.classList.remove('hidden');
		} else {
			participatedEl.textContent = '비공개';
			participatedEl.classList.add('hidden');
		}
		
		if (showManaged) {
			managedEl.textContent = '1개 모임';
			managedEl.classList.remove('hidden');
		} else {
			managedEl.textContent = '비공개';
			managedEl.classList.add('hidden');
		}
	}
	
	// 프로필 저장
	function saveProfile() {
		if (confirm('변경사항을 저장하시겠습니까?')) {
			// 서버로 데이터 전송
			// TODO: 서버 API 호출
			
			alert('프로필이 저장되었습니다.');
		}
	}
	
	// 설정 저장
	function saveSettings() {
		if (confirm('설정을 저장하시겠습니까?')) {
			// 서버로 데이터 전송
			// TODO: 서버 API 호출
			
			alert('설정이 저장되었습니다.');
		}
	}
	
	// 공개 범위 저장
	function savePrivacy() {
		if (confirm('공개 범위 설정을 저장하시겠습니까?')) {
			// 서버로 데이터 전송
			// TODO: 서버 API 호출
			
			alert('공개 범위가 저장되었습니다.');
		}
	}
	
	// 문의 내역 보기
	function viewInquiry(id) {
		window.location.href = 'user_inquiry_detail.jsp?id=' + id;
	}
	
	// 회원 탈퇴
	function confirmWithdraw() {
		const selectedReason = document.querySelector('input[name="withdrawReason"]:checked');
		
		if (!selectedReason) {
			alert('탈퇴 사유를 선택해주세요.');
			return;
		}
		
		if (!confirm('정말로 회원 탈퇴하시겠습니까?\n\n탈퇴 후 30일간 재가입이 제한되며,\n모든 데이터는 복구할 수 없습니다.')) {
			return;
		}
		
		// 최종 확인
		const confirmText = prompt('탈퇴를 진행하려면 "탈퇴합니다"를 입력해주세요.');
		
		if (confirmText === '탈퇴합니다') {
			// 서버로 탈퇴 요청
			// TODO: 서버 API 호출
			
			alert('회원 탈퇴가 완료되었습니다.\n그동안 이용해주셔서 감사합니다.');
			window.location.href = 'index.jsp';
		} else {
			alert('입력이 올바르지 않습니다.');
		}
	}
	
	// 엔터키로 비밀번호 확인
	document.getElementById('confirmPassword').addEventListener('keypress', function(e) {
		if (e.key === 'Enter') {
			verifyPassword();
		}
	});
</script>
</body>
</html>