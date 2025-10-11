<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>문의 상세 및 답변 - 공모자들</title>
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
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	flex-wrap: wrap;
	gap: 20px;
}

.header-left {
	display: flex;
	align-items: center;
	gap: 15px;
}

.back-btn {
	background: #e8f5e6;
	color: #2d5a29;
	border: none;
	padding: 10px 16px;
	border-radius: 8px;
	cursor: pointer;
	font-size: 20px;
	transition: all 0.2s ease;
	text-decoration: none;
	display: flex;
	align-items: center;
}

.back-btn:hover {
	background: #d4ecd1;
	transform: translateX(-3px);
}

.page-title {
	font-size: 32px;
	font-weight: bold;
	color: #2d5a29;
}

.inquiry-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	overflow: hidden;
	margin-bottom: 20px;
}

.inquiry-header {
	padding: 30px 40px;
	border-bottom: 2px solid #f0f0f0;
}

.inquiry-title-section {
	display: flex;
	align-items: flex-start;
	gap: 12px;
	margin-bottom: 20px;
}

.inquiry-badge {
	background: #2d5a29;
	color: white;
	padding: 6px 14px;
	border-radius: 12px;
	font-size: 13px;
	font-weight: bold;
	flex-shrink: 0;
}

.inquiry-title {
	font-size: 28px;
	font-weight: bold;
	color: #333;
	line-height: 1.4;
	word-break: keep-all;
}

.inquiry-meta {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
	padding: 20px 40px;
	background: #f8faf9;
	border-bottom: 1px solid #e8f5e6;
}

