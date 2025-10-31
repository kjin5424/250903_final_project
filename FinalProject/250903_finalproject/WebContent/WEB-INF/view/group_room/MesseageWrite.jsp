<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	request.setAttribute("cp", cp); 
%>
<!DOCTYPE html>
<html lang="ko">
<!-- CSS 파일 로드 (순서 중요!) -->
<link rel="stylesheet" href="<%=cp%>/css/variables.css">
<link rel="stylesheet" href="<%=cp%>/css/common.css">
<link rel="stylesheet" href="<%=cp%>/css/components.css">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쪽지 작성 - 공모자들</title>
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
	max-width: 800px;
	margin: 0 auto;
}

.header {
	text-align: center;
	margin-bottom: 40px;
}

.header-icon {
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

.info-box {
	background: #fff9e6;
	border-left: 4px solid #ffc107;
	padding: 16px 20px;
	border-radius: 6px;
	margin-bottom: 30px;
}

.info-box-title {
	font-weight: 600;
	color: #333;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.info-box-content {
	font-size: 14px;
	color: #666;
	line-height: 1.6;
}

.info-box-content ul {
	margin-left: 20px;
	margin-top: 8px;
}

.info-box-content li {
	margin-bottom: 4px;
}

.form-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	padding: 40px;
}

.form-group {
	margin-bottom: 24px;
}

.form-label {
	display: block;
	font-size: 15px;
	font-weight: 600;
	color: #333;
	margin-bottom: 10px;
}

.required {
	color: #ff6b6b;
	margin-left: 4px;
}

.form-select {
	width: 100%;
	padding: 12px 16px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 15px;
	font-family: inherit;
	cursor: pointer;
	transition: all 0.2s ease;
}

.form-select:focus {
	outline: none;
	border-color: #a8d5a1;
	box-shadow: 0 0 0 3px rgba(168, 213, 161, 0.1);
}

.form-select:disabled {
	background: #f5f5f5;
	cursor: not-allowed;
	color: #999;
}

