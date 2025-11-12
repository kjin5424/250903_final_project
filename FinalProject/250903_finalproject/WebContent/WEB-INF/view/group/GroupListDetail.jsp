<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% 
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- CSS 파일 로드 -->
<link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css">
<link rel="stylesheet" href="<%=cp%>/css_new/grouplist_sample.css">

<title>공모자들 - 모임 상세보기</title>
<style>
/* 모임 상세 페이지 전용 스타일 */
.group-header {
    background: var(--color-white);
    border-radius: var(--radius-lg);
    padding: var(--spacing-xl);
    box-shadow: var(--shadow-sm);
    margin-bottom: var(--spacing-xl);
    display: grid;
    grid-template-columns: 280px 1fr auto;
    gap: var(--spacing-2xl);
    align-items: start;
}

.group-image-container {
    width: 280px;
    height: 280px;
    border-radius: var(--radius-lg);
    background: linear-gradient(135deg, var(--color-primary-lighter), var(--color-secondary-lighter));
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 120px;
    overflow: hidden;
    flex-shrink: 0;
}

.group-image-container img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.group-main-info {
    flex: 1;
    min-width: 0;
}

.group-title-row {
    display: flex;
    align-items: center;
    gap: var(--spacing-md);
    margin-bottom: var(--spacing-lg);
    flex-wrap: wrap;
}

.group-title {
    font-size: 32px;
    color: var(--color-primary-dark);
    font-weight: 700;
    margin-right: var(--spacing-sm);
}

.badge-large {
    padding: 8px 16px;
    border-radius: var(--radius-full);
    font-size: 14px;
    font-weight: 700;
}

.group-meta {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-md);
    margin-bottom: var(--spacing-xl);
    background: var(--color-base);
    padding: var(--spacing-lg);
    border-radius: var(--radius-md);
}

.meta-item {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
    font-size: 15px;
    color: var(--color-text-primary);
}

.meta-item .meta-icon {
    font-size: 20px;
}

.meta-item strong {
    font-weight: 700;
    color: var(--color-primary-dark);
    min-width: 70px;
}

.group-stats {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: var(--spacing-lg);
    padding: var(--spacing-lg);
    background: var(--color-primary-lighter);
    border-radius: var(--radius-md);
}

.stat-item {
    text-align: center;
}

.stat-value {
    font-size: 28px;
    font-weight: 700;
    color: var(--color-primary-dark);
    display: block;
}

.stat-label {
    font-size: 13px;
    color: var(--color-text-secondary);
    margin-top: var(--spacing-xs);
    display: block;
}

.action-buttons {
    display: flex;
    flex-direction: column;
    gap: var(--spacing-sm);
    width: 200px;
}

.action-buttons .btn {
    width: 100%;
    justify-content: center;
    padding: 14px 20px;
    font-size: 14px;
}

.intro-section {
    background: var(--color-white);
    border-radius: var(--radius-lg);
    padding: var(--spacing-xl);
    box-shadow: var(--shadow-sm);
    margin-bottom: var(--spacing-xl);
}

.intro-section h3 {
    color: var(--color-primary-dark);
    margin-bottom: var(--spacing-lg);
    font-size: 22px;
    padding-bottom: var(--spacing-md);
    border-bottom: 2px solid var(--color-primary-lighter);
}

.intro-section .description {
    color: var(--color-text-secondary);
    line-height: 1.8;
    white-space: pre-wrap;
    margin-bottom: var(--spacing-2xl);
    font-size: 15px;
}

.member-list-section {
    background: var(--color-white);
    border-radius: var(--radius-lg);
    padding: var(--spacing-xl);
    box-shadow: var(--shadow-sm);
}

.member-list-section h3 {
    color: var(--color-primary-dark);
    margin-bottom: var(--spacing-lg);
    font-size: 22px;
    padding-bottom: var(--spacing-md);
    border-bottom: 2px solid var(--color-primary-lighter);
}

.member-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-lg);
}

.member-card {
    background: var(--color-base);
    padding: var(--spacing-lg);
    border-radius: var(--radius-md);
    transition: all var(--transition-base);
    cursor: pointer;
    display: flex;
    gap: var(--spacing-md);
    align-items: center;
}

.member-card:hover {
    background: var(--color-primary-lighter);
    transform: translateY(-2px);
    box-shadow: var(--shadow-md);
}

.member-avatar {
    width: 60px;
    height: 60px;
    border-radius: var(--radius-full);
    background: linear-gradient(135deg, var(--color-primary), var(--color-primary-dark));
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    font-weight: 700;
    flex-shrink: 0;
}

.member-info {
    flex: 1;
    min-width: 0;
}