.meta-item {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.meta-label {
	color: #666;
	font-size: 13px;
	font-weight: 500;
}

.meta-value {
	color: #333;
	font-size: 15px;
	font-weight: 600;
}

.meta-value.highlight {
	color: #2d5a29;
	font-size: 16px;
}

.status-badge {
	display: inline-block;
	padding: 6px 14px;
	border-radius: 16px;
	font-size: 13px;
	font-weight: 600;
	white-space: nowrap;
}

.status-pending {
	background: #fff3e0;
	color: #f57c00;
}

.status-answered {
	background: #e8f5e9;
	color: #388e3c;
}

.inquiry-content {
	padding: 40px;
}

.content-section {
	margin-bottom: 30px;
}

.content-section-title {
	font-size: 18px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 2px solid #e8f5e6;
}

.content-text {
	line-height: 1.8;
	font-size: 15px;
	color: #333;
	word-break: keep-all;
	background: #f8faf9;
	padding: 20px;
	border-radius: 8px;
	border-left: 4px solid #a8d5a1;
	white-space: pre-wrap;
}

.warning-box {
	background: #fff9e6;
	border-left: 4px solid #ffc107;
	padding: 16px 20px;
	margin: 0 40px 20px 40px;
	border-radius: 6px;
}

.warning-box-title {
	font-weight: 600;
	color: #f57c00;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.warning-box-content {
	font-size: 14px;
	color: #666;
	line-height: 1.6;
}

.answer-section {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	padding: 40px;
}

.answer-section-title {
	font-size: 22px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.form-group {
	margin-bottom: 20px;
}

.form-label {
	display: block;
	font-size: 16px;
	font-weight: 600;
	color: #333;
	margin-bottom: 10px;
}

.required {
	color: #ff6b6b;
	margin-left: 4px;
}

.form-textarea {
	width: 100%;
	min-height: 250px;
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

.form-textarea:disabled {
	background: #f5f5f5;
	cursor: not-allowed;
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

.button-group {
	display: flex;
	gap: 12px;
	justify-content: flex-end;
	padding-top: 20px;
	border-top: 1px solid #f0f0f0;
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

.answered-section {
	background: #e8f5e6;
	border-left: 4px solid #2d5a29;
	padding: 20px;
	border-radius: 8px;
}

.answered-title {
	font-weight: 600;
	color: #2d5a29;
	margin-bottom: 12px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.answered-content {
	color: #333;
	font-size: 15px;
	line-height: 1.8;
	white-space: pre-wrap;
	background: white;
	padding: 16px;
	border-radius: 6px;
	margin-bottom: 12px;
}

.answered-info {
	font-size: 13px;
	color: #666;
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
}

.template-section {
	background: #f8faf9;
	border: 2px solid #e8f5e6;
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 20px;
}

.template-title {
	font-weight: 600;
	color: #2d5a29;
	margin-bottom: 15px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.template-list {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.template-item {
	background: white;
	padding: 12px 16px;
	border-radius: 8px;
	cursor: pointer;
	transition: all 0.2s ease;
	font-size: 14px;
	color: #666;
	border: 1px solid #e0e0e0;
}

.template-item:hover {
	background: #e8f5e6;
	border-color: #a8d5a1;
	color: #2d5a29;
	transform: translateX(5px);
}

/* 반응형 */
@media (max-width: 768px) {
	body {
		padding: 20px 10px;
	}
	
	.page-title {
		font-size: 24px;
	}
	
	.inquiry-header,
	.inquiry-meta,
	.inquiry-content,
	.answer-section {
		padding: 20px;
	}
	
	.warning-box,
	.answered-section {
		margin: 0 20px 20px 20px;
	}
	
	.inquiry-title {
		font-size: 22px;
	}
	
	.inquiry-meta {
		grid-template-columns: 1fr;
		gap: 15px;
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
	<%
		// 문의 ID 받기
		String inquiryId = request.getParameter("id");
		if (inquiryId == null) inquiryId = "45";
		
		// 실제로는 DB에서 조회
		String inquiryNumber = inquiryId;
		String userId = "user123";
		String userEmail = "user123@example.com";
		String title = "회원탈퇴는 어떻게 하나요?";
		String content = "회원탈퇴를 하고 싶은데 방법을 모르겠습니다.\n\n마이페이지를 들어가봤는데 탈퇴 메뉴가 보이지 않네요.\n탈퇴 절차와 주의사항에 대해 알려주세요.\n\n탈퇴하면 데이터는 모두 삭제되나요?";
		String inquiryDate = "2025-01-10 14:30:25";
		String status = "답변대기";
		String statusClass = "status-pending";
		boolean isAnswered = false;
		
		// 답변이 있는 경우
		String answerContent = "";
		String answerDate = "";
		String answerAdmin = "";
		
		if ("43".equals(inquiryId)) {
			isAnswered = true;
			status = "답변완료";
			statusClass = "status-answered";
			answerContent = "안녕하세요, 공모자들 고객지원팀입니다.\n\n회원탈퇴 방법을 안내해드리겠습니다.\n\n1. 로그인 후 마이페이지 접속\n2. 우측 상단 '설정' 메뉴 클릭\n3. 하단의 '계정 관리' 섹션에서 '회원탈퇴' 버튼 클릭\n4. 탈퇴 사유 선택 및 비밀번호 확인\n5. 최종 확인 후 탈퇴 완료\n\n탈퇴 시 주의사항:\n- 탈퇴 후 30일간 재가입이 제한됩니다.\n- 모든 활동 내역 및 작성한 게시글이 삭제됩니다.\n- 참여 중인 모임이 있다면 먼저 탈퇴해야 합니다.\n- 진행 중인 결제나 환불이 있다면 완료 후 탈퇴하시기 바랍니다.\n\n추가 문의사항이 있으시면 언제든지 연락 주세요.\n감사합니다.";
			answerDate = "2025-01-10 16:20:15";
			answerAdmin = "admin01";
		}
	%>
	
	<div class="container">
		<div class="header">
			<div class="header-left">
				<a href="<%=cp %>/manager/inquiry/InquiryList.jsp" class="back-btn">←</a>
				<h1 class="page-title">문의 상세 및 답변</h1>
			</div>
		</div>
		
		<div class="inquiry-container">
			<div class="inquiry-header">
				<div class="inquiry-title-section">
					<span class="inquiry-badge">💬 문의번호 #<%= inquiryNumber %></span>
					<h2 class="inquiry-title"><%= title %></h2>
				</div>
			</div>
			
			<div class="inquiry-meta">
				<div class="meta-item">
					<span class="meta-label">작성자 아이디</span>
					<span class="meta-value highlight"><%= userId %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">이메일</span>
					<span class="meta-value"><%= userEmail %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">작성일시</span>
					<span class="meta-value"><%= inquiryDate %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">답변상태</span>
					<span class="meta-value">
						<span class="status-badge <%= statusClass %>"><%= status %></span>
					</span>
				</div>
			</div>
			
			<% if (!isAnswered) { %>
			<div class="warning-box">
				<div class="warning-box-title">
					<span>⏰</span>
					<span>답변 대기 중</span>
				</div>
				<div class="warning-box-content">
					이 문의는 아직 답변되지 않았습니다. 하단에서 답변을 작성해주세요.
				</div>
			</div>
			<% } %>
			
			<div class="inquiry-content">
				<div class="content-section">
					<h3 class="content-section-title">📋 문의 내용</h3>
					<div class="content-text"><%= content %></div>
				</div>
			</div>
		</div>
		
		<% if (isAnswered) { %>
		<!-- 답변 완료된 경우 -->
		<div class="answer-section">
			<div class="answer-section-title">
				<span>✅</span>
				<span>답변 내용</span>
			</div>
			
			<div class="answered-section">
				<div class="answered-title">
					<span>💬</span>
					<span>관리자 답변</span>
				</div>
				<div class="answered-content"><%= answerContent %></div>
				<div class="answered-info">
					<span><strong>답변일시:</strong> <%= answerDate %></span>
					<span><strong>답변관리자:</strong> <%= answerAdmin %></span>
				</div>
			</div>
			
			<div class="button-group">
				<a href="admin_inquiry_list.jsp" class="btn btn-cancel">
					<span>📋</span>
					<span>목록으로</span>
				</a>
			</div>
		</div>
		
		<% } else { %>
		<!-- 답변 작성 폼 -->
		<div class="answer-section">
			<div class="answer-section-title">
				<span>✏️</span>
				<span>답변 작성</span>
			</div>
			
			<div class="template-section">
				<div class="template-title">
					<span>📝</span>
					<span>답변 템플릿</span>
				</div>
				<div class="template-list">
					<div class="template-item" onclick="applyTemplate('general')">
						📌 일반 답변 양식
					</div>
					<div class="template-item" onclick="applyTemplate('account')">
						📌 계정 관련 답변 양식
					</div>
					<div class="template-item" onclick="applyTemplate('refund')">
						📌 환불 관련 답변 양식
					</div>
					<div class="template-item" onclick="applyTemplate('technical')">
						📌 기술 지원 답변 양식
					</div>
				</div>
			</div>
			
			<form id="answerForm" onsubmit="return validateAnswer(event)">
				<div class="form-group">
					<label class="form-label">
						답변 내용<span class="required">*</span>
					</label>
					<textarea 
						id="answerContent" 
						name="answerContent" 
						class="form-textarea" 
						placeholder="문의에 대한 답변을 작성해주세요.&#13;&#10;&#13;&#10;답변 작성 가이드:&#13;&#10;- 친절하고 정중한 언어 사용&#13;&#10;- 구체적이고 명확한 설명 제공&#13;&#10;- 단계별 안내가 필요한 경우 번호 매기기&#13;&#10;- 추가 문의 시 연락 방법 안내"
						maxlength="2000"
						required
					></textarea>
					<div class="char-count">
						<span id="answerCount">0</span> / 2,000자
					</div>
					<p class="form-help">답변은 사용자의 이메일(<%= userEmail %>)로 자동 발송됩니다.</p>
				</div>
				
				<div class="button-group">
					<a href="<%=cp %>/manager/inquiry/InquiryList.jsp" class="btn btn-cancel">
						<span>✕</span>
						<span>취소</span>
					</a>
					<button type="submit" class="btn btn-submit">
						<span>📨</span>
						<span>답변 보내기</span>
					</button>
				</div>
			</form>
		</div>
		<% } %>
	</div>
	
	<script>
		// 답변 글자수 카운트
		const answerTextarea = document.getElementById('answerContent');
		const answerCount = document.getElementById('answerCount');
		
		if (answerTextarea) {
			answerTextarea.addEventListener('input', function() {
				answerCount.textContent = this.value.length;
			});
		}
		
		// 템플릿 적용
		function applyTemplate(type) {
			if (!answerTextarea) return;
			
			if (answerTextarea.value.trim()) {
				if (!confirm('작성 중인 내용이 있습니다. 템플릿을 적용하시겠습니까?')) {
					return;
				}
			}
			
			let template = '';
			
			switch(type) {
				case 'general':
					template = '안녕하세요, 공모자들 고객지원팀입니다.\n\n문의해주신 내용에 대해 답변드립니다.\n\n[여기에 구체적인 답변 내용을 작성해주세요]\n\n추가 문의사항이 있으시면 언제든지 연락 주세요.\n감사합니다.';
					break;
				case 'account':
					template = '안녕하세요, 공모자들 고객지원팀입니다.\n\n계정 관련 문의에 대해 답변드립니다.\n\n[계정 관련 안내 내용]\n\n계정 보안을 위해:\n- 비밀번호는 정기적으로 변경해주세요\n- 개인정보는 타인과 공유하지 마세요\n- 의심스러운 활동 발견 시 즉시 신고해주세요\n\n추가 도움이 필요하시면 언제든지 문의해주세요.\n감사합니다.';
					break;
				case 'refund':
					template = '안녕하세요, 공모자들 고객지원팀입니다.\n\n환불 관련 문의에 대해 답변드립니다.\n\n환불 처리 절차:\n1. 환불 사유 확인\n2. 환불 조건 검토\n3. 승인 후 처리 (영업일 기준 3-5일)\n\n환불 정책:\n- [정책 내용]\n\n환불 진행 상황은 이메일로 안내드리겠습니다.\n추가 문의사항이 있으시면 연락 주세요.\n감사합니다.';
					break;
				case 'technical':
					template = '안녕하세요, 공모자들 기술지원팀입니다.\n\n기술적인 문제에 대해 답변드립니다.\n\n문제 해결 방법:\n1. [첫 번째 단계]\n2. [두 번째 단계]\n3. [세 번째 단계]\n\n만약 위 방법으로 해결되지 않는 경우:\n- 사용 중인 브라우저와 버전 확인\n- 캐시 및 쿠키 삭제 시도\n- 다른 브라우저에서 테스트\n\n계속 문제가 발생하면 스크린샷과 함께 재문의 부탁드립니다.\n감사합니다.';
					break;
			}
			
			answerTextarea.value = template;
			answerCount.textContent = template.length;
			answerTextarea.focus();
			answerTextarea.scrollIntoView({ behavior: 'smooth', block: 'center' });
		}
		
		// 답변 유효성 검사
		function validateAnswer(event) {
			event.preventDefault();
			
			const answer = answerTextarea.value.trim();
			
			if (!answer) {
				alert('답변 내용을 입력해주세요.');
				answerTextarea.focus();
				return false;
			}
			
			if (answer.length < 20) {
				alert('답변은 최소 20자 이상 입력해주세요.');
				answerTextarea.focus();
				return false;
			}
			
			// 최종 확인
			if (confirm('답변을 전송하시겠습니까?\n\n답변은 사용자의 이메일(<%= userEmail %>)로 발송됩니다.')) {
				submitAnswer(answer);
			}
			
			return false;
		}
		
		// 답변 제출
		function submitAnswer(answer) {
			// 실제로는 서버로 데이터 전송
			const answerData = {
				inquiryId: '<%= inquiryId %>',
				userId: '<%= userId %>',
				userEmail: '<%= userEmail %>',
				answerContent: answer
			};
			
			console.log('답변 데이터:', answerData);
			
			alert('답변이 성공적으로 전송되었습니다!');
			window.location.href = 'admin_inquiry_list.jsp';
		}
		
		// 페이지 이탈 방지
		<% if (!isAnswered) { %>
		let isSubmitting = false;
		
		window.addEventListener('beforeunload', function(e) {
			const answer = answerTextarea.value.trim();
			
			if (!isSubmitting && answer) {
				e.preventDefault();
				e.returnValue = '';
			}
		});
		
		// 폼 제출시 이탈 방지 해제
		document.getElementById('answerForm').addEventListener('submit', function() {
			isSubmitting = true;
		});
		<% } %>
	</script>
</body>
</html>