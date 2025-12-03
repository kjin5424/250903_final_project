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
/* 챌린지 헤더 */
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

.challenge-description {
	margin-top: var(--spacing-md);
	padding: var(--spacing-md);
	background: rgba(255, 255, 255, 0.7);
	border-radius: var(--radius-md);
	color: var(--color-text-primary);
	line-height: 1.6;
}

/* 진행률 & 참가자 목록 공통 제목 스타일 */
.section-title-inline {
	font-size: 16px;
	font-weight: 700;
	color: var(--color-text-primary);
	display: flex;
	align-items: center;
	gap: var(--spacing-sm);
	margin-bottom: var(--spacing-md);
	margin-top: var(--spacing-xl);
}

/* 진행률 바 - 하얀 배경, accent-dark 진행 */
.progress-container-white {
	background: white;
	border-radius: var(--radius-full);
	height: 24px;
	overflow: hidden;
	box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
}

.progress-bar-accent {
	height: 100%;
	background: var(--color-accent-dark);
	border-radius: var(--radius-full);
	transition: width 0.3s ease;
	display: flex;
	align-items: center;
	justify-content: flex-end;
	padding-right: 12px;
	color: white;
	font-size: 12px;
	font-weight: 600;
}

/* 참가자 목록 토글 */
.toggle-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	cursor: pointer;
	padding: var(--spacing-md);
	background: rgba(255, 255, 255, 0.7);
	border-radius: var(--radius-md);
	transition: all var(--transition-base);
}

.toggle-header:hover {
	background: rgba(255, 255, 255, 0.9);
}

.toggle-icon {
	transition: transform var(--transition-base);
	font-size: 14px;
}

.toggle-icon.active {
	transform: rotate(180deg);
}

.participant-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: var(--spacing-md);
	background: rgba(255, 255, 255, 0.7);
	border-radius: var(--radius-md);
	overflow: hidden;
}

.participant-table th {
	background: rgba(255, 255, 255, 0.9);
	padding: 12px;
	text-align: left;
	font-weight: 600;
	border-bottom: 2px solid var(--color-border);
	font-size: 14px;
}

.participant-table td {
	padding: 14px 12px;
	border-bottom: 1px solid var(--color-border-light);
	font-size: 14px;
}

.participant-table tr:hover {
	background: rgba(255, 255, 255, 0.5);
}

