<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 작성 - 공모자들</title>
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
	<div class="container">
		<div class="header">
			<div class="header-left">
				<a href="admin_notice_list.jsp" class="back-btn">←</a>
				<h1 class="page-title">📝 공지사항 작성</h1>
			</div>
		</div>
		
		<div class="info-box">
			<div class="info-box-title">
				<span>💡</span>
				<span>공지사항 작성 가이드</span>
			</div>
			<div class="info-box-content">
				<ul>
					<li>명확하고 간결한 제목을 작성해주세요.</li>
					<li>중요한 내용은 강조하여 사용자가 쉽게 확인할 수 있도록 해주세요.</li>
					<li>상단 고정은 최대 3개까지 권장됩니다.</li>
				</ul>
			</div>
		</div>
		
		<form id="noticeForm" onsubmit="return validateForm(event)">
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
						required
					>
					<div class="char-count">
						<span id="titleCount">0</span> / 100자
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
						placeholder="공지사항 내용을 입력하세요&#13;&#10;&#13;&#10;- 상세한 내용을 작성해주세요&#13;&#10;- 필요시 목록 형태로 작성하시면 가독성이 좋습니다"
						maxlength="5000"
						required
					></textarea>
					<div class="char-count">
						<span id="contentCount">0</span> / 5,000자
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
						>
						<span class="checkbox-label">📌 상단 고정</span>
					</label>
					<div class="checkbox-description">
						이 공지사항을 목록 상단에 고정하여 사용자가 항상 볼 수 있도록 합니다.
					</div>
				</div>
				
				<div class="button-group">
					<button type="button" class="btn btn-cancel" onclick="cancelWrite()">
						<span>✕</span>
						<span>작성 취소</span>
					</button>
					<button type="submit" class="btn btn-submit">
						<span>✓</span>
						<span>게시하기</span>
					</button>
				</div>
			</div>
		</form>
	</div>
	
	<script>
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
			
			const isPinned = document.getElementById('isPinned').checked;
			
			// 최종 확인
			const message = isPinned 
				? '이 공지사항을 상단에 고정하여 게시하시겠습니까?' 
				: '공지사항을 게시하시겠습니까?';
				
			if (confirm(message)) {
				// 여기서 실제 제출 처리
				submitNotice(title, content, isPinned);
			}
			
			return false;
		}
		
		// 공지사항 제출
		function submitNotice(title, content, isPinned) {
			// 실제로는 서버로 데이터 전송
			console.log('제목:', title);
			console.log('내용:', content);
			console.log('상단 고정:', isPinned);
			
			alert('공지사항이 성공적으로 게시되었습니다!');
			window.location.href = 'noticelist.do';
		}
		
		// 작성 취소
		function cancelWrite() {
			const title = titleInput.value.trim();
			const content = contentInput.value.trim();
			
			if (title || content) {
				if (confirm('작성 중인 내용이 있습니다. 정말 취소하시겠습니까?')) {
					window.location.href = 'noticelist.do';
				}
			} else {
				window.location.href = 'noticelist.do';
			}
		}
		
		// 페이지 이탈 방지
		let isSubmitting = false;
		
		window.addEventListener('beforeunload', function(e) {
			const title = titleInput.value.trim();
			const content = contentInput.value.trim();
			
			if (!isSubmitting && (title || content)) {
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