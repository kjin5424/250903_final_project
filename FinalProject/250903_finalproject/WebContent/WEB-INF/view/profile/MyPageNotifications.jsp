<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    
    .notification-item {
        display: flex;
        gap: var(--spacing-md);
        padding: var(--spacing-lg);
        background: var(--color-white);
        border-radius: var(--radius-md);
        margin-bottom: var(--spacing-sm);
        transition: all var(--transition-base);
        cursor: pointer;
    }
    
    .notification-item:hover {
        background: var(--color-primary-lighter);
    }
    
    .notification-item.unread {
        border-left: 4px solid var(--color-primary-dark);
        background: var(--color-primary-lighter);
    }
    
    .notification-icon-wrapper {
        flex-shrink: 0;
        width: 48px;
        height: 48px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
    }
    
    .icon-notice {
        background: linear-gradient(135deg, var(--color-primary-lighter), var(--color-primary-light));
    }
    
    .icon-comment {
        background: linear-gradient(135deg, var(--color-secondary-lighter), var(--color-secondary-light));
    }
    
    .icon-vote {
        background: linear-gradient(135deg, #FFF3E0, #FFE0B2);
    }
    
    .notification-content {
        flex: 1;
    }
    
    .notification-title {
        font-size: 15px;
        font-weight: 600;
        color: var(--color-text-primary);
        margin-bottom: var(--spacing-xs);
    }
    
    .notification-message {
        font-size: 14px;
        color: var(--color-text-secondary);
        line-height: 1.5;
    }
    
    .notification-time {
        font-size: 12px;
        color: var(--color-text-tertiary);
        margin-top: var(--spacing-xs);
    }
</style>

<div class="content-section">
    <div class="page-header">
        <h1 class="page-title">🔔 알림</h1>
	    <p class="page-description">최근 활동 알림을 확인하세요</p>
    </div>

    <div class="activity-list">
        <div class="notification-item unread">
            <div class="notification-icon-wrapper icon-notice">
            	    🔔
            </div>
            <div class="notification-content">
                <div class="notification-title">새로운 모임 승인 알림</div>
                <div class="notification-message">
                    '초보자를 위한 파이썬 입문' 모임이 승인되었습니다. 활동을 시작해보세요!
                </div>
                <div class="notification-time">2024-10-10 09:12</div>
            </div>
        </div>

        <div class="notification-item unread">
            <div class="notification-icon-wrapper icon-vote">
            	    🗳️
            </div>
            <div class="notification-content">
                <div class="notification-title">투표 참여 요청</div>
                <div class="notification-message">
                    다음 모임 일정 투표에 참여해주세요. 미참가 시 자동 탈퇴 기준을 확인하세요.
                </div>
                <div class="notification-time">2024-10-09 18:30</div>
            </div>
        </div>

        <div class="notification-item">
            <div class="notification-icon-wrapper icon-comment">
             	   💬
            </div>
            <div class="notification-content">
                <div class="notification-title">댓글 알림</div>
                <div class="notification-message">
                    영어 회화 스터디 게시물에 새로운 댓글이 달렸습니다.
                </div>
                <div class="notification-time">2024-10-08 12:05</div>
            </div>
        </div>

        <div class="notification-item">
            <div class="notification-icon-wrapper icon-notice">
             	   📢
            </div>
            <div class="notification-content">
                <div class="notification-title">공지사항 알림</div>
                <div class="notification-message">
                    '주말 독서 모임'에 새로운 공지사항이 등록되었습니다.
                </div>
                <div class="notification-time">2024-10-07 14:20</div>
            </div>
        </div>

        <div class="notification-item">
            <div class="notification-icon-wrapper icon-comment">
         	       💬
            </div>
            <div class="notification-content">
                <div class="notification-title">멘션 알림</div>
                <div class="notification-message">
                    김철수님이 게시물에서 회원님을 언급했습니다.
                </div>
                <div class="notification-time">2024-10-06 10:45</div>
            </div>
        </div>
    </div>

    <!-- 더 불러오기 버튼 -->
    <div style="text-align: center; margin-top: var(--spacing-lg);">
        <button class="btn btn-outline" onclick="loadMoreNotifications()">
            더 불러오기
        </button>
    </div>
</div>

<script>
    function markAllAsRead() {
        const unreadItems = document.querySelectorAll('.notification-item.unread');
        unreadItems.forEach(item => {
            item.classList.remove('unread');
        });
        alert('모든 알림을 읽음 처리했습니다.');
    }
    
    function loadMoreNotifications() {
        alert('더 많은 알림을 불러오는 중...');
        // TODO: 실제 알림 로드 처리
    }
</script>
