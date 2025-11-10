<%@ page contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
    
    function openModal(name, role, intro, avatarText) {
        document.getElementById('modal-avatar').textContent = avatarText;
        document.getElementById('modal-name').textContent = name;
        
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
    
    function goToProfile() {
        alert('프로필 페이지로 이동합니다.');
        // 실제로는 location.href = 'profile.do?userId=xxx';
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
                    알고리즘 정복 스터디 - 모임원
                </h1>
            </div>

            <!-- 모임원 목록 -->
            <div class="members-grid">
                <!-- 모임장 -->
                <div class="member-card" onclick="openModal('코딩마스터', '모임장', '알고리즘과 코딩 교육 전문가입니다. 함께 성장하는 스터디를 만들어가요!', '코')">
                    <div class="member-header">
                        <div class="member-role-badge leader">모임장</div>
                        <div class="member-avatar">코</div>
                    </div>
                    <div class="member-info">
                        <div class="member-name">코딩마스터</div>
                        <div class="member-intro">알고리즘과 코딩 교육 전문가입니다. 함께 성장하는 스터디를 만들어가요!</div>
                    </div>
                </div>

                <!-- 부모임장 -->
                <div class="member-card" onclick="openModal('서브리더', '부모임장', '모임장을 보좌하며 스터디 운영을 돕고 있습니다.', '서')">
                    <div class="member-header">
                        <div class="member-role-badge sub-leader">부모임장</div>
                        <div class="member-avatar">서</div>
                    </div>
                    <div class="member-info">
                        <div class="member-name">서브리더</div>
                        <div class="member-intro">모임장을 보좌하며 스터디 운영을 돕고 있습니다.</div>
                    </div>
                </div>

                <!-- 도우미 -->
                <div class="member-card" onclick="openModal('헬퍼', '도우미', '문제 해설과 자료 정리를 담당하고 있습니다.', '헬')">
                    <div class="member-header">
                        <div class="member-role-badge helper">도우미</div>
                        <div class="member-avatar">헬</div>
                    </div>
                    <div class="member-info">
                        <div class="member-name">헬퍼</div>
                        <div class="member-intro">문제 해설과 자료 정리를 담당하고 있습니다.</div>
                    </div>
                </div>

                <!-- 모임원 -->
                <div class="member-card" onclick="openModal('민수', '모임원', '문제를 같이 풀며 성장하고 싶습니다. 열심히 참여하겠습니다!', '민')">
                    <div class="member-header">
                        <div class="member-role-badge member">모임원</div>
                        <div class="member-avatar">민</div>
                    </div>
                    <div class="member-info">
                        <div class="member-name">민수</div>
                        <div class="member-intro">문제를 같이 풀며 성장하고 싶습니다. 열심히 참여하겠습니다!</div>
                    </div>
                </div>

                <div class="member-card" onclick="openModal('지연', '모임원', '매주 성실하게 참여합니다. 함께 공부하며 좋은 인연이 되었으면 합니다.', '지')">
                    <div class="member-header">
                        <div class="member-role-badge member">모임원</div>
                        <div class="member-avatar">지</div>
                    </div>
                    <div class="member-info">
                        <div class="member-name">지연</div>
                        <div class="member-intro">매주 성실하게 참여합니다. 함께 공부하며 좋은 인연이 되었으면 합니다.</div>
                    </div>
                </div>

                <div class="member-card" onclick="openModal('하준', '모임원', 'CS 공부에 관심이 많습니다. 스터디를 통해 더 성장하고 싶어요!', '하')">
                    <div class="member-header">
                        <div class="member-role-badge member">모임원</div>
                        <div class="member-avatar">하</div>
                    </div>
                    <div class="member-info">
                        <div class="member-name">하준</div>
                        <div class="member-intro">CS 공부에 관심이 많습니다. 스터디를 통해 더 성장하고 싶어요!</div>
                    </div>
                </div>
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
