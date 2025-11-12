<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공모자들 - 본인 확인</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" href="<%=cp%>/css/cssAuthorization/Login.css">
<style type="text/css">

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

.modal-buttons {
	display: flex;
	gap: 10px;
}

.password-modal {
	background: white;
	border-radius: 16px;
	padding: 40px;
	max-width: 400px;
	width: 90%;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 1000;
}

</style>
</head>
<body>
    <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
	<form action="${pageContext.request.contextPath}/profilemodifycheck.do" method="post">
	<div class="modal-overlay">
		<div class="password-modal">
			<c:if test="${not empty error }">
				<p class="modal-description">${error }</p>
			</c:if>
			<h2 class="modal-title">🔒 본인 확인</h2>
			<p class="modal-description">개인정보 보호를 위해<br>비밀번호를 다시 한 번 입력해주세요.</p>
			<div class="form-group">
					<label class="form-label" for="password">비밀번호</label>
					<div class="form-input-wrapper">
						<input type="password" id="password" name="password"
							class="form-input" placeholder="비밀번호를 입력하세요"
							autocomplete="current-password" required> <span
							class="input-icon">🔒</span>
					</div>
				</div>
			<div class="modal-buttons">
				<button class="modal-btn modal-btn-cancel" type="reset">취소</button>
				<button class="modal-btn modal-btn-confirm" type="submit">확인</button>
			</div>
		</div>
	</div>
	</form>


</body>
</html>