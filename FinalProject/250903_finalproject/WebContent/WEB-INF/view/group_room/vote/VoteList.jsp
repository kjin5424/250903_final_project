<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>투표 리스트</title>
<link rel="stylesheet" href="<%=cp %>/css_new/common_sample.css" />
<link rel="stylesheet" href="<%=cp %>/css_new/board_sample.css" />
<link rel="stylesheet" href="<%=cp %>/css_new/vote_sample.css" />
<link rel="stylesheet" href="<%=cp %>/css_new/home_sample.css" />

<script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
    $(function() {
        var errorType = parseInt("${errorType}", 10);
        if (errorType) {
            if (errorType === 1) {
            	alert("로그인 후 이용 가능합니다.");
        	} else if(errorType === 2) {
            	alert("활동 등록은 해당 모임의 구성원만 가능합니다.");
           	}
        }
    });
    
    // 필터 기능
    function filterVotes(status, event) {
		const cards = document.querySelectorAll('.vote-card');
		const tabs = document.querySelectorAll('.vote-filter-tab');
		
		// 탭 활성화
		tabs.forEach(tab => tab.classList.remove('active'));
		event.target.closest('.vote-filter-tab').classList.add('active');
		
		// 카드 필터링
		cards.forEach(card => {
			if (status === 'all') {
				card.style.display = 'flex';
			} else {
				if (card.dataset.status === status) {
					card.style.display = 'flex';
				} else {
					card.style.display = 'none';
				}
			}
		});
	}
</script>
</head>
<body>
<!-- 상단 메뉴바 -->
<c:import url="/WEB-INF/view/common/TopMenuBar.jsp"/>

