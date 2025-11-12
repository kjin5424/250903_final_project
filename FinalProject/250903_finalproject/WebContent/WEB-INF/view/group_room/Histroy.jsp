<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <title>모임 히스토리 - 공모자들</title>
    <link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css" />
    <link rel="stylesheet" href="<%=cp%>/css_new/board_sample.css" />
    <style>
/* 모임 히스토리 페이지 전용 스타일 */

/* 페이지 헤더 (원래 스타일 유지) */
.page-header {
	background: linear-gradient(135deg, #2d5a29 0%, #4a8a42 100%);
	color: white;
	padding: 40px;
	border-radius: var(--radius-lg);
	margin-bottom: var(--spacing-xl);
	box-shadow: var(--shadow-lg);
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: var(--spacing-md);
}

.page-title {
	font-size: 32px;
	font-weight: 700;
	display: flex;
	align-items: center;
	gap: var(--spacing-md);
	color: white;
}

.group-name {
	font-size: 18px;
	opacity: 0.9;
}

.btn-back {
	background: rgba(255,255,255,0.2);
	color: white;
	border: 2px solid white;
	padding: 10px 20px;
	border-radius: var(--radius-md);
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all var(--transition-base);
}

.btn-back:hover {
	background: white;
	color: #2d5a29;
}

/* 통계 그리드 */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: var(--spacing-lg);
	margin-bottom: var(--spacing-xl);
}

.stat-card {
	background: linear-gradient(135deg, var(--color-primary-lighter) 0%, var(--color-secondary-lighter) 100%);
	padding: var(--spacing-xl);
	border-radius: var(--radius-lg);
	text-align: center;
	box-shadow: var(--shadow-sm);
	transition: all var(--transition-base);
}

.stat-card:hover {
	transform: translateY(-4px);
	box-shadow: var(--shadow-lg);
}

.stat-value {
	font-size: 36px;
	font-weight: 700;
	color: var(--color-primary-dark);
	margin-bottom: var(--spacing-sm);
}

.stat-label {
	font-size: 14px;
	color: var(--color-text-secondary);
	font-weight: 600;
}

/* 타임라인 */
.timeline-container {
	position: relative;
	padding: var(--spacing-xl) 0;
}

/* 타임라인 배경 선 - 첫 번째와 마지막 제외하고 쭉 이어짐 */
.timeline-container::before {
	content: '';
	position: absolute;
	left: 31px;
	top: 52px;
	bottom: 52px;
	width: 3px;
	background: linear-gradient(to bottom, var(--color-primary), var(--color-primary-light));
}

.timeline-item {
	position: relative;
	padding-left: 90px;
	margin-bottom: var(--spacing-xl);
	min-height: 60px;
	display: flex;
	align-items: center;
}

.timeline-date {
	position: absolute;
	left: 0;
	top: 50%;
	transform: translateY(-50%);
	display: flex;
	flex-direction: column;
	align-items: center;
	gap: var(--spacing-xs);
	width: 70px;
}

.timeline-dot {
	width: 24px;
	height: 24px;
	background: var(--color-primary-dark);
	border-radius: var(--radius-full);
	border: 4px solid var(--color-white);
	box-shadow: 0 0 0 3px var(--color-primary-lighter);
	z-index: 2;
	position: relative;
}

.timeline-date-text {
	font-size: 11px;
	color: var(--color-text-tertiary);
	font-weight: 600;
	white-space: nowrap;
	text-align: center;
}

.timeline-content {
	background: var(--color-white);
	padding: var(--spacing-lg);
	border-radius: var(--radius-lg);
	border: 2px solid var(--color-border-light);
	transition: all var(--transition-base);
	flex: 1;
}

.timeline-content:hover {
	border-color: var(--color-primary);
	box-shadow: var(--shadow-md);
}

.timeline-title {
	font-size: 16px;
	font-weight: 700;
	color: var(--color-text-primary);
	margin-bottom: var(--spacing-sm);
	display: flex;
	align-items: center;
	gap: var(--spacing-sm);
	flex-wrap: wrap;
}

.timeline-category {
	display: inline-block;
	padding: 4px 12px;
	border-radius: var(--radius-full);
	font-size: 12px;
	font-weight: 600;
}

