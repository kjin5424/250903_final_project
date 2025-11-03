<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//공지사항 게시물 번호 받기
	String noticeNum = request.getParameter("noticeNum");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 수정 - 공모자들</title>
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

.notice-number-badge {
	background: #2d5a29;
	color: white;
	padding: 6px 16px;
	border-radius: 20px;
	font-size: 14px;
	font-weight: 600;
	display: inline-flex;
	align-items: center;
	gap: 6px;
}

.form-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	padding: 40px;
}

.form-group {
	margin-bottom: 30px;
}

.form-label {
	display: block;
	font-size: 16px;
	font-weight: 600;
	color: #333;
	margin-bottom: 10px;
}

.form-label .required {
	color: #ff6b6b;
	margin-left: 4px;
}

.form-input {
	width: 100%;
	padding: 14px 16px;
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
	min-height: 400px;
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

.pin-section {
	background: #f8faf9;
	border: 2px solid #e8f5e6;
	border-radius: 10px;
	padding: 20px;
	margin-bottom: 30px;
}

.checkbox-wrapper {
	display: flex;
	align-items: center;
	gap: 12px;
	cursor: pointer;
}

.checkbox-input {
	width: 22px;
	height: 22px;
	cursor: pointer;
	accent-color: #2d5a29;
}

.checkbox-label {
	font-size: 16px;
	font-weight: 500;
	color: #333;
	cursor: pointer;
	user-select: none;
}

.checkbox-description {
	font-size: 13px;
	color: #666;
	margin-top: 8px;
	margin-left: 34px;
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

.info-box {
	background: #fff9e6;
	border-left: 4px solid #ffc107;
	padding: 16px;
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

.edit-info-box {
	background: #e8f5e6;
	border-left: 4px solid #2d5a29;
	padding: 16px;
	border-radius: 6px;
	margin-bottom: 30px;
}

.edit-info-box-title {
	font-weight: 600;
	color: #2d5a29;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.edit-info-box-content {
	font-size: 14px;
	color: #666;
	line-height: 1.6;
}

.meta-info {
	display: flex;
	gap: 20px;
	flex-wrap: wrap;
	font-size: 13px;
	color: #666;
	margin-top: 8px;
}

.meta-info-item {
	display: flex;
	align-items: center;
	gap: 6px;
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
		// 공지사항 ID 받기
		String noticeId = request.getParameter("id");
		if (noticeId == null) noticeId = "23";
		
		// 실제로는 DB에서 조회
		int noticeNumber = 23;
		String existingTitle = "2025년 새해 맞이 서비스 업데이트 안내";
		String existingContent = "안녕하세요, 공모자들 운영팀입니다.\n\n2025년 새해를 맞이하여 더 나은 서비스를 제공하기 위해 다음과 같은 업데이트를 진행하였습니다.\n\n주요 업데이트 내용:\n- 모임 검색 기능 개선: 키워드, 지역, 카테고리별 상세 검색이 가능해졌습니다.\n- 알림 기능 추가: 내가 참여한 모임의 새 소식을 실시간으로 받아볼 수 있습니다.\n- 프로필 커스터마이징: 프로필 사진과 소개글을 자유롭게 수정할 수 있습니다.\n- 모임 후기 시스템: 참여한 모임에 대한 후기를 작성하고 공유할 수 있습니다.\n- UI/UX 개선: 더 직관적이고 사용하기 편한 인터페이스로 개선되었습니다.";
		boolean isPinned = true;
		String author = "관리자";
		String createDate = "2025-01-05";
		int views = 1523;
	%>
	
	<div class="container">
		<div class="header">
			<div class="header-left">
				<a href="ManagerNoticeOpen.jsp?id=<%= noticeId %>" class="back-btn">←</a>
				<h1 class="page-title">✏️ 공지사항 수정</h1>
				<span class="notice-number-badge">
					<span>#</span>
					<span><%= noticeNumber %></span>
				</span>
			</div>
		</div>
		
		<div class="edit-info-box">
			<div class="edit-info-box-title">
				<span>📝</span>
				<span>수정 중인 공지사항 정보</span>
			</div>
			<div class="edit-info-box-content">
				게시물 번호 <%= noticeNumber %>번을 수정하고 있습니다.
				<div class="meta-info">
					<span class="meta-info-item">
						<strong>작성자:</strong> <%= author %>
					</span>
					<span class="meta-info-item">
						<strong>작성일:</strong> <%= createDate %>
					</span>
					<span class="meta-info-item">
						<strong>조회수:</strong> <%= String.format("%,d", views) %>회
					</span>
				</div>
			</div>
		</div>
		
		<div class="info-box">
			<div class="info-box-title">
				<span>💡</span>
				<span>공지사항 수정 가이드</span>
			</div>
			<div class="info-box-content">
				<ul>
					<li>수정 내용은 즉시 사용자에게 반영됩니다.</li>
					<li>중요한 변경사항이 있다면 공지사항 제목에 [수정] 표시를 권장합니다.</li>
					<li>상단 고정 설정을 변경할 수 있습니다.</li>
				</ul>
			</div>
		</div>
		
		<form id="noticeForm" onsubmit="return validateForm(event)">
			<input type="hidden" name="noticeId" value="<%= noticeId %>">
			
			<div class="form-container">
				<div class="form-group">
					<label class="form-label">
						제목<span class="required">*</span>
					</label>
					<input 
						type="text" 
						id="title" 
						name="title" 
						class="form-input" 
						placeholder="공지사항 제목을 입력하세요"
						maxlength="100"
						value="<%= existingTitle %>"
						required
					>
					<div class="char-count">
						<span id="titleCount"><%= existingTitle.length() %></span> / 100자
					</div>
				</div>
				
				<div class="form-group">
					<label class="form-label">
						내용<span class="required">*</span>
					</label>
					<textarea 
						id="content" 
						name="content" 
						class="form-textarea" 
						placeholder="공지사항 내용을 입력하세요"
						maxlength="5000"
						required
					><%= existingContent %></textarea>
					<div class="char-count">
						<span id="contentCount"><%= existingContent.length() %></span> / 5,000자
					</div>
				</div>
				
				<div class="pin-section">
					<label class="checkbox-wrapper">
						<input 
							type="checkbox" 
							id="isPinned" 
							name="isPinned" 
							class="checkbox-input"
							value="true"
							<%= isPinned ? "checked" : "" %>
						>
						<span class="checkbox-label">📌 상단 고정</span>
					</label>
					<div class="checkbox-description">
						이 공지사항을 목록 상단에 고정하여 사용자가 항상 볼 수 있도록 합니다.
					</div>
				</div>
				
				<div class="button-group">
					<button type="button" class="btn btn-cancel" onclick="location.href='noticelist.do'">
						<span>✕</span>
						<span>수정 취소</span>
					</button>
					<button type="submit" class="btn btn-submit">
						<span>✓</span>
						<span>수정 완료</span>
					</button>
				</div>
			</div>
		</form>
	</div>
	
	<script>
		// 원본 데이터 저장 (변경 감지용)
		const originalData = {
			title: '<%= existingTitle.replace("'", "\\'") %>',
			content: `<%= existingContent.replace("`", "\\`").replace("\n", "\\n") %>`,
			isPinned: <%= isPinned %>
		};
		
		// 제목 글자수 카운트
		const titleInput = document.getElementById('title');
		const titleCount = document.getElementById('titleCount');
		
		titleInput.addEventListener('input', function() {
			titleCount.textContent = this.value.length;
		});
		
		// 내용 글자수 카운트
		const contentInput = document.getElementById('content');
		const contentCount = document.getElementById('contentCount');
		
		contentInput.addEventListener('input', function() {
			contentCount.textContent = this.value.length;
		});
		
		// 폼 유효성 검사
		function validateForm(event) {
			event.preventDefault();
			
			const title = titleInput.value.trim();
			const content = contentInput.value.trim();
			
			if (!title) {
				alert('제목을 입력해주세요.');
				titleInput.focus();
				return false;
			}
			
			if (title.length < 5) {
				alert('제목은 최소 5자 이상 입력해주세요.');
				titleInput.focus();
				return false;
			}
			
			if (!content) {
				alert('내용을 입력해주세요.');
				contentInput.focus();
				return false;
			}
			
			if (content.length < 10) {
				alert('내용은 최소 10자 이상 입력해주세요.');
				contentInput.focus();
				return false;
			}
			
			// 변경사항 확인
			const isPinned = document.getElementById('isPinned').checked;
			const hasChanges = 
				title !== originalData.title || 
				content !== originalData.content || 
				isPinned !== originalData.isPinned;
			
			if (!hasChanges) {
				alert('변경된 내용이 없습니다.');
				return false;
			}
			
			// 최종 확인
			if (confirm('공지사항을 수정하시겠습니까?\n수정 내용은 즉시 사용자에게 공개됩니다.')) {
				// 여기서 실제 제출 처리
				submitEdit(title, content, isPinned);
			}
			
			return false;
		}
		
		// 공지사항 수정 제출
		function submitEdit(title, content, isPinned) {
			// 실제로는 서버로 데이터 전송
			//console.log('공지사항 ID:', '<%= noticeId %>');
			//console.log('제목:', title);
			//console.log('내용:', content);
			//console.log('상단 고정:', isPinned);
			
			alert('공지사항이 성공적으로 수정되었습니다!');
			window.location.href = 'ManagerNoticeOpen.jsp?id=' + <%=noticeId %>;
		}
		
		// 수정 취소
		function cancelEdit() {
			const title = titleInput.value.trim();
			const content = contentInput.value.trim();
			const isPinned = document.getElementById('isPinned').checked;
			
			const hasChanges = 
				title !== originalData.title || 
				content !== originalData.content || 
				isPinned !== originalData.isPinned;
			
			if (hasChanges) {
				if (confirm('수정 중인 내용이 있습니다. 정말 취소하시겠습니까?')) {
					window.location.href = 'ManagerNoticeOpen.jsp';
				}
			} else {
				window.location.href = 'ManagerNoticeOpen.jsp';
			}
		}
		
		// 페이지 이탈 방지
		let isSubmitting = false;
		
		window.addEventListener('beforeunload', function(e) {
			const title = titleInput.value.trim();
			const content = contentInput.value.trim();
			const isPinned = document.getElementById('isPinned').checked;
			
			const hasChanges = 
				title !== originalData.title || 
				content !== originalData.content || 
				isPinned !== originalData.isPinned;
			
			if (!isSubmitting && hasChanges) {
				e.preventDefault();
				e.returnValue = '';
			}
		});
		
		// 폼 제출시 이탈 방지 해제
		document.getElementById('noticeForm').addEventListener('submit', function() {
			isSubmitting = true;
		});
	</script>
</body>
</html>