.member-name {
    font-weight: 700;
    color: var(--color-text-primary);
    font-size: 16px;
    margin-bottom: var(--spacing-xs);
}

.member-role {
    font-size: 12px;
    color: var(--color-text-inverse);
    background: var(--color-primary-dark);
    padding: 4px 10px;
    border-radius: var(--radius-full);
    display: inline-block;
    margin-bottom: var(--spacing-xs);
}

.member-intro {
    font-size: 13px;
    color: var(--color-text-secondary);
    line-height: 1.5;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

.modal-bg {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    align-items: center;
    justify-content: center;
    z-index: 2000;
}

.modal {
    background: var(--color-white);
    padding: var(--spacing-xl);
    border-radius: var(--radius-lg);
    max-width: 500px;
    width: 90%;
    position: relative;
    box-shadow: var(--shadow-xl);
}

.modal-close {
    position: absolute;
    top: var(--spacing-md);
    right: var(--spacing-md);
    cursor: pointer;
    font-size: 24px;
    color: var(--color-text-tertiary);
    background: none;
    border: none;
    transition: color var(--transition-fast);
}

.modal-close:hover {
    color: var(--color-text-primary);
}

@media (max-width: 1024px) {
    .group-header {
        grid-template-columns: 1fr;
    }
    
    .group-image-container {
        width: 100%;
        max-width: 280px;
        margin: 0 auto;
    }
    
    .action-buttons {
        width: 100%;
    }
    
    .group-stats {
        grid-template-columns: repeat(2, 1fr);
    }
    
    .member-grid {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 768px) {
    .group-meta {
        grid-template-columns: 1fr;
    }
}
</style>

<script>
function toggleFavorite() {
    const btn = document.querySelector('.btn-favorite');
    if (btn.textContent.includes('즐겨찾기')) {
        btn.innerHTML = '⭐ 즐겨찾기 해제';
        alert('즐겨찾기에 추가되었습니다!');
    } else {
        btn.innerHTML = '☆ 즐겨찾기';
        alert('즐겨찾기에서 제거되었습니다!');
    }
}

function joinGroup() {
	const groupCode = document.getElementById('groupApplyCode').value;
    if (confirm('이 모임에 가입 신청하시겠습니까?')) {
        if (groupCode) {
            window.location.href = 'apply.do?groupCode=' + groupCode;
        } else {
            alert("모임 코드가 유효하지 않습니다.");
        }
    }
}

function openModal(title, subtitle, content) {
    document.getElementById('modal-title').textContent = title;
    document.getElementById('modal-subtitle').textContent = subtitle;
    document.getElementById('modal-content').textContent = content;
    document.getElementById('modal-bg').style.display = 'flex';
}

function closeModal() {
    document.getElementById('modal-bg').style.display = 'none';
}

window.onload = function() {
    // 멤버 클릭 이벤트
    document.querySelectorAll('.member-card').forEach(card => {
        card.addEventListener('click', function() {
            const name = this.querySelector('.member-name').textContent;
            const role = this.querySelector('.member-role') ? this.querySelector('.member-role').textContent : '';
            const intro = this.querySelector('.member-intro') ? this.querySelector('.member-intro').textContent : '';
            openModal(name, role, intro);
        });
    });
}
</script>
</head>

<body>
    <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
<input type="hidden" id="groupApplyCode" value="${groupDetail.groupApplyCode}">
    <div class="content">
        <!-- 뒤로가기 버튼 -->
        <button class="btn btn-ghost" onclick="location.href='mainpage.do'" style="margin-bottom: var(--spacing-lg);">
            ← 모임 목록으로
        </button>

        <!-- 모임 헤더 -->
        <div class="group-header">
            <!-- 모임 이미지 (카테고리별 이모티콘 지원) -->
            <div class="group-image-container">
                <c:choose>
                    <c:when test="${groupDetail.savePath != null}">
                        <img src="<%=cp%>/img/group/${groupDetail.savePath}" alt="모임 이미지" />
                    </c:when>
                    <c:when test="${groupDetail.topicType eq '1'}"> 📖 </c:when>
                    <c:when test="${groupDetail.topicType eq '2'}"> 🌐 </c:when>
                    <c:when test="${groupDetail.topicType eq '3'}"> 💻 </c:when>
                    <c:when test="${groupDetail.topicType eq '4'}"> 🚀 </c:when>
                    <c:when test="${groupDetail.topicType eq '5'}"> 📜 </c:when>
                    <c:when test="${groupDetail.topicType eq '6'}"> 📝 </c:when>
                    <c:when test="${groupDetail.topicType eq '7'}"> 🎨 </c:when>
                    <c:otherwise>📌</c:otherwise>
                </c:choose>
            </div>
            
            <!-- 모임 정보 -->
            <div class="group-main-info">
                <div class="group-title-row">
                    <h1 class="group-title">${groupDetail.groupTitle}</h1>
                    <span class="badge badge-secondary badge-large">${groupDetail.topic}</span>
                    <c:choose>
                        <c:when test="${groupDetail.currentMemberCount < groupDetail.headCount}">
                            <span class="badge badge-primary badge-large">모집중</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-accent badge-large">모집완료</span>
                        </c:otherwise>
                    </c:choose>
                    <span class="badge badge-primary badge-large">Lv.${groupDetail.groupLevel}</span>
                </div>

                <div class="group-meta">
                    <div class="meta-item">
                        <span class="meta-icon">👤</span>
                        <strong>모임장</strong>
                        <span>
                            <c:set var="leaderFound" value="false" />
                            <c:forEach var="member" items="${memberList}">
                                <c:if test="${member.position eq '모임장'}">
                                    <c:out value="${member.nickName}" />
                                    <c:set var="leaderFound" value="true" />
                                </c:if>
                            </c:forEach>
                            <c:if test="${!leaderFound}">
                                (정보 없음)
                            </c:if>
                        </span>
                    </div>

                    <div class="meta-item">
                        <span class="meta-icon">📅</span>
                        <strong>개설일</strong>
                        <span>${groupDetail.openDate}</span>
                    </div>

                    <div class="meta-item">
                        <span class="meta-icon">📍</span>
                        <strong>지역</strong>
                        <span>${groupDetail.region}</span>
                    </div>

                    <div class="meta-item">
                        <span class="meta-icon">⏰</span>
                        <strong>주기</strong>
                        <span>${groupDetail.frequency}</span>
                    </div>
                </div>

                <div class="group-stats">
                    <div class="stat-item">
                        <span class="stat-value">${groupDetail.currentMemberCount}/${groupDetail.maxCount}</span>
                        <span class="stat-label">모임원</span>
                    </div>

                    <div class="stat-item">
                        <span class="stat-value">${groupDetail.totalAttendance}%</span>
                        <span class="stat-label">평균 출석률</span>
                    </div>

                    <div class="stat-item">
                        <span class="stat-value">${activityCount}회</span>
                        <span class="stat-label">누적 활동</span>
                    </div>

                    <div class="stat-item">
                        <span class="stat-value">${groupDetail.difficulty}</span>
                        <span class="stat-label">학습 난이도</span>
                    </div>
                </div>
            </div>

            <!-- 액션 버튼 (오른쪽 세로 배치) -->
            <div class="action-buttons">
                <button class="btn btn-primary" onclick="joinGroup()">
                   	 ✅ 가입 신청하기
                </button>
                <button class="btn btn-accent btn-favorite" onclick="toggleFavorite()">
                    ☆ 즐겨찾기
                </button>
                <button class="btn btn-outline" onclick="location.href='home.do?groupApplyCode=${groupDetail.groupApplyCode}'">
                    	👀 모임 구경하기
                </button>
            </div>
        </div>

        <!-- 모임 소개 -->
        <div class="intro-section">
            <h3>📝 모임 소개</h3>
            <div class="description">${groupDetail.groupContent}</div>
        </div>

        <!-- 모임원 한 줄 소개 -->
        <div class="member-list-section">
            <h3>👥 모임원 한 줄 소개</h3>
            <c:choose>
                <c:when test="${not empty memberList}">
                    <div class="member-grid">
                        <c:forEach var="member" items="${memberList}">
                            <div class="member-card">
                                <div class="member-avatar">
                                    <c:out value="${fn:substring(member.nickName, 0, 1)}" default="?" />
                                </div>
                                <div class="member-info">
                                    <div class="member-name">${member.nickName}</div>
                                    <div class="member-role">${member.position}</div>
                                    <div class="member-intro">${member.selfIntroduction}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">👥</div>
                        <div class="empty-state-description">아직 가입된 모임원이 없습니다.</div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 모달 -->
    <div id="modal-bg" class="modal-bg" onclick="closeModal()">
        <div class="modal" onclick="event.stopPropagation();">
            <button class="modal-close" onclick="closeModal()">×</button>
            <h2 id="modal-title" style="color: var(--color-primary-dark); margin-bottom: var(--spacing-sm);"></h2>
            <h4 id="modal-subtitle" style="color: var(--color-text-secondary); margin-bottom: var(--spacing-md);"></h4>
            <p id="modal-content" style="color: var(--color-text-secondary); line-height: 1.6;"></p>
        </div>
    </div>
</body>
</html>
