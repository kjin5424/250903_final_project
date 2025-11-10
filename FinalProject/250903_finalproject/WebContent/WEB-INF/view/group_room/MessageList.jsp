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
<title>쪽지함 - 공모자들</title>

<!-- CSS 파일 임포트 -->
<link rel="stylesheet" href="<%=cp %>/css_new/common_sample.css">
<link rel="stylesheet" href="<%=cp %>/css_new/board_sample.css">
<link rel="stylesheet" href="<%=cp %>/css_new/messagelist.css">

<script>
    let currentTab = 'inbox';
    
    // 탭 전환
    function showTab(tab) {
        currentTab = tab;
        
        // 탭 버튼 활성화
        document.querySelectorAll('.board-tab').forEach(btn => {
            btn.classList.remove('active');
        });
        document.getElementById(tab + '-tab').classList.add('active');
        
        // 메시지 표시/숨김
        document.querySelectorAll('.message-card').forEach(card => {
            if(card.dataset.type === tab) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
                // 숨길 때 답장 폼도 닫기
                const replyForm = card.querySelector('.reply-form');
                if(replyForm) {
                    replyForm.classList.remove('active');
                }
            }
        });
    }
    
    // 쪽지 내용 펼치기/접기
    function toggleMessage(cardId) {
        const card = document.getElementById('card-' + cardId);
        const messageBody = card.querySelector('.message-body');
        
        // 안읽음 상태면 읽음 처리 (애니메이션 후)
        if(card.classList.contains('unread')) {
            // 3초 후 unread 클래스 제거하고 read 클래스 추가
            setTimeout(() => {
                card.classList.remove('unread');
                card.classList.add('read');
                // 실제로는 서버에 읽음 처리 요청
                // markAsRead(cardId);
            }, 3000);
        }
        
        // 내용 펼치기/접기
        messageBody.classList.toggle('expanded');
    }
    
    // 답장 폼 토글
    function toggleReplyForm(event, cardId) {
        event.stopPropagation();
        
        const card = document.getElementById('card-' + cardId);
        const replyForm = card.querySelector('.reply-form');
        
        // 다른 모든 답장 폼 닫기
        document.querySelectorAll('.reply-form').forEach(form => {
            if(form !== replyForm) {
                form.classList.remove('active');
            }
        });
        
        replyForm.classList.toggle('active');
        
        // 폼이 열렸으면 textarea에 포커스
        if(replyForm.classList.contains('active')) {
            replyForm.querySelector('textarea').focus();
        }
    }
    
    // 답장 전송
    function sendReply(event, cardId, recipient) {
        event.preventDefault();
        
        const card = document.getElementById('card-' + cardId);
        const textarea = card.querySelector('.reply-textarea');
        const content = textarea.value.trim();
        
        if(!content) {
            alert('답장 내용을 입력해주세요.');
            return;
        }
        
        if(confirm(recipient + '님에게 답장을 전송하시겠습니까?')) {
            alert('답장이 전송되었습니다.');
            textarea.value = '';
            const replyForm = card.querySelector('form');
            alert(content);
            replyForm.submit();
        }
    }
    
    // 답장 취소
    function cancelReply(event, cardId) {
        event.preventDefault();
        
        const card = document.getElementById('card-' + cardId);
        const textarea = card.querySelector('.reply-textarea');
        
        if(textarea.value.trim() && !confirm('작성 중인 내용이 있습니다. 취소하시겠습니까?')) {
            return;
        }
        
        textarea.value = '';
        card.querySelector('.reply-form').classList.remove('active');
    }
    
    // 쪽지 삭제
    function deleteMessage(event, cardId) {
        event.stopPropagation();
        
        if(confirm('이 쪽지를 삭제하시겠습니까?')) {
            alert('쪽지가 삭제되었습니다.');
            // 실제로는 서버로 삭제 요청
            // location.href = 'messageDelete.do?id=' + cardId;
            
            // 임시로 카드 제거
            document.getElementById('card-' + cardId).remove();
        }
    }
    
    // 사용자 정보 모달
    function showUserModal(event, name, avatar) {
        event.stopPropagation();
        
        document.getElementById('user-modal-avatar').textContent = avatar;
        document.getElementById('user-modal-name').textContent = name;
        document.getElementById('user-modal-intro').textContent = name + '님의 프로필입니다.';
        
        document.getElementById('user-modal-overlay').classList.add('active');
    }
    
    function closeUserModal() {
        document.getElementById('user-modal-overlay').classList.remove('active');
    }
    
    function goToProfile() {
        alert('프로필 페이지로 이동합니다.');
        // location.href = 'profile.do?userId=xxx';
    }
    
    function reportUser() {
        if (confirm('이 사용자를 신고하시겠습니까?')) {
            // 🚨 신고 페이지로 이동 (임의 사용자 신고)
            window.location.href = "<%=cp%>/reportmember.do";
        }
    }
    
    // 페이지 로드 시
    window.addEventListener('DOMContentLoaded', function() {
        showTab('inbox');
        
        // 모달 외부 클릭 시 닫기
        document.getElementById('user-modal-overlay').addEventListener('click', function(e) {
            if(e.target === this) {
                closeUserModal();
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
            <!-- 헤더 -->
            <div class="board-header">
                <h1 class="board-title">
                    <span class="board-title-icon">✉️</span>
                    쪽지함
                </h1>
                <div class="board-actions">
                    <button class="btn btn-primary" onclick="location.href='writemessage.do'">
                        	✏️ 쪽지 쓰기
                    </button>
                </div>
            </div>

            <!-- 탭 -->
            <div class="board-tabs">
                <button id="inbox-tab" class="board-tab active" onclick="showTab('inbox')">
                    받은 쪽지
                </button>
                <button id="sent-tab" class="board-tab" onclick="showTab('sent')">
                    보낸 쪽지
                </button>
            </div>

            <!-- 쪽지 리스트 -->
			<div class="message-list">
            <!-- 받은 쪽지 -->
            <c:forEach var="fm" items="${forwardedMessage}" varStatus="loop">
			    <div id="card-${loop.count}" class="message-card ${empty fm.readDate ? 'unread' : 'read'}" data-type="inbox">
			
			        <button class="message-delete-btn" onclick="deleteMessage(event, ${loop.count})">×</button>
			
			        <div class="message-header">
			            <div class="message-avatar"
			                 onclick="showUserModal(event, '${fm.nickName}', '${empty fm.savePath ? fn:substring(fm.nickName, 0, 1) : fm.savePath}')">
			                ${empty fm.savePath ? fn:substring(fm.nickName, 0, 1) : fm.savePath}
			            </div>
			
			            <div class="message-info">
			                <div class="message-sender"
			                     onclick="showUserModal(event, '${fm.nickName}', '${empty fm.savePath ? fn:substring(fm.nickName, 0, 1) : fm.savePath}')">
			                    ${fm.nickName}
			                </div>
			                <div class="message-meta">
			                    <span class="message-date">${fm.createdDate}</span>
			                    <span class="message-status unread">${empty fm.readDate ? '● 안읽음' : ''}</span>
			                </div>
			            </div>
			        </div>
			
			        <div class="message-body" onclick="toggleMessage(${loop.count})">
			            <div class="message-content">${fm.content}</div>
			        </div>
			
			        <div class="message-footer">
			            <button class="message-reply-btn" onclick="toggleReplyForm(event, ${loop.count})">💬 답장하기</button>

						<!-- 답장 영역 -->
			            <form action="<%=cp %>/messagewriteOk.do" id="reply-form-${loop.count }" method="POST">
			                <textarea 
			                	id="content" 
								name="content" 	
			                	class="reply-textarea" 
			                	placeholder="답장 내용을 입력하세요...">
			                </textarea>
			                <input type="hidden" name="receiver" value="${fm.forwarder }">
			                <div class="reply-actions">
			                    <button type="button" class="reply-submit-btn" onclick="sendReply(event, ${loop.count}, '${fm.nickName}')">전송</button>
			                    <button type="button" class="reply-cancel-btn" onclick="cancelReply(event, ${loop.count})">취소</button>
			                </div>
			            </form>
			        </div>
			    </div>
			</c:forEach>
			<!-- 보낸 쪽지 -->
			<c:forEach var="rm" items="${receivedMessage}" varStatus="loop">
                <div id="card-${loop.count}" class="message-card" data-type="sent" style="display: none;">
                    <button class="message-delete-btn" onclick="deleteMessage(event, ${loop.count})">×</button>
                    
                    <div class="message-header">
                        <div class="message-avatar" 
                        	onclick="showUserModal(event, '${rm.nickName}', '${empty rm.savePath ? fn:substring(rm.nickName, 0, 1) : rm.savePath}')">
                        	${empty rm.savePath ? fn:substring(rm.nickName, 0, 1) : rm.savePath}
                        </div>
                        <div class="message-info">
                            <div class="message-sender" 
                            	onclick="showUserModal(event, '${rm.nickName}', '${empty rm.savePath ? fn:substring(rm.nickName, 0, 1) : rm.savePath}')">
                                ${rm.nickName } 님에게
                            </div>
                            <div class="message-meta">
                                <span class="message-date">${rm.createdDate }</span>
                            </div>
                        </div>
                    </div>
                    <div class="message-body" onclick="toggleMessage(${loop.count})">
                        <div class="message-content">${rm.content }</div>
                    </div>
                </div>
			</c:forEach>
			</div>
        </div>
    </div>

    <!-- 사용자 정보 모달 -->
    <div id="user-modal-overlay" class="user-modal-overlay">
        <div class="user-modal-content">
            <button class="user-modal-close-btn" onclick="closeUserModal()">×</button>
            
            <div class="user-modal-header">
                <div class="user-modal-avatar" id="user-modal-avatar">👤</div>
                <h2 class="user-modal-name" id="user-modal-name">사용자</h2>
            </div>
            
            <div class="user-modal-body">
                <p class="user-modal-intro" id="user-modal-intro">사용자 정보</p>
                <div class="user-modal-actions">
                    <button class="user-modal-btn profile" onclick="goToProfile()">
                        <span class="user-modal-btn-icon">👤</span>
                        <span>프로필 보기</span>
                    </button>
                    
                    <button class="user-modal-btn report" onclick="reportUser()">
                        <span class="user-modal-btn-icon">🚨</span>
                        <span>신고하기</span>
                    </button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