.category-join {
	background: var(--color-primary-lighter);
	color: var(--color-primary-dark);
}

.category-level {
	background: var(--color-secondary-lighter);
	color: var(--color-secondary-dark);
}

.category-activity {
	background: #e3f2fd;
	color: #1565c0;
}

.category-challenge {
	background: #fff3e0;
	color: #f57c00;
}

.category-position {
	background: #fce4ec;
	color: #c2185b;
}

.timeline-description {
	color: var(--color-text-secondary);
	font-size: 14px;
	line-height: 1.6;
}

/* 빈 상태 */
.empty-state {
	text-align: center;
	padding: 80px 20px;
	color: var(--color-text-tertiary);
}

.empty-icon {
	font-size: 64px;
	margin-bottom: var(--spacing-lg);
	opacity: 0.6;
}

/* 탭 컨텐츠 */
.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

@media (max-width: 768px) {
	.page-header {
		padding: 25px 20px;
	}
	
	.page-title {
		font-size: 24px;
	}
	
	.header-top {
		flex-direction: column;
		gap: var(--spacing-md);
		align-items: flex-start;
	}
	
	.stats-grid {
		grid-template-columns: 1fr;
	}
	
	.timeline-container::before {
		left: 26px;
	}
	
	.timeline-item {
		padding-left: 70px;
	}
	
	.timeline-date {
		width: 60px;
	}
	
	.timeline-dot {
		width: 20px;
		height: 20px;
	}
}
    </style>
    <script>
        function switchTab(tabName) {
            // 모든 탭 비활성화
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.board-tab').forEach(t => t.classList.remove('active'));
            
            // 선택한 탭 활성화
            document.getElementById(tabName + '-tab').classList.add('active');
            event.target.classList.add('active');
        }
    </script>
