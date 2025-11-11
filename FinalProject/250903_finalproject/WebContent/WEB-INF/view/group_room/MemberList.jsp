<%@ page contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" %>
<% 
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들 - 모임원 리스트</title>

<!-- 기존 CSS 파일 import -->
<link rel="stylesheet" href="<%=cp %>/css_new/common_sample.css">
<link rel="stylesheet" href="<%=cp %>/css_new/board_sample.css">
<link rel="stylesheet" href="<%=cp %>/css_new/memberList_sample.css">

<script>
    // 현재 사용자가 모임원인지 여부 (서버에서 전달받아야 함)
    const isGroupMember = true; // 실제로는 서버에서 값을 받아와야 합니다
    
    function openModal(nickName, role, intro, avatarText) {
    	selectedNikName = nickName;
        document.getElementById('modal-avatar').textContent = avatarText;
        document.getElementById('modal-name').textContent = nickName;
        
        const roleElement = document.getElementById('modal-role');
        roleElement.textContent = role;
        roleElement.className = 'modal-role';
        
        // 역할에 따른 클래스 추가
        if (role === '모임장') {
            roleElement.classList.add('leader');
        } else if (role === '부모임장') {
            roleElement.classList.add('sub-leader');
        } else if (role === '도우미') {
            roleElement.classList.add('helper');
        } else {
            roleElement.classList.add('member');
        }
        
        document.getElementById('modal-intro').textContent = intro;
        
        // 모임원인 경우 쪽지 버튼 표시
        const actionsContainer = document.getElementById('modal-actions');
        const messageBtn = document.getElementById('message-btn');
        
        if (isGroupMember) {
            // 모임원이면 3칸 레이아웃
            actionsContainer.className = 'modal-actions member-only';
            messageBtn.style.display = 'flex';
        } else {
            // 모임원 아니면 2칸 레이아웃 (프로필 2, 신고 1)
            actionsContainer.className = 'modal-actions no-message';
            messageBtn.style.display = 'none';
        }
        
        document.getElementById('modal-overlay').classList.add('active');
        
    }

    function closeModal() {
        document.getElementById('modal-overlay').classList.remove('active');
    }
    
    function goToProfile(nickName) {
        location.href = 'profile.do?nickName=' + encodeURIComponent(selectedNikName, "UTF-8");
    }
    
    function sendMessage() {
        alert('쪽지 작성 페이지로 이동합니다.');
        // 실제로는 location.href = 'message.do?userId=xxx';
    }
    
    function reportUser() {
        if (confirm('이 사용자를 신고하시겠습니까?')) {
            //alert('신고가 접수되었습니다.');
        	// 신고 페이지로 이동 (모임원 신고용)
            window.location.href = "<%=cp%>/reportmember.do";
        }
    }
    
    // 모달 외부 클릭 시 닫기
    document.addEventListener('DOMContentLoaded', function() {
        const modalOverlay = document.getElementById('modal-overlay');
        modalOverlay.addEventListener('click', function(e) {
            if (e.target === modalOverlay) {
                closeModal();
            }
        });
    });
</script>

</head>
<body>
    <!-- 상단바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

    <!-- 사이드바 -->
    <c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />

    <!-- 메인 컨테이너 -->
    <div class="main-container">
        <div class="board-container">
            <!-- 게시판 헤더 -->
            <div class="board-header">
                <h1 class="board-title">
                    <span class="board-title-icon">👥</span>
                    ${title } - 모임원
                </h1>
            </div>

            <!-- 모임원 목록 -->
            <div class="members-grid">
            	<c:forEach var="user" items="${groupUserList }">
	                <div class="member-card" 
	                	onclick="openModal('${user.nickName}'
	                					 , '${user.position }'
	                					 , '${user.selfIntroduction }'
	                					 , '${not empty user.savePath ? user.savePath :  fn:substring(user.nickName, 0, 1)}')">
	                    <div class="member-header">
	                        <c:choose>
	                        	<c:when test="${user.position == '모임장' }">
	                        		<div class="member-role-badge leader">${user.position }</div>
	                        	</c:when>
	                        	<c:when test="${user.position == '부모임장' }">
	                        		<div class="member-role-badge sub-leader">${user.position }</div>
	                        	</c:when>
	                        	<c:when test="${user.position == '도우미' }">
	                        		<div class="member-role-badge helper">${user.position }</div>
	                        	</c:when>
	                        </c:choose>
	                        <div class="member-avatar">${not empty user.savePath ? user.savePath :  fn:substring(user.nickName, 0, 1)}</div>
	                    </div>
	                    <div class="member-info">
	                        <div class="member-name">${user.nickName }</div>
	                        <div class="member-intro">${user.selfIntroduction }</div>
	                    </div>
	                </div>
            	</c:forEach>
            </div>
        </div>
    </div>

    <!-- 모달 -->
    <div id="modal-overlay" class="modal-overlay">
        <div class="modal-content">
            <button class="modal-close" onclick="closeModal()">×</button>
            
            <div class="modal-header">
                <div class="modal-avatar" id="modal-avatar">👤</div>
                <h2 class="modal-name" id="modal-name"></h2>
                <span class="modal-role" id="modal-role"></span>
            </div>
            
            <div class="modal-body">
                <p class="modal-intro" id="modal-intro"></p>
                
                <div id="modal-actions" class="modal-actions no-message">
                    <button class="modal-btn profile" onclick="goToProfile()">
                        <span class="modal-btn-icon">👤</span>
                        <span>프로필 보기</span>
                    </button>
                    
                    <button id="message-btn" class="modal-btn message" onclick="sendMessage()" style="display: none;">
                        <span class="modal-btn-icon">💌</span>
                        <span>쪽지 보내기</span>
                    </button>
                    
                    <button class="modal-btn report" onclick="reportUser()">
                        <span class="modal-btn-icon">🚨</span>
                        <span>신고하기</span>
                    </button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
