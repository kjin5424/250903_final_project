<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>쪽지 작성 - 공모자들</title>

<!-- CSS 파일 임포트 -->
<link rel="stylesheet" href="<%=cp %>/css_new/common_sample.css">
<link rel="stylesheet" href="<%=cp %>/css_new/board_sample.css">
<link rel="stylesheet" href="<%=cp %>/css_new/messagelist.css">
<link rel="stylesheet" href="<%=cp %>/css_new/writepage.css">

<style type="text/css">
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
</style>

</head>
<body>
<!-- 상단바 -->
<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
<!-- 사이드바 -->
<c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />
	
<div class="write-container">
	<div class="write-form">
		<h1 class="write-title">💬쪽지 작성</h1>
		
		<div class="info-box">
			<div class="info-box-title">
				<span>💡</span>
				<span>쪽지 작성 가이드</span>
			</div>
			<div class="info-box-content">
				<ul>
					<!-- <li>같은 모임에 참여하고 있는 모임원들에게만 쪽지를 보낼 수 있습니다.</li> -->
					<!-- <li>쪽지는 상대방이 언제든지 확인할 수 있도록 보관됩니다.</li> -->
					<li>정중하고 성숙한 내용의 쪽지 작성을 부탁드립니다.</li>
					<li>부적절한 내용의 쪽지는 신고 대상이 될 수 있습니다.</li>
				</ul>
			</div>
		</div>
		
		<form action="messagewriteOk.do" id="messageForm" method="POST" >
				<!-- 
				모임 선택
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
				 -->
				<!-- 수신자 선택 -->
				<div class="form-group mt-lg">
					<label class="form-label">
						수신자
					</label>
					<select id="receiver" name="receiver" class="selectReceiver" required>
					    <option value="select">받는 사람을 선택하세요</option>
					    <c:forEach var="user" items="${userList}">
					        <c:if test="${user.receiver ne forwarder}">
					            <c:choose>
					                <c:when test="${user.position eq '모임장'}">
					                    <option value="${user.receiver}"> ${user.nickName}👑</option>
					                </c:when>
					                <c:when test="${user.position eq '부모임장'}">
					                    <option value="${user.receiver}"> ${user.nickName}⭐</option>
					                </c:when>
					                <c:when test="${user.position eq '도우미'}">
					                    <option value="${user.receiver}"> ${user.nickName}🤝</option>
					                </c:when>
					                <c:otherwise>
					                    <option value="${user.receiver}">${user.nickName}</option>
					                </c:otherwise>
					            </c:choose>
					        </c:if>
					    </c:forEach>
					</select>
				</div>
				<!-- 쪽지내용 -->
				<div class="form-group mt-lg">
					<label class="form-label">내용</label>
					<textarea 
						id="content" 
						name="content" 
						class="form-textarea" 
						placeholder="쪽지 내용을 입력하세요"
						maxlength="1000"
						required
					></textarea>
					<div class="char-count">
						<span id="contentCount">0</span> / 1,000자
					</div>
				</div>
				
				<div class="form-actions">
					<button type="button" class="btn btn-ghost" onclick="cancelWrite()">취소</button>
					<button type="button" class="btn btn-primary" id="submitBtn">📨쪽지 보내기</button>
				</div>
		</form><!-- messageForm -->
	</div>
</div>
		
<script>

// 쪽지 전송
$("#submitBtn").click(function()
{
	var selectReceiver = $(".selectReceiver").val();
	var content = $("#content").val().trim();
	
	if (selectReceiver == "select") {
        alert("받는 사람을 선택하세요.");
        $(".selectReceiver").focus();
        return;
    }
	if (!content) {
        alert("내용을 입력해주세요.");
        $("#content").focus();
        return;
    }
	$("#messageForm").submit();
})

// 작성 취소
function cancelWrite() {
	const content = document.getElementById('content').value.trim();
	
	if (content) {
		if (confirm('작성 중인 쪽지가 있습니다. 정말 취소하시겠습니까?')) {
			window.location.href = 'messagelist.do';
		}
	} else {
		window.location.href = 'messagelist.do';
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

// 내용 글자수 카운트
const contentInput = document.getElementById('content');
const contentCount = document.getElementById('contentCount');

contentInput.addEventListener('input', function() {
	contentCount.textContent = this.value.length;
	updateSubmitButton();
});

// 폼 제출시 이탈 방지 해제
document.getElementById('messageForm').addEventListener('submit', function() {
	isSubmitting = true;
});
</script>
</body>
</html>