/* 체크리스트 */
.checklist-section {
	background: var(--color-white);
	padding: var(--spacing-xl);
	border-radius: var(--radius-lg);
	margin-bottom: var(--spacing-xl);
	box-shadow: var(--shadow-sm);
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

/* 댓글 영역 - 이미지 스타일 적용 */
.comments-section {
	background: var(--color-white);
	padding: var(--spacing-xl);
	border-radius: var(--radius-lg);
	box-shadow: var(--shadow-sm);
}

.comments-title {
	font-size: 18px;
	font-weight: 700;
	color: var(--color-text-primary);
	margin-bottom: var(--spacing-lg);
	display: flex;
	align-items: center;
	gap: var(--spacing-sm);
}

.comment-write {
	background: var(--color-base);
	border-radius: var(--radius-md);
	padding: var(--spacing-lg);
	margin-bottom: var(--spacing-xl);
}

.comment-textarea {
	width: 100%;
	padding: var(--spacing-md);
	border: 2px solid var(--color-border);
	border-radius: var(--radius-md);
	font-size: 14px;
	resize: vertical;
	min-height: 80px;
	font-family: inherit;
	margin-bottom: var(--spacing-md);
	background: var(--color-white);
	transition: all var(--transition-fast);
}

.comment-textarea:focus {
	outline: none;
	border-color: var(--color-primary);
	box-shadow: 0 0 0 3px var(--color-primary-lighter);
}

.comment-submit-area {
	display: flex;
	justify-content: flex-end;
}

.btn-submit-comment {
	padding: 10px 20px;
	background: var(--color-primary);
	color: white;
	border: none;
	border-radius: var(--radius-md);
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all var(--transition-base);
}

.btn-submit-comment:hover {
	background: var(--color-primary-dark);
	transform: translateY(-1px);
}

.comment-list {
	display: flex;
	flex-direction: column;
	gap: var(--spacing-md);
}

/* 이미지와 동일한 댓글 스타일 */
.comment-item {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	padding: var(--spacing-lg);
	background: var(--color-base);
	border-radius: var(--radius-md);
	transition: all var(--transition-fast);
}

.comment-item:hover {
	box-shadow: var(--shadow-sm);
}

.comment-left {
	display: flex;
	gap: var(--spacing-md);
	flex: 1;
}

.comment-avatar {
	width: 40px;
	height: 40px;
	border-radius: var(--radius-full);
	background: var(--color-secondary);
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-weight: 700;
	font-size: 16px;
	flex-shrink: 0;
}

.comment-body {
	flex: 1;
}

.comment-author-line {
	display: flex;
	align-items: baseline;
	gap: var(--spacing-md);
	margin-bottom: var(--spacing-xs);
}

.comment-author-name {
	font-weight: 600;
	color: var(--color-text-primary);
	font-size: 14px;
}

.comment-date {
	font-size: 12px;
	color: var(--color-text-tertiary);
}

.comment-content {
	font-size: 14px;
	color: var(--color-text-primary);
	line-height: 1.5;
}

.comment-actions {
	display: flex;
	gap: var(--spacing-sm);
	flex-shrink: 0;
}

.btn-comment-delete {
	padding: 8px 16px;
	background: var(--color-accent);
	color: white;
	border: none;
	border-radius: var(--radius-sm);
	font-size: 13px;
	font-weight: 600;
	cursor: pointer;
	transition: all var(--transition-fast);
}

.btn-comment-delete:hover {
	background: var(--color-accent-dark);
}

.btn-comment-report {
	padding: 8px 16px;
	background: transparent;
	color: var(--color-primary-dark);
	border: 2px solid var(--color-primary);
	border-radius: var(--radius-sm);
	font-size: 13px;
	font-weight: 600;
	cursor: pointer;
	transition: all var(--transition-fast);
}

.btn-comment-report:hover {
	background: var(--color-primary-lighter);
}

.hidden {
	display: none;
}

/* 반응형 */
@media (max-width: 768px) {
	.comment-item {
		flex-direction: column;
		gap: var(--spacing-md);
	}
	
	.comment-actions {
		align-self: flex-start;
	}
}
</style>
<script type="text/javascript">
$(function()
{
    // 참가자 목록 토글
    $('#participantTitle').on('click', function() {
        const $table = $('#participantTable');
        const $icon = $(this).find('.toggle-icon');
        
        $table.toggleClass('hidden');
        $icon.toggleClass('active');
    });
    
    // 체크박스 변경 시 진행률 업데이트
    $('.checklist-checkbox').on('change', function() {
        const $item = $(this).closest('.checklist-item');
        $item.toggleClass('completed');
        
        // 진행률 계산
        updateProgress();
        
        // DB 저장 (AJAX)
        const challengeDetailCode = $(this).val();
        const isChecked = $(this).is(':checked');
        
        $.ajax({
            url: '<%=cp%>/challenge/updateProgress.action',
            type: 'POST',
            data: {
                challengeDetailCode: challengeDetailCode,
                completed: isChecked
            },
            success: function(response) {
                console.log('진행률 업데이트 성공');
            },
            error: function() {
                alert('진행률 업데이트에 실패했습니다.');
                // 실패 시 체크 상태 되돌리기
                $item.toggleClass('completed');
                this.checked = !isChecked;
            }
        });
    });
    
    // 진행률 업데이트 함수
    function updateProgress() {
        const totalItems = $('.checklist-checkbox').length;
        const checkedItems = $('.checklist-checkbox:checked').length;
        const percentage = totalItems > 0 ? Math.round((checkedItems / totalItems) * 100) : 0;
        
        // 진행률 바 업데이트
        $('#progressBar').css('width', percentage + '%');
        $('#progressText').text(percentage + '%');
        $('#progressPercent').text(percentage);
    }
    
    // 페이지 로드 시 초기 진행률 계산
    updateProgress();
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
					<!-- 작성자인 경우 삭제/신고, 그 외는 참가 버튼 -->
					<c:choose>
						<c:when test="${isAuthor}">
							<button class="btn btn-accent btn-sm">삭제</button>
							<button class="btn btn-outline btn-sm">신고</button>
						</c:when>
						<c:otherwise>
							<!-- 미참가 상태인 경우만 참가 버튼 표시 -->
							<c:if test="${!isParticipated}">
								<button class="btn btn-primary btn-sm">참가하기</button>
							</c:if>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- 1. 챌린지 헤더 (핵심 정보 + 전체 진행률 + 참가자 목록) -->
			<div class="challenge-header-section">
				<h1 style="font-size: 24px; font-weight: 700; margin-bottom: var(--spacing-md);">
					${challengeDetail.title}
				</h1>
				
				<div class="challenge-meta">
					<div class="meta-item">
						<span>📅</span>
						<span>${challengeDetail.startDate} ~ ${challengeDetail.endDate}</span>
					</div>
					<div class="meta-item">
						<span>⏱️</span>
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

				<!-- 전체 진행률 -->
				<div class="section-title-inline">
					<span>📊</span>
					<span>전체 진행률</span>
					<span id="progressText" style="color: var(--color-accent-dark); font-weight: 700;">
						<fmt:formatNumber value="${ratio}" pattern="#"/>%
					</span>
				</div>
				<div class="progress-container-white">
					<div id="progressBar" class="progress-bar-accent" style="width: ${ratio}%">
						<span id="progressPercent"><fmt:formatNumber value="${ratio}" pattern="#"/>%</span>
					</div>
				</div>

				<!-- 참가자 목록 -->
				<div class="section-title-inline">
					<span>👥</span>
					<span>참가자 목록 (${members.size()}명)</span>
				</div>
				<div class="toggle-header" id="participantTitle">
					<span style="font-size: 14px; color: var(--color-text-secondary);">
						클릭하여 참가자 목록 보기
					</span>
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

			<!-- 2. 도전과제 체크리스트 -->
			<div class="checklist-section">
				<h3 style="font-size: 18px; font-weight: 700; margin-bottom: var(--spacing-lg); display: flex; align-items: center; gap: var(--spacing-sm);">
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

			<!-- 3. 인증 소감 -->
			<div class="comments-section">
				<h3 class="comments-title">
					<span>💬</span>
					<span>인증 소감 (2)</span>
				</h3>

				<!-- 댓글 작성 -->
				<div class="comment-write">
					<textarea class="comment-textarea" rows="3" placeholder="도전과제를 완료한 소감을 공유해주세요..."></textarea>
					<div class="comment-submit-area">
						<button class="btn-submit-comment">등록하기</button>
					</div>
				</div>

				<!-- 댓글 목록 -->
				<div class="comment-list">
					<div class="comment-item">
						<div class="comment-left">
							<div class="comment-avatar">B</div>
							<div class="comment-body">
								<div class="comment-author-line">
									<span class="comment-author-name">userB</span>
									<span class="comment-date">yy-mm-dd</span>
								</div>
								<div class="comment-content">
									가뿐해요<br>여러분도 해보세요
								</div>
							</div>
						</div>
						<div class="comment-actions">
							<button class="btn-comment-delete">삭제</button>
							<button class="btn-comment-report">신고</button>
						</div>
					</div>

					<div class="comment-item">
						<div class="comment-left">
							<div class="comment-avatar">C</div>
							<div class="comment-body">
								<div class="comment-author-line">
									<span class="comment-author-name">userC</span>
									<span class="comment-date">yy-mm-dd</span>
								</div>
								<div class="comment-content">
									힘들었지만 뿌듯해요!
								</div>
							</div>
						</div>
						<div class="comment-actions">
							<button class="btn-comment-delete">삭제</button>
							<button class="btn-comment-report">신고</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</body>
</html>
