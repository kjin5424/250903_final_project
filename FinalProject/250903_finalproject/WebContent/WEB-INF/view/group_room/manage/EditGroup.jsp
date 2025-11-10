<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들 - 모임 정보 수정</title>
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
	transition: all 0.2s ease;
	text-decoration: none;
	display: flex;
	align-items: center;
}

.tab.active {
	background: #f5f7fa;
	color: #2d5a29;
	height: 40px;
}

.profile-btn {
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
	max-width: 900px;
	margin: 30px auto;
	padding: 0 20px;
}

.page-header {
	background: white;
	border-radius: 12px;
	padding: 30px;
	margin-bottom: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.page-title {
	font-size: 28px;
	color: #2d5a29;
	margin-bottom: 10px;
	font-weight: bold;
}

.page-subtitle {
	color: #666;
	font-size: 14px;
	margin-bottom: 15px;
}

.warning-alert {
	background: #fff3cd;
	border-left: 4px solid #ffc107;
	padding: 15px;
	margin-top: 15px;
	border-radius: 8px;
}

.warning-alert strong {
	color: #856404;
	display: block;
	margin-bottom: 8px;
}

.warning-alert p {
	color: #856404;
	margin: 5px 0;
	font-size: 13px;
}

.form-container {
	background: white;
	border-radius: 12px;
	padding: 40px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.form-section {
	margin-bottom: 35px;
	padding-bottom: 35px;
	border-bottom: 2px solid #f0f0f0;
}

.form-section:last-of-type {
	border-bottom: none;
}

.section-title {
	font-size: 20px;
	color: #2d5a29;
	margin-bottom: 25px;
	font-weight: 600;
	display: flex;
	align-items: center;
	gap: 8px;
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

.form-input, .form-select, .form-textarea {
	width: 100%;
	padding: 12px 15px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	transition: all 0.3s;
	font-family: inherit;
}

.form-input:focus, .form-select:focus, .form-textarea:focus {
	outline: none;
	border-color: #8bc683;
	box-shadow: 0 0 0 3px rgba(139, 198, 131, 0.1);
}

.form-textarea {
	resize: vertical;
	min-height: 100px;
}

.tip {
	font-size: 12px;
	color: #999;
	margin-top: 5px;
	display: flex;
	align-items: center;
	gap: 5px;
}

.tip::before {
	content: "💡";
	font-size: 14px;
}

.tip-red {
	font-size: 12px;
	color: #f44336;
	margin-top: 5px;
	font-weight: 500;
}

.radio-group {
	display: flex;
	flex-wrap: wrap;
	gap: 15px;
	margin-top: 8px;
}

.radio-item {
	display: flex;
	align-items: center;
	gap: 6px;
}

.radio-item input[type="radio"] {
	width: 18px;
	height: 18px;
	cursor: pointer;
	accent-color: #4CAF50;
}

.radio-item label {
	cursor: pointer;
	font-size: 14px;
	color: #333;
	font-weight: normal;
}

.image-upload-area {
	border: 2px dashed #e0e0e0;
	border-radius: 8px;
	padding: 20px;
	text-align: center;
	transition: all 0.3s;
}

.image-upload-area:hover {
	border-color: #8bc683;
	background: #f8faf8;
}

#currentImage, #preview {
	max-width: 300px;
	height: auto;
	margin: 15px auto;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	display: block;
}

#preview {
	display: none;
}

.btn-remove-image {
	padding: 8px 16px;
	background: #f44336;
	color: white;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	font-size: 13px;
	font-weight: 600;
	transition: all 0.3s;
	margin-top: 10px;
}

.btn-remove-image:hover {
	background: #d32f2f;
	transform: translateY(-2px);
}

.address-search-wrapper {
	display: flex;
	gap: 10px;
	align-items: flex-start;
}

.address-search-wrapper .form-input {
	flex: 1;
}

.btn-search {
	padding: 12px 20px;
	background: #2d5a29;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
	white-space: nowrap;
}

.btn-search:hover {
	background: #234520;
	transform: translateY(-2px);
}

.password-section {
	display: none;
	margin-top: 15px;
	padding: 20px;
	background: #fff3e0;
	border-radius: 8px;
	border: 2px solid #ffe0b2;
}

.button-group {
	display: flex;
	gap: 15px;
	margin-top: 40px;
	justify-content: center;
}

.btn-submit, .btn-cancel {
	padding: 14px 40px;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
}

.btn-submit {
	background: #4CAF50;
	color: white;
}

.btn-submit:hover {
	background: #45a049;
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
}

.btn-cancel {
	background: #e0e0e0;
	color: #666;
}

.btn-cancel:hover {
	background: #d0d0d0;
	transform: translateY(-2px);
}

.readonly-info {
	background: #f8f9fa;
	padding: 12px 15px;
	border-radius: 8px;
	border: 2px solid #e9ecef;
	color: #666;
	font-size: 14px;
}

@media ( max-width : 768px) {
	.container {
		padding: 0 15px;
	}
	.form-container {
		padding: 25px 20px;
	}
	.button-group {
		flex-direction: column;
	}
	.btn-submit, .btn-cancel {
		width: 100%;
	}
	.address-search-wrapper {
		flex-direction: column;
	}
}
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function toggleRegion() {
    const onOffType = parseInt(document.querySelector('input[name="onOffType"]:checked')?.value || '1');
    const addressSection = document.getElementById("addressSection");
    const isOffline = onOffType === 2 || onOffType === 3;
    addressSection.style.display = isOffline ? "block" : "none";
}

function togglePassword() {
    const privacySelect = document.getElementById("privacy");
    const passwordDiv = document.getElementById("passwordDiv");
    const currentPassword = "${groupDetail.password}";
    const isPrivate = (privacySelect.value === "private") || (currentPassword && currentPassword.trim() !== "");
    passwordDiv.style.display = isPrivate ? "block" : "none";
}

function previewImage(event) {
    const file = event.target.files[0];
    const preview = document.getElementById('preview');
    const currentImage = document.getElementById('currentImage');
    
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.src = e.target.result;
            preview.style.display = 'block';
            if(currentImage) currentImage.style.display = 'none';
        }
        reader.readAsDataURL(file);
    } else {
        preview.src = '#';
        preview.style.display = 'none';
        if(currentImage) currentImage.style.display = 'block';
    }
}