<!-- 사이드바 -->
<c:import url="/WEB-INF/view/common/GroupSideBar.jsp"/>

	<!-- 메인 콘텐츠 -->
	<div class="main-container">
		<div class="board-container">
			<!-- 게시판 헤더 -->
			<div class="board-header">
				<h2 class="board-title">
					<span class="board-title-icon">📊</span>
					투표 관리
				</h2>
				<div class="board-actions">
					<a href="votecreate.do?groupApplyCode=${groupApplyCode}">
						<button class="btn btn-primary">
							<span>➕</span>
							<span>새 투표 만들기</span>
						</button>
					</a>
				</div>
			</div>
			
			<!-- 필터 탭 -->
			<div class="vote-filters">
				<button class="vote-filter-tab active" onclick="filterVotes('all', event)">
					전체 <span style="color: var(--color-primary);">●</span>
				</button>
				<button class="vote-filter-tab" onclick="filterVotes('ongoing', event)">
					투표중 <span style="color: var(--color-primary);">●</span>
				</button>
				<button class="vote-filter-tab" onclick="filterVotes('ended', event)">
					종료 <span style="color: #999;">●</span>
				</button>
			</div>
			
			<!-- 투표 카드 그리드 -->
			<c:choose>
				<c:when test="${not empty activityList}">
					<div class="vote-grid">
						<c:forEach var="activityDTO" items="${activityList}">
							<c:set var="isEnded" value="${activityDTO.status != '투표중'}" />
							<div class="vote-card ${activityDTO.status == '투표중' ? 'ongoing' : 'ended'}" 
							     data-status="${activityDTO.status == '투표중' ? 'ongoing' : 'ended'}">
								
								<!-- 카드 헤더 -->
								<div class="vote-card-header">
									<div class="vote-title-section">
										<h3 class="vote-title">${activityDTO.content}</h3>
									</div>
									<span class="vote-status-badge ${activityDTO.status == '투표중' ? 'ongoing' : 'ended'}">
										<span>${activityDTO.status == '투표중' ? '🔥' : '✓'}</span>
										<span>${activityDTO.status}</span>
									</span>
								</div>
								
								<!-- 투표 기간 -->
								<div class="vote-info-section">
									<div class="vote-info-row">
										<span class="vote-info-icon">📅</span>
										<span class="vote-info-label">투표기간</span>
										<span class="vote-info-value">${activityDTO.createdDate} ~ ${activityDTO.limitVoteDate}</span>
									</div>
									<div class="vote-info-row">
										<span class="vote-info-icon">📍</span>
										<span class="vote-info-label">활동일시</span>
										<span class="vote-info-value">${activityDTO.activeDate} ~ ${activityDTO.activeEndTime}</span>
									</div>
									<div class="vote-info-row">
										<span class="vote-info-icon">🌐</span>
										<span class="vote-info-label">진행방식</span>
										<span class="vote-info-value">${activityDTO.onOffLine}</span>
									</div>
									<div class="vote-info-row">
										<span class="vote-info-icon">🏢</span>
										<span class="vote-info-label">장소</span>
										<span class="vote-info-value">${activityDTO.place}</span>
									</div>
								</div>
								
								<!-- 참여 통계 -->
								<div class="vote-stats">
									<div class="vote-stat-item">
										<span class="vote-stat-number">${activityDTO.totalMember}</span>
										<span class="vote-stat-label">총 인원</span>
									</div>
									<div class="vote-stat-item">
										<span class="vote-stat-number" style="color: var(--color-primary);">${activityDTO.registrants}</span>
										<span class="vote-stat-label">참여</span>
									</div>
									<div class="vote-stat-item">
										<span class="vote-stat-number" style="color: #9E9E9E;">${activityDTO.totalMember - activityDTO.registrants}</span>
										<span class="vote-stat-label">미참</span>
									</div>
								</div>
								
								<!-- 투표 옵션 -->
								<div class="vote-options">
									<!-- 참여 옵션 -->
									<div class="vote-option">
										<div class="vote-option-header">
											<label class="vote-option-label">
												<input type="radio" name="vote_${activityDTO.activityCode}" value="1" ${isEnded ? 'disabled' : ''}>
												<span>✅ 참여</span>
											</label>
											<span class="vote-option-percentage">
												${activityDTO.registrants}명 
												(${activityDTO.totalMember > 0 ? String.format('%.1f', activityDTO.registrants * 100.0 / activityDTO.totalMember) : '0'}%)
											</span>
										</div>
										<div class="vote-progress-bar">
											<div class="vote-progress-fill participate" 
											     style="width: ${activityDTO.totalMember > 0 ? activityDTO.registrants * 100 / activityDTO.totalMember : 0}%;"></div>
										</div>
									</div>
									
									<!-- 미참 옵션 -->
									<div class="vote-option">
										<div class="vote-option-header">
											<label class="vote-option-label">
												<input type="radio" name="vote_${activityDTO.activityCode}" value="0" ${isEnded ? 'disabled' : ''}>
												<span>❌ 미참</span>
											</label>
											<span class="vote-option-percentage">
												${activityDTO.totalMember - activityDTO.registrants}명 
												(${activityDTO.totalMember > 0 ? String.format('%.1f', (activityDTO.totalMember - activityDTO.registrants) * 100.0 / activityDTO.totalMember) : '0'}%)
											</span>
										</div>
										<div class="vote-progress-bar">
											<div class="vote-progress-fill not-participate" 
											     style="width: ${activityDTO.totalMember > 0 ? (activityDTO.totalMember - activityDTO.registrants) * 100 / activityDTO.totalMember : 0}%;"></div>
										</div>
									</div>
								</div>
								
								<!-- 버튼 그룹 -->
								<div class="vote-button-group">
									<button class="vote-btn vote-btn-submit" 
									        onclick="submitVote('${activityDTO.activityCode}')"
									        ${isEnded ? 'disabled' : ''}>
										<span>✓</span>
										<span>제출</span>
									</button>
									<a href="VoteModify.jsp?activityCode=${activityDTO.activityCode}" style="flex: 1;">
										<button class="vote-btn vote-btn-edit" 
										        style="width: 100%;"
										        ${isEnded ? 'disabled' : ''}>
											<span>✏️</span>
											<span>수정</span>
										</button>
									</a>
									<button class="vote-btn vote-btn-delete" 
									        onclick="deleteVote('${activityDTO.activityCode}')"
									        ${isEnded ? 'disabled' : ''}>
										<span>🗑️</span>
										<span>삭제</span>
									</button>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<div class="vote-empty">
						<div class="vote-empty-icon">📊</div>
						<div class="vote-empty-text">진행 중인 투표가 없습니다</div>
						<div class="empty-subtext">새로운 투표를 만들어보세요!</div>
					</div>
				</c:otherwise>
			</c:choose>
			
			<!-- 페이지네이션 -->
			<div class="pagination">
				${pageIndexList}
			</div>
		</div>
	</div>
	
	<script>
	function submitVote(activityCode) {
		const selectedOption = document.querySelector('input[name="vote_' + activityCode + '"]:checked');
		if (!selectedOption) {
			alert('투표 옵션을 선택해주세요.');
			return;
		}
		// 투표 제출 로직
		alert('투표가 제출되었습니다.');
		// location.href = 'votesubmit.do?activityCode=' + activityCode + '&vote=' + selectedOption.value;
	}
	
	function deleteVote(activityCode) {
		if (confirm('정말 삭제하시겠습니까?')) {
			// 삭제 로직
			// location.href = 'votedelete.do?activityCode=' + activityCode;
		}
	}
	</script>
</body>
</html>
