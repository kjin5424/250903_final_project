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
            // 실제로는 서버로 전송
            // 서버 응답 후:
            textarea.value = '';
            card.querySelector('.reply-form').classList.remove('active');
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
                <!-- 받은 쪽지 1 (안 읽음) -->
                <div id="card-1" class="message-card unread" data-type="inbox">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 1)">×</button>
                    
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '이유빙빙', '이')">이</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '이유빙빙', '이')">
                                이유빙빙
                            </div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-12 14:30</span>
                                <span class="message-status unread">● 안읽음</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="message-body" onclick="toggleMessage(1)">
                        <div class="message-content">
안녕하세요! 이번 주 스터디 일정은 목요일 19:00~21:00입니다. 온라인으로 진행 예정이니 참고해주세요. 많은 참여 부탁드립니다!

이번 주제는 동적 프로그래밍(DP)의 심화 과정입니다. 지난주에 배운 기초 개념을 바탕으로 더 복잡한 문제들을 다뤄볼 예정입니다. 백준 1463번, 11726번, 2579번 문제를 미리 풀어보시면 좋을 것 같습니다.

준비물: 노트북, 필기구
참고자료: https://example.com/dp-tutorial

궁금한 점 있으시면 댓글이나 쪽지로 언제든지 질문해주세요!
                        </div>
                    </div>
                    
                    <div class="message-footer">
                        <button class="message-reply-btn" onclick="toggleReplyForm(event, 1)">
                            💬 답장하기
                        </button>
                        
                        <form class="reply-form">
                            <textarea class="reply-textarea" placeholder="답장 내용을 입력하세요..."></textarea>
                            <div class="reply-actions">
                                <button type="button" class="reply-submit-btn" onclick="sendReply(event, 1, '이유빙빙')">
                                    전송
                                </button>
                                <button type="button" class="reply-cancel-btn" onclick="cancelReply(event, 1)">
                                    취소
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- 받은 쪽지 2 (읽음) - 긴 텍스트 샘플 -->
                <div id="card-2" class="message-card read" data-type="inbox">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 2)">×</button>
                    
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '알고리즘초보', '알')">알</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '알고리즘초보', '알')">
                                알고리즘초보
                            </div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-11 09:15</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="message-body" onclick="toggleMessage(2)">
                        <div class="message-content">
안녕하세요! 저번 스터디에서 다룬 DP 문제 관련해서 질문이 있는데요, 시간 되실 때 답변 부탁드립니다.

구체적으로는 메모이제이션을 어떻게 적용하는지 잘 모르겠어서요. 예제 코드 같은 것 있으면 공유해주시면 정말 감사하겠습니다!

특히 백준 1463번 문제에서 Top-down 방식과 Bottom-up 방식의 차이점을 잘 모르겠습니다. 두 방식의 장단점과 언제 어떤 방식을 사용하는 게 좋은지 설명해주실 수 있을까요?

또한 DP 테이블을 설계할 때 어떤 점들을 고려해야 하는지도 궁금합니다. 상태 정의하는 방법이 어려워서 막히는 경우가 많거든요.

시간 되실 때 답변 부탁드립니다. 감사합니다!
                        </div>
                    </div>
                    
                    <div class="message-footer">
                        <button class="message-reply-btn" onclick="toggleReplyForm(event, 2)">
                            💬 답장하기
                        </button>
                        
                        <form class="reply-form">
                            <textarea class="reply-textarea" placeholder="답장 내용을 입력하세요..."></textarea>
                            <div class="reply-actions">
                                <button type="button" class="reply-submit-btn" onclick="sendReply(event, 2, '알고리즘초보')">
                                    전송
                                </button>
                                <button type="button" class="reply-cancel-btn" onclick="cancelReply(event, 2)">
                                    취소
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- 받은 쪽지 3 (읽음) -->
                <div id="card-3" class="message-card read" data-type="inbox">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 3)">×</button>
                    
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '코딩마스터', '코')">코</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '코딩마스터', '코')">
                                코딩마스터
                            </div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-10 16:45</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="message-body" onclick="toggleMessage(3)">
                        <div class="message-content">
다음 주 스터디에서 다룰 자료를 미리 공유드립니다. 미리 예습해오시면 더 좋을 것 같아요!
                        </div>
                    </div>
                    
                    <div class="message-footer">
                        <button class="message-reply-btn" onclick="toggleReplyForm(event, 3)">
                            💬 답장하기
                        </button>
                        
                        <form class="reply-form">
                            <textarea class="reply-textarea" placeholder="답장 내용을 입력하세요..."></textarea>
                            <div class="reply-actions">
                                <button type="button" class="reply-submit-btn" onclick="sendReply(event, 3, '코딩마스터')">
                                    전송
                                </button>
                                <button type="button" class="reply-cancel-btn" onclick="cancelReply(event, 3)">
                                    취소
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- 보낸 쪽지 1 -->
                <div id="card-4" class="message-card" data-type="sent" style="display: none;">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 4)">×</button>
                    
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '코딩마스터', '코')">코</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '코딩마스터', '코')">
                                코딩마스터 님에게
                            </div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-12 15:00</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="message-body" onclick="toggleMessage(4)">
                        <div class="message-content">
