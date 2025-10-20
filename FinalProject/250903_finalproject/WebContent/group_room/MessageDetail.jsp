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
<title>쪽지 확인 - 공모자들</title>
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
	margin-top: 20px;
	margin-bottom: 20px;
	
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

#title
{
	width: 100%;
	padding: 16px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 15px;
	font-family: inherit;
	resize: none;
	transition: all 0.2s ease;
	line-height: 1.6;
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
		<jsp:include page="/common/TopMenuBar.jsp" />
	</div>
	
	<div class="container">
				
				<!-- 발신자 정보 표시 -->
				<div class="recipient-info" id="recipientInfo">
					<div class="recipient-info-title">쪽지 발신자 정보</div>
					<div class="recipient-details">
						<div class="recipient-details-item">
							<span class="recipient-details-label">닉네임: 코딩왕</span>
						</div>
						<div class="recipient-details-item">
							<span class="recipient-details-label">가입일: 2024-01-15</span>
						</div>
						<div class="recipient-details-item">
							<span class="recipient-details-label">역할: 모임장</span>
						</div>
					</div>
				</div>
				
				<!-- 제목 -->
				<div class="form-group">
					<label class="form-label">
						제목
					</label>
					<input type="text" id="title" value="안녕하세요, 반갑습니다." readonly="readonly"
					maxlength="100">
					
				</div>
				
				<!-- 내용 -->
				<div class="form-group">
					<label class="form-label">
						내용
					</label>
					<textarea 
						id="content" 
						name="content" 
						class="form-textarea" 
					>우리 한 번 잘 해봅시다. 잘 부탁합니다.</textarea>
				</div>
				
				<div class="button-group">
					<button type="button" class="btn btn-cancel" onclick="goBack()">
						<span>✕</span>
						<span>뒤로가기</span>
					</button>
					<button type="button" class="btn btn-submit" onclick="goWrite()">
						<span>📨</span>
						<span>답장 보내기</span>
					</button>
				</div>
	</div>
		
	<script>
		// 뒤로 가기
		// 이전 페이지가 어딘지 몰라서 일단 group-romm 하위의 Home.jsp 로 보냈습니다.
		function goBack() 
		{
			document.location.href="${cp}/group_room/Home.jsp";	
		}
	
		// 답장 작성하러 가기
		function goWrite() 
		{
			document.location.href="${cp}/group_room/MesseageWrite.jsp";	
		}
	</script>

<%@ page contentType="text/html; charset=UTF-8"%>