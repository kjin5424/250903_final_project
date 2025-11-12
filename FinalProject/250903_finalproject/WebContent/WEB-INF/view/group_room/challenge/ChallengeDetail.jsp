<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>도전과제 상세 - 공모자들</title>
<link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css" />
<link rel="stylesheet" href="<%=cp%>/css_new/board_sample.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<style>
/* 도전과제 상세 페이지 전용 스타일 */

/* === 1. 핵심 정보 영역 === */
.challenge-header-section {
	background: linear-gradient(135deg, var(--color-primary-lighter) 0%, var(--color-secondary-lighter) 100%);
	padding: var(--spacing-xl);
	border-radius: var(--radius-lg);
	margin-bottom: var(--spacing-xl);
}

.challenge-meta {
	display: flex;
	gap: var(--spacing-lg);
	margin-top: var(--spacing-md);
	flex-wrap: wrap;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: var(--spacing-sm);
	color: var(--color-text-secondary);
	font-size: 15px;
}

.meta-icon {
	font-size: 18px;
}

.challenge-description {
	margin-top: var(--spacing-md);
	padding: var(--spacing-md);
	background: rgba(255, 255, 255, 0.7);
	border-radius: var(--radius-md);
	color: var(--color-text-primary);
	line-height: 1.6;
}

/* === 2. 통계 대시보드 === */
.stats-dashboard {
	background: var(--color-white);
	padding: var(--spacing-xl);
	border-radius: var(--radius-lg);
	margin-bottom: var(--spacing-xl);
	box-shadow: var(--shadow-sm);
}

.stats-title {
	font-size: 18px;
	font-weight: 700;
	margin-bottom: var(--spacing-lg);
	color: var(--color-text-primary);
}

.stats-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: var(--spacing-lg);
	margin-bottom: var(--spacing-xl);
}

.stat-card {
	text-align: center;
	padding: var(--spacing-lg);
	background: var(--color-base);
	border-radius: var(--radius-md);
	transition: all var(--transition-base);
}

.stat-card:hover {
	transform: translateY(-2px);
	box-shadow: var(--shadow-md);
}

.stat-card .label {
	font-size: 13px;
	color: var(--color-text-tertiary);
	margin-bottom: var(--spacing-sm);
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

.stat-card .value {
	font-size: 32px;
	font-weight: 700;
	color: var(--color-primary-dark);
}

/* === 3. 체크리스트 영역 === */
.checklist-section {
	background: var(--color-white);
	padding: var(--spacing-xl);
	border-radius: var(--radius-lg);
	margin-bottom: var(--spacing-xl);
	box-shadow: var(--shadow-sm);
}

.section-title {
	font-size: 18px;
	font-weight: 700;
	margin-bottom: var(--spacing-lg);
	color: var(--color-text-primary);
	display: flex;
	align-items: center;
	gap: var(--spacing-sm);
}

.checklist-grid {
	display: grid;
	gap: var(--spacing-md);
}

.checklist-item {
	display: flex;
	align-items: center;
	padding: var(--spacing-md) var(--spacing-lg);
	background: var(--color-base);
	border: 2px solid var(--color-border-light);
	border-radius: var(--radius-md);
	transition: all var(--transition-base);
	cursor: pointer;
}

.checklist-item:hover {
	border-color: var(--color-primary);
	background: var(--color-primary-lighter);
}

.checklist-item.completed {
	background: var(--color-primary-lighter);
	border-color: var(--color-primary);
}

.checklist-checkbox {
	width: 24px;
	height: 24px;
	margin-right: var(--spacing-md);
	cursor: pointer;
	flex-shrink: 0;
}

.checklist-step {
	font-weight: 600;
	color: var(--color-primary-dark);
	min-width: 60px;
	margin-right: var(--spacing-md);
}

.checklist-content {
	flex: 1;
	color: var(--color-text-primary);
}

/* === 4. 참가자 섹션 === */
.participants-section {
	background: var(--color-white);
	padding: var(--spacing-xl);
	border-radius: var(--radius-lg);
	margin-bottom: var(--spacing-xl);
	box-shadow: var(--shadow-sm);
}

.toggle-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	cursor: pointer;
	padding: var(--spacing-md);
	background: var(--color-base);
	border-radius: var(--radius-md);
	transition: all var(--transition-base);
}

.toggle-header:hover {
	background: var(--color-secondary-lighter);
}

.toggle-icon {
	transition: transform var(--transition-base);
}

.toggle-icon.active {
	transform: rotate(180deg);
}

.participant-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: var(--spacing-lg);
}

.participant-table th {
	background: var(--color-base);
	padding: 12px;
	text-align: left;
	font-weight: 600;
	border-bottom: 2px solid var(--color-border);
}