function removeCurrentImage() {
    if(confirm('현재 이미지를 삭제하시겠습니까? (기본 이미지로 변경됩니다)')) {
        document.getElementById('currentImage').style.display = 'none';
        document.getElementById('removeImageFlag').value = 'true';
        alert('이미지가 삭제됩니다. 저장 버튼을 눌러 변경사항을 적용하세요.');
    }
}

function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.getElementById('roadAddress').value = data.roadAddress;
            document.getElementById('postcode').value = data.zonecode;
        }
    }).open();
}

function validateAndSubmit(event) {
    const privacy = document.getElementById("privacy").value;
    
    if (privacy === "private") {
        const pw1 = document.getElementById("password").value;
        const pw2 = document.getElementById("passwordConfirm").value;

        if (pw1 && (pw1 !== pw2)) {
            alert("새 비밀번호가 확인과 일치하지 않습니다. 다시 입력해주세요.");
            document.getElementById("password").value = "";
            document.getElementById("passwordConfirm").value = "";
            document.getElementById("password").focus();
            event.preventDefault();
            return false;
        }
    }
    
    if (!confirm('모임 정보를 수정하시겠습니까?\n모든 모임원에게 변경 알림이 발송됩니다.')) {
        event.preventDefault();
        return false;
    }
    
    return true;
}

function cancelEdit() {
    if(confirm('변경사항이 저장되지 않습니다. 정말 취소하시겠습니까?')) {
        history.back();
    }
}