</head>
<body>
    <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
    
    <!-- 사이드바 -->
    <c:import url="/WEB-INF/view/common/GroupSideBar.jsp"></c:import>

    <!-- 메인 콘텐츠 -->
    <div class="main-container">
        <!-- 페이지 헤더 (원래 스타일) -->
        <div class="page-header">
            <div class="header-top">
                <div>
                    <div class="page-title"><span>📜</span><span>모임 히스토리</span></div>
                    <div class="group-name">알고리즘 정복 스터디</div>
                </div>
                <button class="btn-back" onclick="history.back()">← 뒤로가기</button>
            </div>
        </div>

        <div class="board-container">
            <!-- 통계 카드 -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">${countActivity}</div>
                    <div class="stat-label">총 활동 횟수</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">${countChallenge}</div>
                    <div class="stat-label">도전과제 완료</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">Lv.${groupLevel}</div>
                    <div class="stat-label">현재 레벨</div>
                </div>
            </div>

            <!-- 탭 네비게이션 -->
            <div class="board-tabs">
                <button class="board-tab active" onclick="switchTab('all')">📋 전체</button>
                <button class="board-tab" onclick="switchTab('member')">👥 모임 및 권한</button>
                <button class="board-tab" onclick="switchTab('level')">🆙 레벨</button>
            </div>

            <!-- 전체 히스토리 -->
            <div id="all-tab" class="tab-content active">
                <c:choose>
                    <c:when test="${not empty history}">
                        <div class="timeline-container">
                            <c:forEach var="historyDTO" items="${history}">
                                <div class="timeline-item">
                                    <div class="timeline-date">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-date-text">${historyDTO.updateDate}</div>
                                    </div>
                                    <div class="timeline-content">
                                        <div class="timeline-title">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${historyDTO.type eq 'JOIN'}">🥳 신규회원!</c:when>
                                                    <c:when test="${historyDTO.type eq 'LEVEL'}">🆙 레벨업!</c:when>
                                                    <c:when test="${historyDTO.type eq 'ACTIVITY'}">🗳️ 활동 등록!</c:when>
                                                    <c:when test="${historyDTO.type eq 'CHALLENGE'}">🎯 도전과제 등록!</c:when>
                                                    <c:when test="${historyDTO.type eq 'POSITION'}">👑 권한 변경</c:when>
                                                    <c:otherwise>♻️ 모임정보 변경!</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span class="timeline-category 
                                                <c:choose>
                                                    <c:when test="${historyDTO.type eq 'JOIN'}">category-join</c:when>
                                                    <c:when test="${historyDTO.type eq 'LEVEL'}">category-level</c:when>
                                                    <c:when test="${historyDTO.type eq 'ACTIVITY'}">category-activity</c:when>
                                                    <c:when test="${historyDTO.type eq 'CHALLENGE'}">category-challenge</c:when>
                                                    <c:when test="${historyDTO.type eq 'POSITION'}">category-position</c:when>
                                                    <c:otherwise>category-join</c:otherwise>
                                                </c:choose>">
                                                <c:choose>
                                                    <c:when test="${historyDTO.type eq 'JOIN'}">가입</c:when>
                                                    <c:when test="${historyDTO.type eq 'LEVEL'}">레벨</c:when>
                                                    <c:when test="${historyDTO.type eq 'ACTIVITY'}">활동</c:when>
                                                    <c:when test="${historyDTO.type eq 'CHALLENGE'}">도전과제</c:when>
                                                    <c:when test="${historyDTO.type eq 'POSITION'}">역할</c:when>
                                                    <c:otherwise>변경</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="timeline-description">${historyDTO.history}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <div>아직 히스토리가 없습니다.</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 모임 및 권한 히스토리 -->
            <div id="member-tab" class="tab-content">
                <c:choose>
                    <c:when test="${not empty notLevelHistory}">
                        <div class="timeline-container">
                            <c:forEach var="notLevel" items="${notLevelHistory}">
                                <div class="timeline-item">
                                    <div class="timeline-date">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-date-text">${notLevel.updateDate}</div>
                                    </div>
                                    <div class="timeline-content">
                                        <div class="timeline-title">
                                            <span>
                                                <c:choose>
                                                    <c:when test="${notLevel.type eq 'JOIN'}">🥳 신규회원!</c:when>
                                                    <c:when test="${notLevel.type eq 'ACTIVITY'}">🗳️ 활동 등록!</c:when>
                                                    <c:when test="${notLevel.type eq 'CHALLENGE'}">🎯 도전과제 등록!</c:when>
                                                    <c:when test="${notLevel.type eq 'POSITION'}">👑 권한 변경</c:when>
                                                    <c:otherwise>♻️ 모임정보 변경!</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span class="timeline-category 
                                                <c:choose>
                                                    <c:when test="${notLevel.type eq 'JOIN'}">category-join</c:when>
                                                    <c:when test="${notLevel.type eq 'ACTIVITY'}">category-activity</c:when>
                                                    <c:when test="${notLevel.type eq 'CHALLENGE'}">category-challenge</c:when>
                                                    <c:when test="${notLevel.type eq 'POSITION'}">category-position</c:when>
                                                    <c:otherwise>category-join</c:otherwise>
                                                </c:choose>">
                                                <c:choose>
                                                    <c:when test="${notLevel.type eq 'JOIN'}">가입</c:when>
                                                    <c:when test="${notLevel.type eq 'ACTIVITY'}">활동</c:when>
                                                    <c:when test="${notLevel.type eq 'CHALLENGE'}">도전과제</c:when>
                                                    <c:when test="${notLevel.type eq 'POSITION'}">역할</c:when>
                                                    <c:otherwise>변경</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="timeline-description">${notLevel.history}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <div>아직 히스토리가 없습니다.</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 레벨 히스토리 -->
            <div id="level-tab" class="tab-content">
                <c:choose>
                    <c:when test="${not empty levelHistory}">
                        <div class="timeline-container">
                            <c:forEach var="level" items="${levelHistory}">
                                <div class="timeline-item">
                                    <div class="timeline-date">
                                        <div class="timeline-dot"></div>
                                        <div class="timeline-date-text">${level.updateDate}</div>
                                    </div>
                                    <div class="timeline-content">
                                        <div class="timeline-title">
                                            <span>🆙 레벨업!</span>
                                            <span class="timeline-category category-level">레벨</span>
                                        </div>
                                        <div class="timeline-description">${level.history}</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">📭</div>
                            <div>아직 레벨업 히스토리가 없습니다.</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>