.participant-table td {
	padding: 14px 12px;
	border-bottom: 1px solid var(--color-border-light);
}

.participant-table tr:hover {
	background: var(--color-base);
}

.hidden {
	display: none;
}

/* === 5. 댓글 영역 === */
.comments-section {
	background: var(--color-white);
	padding: var(--spacing-xl);
	border-radius: var(--radius-lg);
	box-shadow: var(--shadow-sm);
}

.comment-write {
	padding: var(--spacing-lg);
	background: var(--color-base);
	border-radius: var(--radius-md);
	margin-bottom: var(--spacing-xl);
}

.comment-write textarea {
	margin-bottom: var(--spacing-md);
}

.comment-actions {
	display: flex;
	gap: var(--spacing-sm);
	justify-content: flex-end;
}

.comment-list {
	display: flex;
	flex-direction: column;
	gap: var(--spacing-md);
}

.comment-item {
	display: flex;
	justify-content: space-between;
	padding: var(--spacing-lg);
	background: var(--color-base);
	border-radius: var(--radius-md);
	transition: all var(--transition-base);
}

.comment-item:hover {
	box-shadow: var(--shadow-sm);
}

.comment-item .username {
	font-weight: 600;
	color: var(--color-text-primary);
	margin-bottom: var(--spacing-xs);
}

.comment-item .content {
	color: var(--color-text-secondary);
	line-height: 1.6;
}

.comment-item .right {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	gap: var(--spacing-sm);
}

.comment-item .date {
	font-size: 13px;
	color: var(--color-text-tertiary);
}

/* === 반응형 === */
@media (max-width: 768px) {
	.stats-grid {
		grid-template-columns: 1fr;
	}
	
	.checklist-item {
		flex-direction: column;
		align-items: flex-start;
	}
	
	.comment-item {
		flex-direction: column;
		gap: var(--spacing-md);
	}
	
	.comment-item .right {
		align-items: flex-start;
		flex-direction: row;
	}
}
</style>
<script type="text/javascript">
$(function()
{
    $('#participantTitle').on('click', function() {
        const $table = $('#participantTable');
        const $icon = $(this).find('.toggle-icon');
        
        $table.toggleClass('hidden');
        $icon.toggleClass('active');

        if ($table.hasClass('hidden')) {
            $table.css("display", "none");
        } else {
            $table.css("display", "table");
        }
    });
    
    // 체크박스 클릭 시 완료 표시
    $('.checklist-checkbox').on('change', function() {
        $(this).closest('.checklist-item').toggleClass('completed');
    });
});
</script>
</head>