감사합니다! 목요일 19시에 꼭 참여하겠습니다. 혹시 준비해야 할 자료가 있을까요?
                        </div>
                    </div>
                </div>

                <!-- 보낸 쪽지 2 -->
                <div id="card-5" class="message-card" data-type="sent" style="display: none;">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 5)">×</button>
                    
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '알고리즘초보', '알')">알</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '알고리즘초보', '알')">
                                알고리즘초보 님에게
                            </div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-11 10:30</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="message-body" onclick="toggleMessage(5)">
                        <div class="message-content">
DP 문제 관련 질문에 답변드립니다. 메모이제이션을 활용하면 시간복잡도를 줄일 수 있습니다. 자세한 내용은 다음 스터디 때 설명드릴게요!

참고할만한 블로그 링크 공유합니다: https://blog.example.com/dp-tutorial

추가 질문 있으시면 언제든지 쪽지 주세요!
                        </div>
                    </div>
                </div>
                
                <!-- 더미 받은 쪽지 4-9 -->
                <div id="card-6" class="message-card read" data-type="inbox">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 6)">×</button>
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '민수', '민')">민</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '민수', '민')">민수</div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-09 11:20</span>
                            </div>
                        </div>
                    </div>
                    <div class="message-body" onclick="toggleMessage(6)">
                        <div class="message-content">스터디 시간 변경 건의드립니다. 개인 일정 때문에...</div>
                    </div>
                    <div class="message-footer">
                        <button class="message-reply-btn" onclick="toggleReplyForm(event, 6)">💬 답장하기</button>
                        <form class="reply-form">
                            <textarea class="reply-textarea" placeholder="답장 내용을 입력하세요..."></textarea>
                            <div class="reply-actions">
                                <button type="button" class="reply-submit-btn" onclick="sendReply(event, 6, '민수')">전송</button>
                                <button type="button" class="reply-cancel-btn" onclick="cancelReply(event, 6)">취소</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div id="card-7" class="message-card read" data-type="inbox">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 7)">×</button>
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '지연', '지')">지</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '지연', '지')">지연</div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-08 15:45</span>
                            </div>
                        </div>
                    </div>
                    <div class="message-body" onclick="toggleMessage(7)">
                        <div class="message-content">저번 주 과제 피드백 감사합니다! 많은 도움이 되었어요.</div>
                    </div>
                    <div class="message-footer">
                        <button class="message-reply-btn" onclick="toggleReplyForm(event, 7)">💬 답장하기</button>
                        <form class="reply-form">
                            <textarea class="reply-textarea" placeholder="답장 내용을 입력하세요..."></textarea>
                            <div class="reply-actions">
                                <button type="button" class="reply-submit-btn" onclick="sendReply(event, 7, '지연')">전송</button>
                                <button type="button" class="reply-cancel-btn" onclick="cancelReply(event, 7)">취소</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div id="card-8" class="message-card read" data-type="inbox">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 8)">×</button>
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '하준', '하')">하</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '하준', '하')">하준</div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-07 09:30</span>
                            </div>
                        </div>
                    </div>
                    <div class="message-body" onclick="toggleMessage(8)">
                        <div class="message-content">다음 스터디 주제로 그래프 알고리즘 어떨까요?</div>
                    </div>
                    <div class="message-footer">
                        <button class="message-reply-btn" onclick="toggleReplyForm(event, 8)">💬 답장하기</button>
                        <form class="reply-form">
                            <textarea class="reply-textarea" placeholder="답장 내용을 입력하세요..."></textarea>
                            <div class="reply-actions">
                                <button type="button" class="reply-submit-btn" onclick="sendReply(event, 8, '하준')">전송</button>
                                <button type="button" class="reply-cancel-btn" onclick="cancelReply(event, 8)">취소</button>
                            </div>
                        </form>
                    </div>
                </div>

                <div id="card-9" class="message-card read" data-type="inbox">
                    <button class="message-delete-btn" onclick="deleteMessage(event, 9)">×</button>
                    <div class="message-header">
                        <div class="message-avatar" onclick="showUserModal(event, '서브리더', '서')">서</div>
                        <div class="message-info">
                            <div class="message-sender" onclick="showUserModal(event, '서브리더', '서')">서브리더</div>
                            <div class="message-meta">
                                <span class="message-date">2024-10-06 18:00</span>
                            </div>
                        </div>
                    </div>
                    <div class="message-body" onclick="toggleMessage(9)">
                        <div class="message-content">스터디 자료 정리 완료했습니다. 확인 부탁드려요!</div>
                    </div>
                    <div class="message-footer">
                        <button class="message-reply-btn" onclick="toggleReplyForm(event, 9)">💬 답장하기</button>
                        <form class="reply-form">
                            <textarea class="reply-textarea" placeholder="답장 내용을 입력하세요..."></textarea>
                            <div class="reply-actions">
                                <button type="button" class="reply-submit-btn" onclick="sendReply(event, 9, '서브리더')">전송</button>
                                <button type="button" class="reply-cancel-btn" onclick="cancelReply(event, 9)">취소</button>
                            </div>
                        </form>
                    </div>
                </div>
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