.select-row {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.form-input {
	width: 100%;
	padding: 12px 16px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 15px;
	font-family: inherit;
	transition: all 0.2s ease;
}

.form-input:focus {
	outline: none;
	border-color: #a8d5a1;
	box-shadow: 0 0 0 3px rgba(168, 213, 161, 0.1);
}

.form-textarea {
	width: 100%;
	min-height: 300px;
	padding: 16px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 15px;
	font-family: inherit;
	resize: vertical;
	transition: all 0.2s ease;
	line-height: 1.6;
}

.form-textarea:focus {
	outline: none;
	border-color: #a8d5a1;
	box-shadow: 0 0 0 3px rgba(168, 213, 161, 0.1);
}

.char-count {
	text-align: right;
	font-size: 13px;
	color: #999;
	margin-top: 6px;
}

.form-help {
	font-size: 13px;
	color: #666;
	margin-top: 6px;
	line-height: 1.5;
}

.recipient-info {
	background: #f8faf9;
	border: 2px solid #e8f5e6;
	border-radius: 10px;
	padding: 16px;
	margin-top: 15px;
	display: none;
}

.recipient-info.show {
	display: block;
}

.recipient-info-title {
	font-weight: 600;
	color: #2d5a29;
	margin-bottom: 10px;
	font-size: 14px;
}

.recipient-details {
	font-size: 14px;
	color: #666;
	line-height: 1.6;
}

.recipient-details-item {
	display: flex;
	gap: 10px;
	margin-bottom: 8px;
}

.recipient-details-item:last-child {
	margin-bottom: 0;
}

.recipient-details-label {
	font-weight: 600;
	color: #333;
	min-width: 80px;
}

.button-group {
	display: flex;
	gap: 12px;
	justify-content: flex-end;
	padding-top: 30px;
	border-top: 2px solid #f0f0f0;
}

.btn {
	padding: 14px 32px;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
	display: flex;
	align-items: center;
	gap: 8px;
	text-decoration: none;
}

.btn-cancel {
	background: #f0f0f0;
	color: #666;
}

.btn-cancel:hover {
	background: #e0e0e0;
	transform: translateY(-2px);
}

.btn-submit {
	background: #2d5a29;
	color: white;
}

.btn-submit:hover {
	background: #1f4019;
	transform: translateY(-2px);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.btn-submit:disabled {
	background: #ccc;
	cursor: not-allowed;
	transform: none;
}

/* 반응형 */
@media (max-width: 768px) {
	body {
		padding: 20px 10px;
	}
	
	.page-title {
		font-size: 24px;
	}
	
	.form-container {
		padding: 24px 20px;
	}
	
	.select-row {
		grid-template-columns: 1fr;
	}
	
	.button-group {
		flex-direction: column-reverse;
	}
	
	.btn {
		width: 100%;
		justify-content: center;
	}
}
</style>
</head>
<body>
	<!-- 상단바 -->
	<div id="topMenu">
		<jsp:include page="<%=cp %>/common/TopMenuBar.jsp" />
	</div>
	
	<div class="container">
		<div class="header">
			<div class="header-icon">💬</div>
			<h1 class="page-title">쪽지 작성</h1>
			<p class="page-subtitle">같은 모임원에게 쪽지를 보내세요</p>
		</div>
		
		<div class="info-box">
			<div class="info-box-title">
				<span>💡</span>
				<span>쪽지 작성 가이드</span>
			</div>
			<div class="info-box-content">
				<ul>
					<li>같은 모임에 참여하고 있는 모임원들에게만 쪽지를 보낼 수 있습니다.</li>
					<li>쪽지는 상대방이 언제든지 확인할 수 있도록 보관됩니다.</li>
					<li>정중하고 성숙한 내용의 쪽지 작성을 부탁드립니다.</li>
					<li>부적절한 내용의 쪽지는 신고 대상이 될 수 있습니다.</li>
				</ul>
			</div>
		</div>
		
		<form id="messageForm" onsubmit="return validateForm(event)">
			<div class="form-container">
				<div class="select-row">
					<!-- 모임 선택 -->
					<div class="form-group">
						<label class="form-label">
							모임 선택<span class="required">*</span>
						</label>
						<select id="meeting" class="form-select" onchange="loadMembers()" required>
							<option value="">참여 중인 모임을 선택하세요</option>
							<option value="1">알고리즘 정복 스터디</option>
							<option value="2">Java Spring 마스터</option>
							<option value="3">React 실전 프로젝트</option>
							<option value="4">사진 촬영 동아리</option>
						</select>
						<p class="form-help">현재 참여 중인 모임에서만 선택 가능합니다</p>
					</div>
					
					<!-- 수신자 선택 -->
					<div class="form-group">
						<label class="form-label">
							수신자<span class="required">*</span>
						</label>
						<select id="recipient" class="form-select" onchange="showRecipientInfo()" required>
							<option value="">받는 사람을 선택하세요</option>
						</select>
						<p class="form-help">선택한 모임의 모임원 목록입니다</p>
					</div>
				</div>
				
				<!-- 수신자 정보 표시 -->
				<div class="recipient-info" id="recipientInfo">
					<div class="recipient-info-title">쪽지 수신자 정보</div>
					<div class="recipient-details">
						<div class="recipient-details-item">
							<span class="recipient-details-label">닉네임:</span>
							<span id="recipientNickname">-</span>
						</div>
						<div class="recipient-details-item">
							<span class="recipient-details-label">가입일:</span>
							<span id="recipientJoinDate">-</span>
						</div>
						<div class="recipient-details-item">
							<span class="recipient-details-label">역할:</span>
							<span id="recipientRole">-</span>
						</div>
					</div>
				</div>
				
				<!-- 제목 -->
				<div class="form-group">
					<label class="form-label">
						제목<span class="required">*</span>
					</label>
					<input 
						type="text" 
						id="title" 
						name="title" 
						class="form-input" 
						placeholder="쪽지 제목을 입력하세요"
						maxlength="100"
						required
					>
					<div class="char-count">
						<span id="titleCount">0</span> / 100자
					</div>
				</div>
				
				<!-- 내용 -->
				<div class="form-group">
					<label class="form-label">
						내용<span class="required">*</span>
					</label>
					<textarea 
						id="content" 
						name="content" 
						class="form-textarea" 
						placeholder="쪽지 내용을 작성해주세요.&#13;&#10;&#13;&#10;존댓글 사용과 정중한 표현을 부탁드립니다."
						maxlength="1000"
						required
					></textarea>
					<div class="char-count">
						<span id="contentCount">0</span> / 1,000자
					</div>
					<p class="form-help">정중하고 성숙한 내용의 쪽지 작성을 부탁드립니다.</p>
				</div>
				
				<div class="button-group">
					<button type="button" class="btn btn-cancel" onclick="cancelWrite()">
						<span>✕</span>
						<span>작성 취소</span>
					</button>
					<button type="submit" class="btn btn-submit" id="submitBtn" disabled>
						<span>📨</span>
						<span>쪽지 보내기</span>
					</button>
				</div>
			</div>
		</form>
	</div>
		
	<script>
		// 모임별 모임원 데이터 (실제로는 서버에서 조회)
		const meetingMembers = {
			"1": [
				{ id: "member1", nickname: "코딩왕", joinDate: "2024-01-10", role: "모임장" },
				{ id: "member2", nickname: "알고리즘마스터", joinDate: "2024-01-15", role: "모임원" },
				{ id: "member3", nickname: "개발천재", joinDate: "2024-02-01", role: "모임원" }
			],
			"2": [
				{ id: "member4", nickname: "스프링전문가", joinDate: "2024-01-20", role: "모임장" },
				{ id: "member5", nickname: "백엔드개발자", joinDate: "2024-02-10", role: "모임원" }
			],
			"3": [
				{ id: "member6", nickname: "리액트마니아", joinDate: "2024-02-05", role: "모임장" },
				{ id: "member7", nickname: "프론트엔드러", joinDate: "2024-02-15", role: "모임원" },
				{ id: "member8", nickname: "UI디자이너", joinDate: "2024-03-01", role: "모임원" }
			],
			"4": [
				{ id: "member9", nickname: "사진작가", joinDate: "2024-01-05", role: "모임장" },
				{ id: "member10", nickname: "셔터광", joinDate: "2024-01-25", role: "모임원" },
				{ id: "member11", nickname: "렌즈매니아", joinDate: "2024-02-20", role: "모임원" }
			]
		};
		
		// 모임 선택 시 모임원 로드
		function loadMembers() {
			const meetingId = document.getElementById('meeting').value;
			const recipientSelect = document.getElementById('recipient');
			const recipientInfo = document.getElementById('recipientInfo');
			
			// 선택 초기화
			recipientSelect.innerHTML = '<option value="">받는 사람을 선택하세요</option>';
			recipientInfo.classList.remove('show');
			
			if (!meetingId) return;
			
			// 해당 모임의 모임원 로드
			const members = meetingMembers[meetingId] || [];
			
			members.forEach(member => { 
				const option = document.createElement('option');
				option.value = member.id;
				option.textContent = member.nickname;
				option.dataset.joinDate = member.joinDate;
				option.dataset.role = member.role;
				recipientSelect.appendChild(option);
			});
			
			updateSubmitButton();
		}
		
		// 수신자 정보 표시
		function showRecipientInfo() {
			const recipientSelect = document.getElementById('recipient');
			const selectedOption = recipientSelect.options[recipientSelect.selectedIndex];
			const recipientInfo = document.getElementById('recipientInfo');
			
			if (!recipientSelect.value) {
				recipientInfo.classList.remove('show');
				return;
			}
			
			// 수신자 정보 업데이트
			document.getElementById('recipientNickname').textContent = selectedOption.text;
			document.getElementById('recipientJoinDate').textContent = selectedOption.dataset.joinDate;
			document.getElementById('recipientRole').textContent = selectedOption.dataset.role;
			
			recipientInfo.classList.add('show');
			updateSubmitButton();
		}
		
		// 제목 글자수 카운트
		const titleInput = document.getElementById('title');
		const titleCount = document.getElementById('titleCount');
		
		titleInput.addEventListener('input', function() {
			titleCount.textContent = this.value.length;
			updateSubmitButton();
		});
		
		// 내용 글자수 카운트
		const contentInput = document.getElementById('content');
		const contentCount = document.getElementById('contentCount');
		
		contentInput.addEventListener('input', function() {
			contentCount.textContent = this.value.length;
			updateSubmitButton();
		});
		
		// 제출 버튼 활성화 여부
		function updateSubmitButton() {
			const meeting = document.getElementById('meeting').value;
			const recipient = document.getElementById('recipient').value;
			const title = document.getElementById('title').value.trim();
			const content = document.getElementById('content').value.trim();
			const submitBtn = document.getElementById('submitBtn');
			
			if (meeting && recipient && title.length >= 5 && content.length >= 10) {
				submitBtn.disabled = false;
			} else {
				submitBtn.disabled = true;
			}
		}
		
		// 폼 유효성 검사
		function validateForm(event) {
			event.preventDefault();
			
			const meeting = document.getElementById('meeting').value;
			const recipient = document.getElementById('recipient').value;
			const title = document.getElementById('title').value.trim();
			const content = document.getElementById('content').value.trim();
			
			if (!meeting) {
				alert('모임을 선택해주세요.');
				document.getElementById('meeting').focus();
				return false;
			}
			
			if (!recipient) {
				alert('수신자를 선택해주세요.');
				document.getElementById('recipient').focus();
				return false;
			}
			
			if (!title) {
				alert('제목을 입력해주세요.');
				document.getElementById('title').focus();
				return false;
			}
			
			if (title.length < 5) {
				alert('제목은 최소 5자 이상 입력해주세요.');
				document.getElementById('title').focus();
				return false;
			}
			
			if (!content) {
				alert('내용을 입력해주세요.');
				document.getElementById('content').focus();
				return false;
			}
			
			if (content.length < 10) {
				alert('내용은 최소 10자 이상 입력해주세요.');
				document.getElementById('content').focus();
				return false;
			}
			
			// 최종 확인
			if (confirm('쪽지를 보내시겠습니까?')) {
				submitMessage(meeting, recipient, title, content);
			}
			
			return false;
		}
		
		// 쪽지 전송
		function submitMessage(meeting, recipient, title, content) {
			const messageData = {
				meeting: meeting,
				recipient: recipient,
				title: title,
				content: content
			};
			
			console.log('쪽지 데이터:', messageData);
			
			alert('쪽지가 성공적으로 전송되었습니다!');
			window.location.href = 'messages_list.jsp';
		}
		
		// 작성 취소
		function cancelWrite() {
			const title = document.getElementById('title').value.trim();
			const content = document.getElementById('content').value.trim();
			
			if (title || content) {
				if (confirm('작성 중인 쪽지가 있습니다. 정말 취소하시겠습니까?')) {
					window.location.href = 'messages_list.jsp';
				}
			} else {
				window.location.href = 'messages_list.jsp';
			}
		}
		
		// 페이지 이탈 방지
		let isSubmitting = false;
		
		window.addEventListener('beforeunload', function(e) {
			const title = document.getElementById('title').value.trim();
			const content = document.getElementById('content').value.trim();
			
			if (!isSubmitting && (title || content)) {
				e.preventDefault();
				e.returnValue = '';
			}
		});
		
		// 폼 제출시 이탈 방지 해제
		document.getElementById('messageForm').addEventListener('submit', function() {
			isSubmitting = true;
		});
	</script>
</body>
</html>