<body>
	<!-- 상단 메뉴바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
	
	<!-- 사이드바 -->
	<c:import url="/WEB-INF/view/common/GroupSideBar.jsp"></c:import>

	<!-- 통계 전처리 -->
	<c:set var="successCount" value="0" />
	<c:forEach var="member" items="${members}">
		<c:if test="${member.successed == '달성'}">
			<c:set var="successCount" value="${successCount+1}"/>
		</c:if>
	</c:forEach>
	<c:choose>
		<c:when test="${members.size() > 0}">
		    <c:set var="ratio" value="${successCount / members.size() * 100}"/>
		</c:when>
		<c:otherwise>
		    <c:set var="ratio" value="0"/>
		</c:otherwise>
	</c:choose>

	<!-- 메인 콘텐츠 -->
	<div class="main-container">
		<div class="board-container">
			<!-- 페이지 헤더 -->
			<div class="board-header">
				<h2 class="board-title">
					<span class="board-title-icon">🎯</span>
					도전과제 상세
				</h2>
				<div class="board-actions">
					<button class="btn btn-accent btn-sm">삭제</button>
					<button class="btn btn-outline btn-sm">신고</button>
				</div>
			</div>

			<!-- 1. 핵심 정보 영역 -->
			<div class="challenge-header-section">
				<h1 style="font-size: 24px; font-weight: 700; margin-bottom: var(--spacing-md);">
					${challengeDetail.title}
				</h1>
				
				<div class="challenge-meta">
					<div class="meta-item">
						<span class="meta-icon">📅</span>
						<span>${challengeDetail.startDate} ~ ${challengeDetail.endDate}</span>
					</div>
					<div class="meta-item">
						<span class="meta-icon">⏱️</span>
						<span>
							<c:choose>
								<c:when test="${challengeDetail.challengeType eq 1}">
									일일 도전과제 (7일)
								</c:when>
								<c:otherwise>
									주간 도전과제 (5주)
								</c:otherwise>
							</c:choose>
						</span>
					</div>
				</div>
				
				<div class="challenge-description">
					${challengeDetail.content}
				</div>
			</div>

			<!-- 2. 통계 대시보드 -->
			<div class="stats-dashboard">
				<h3 class="stats-title">📊 진행 현황</h3>
				
				<div class="stats-grid">
					<div class="stat-card">
						<div class="label">총 참가자</div>
						<div class="value">${members.size()}</div>
					</div>
					<div class="stat-card">
						<div class="label">달성 완료</div>
						<div class="value" style="color: var(--color-accent);">${successCount}</div>
					</div>
					<div class="stat-card">
						<div class="label">달성률</div>
						<div class="value" style="color: var(--color-secondary-dark);">
							<fmt:formatNumber value="${ratio}" pattern="#.0"/>%
						</div>
					</div>
				</div>

				<!-- 진행률 바 -->
				<div class="progress-wrapper">
					<div class="progress-label">
						<span>전체 진행률</span>
						<span><fmt:formatNumber value="${ratio}" pattern="#.0"/>%</span>
					</div>
					<div class="progress-container progress-lg">
						<div class="progress-bar" style="width: ${ratio}%"></div>
					</div>
				</div>
			</div>

			<!-- 3. 도전과제 체크리스트 -->
			<div class="checklist-section">
				<h3 class="section-title">
					<span>✅</span>
					<span>
						<c:choose>
							<c:when test="${challengeDetail.challengeType eq 1}">
								일일 체크리스트
							</c:when>
							<c:otherwise>
								주간 체크리스트
							</c:otherwise>
						</c:choose>
					</span>
				</h3>
				
				<div class="checklist-grid">
					<c:choose>
						<c:when test="${challengeDetail.challengeType eq 1}">
							<c:forEach var="challenge" items="${challengeContentList}">
								<div class="checklist-item">
									<input type="checkbox" class="checklist-checkbox"
										value="${challenge.challengeDetailCode}">
									<span class="checklist-step">Day ${challenge.round}</span>
									<span class="checklist-content">${challenge.contentDetail}</span>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="challenge" items="${challengeContentList}">
								<div class="checklist-item">
									<input type="checkbox" class="checklist-checkbox"
										value="${challenge.challengeDetailCode}">
									<span class="checklist-step">Week ${challenge.round}</span>
									<span class="checklist-content">${challenge.contentDetail}</span>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- 4. 참가자 목록 (접기/펼치기) -->
			<div class="participants-section">
				<div class="toggle-header" id="participantTitle">
					<h3 class="section-title" style="margin: 0;">
						<span>👥</span>
						<span>참가자 목록 (${members.size()}명)</span>
					</h3>
					<span class="toggle-icon">▼</span>
				</div>

				<table id="participantTable" class="participant-table hidden">
					<thead>
						<tr>
							<th style="width: 30%;">참가자</th>
							<th style="width: 20%;">달성여부</th>
							<th style="width: 25%;">달성일</th>
							<th style="width: 25%;">진행률</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="challenger" items="${members}">
							<tr>
								<td><strong>${challenger.nickname}</strong></td>
								<td>
									<c:choose>
										<c:when test="${challenger.successed == '달성'}">
											<span class="badge badge-primary">✓ 달성</span>
										</c:when>
										<c:otherwise>
											<span class="badge">진행중</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>${challenger.successedDate == null ? "-" : challenger.successedDate}</td>
								<td>
									<div class="progress-container">
										<div class="progress-bar" style="width: ${challenger.successed == '달성' ? '100' : '0'}%"></div>
									</div>
								</td>
							</tr>					
						</c:forEach>
					</tbody>
				</table>
			</div>

			<!-- 5. 인증 댓글 영역 -->
			<div class="comments-section">
				<h3 class="section-title">
					<span>💬</span>
					<span>인증 소감 (2)</span>
				</h3>

				<!-- 댓글 작성 -->
				<div class="comment-write">
					<textarea rows="3" placeholder="도전과제를 완료한 소감을 공유해주세요..."></textarea>
					<div class="comment-actions">
						<button class="btn btn-ghost btn-sm">📷 이미지</button>
						<button class="btn btn-primary btn-sm">등록하기</button>
					</div>
				</div>

				<!-- 댓글 목록 -->
				<div class="comment-list">
					<div class="comment-item">
						<div class="left">
							<p class="username">userB</p>
							<p class="content">
								가뿐해요<br>여러분도 해보세요
							</p>
						</div>
						<div class="right">
							<p class="date">yy-mm-dd</p>
							<button class="btn btn-accent btn-sm">삭제</button>
							<button class="btn btn-outline btn-sm">신고</button>
						</div>
					</div>

					<div class="comment-item">
						<div class="left">
							<p class="username">userC</p>
							<p class="content">힘들었지만 뿌듯해요!</p>
						</div>
						<div class="right">
							<p class="date">yy-mm-dd</p>
							<button class="btn btn-accent btn-sm">삭제</button>
							<button class="btn btn-outline btn-sm">신고</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</body>
</html>