window.onload = function() {
    toggleRegion();
    togglePassword();
}
</script>
</head>
<body>
	<nav class="navbar">
		<div class="nav-left">
			<div class="logo-tab">
				<span>로고 들어갈 자리</span>
			</div>
			<a href="?page=notice" class="tab">공지사항</a> 
			<a href="?page=groups" class="tab">모임구경</a> 
			<a href="?page=creategroup" class="tab">모임 개설</a> 
			<a href="?page=mygroups" class="tab active">내 모임</a>
		</div>
		<div class="nav-right">
			<a href="mypage.jsp" class="profile-btn"> 
				<span>👤</span>
				<span>마이페이지</span>
			</a>
		</div>
	</nav>

	<div class="container">
		<div class="page-header">
			<h1 class="page-title">⚙️ 모임 정보 수정</h1>
			<p class="page-subtitle">모임 정보를 수정할 수 있습니다. 변경 시 모든 모임원에게 알림이 발송됩니다.</p>
			<div class="warning-alert">
				<strong>⚠️ 중요 안내</strong>
				<p>• 모임 정보 변경 시 모든 모임원에게 알림이 발송됩니다.</p>
				<p>• 악의적인 변경사항은 모임원들의 신고 대상이 될 수 있습니다.</p>
				<p>• 투표 미참여 탈퇴 기간 변경 시, 해당 조건으로 탈퇴되는 회원이 있을 경우 안내됩니다.</p>
			</div>
		</div>

		<div class="form-container">
			<form action="${pageContext.request.contextPath}/groupeditcomplete.do" 
			      method="post" 
			      enctype="multipart/form-data" 
			      onsubmit="return validateAndSubmit(event)">

				<input type="hidden" name="groupApplyCode" value="${groupDetail.groupApplyCode}">
				<input type="hidden" id="removeImageFlag" name="removeImageFlag" value="false">

				<!-- 기본 정보 -->
				<div class="form-section">
					<div class="section-title">📋 기본 정보</div>

					<div class="form-group">
						<label class="form-label">모임 이름</label>
						<input type="text" class="form-input" name="groupTitle"
							value="${groupDetail.groupTitle}" placeholder="모임 이름을 입력하세요" required>
						<div class="tip">모임 이름은 중복 가능하며, 간결하고 기억하기 쉽게 작성하세요.</div>
					</div>

					<div class="form-group">
						<label class="form-label">모임 이미지</label>
						<div class="image-upload-area">
							<c:if test="${not empty groupDetail.savePath}">
								<div style="margin-bottom: 15px;">
									<p style="font-size: 13px; color: #666; margin-bottom: 10px;">📷 현재 이미지</p>
									<img id="currentImage" src="${groupDetail.savePath}" alt="현재 모임 이미지">
									<button type="button" class="btn-remove-image" onclick="removeCurrentImage()">
										🗑️ 이미지 삭제
									</button>
								</div>
							</c:if>
							<div>
								<p style="font-size: 13px; color: #666; margin-bottom: 10px;">📁 새 이미지 업로드</p>
								<input type="file" id="image" name="image" accept="image/*"
									onchange="previewImage(event)" style="margin-bottom: 10px;">
								<div class="tip" style="justify-content: center;">새 이미지를 업로드하면 기존 이미지가 교체됩니다.</div>
							</div>
						</div>
						<img id="preview" src="#" alt="이미지 미리보기">
					</div>

					<div class="form-group">
						<label class="form-label">카테고리</label>
						<div class="radio-group">
							<div class="radio-item">
								<input type="radio" id="category_reading" name="topicType" value="1"
									<c:if test="${groupDetail.topicType == 1}">checked</c:if>>
								<label for="category_reading">📚 독서</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="category_language" name="topicType" value="2"
									<c:if test="${groupDetail.topicType == 2}">checked</c:if>>
								<label for="category_language">🗣️ 어학</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="category_it" name="topicType" value="3"
									<c:if test="${groupDetail.topicType == 3}">checked</c:if>>
								<label for="category_it">💻 IT</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="category_startup" name="topicType" value="4"
									<c:if test="${groupDetail.topicType == 4}">checked</c:if>>
								<label for="category_startup">💼 창업·취업</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="category_cert" name="topicType" value="5"
									<c:if test="${groupDetail.topicType == 5}">checked</c:if>>
								<label for="category_cert">📜 자격증</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="category_exam" name="topicType" value="6"
									<c:if test="${groupDetail.topicType == 6}">checked</c:if>>
								<label for="category_exam">✏️ 시험</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="category_hobby" name="topicType" value="7"
									<c:if test="${groupDetail.topicType == 7}">checked</c:if>>
								<label for="category_hobby">🎨 취미</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="category_etc" name="topicType" value="8"
									<c:if test="${groupDetail.topicType == 8}">checked</c:if>>
								<label for="category_etc">📦 기타</label>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label class="form-label">상세 내용</label>
						<textarea class="form-textarea" name="groupContent" rows="5"
							placeholder="모임에 대한 자세한 설명을 작성하세요" required>${groupDetail.groupContent}</textarea>
					</div>
				</div>

				<!-- 모임 형태 -->
				<div class="form-section">
					<div class="section-title">📍 모임 형태 및 장소</div>

					<div class="form-group">
						<label class="form-label">모임 형태</label>
						<div class="radio-group">
							<div class="radio-item">
								<input type="radio" id="online" name="onOffType" value="1" 
									onclick="toggleRegion()"
									<c:if test="${groupDetail.onOffType == 1}">checked</c:if>>
								<label for="online">💻 온라인</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="offline" name="onOffType" value="2" 
									onclick="toggleRegion()"
									<c:if test="${groupDetail.onOffType == 2}">checked</c:if>>
								<label for="offline">🏢 오프라인</label>
							</div>
							<div class="radio-item">
								<input type="radio" id="both" name="onOffType" value="3" 
									onclick="toggleRegion()"
									<c:if test="${groupDetail.onOffType == 3}">checked</c:if>>
								<label for="both">🌐 온오프 병행</label>
							</div>
						</div>
					</div>

					<div id="addressSection" style="display: none;">
						<div class="form-group">
							<label class="form-label">주소 검색</label>
							<div class="address-search-wrapper">
								<input type="text" class="form-input" id="roadAddress"
									name="region" value="${groupDetail.region}"
									placeholder="주소 검색 버튼을 눌러주세요" readonly>
								<button type="button" class="btn-search" onclick="searchAddress()">
									🔍 주소 검색
								</button>
							</div>
						</div>
						<div class="form-group" style="display:none;">
							<input type="text" class="form-input" id="postcode" name="postcode">
						</div>
					</div>

					<div class="form-group">
						<label class="form-label">모임 빈도</label>
						<select class="form-select" name="frequencyType">
							<option value="1" <c:if test="${groupDetail.frequencyType == 1}">selected</c:if>>1년</option>
							<option value="2" <c:if test="${groupDetail.frequencyType == 2}">selected</c:if>>반기</option>
							<option value="3" <c:if test="${groupDetail.frequencyType == 3}">selected</c:if>>분기</option>
							<option value="4" <c:if test="${groupDetail.frequencyType == 4}">selected</c:if>>격월</option>
							<option value="5" <c:if test="${groupDetail.frequencyType == 5}">selected</c:if>>매월</option>
							<option value="6" <c:if test="${groupDetail.frequencyType == 6}">selected</c:if>>격주</option>
							<option value="7" <c:if test="${groupDetail.frequencyType == 7}">selected</c:if>>매주</option>
							<option value="8" <c:if test="${groupDetail.frequencyType == 8}">selected</c:if>>비정기</option>
						</select>
					</div>
				</div>

				<!-- 참여 제한 -->
				<div class="form-section">
					<div class="section-title">👥 참여 제한</div>

					<div class="form-group">
						<label class="form-label">청소년 환영</label>
						<select class="form-select" name="youthFriendlyType">
							<option value="1" <c:if test="${groupDetail.youthFriendlyType == 1}">selected</c:if>>예</option>
							<option value="2" <c:if test="${groupDetail.youthFriendlyType == 2}">selected</c:if>>아니오</option>
						</select>
						<div class="tip-red">
							❗ 청소년 환영 시, 모임 종료 시간은 오후 10시 이후로 설정할 수 없습니다.
						</div>
					</div>

					<div class="form-group">
						<label class="form-label">현재 인원</label>
						<div class="readonly-info">
							현재 ${groupDetail.currentMemberCount}명 / 최대 ${groupDetail.maxCount}명
							<br>
							<small style="color:#f57c00; font-weight:600;">
								💡 현재 레벨 ${groupDetail.groupLevel} - 레벨업 시 인원 상한이 증가합니다.
							</small>
						</div>
					</div>

					<div class="form-group">
						<label class="form-label">성별 제한</label>
						<select class="form-select" name="genderType">
							<option value="1" <c:if test="${groupDetail.genderType == 1}">selected</c:if>>제한 없음</option>
							<option value="2" <c:if test="${groupDetail.genderType == 2}">selected</c:if>>동일 성별만</option>
						</select>
					</div>

					<div class="form-group">
						<label class="form-label">학습 난이도</label>
						<select class="form-select" name="difficultyType">
							<option value="1" <c:if test="${groupDetail.difficultyType == 1}">selected</c:if>>상 (고급)</option>
							<option value="2" <c:if test="${groupDetail.difficultyType == 2}">selected</c:if>>중 (중급)</option>
							<option value="3" <c:if test="${groupDetail.difficultyType == 3}">selected</c:if>>하 (초급)</option>
						</select>
					</div>
				</div>

				<!-- 모임 설정 -->
				<div class="form-section">
					<div class="section-title">⚙️ 모임 설정</div>

					<div class="form-group">
						<label class="form-label">가입 질문 (선택사항)</label>
						<textarea class="form-textarea" name="question" rows="3"
							placeholder="예: 이 모임에 참여하려는 이유는 무엇인가요?">${groupDetail.question}</textarea>
						<div class="tip">가입 신청 시 답변을 요구할 질문을 하나 작성할 수 있습니다.</div>
					</div>

					<div class="form-group">
						<label class="form-label">모임 내 주의사항/규칙</label>
						<textarea class="form-textarea" name="rule" rows="3"
							placeholder="모임원들이 지켜야 할 규칙이나 주의사항을 작성하세요">${groupDetail.rule}</textarea>
					</div>

					<div class="form-group">
						<label class="form-label">투표 미참가 시 탈퇴 기준</label>
						<select class="form-select" name="kickOut">
							<option value="1" <c:if test="${groupDetail.kickOut == 1}">selected</c:if>>1회</option>
							<option value="2" <c:if test="${groupDetail.kickOut == 2}">selected</c:if>>2회</option>
							<option value="3" <c:if test="${groupDetail.kickOut == 3}">selected</c:if>>3회</option>
							<option value="4" <c:if test="${groupDetail.kickOut == 4}">selected</c:if>>4회</option>
							<option value="5" <c:if test="${groupDetail.kickOut == 5}">selected</c:if>>5회</option>
							<option value="6" <c:if test="${groupDetail.kickOut == 6}">selected</c:if>>6회</option>
							<option value="7" <c:if test="${groupDetail.kickOut == 7}">selected</c:if>>7회</option>
							<option value="8" <c:if test="${groupDetail.kickOut == 8}">selected</c:if>>8회</option>
							<option value="9" <c:if test="${groupDetail.kickOut == 9}">selected</c:if>>9회</option>
							<option value="10" <c:if test="${groupDetail.kickOut == 10}">selected</c:if>>10회</option>
						</select>
						<div class="tip">지정한 기간 이상 투표에 참여하지 않으면 자동 탈퇴됩니다.</div>
						<div class="tip-red">⚠️ 변경 시 해당 조건으로 탈퇴될 회원이 있을 경우 안내됩니다.</div>
					</div>

					<div class="form-group">
						<label class="form-label">모임 공개 설정</label>
						<select class="form-select" id="privacy" name="privacy" onchange="togglePassword()">
							<option value="public" <c:if test="${empty groupDetail.password}">selected</c:if>>🌐 공개</option>
							<option value="private" <c:if test="${not empty groupDetail.password}">selected</c:if>>🔒 비공개 (비밀번호 필요)</option>
						</select>
					</div>

					<div id="passwordDiv" class="password-section">
						<div class="form-group">
							<label class="form-label">비밀번호 설정</label>
							<input type="password" class="form-input" id="password" name="password"
								placeholder="비밀번호 입력 (변경 시에만 입력)">
							<div class="tip">비밀번호를 변경하지 않으려면 비워두세요.</div>
						</div>
						<div class="form-group">
							<label class="form-label">비밀번호 확인</label>
							<input type="password" class="form-input" id="passwordConfirm" name="passwordConfirm"
								placeholder="비밀번호 다시 입력">
						</div>
					</div>
				</div>

				<div class="button-group">
					<button type="submit" class="btn-submit">✅ 저장</button>
					<button type="button" class="btn-cancel" onclick="cancelEdit()">❌ 취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>