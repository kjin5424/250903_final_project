<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>도전 과제 리스트</title>
<link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css" />
<link rel="stylesheet" href="<%=cp%>/css_new/board_sample.css" />
<link rel="stylesheet" href="<%=cp%>/css_new/challenge_sample.css" />
<link rel="stylesheet" href="<%=cp%>/css_new/home_sample.css" />
</head>
<body>
	<!-- 상단 메뉴바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

	<!-- 사이드바 -->
	<c:import url="/WEB-INF/view/common/GroupSideBar.jsp"></c:import>

	<!-- 메인 콘텐츠 -->
	<div class="main-container">
		<div class="board-container">
			<!-- 게시판 헤더 -->
			<div class="board-header">
				<h2 class="board-title">
					<span class="board-title-icon">🏆</span> 도전 과제
				</h2>
				<div class="board-actions">
					<a href="challengecreatepage.do" class="btn btn-primary"> <span>📝</span>
						<span>도전과제 작성하기</span>
					</a>
				</div>
			</div>

			<!-- 필터 탭 -->
			<div class="challenge-filters">
				<button class="filter-tab active"
					onclick="filterChallenges('all', event)">
					전체 <span style="color: var(- -color-primary);">●</span>
				</button>
				<button class="filter-tab"
					onclick="filterChallenges('started', event)">
					진행중 <span style="color: var(- -color-primary);">●</span>
				</button>
				<button class="filter-tab"
					onclick="filterChallenges('ready', event)">
					대기중 <span style="color: var(- -color-secondary);">●</span>
				</button>
				<button class="filter-tab"
					onclick="filterChallenges('ended', event)">
					종료 <span style="color: #999;">●</span>
				</button>
			</div>

			<!-- 도전 과제 카드 그리드 -->
			<div class="challenge-grid">
				<c:forEach var="challenge" items="${challengeList }">
					<c:choose>
						<%-- 대기중인 도전 과제 --%>
						<c:when test="${challenge.status eq 1 }">
							<div class="challenge-card ready" data-status="ready"
								onclick="location.href='challengedetailpage.do?challengeCode=${challenge.challengeCode}'">
								<div class="card-header">
									<div class="card-title-section">
										<h3 class="card-title">${challenge.title }📚</h3>
									</div>
									<span class="status-badge ready">
										<span>⏱️</span>
										<span>대기중</span>
									</span>
								</div>
	
								<div class="card-info">
									<div class="info-row">
										<div class="info-label">
											<span>📅</span> <span>기간</span>
										</div>
										<div class="info-value">${challenge.startDate }~
											${challenge.endDate }
										</div>
									</div>
									<div class="info-row">
										<div class="info-label">
											<span>🎯</span> <span>타입</span>
										</div>
										<div class="info-value">
											<c:choose>
												<c:when test="${challenge.challengeType eq 1}">
													<span class="type-badge daily">☀️ 일간과제</span>
												</c:when>
												<c:otherwise>
													<span class="type-badge monthly">🌙 월간과제</span>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
	
								<div class="card-footer">
									<div class="card-author">
										<div class="author-avatar">A</div>
										<span>userA</span>
									</div>
									<div class="card-date">${challenge.createdDate }</div>
								</div>
							</div>
						</c:when>
						
						<%-- 진행중인 도전 과제 --%>
						<c:when test="${challenge.status eq 2 }">
							<div class="challenge-card started" data-status="started" 
								onclick="location.href='challengedetailpage.do?challengeCode=${challenge.challengeCode}'">
								<div class="card-header">
									<div class="card-title-section">
										<h3 class="card-title">${challenge.title }📚</h3>
									</div>
									<span class="status-badge started">
										<span>🔥</span>
										<span>진행중</span>
									</span>
								</div>
	
								<div class="card-info">
									<div class="info-row">
										<div class="info-label">
											<span>📅</span> <span>기간</span>
										</div>
										<div class="info-value">${challenge.startDate }~
											${challenge.endDate }
										</div>
									</div>
									<div class="info-row">
										<div class="info-label">
											<span>🎯</span> <span>타입</span>
										</div>
										<div class="info-value">
											<c:choose>
												<c:when test="${challenge.challengeType eq 1}">
													<span class="type-badge daily">☀️ 일간과제</span>
												</c:when>
												<c:otherwise>
													<span class="type-badge monthly">🌙 월간과제</span>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
	
								<div class="card-footer">
									<div class="card-author">
										<div class="author-avatar">A</div>
										<span>userA</span>
									</div>
									<div class="card-date">${challenge.createdDate }</div>
								</div>
							</div>
						</c:when>
						<%-- 종료된 도전과제 --%>
						<c:otherwise>
							<div class="challenge-card ended" data-status="ended"
								onclick="location.href='challengedetailpage.do?challengeCode=${challenge.challengeCode}'">
								<div class="card-header">
									<div class="card-title-section">
										<h3 class="card-title">${challenge.title }📚</h3>
									</div>
									<span class="status-badge ended">
										<span>✓</span>
										<span>종료</span>
									</span>
								</div>
	
								<div class="card-info">
									<div class="info-row">
										<div class="info-label">
											<span>📅</span> <span>기간</span>
										</div>
										<div class="info-value">${challenge.startDate }~
											${challenge.endDate }
										</div>
									</div>
									<div class="info-row">
										<div class="info-label">
											<span>🎯</span> <span>타입</span>
										</div>
										<div class="info-value">
											<c:choose>
												<c:when test="${challenge.challengeType eq 1}">
													<span class="type-badge daily">☀️ 일간과제</span>
												</c:when>
												<c:otherwise>
													<span class="type-badge monthly">🌙 월간과제</span>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
	
								<div class="card-footer">
									<div class="card-author">
										<div class="author-avatar">A</div>
										<span>userA</span>
									</div>
									<div class="card-date">${challenge.createdDate }</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>

			<!-- 
			도전 과제 카드 그리드
			<div class="challenge-grid">
				대기 중인 과제
				<div class="challenge-card ready" data-status="ready" onclick="location.href='ChallengeDetail.jsp'">
					<div class="card-header">
						<div class="card-title-section">
							<h3 class="card-title">영단어 마스터 📚</h3>
						</div>
						<span class="status-badge ready">
							<span>⏱️</span>
							<span>대기중</span>
						</span>
					</div>
					
					<div class="card-info">
						<div class="info-row">
							<div class="info-label">
								<span>📅</span>
								<span>기간</span>
							</div>
							<div class="info-value">2025-10-15 ~ 2025-10-21</div>
						</div>
						<div class="info-row">
							<div class="info-label">
								<span>🎯</span>
								<span>타입</span>
							</div>
							<div class="info-value">
								<span class="type-badge daily">☀️ 일간과제</span>
							</div>
						</div>
					</div>
					
					<div class="card-footer">
						<div class="card-author">
							<div class="author-avatar">A</div>
							<span>userA</span>
						</div>
						<div class="card-date">2025-10-10</div>
					</div>
				</div>
				
				진행 중인 과제
				<div class="challenge-card started" data-status="started" onclick="location.href='ChallengeDetail.jsp'">
					<div class="card-header">
						<div class="card-title-section">
							<h3 class="card-title">한자 마스터 ✍️</h3>
						</div>
						<span class="status-badge started">
							<span>🔥</span>
							<span>진행중</span>
						</span>
					</div>
					
					<div class="card-info">
						<div class="info-row">
							<div class="info-label">
								<span>📅</span>
								<span>기간</span>
							</div>
							<div class="info-value">
								<span class="info-value">2025-10-06 ~ 2025-11-09</span>
							</div>
						</div>
						<div class="info-row">
							<div class="info-label">
								<span>🎯</span>
								<span>타입</span>
							</div>
							<div class="info-value">
								<span class="type-badge monthly">🌙 월간과제</span>
							</div>
						</div>
					</div>
					
					<div class="card-footer">
						<div class="card-author">
							<div class="author-avatar">A</div>
							<span>userA</span>
						</div>
						<div class="card-date">2025-09-20</div>
					</div>
				</div>
				
				종료된 과제 1
				<div class="challenge-card ended" data-status="ended" onclick="location.href='ChallengeDetail.jsp'">
					<div class="card-header">
						<div class="card-title-section">
							<h3 class="card-title">일어 마스터 완전 정복하기 프로젝트 🇯🇵</h3>
						</div>
						<span class="status-badge ended">
							<span>✓</span>
							<span>종료</span>
						</span>
					</div>
					
					<div class="card-info">
						<div class="info-row">
							<div class="info-label">
								<span>📅</span>
								<span>기간</span>
							</div>
							<div class="info-value">2025-09-22 ~ 2025-09-28</div>
						</div>
						<div class="info-row">
							<div class="info-label">
								<span>🎯</span>
								<span>타입</span>
							</div>
							<div class="info-value">
								<span class="type-badge daily">☀️ 일간과제</span>
							</div>
						</div>
					</div>
					
					<div class="card-footer">
						<div class="card-author">
							<div class="author-avatar">D</div>
							<span>userD</span>
						</div>
						<div class="card-date">2025-09-15</div>
					</div>
				</div>
				
				종료된 과제 2
				<div class="challenge-card ended" data-status="ended" onclick="location.href='ChallengeDetail.jsp'">
					<div class="card-header">
						<div class="card-title-section">
							<h3 class="card-title">영단어 마스터 📚</h3>
						</div>
						<span class="status-badge ended">
							<span>✓</span>
							<span>종료</span>
						</span>
					</div>
					
					<div class="card-info">
						<div class="info-row">
							<div class="info-label">
								<span>📅</span>
								<span>기간</span>
							</div>
							<div class="info-value">2025-09-06 ~ 2025-09-12</div>
						</div>
						<div class="info-row">
							<div class="info-label">
								<span>🎯</span>
								<span>타입</span>
							</div>
							<div class="info-value">
								<span class="type-badge daily">☀️ 일간과제</span>
							</div>
						</div>
					</div>
					
					<div class="card-footer">
						<div class="card-author">
							<div class="author-avatar">D</div>
							<span>userD</span>
						</div>
						<div class="card-date">2025-09-04</div>
					</div>
				</div>
				
				종료된 과제 3
				<div class="challenge-card ended" data-status="ended" onclick="location.href='ChallengeDetail.jsp'">
					<div class="card-header">
						<div class="card-title-section">
							<h3 class="card-title">불어 마스터 🇫🇷</h3>
						</div>
						<span class="status-badge ended">
							<span>✓</span>
							<span>종료</span>
						</span>
					</div>
					
					<div class="card-info">
						<div class="info-row">
							<div class="info-label">
								<span>📅</span>
								<span>기간</span>
							</div>
							<div class="info-value">2025-09-07 ~ 2025-10-11</div>
						</div>
						<div class="info-row">
							<div class="info-label">
								<span>🎯</span>
								<span>타입</span>
							</div>
							<div class="info-value">
								<span class="type-badge monthly">🌙 월간과제</span>
							</div>
						</div>
					</div>
					
					<div class="card-footer">
						<div class="card-author">
							<div class="author-avatar">D</div>
							<span>userD</span>
						</div>
						<div class="card-date">2025-09-04</div>
					</div>
				</div>
				
				종료된 과제 4
				<div class="challenge-card ended" data-status="ended" onclick="location.href='ChallengeDetail.jsp'">
					<div class="card-header">
						<div class="card-title-section">
							<h3 class="card-title">아랍어 마스터 🕌</h3>
						</div>
						<span class="status-badge ended">
							<span>✓</span>
							<span>종료</span>
						</span>
					</div>
					
					<div class="card-info">
						<div class="info-row">
							<div class="info-label">
								<span>📅</span>
								<span>기간</span>
							</div>
							<div class="info-value">2025-09-08 ~ 2025-09-14</div>
						</div>
						<div class="info-row">
							<div class="info-label">
								<span>🎯</span>
								<span>타입</span>
							</div>
							<div class="info-value">
								<span class="type-badge daily">☀️ 일간과제</span>
							</div>
						</div>
					</div>
					
					<div class="card-footer">
						<div class="card-author">
							<div class="author-avatar">A</div>
							<span>userA</span>
						</div>
						<div class="card-date">2025-09-01</div>
					</div>
				</div>
				
				종료된 과제 5
				<div class="challenge-card ended" data-status="ended" onclick="location.href='ChallengeDetail.jsp'">
					<div class="card-header">
						<div class="card-title-section">
							<h3 class="card-title">일어 마스터 🇯🇵</h3>
						</div>
						<span class="status-badge ended">
							<span>✓</span>
							<span>종료</span>
						</span>
					</div>
					
					<div class="card-info">
						<div class="info-row">
							<div class="info-label">
								<span>📅</span>
								<span>기간</span>
							</div>
							<div class="info-value">2025-09-01 ~ 2025-10-05</div>
						</div>
						<div class="info-row">
							<div class="info-label">
								<span>🎯</span>
								<span>타입</span>
							</div>
							<div class="info-value">
								<span class="type-badge monthly">🌙 월간과제</span>
							</div>
						</div>
					</div>
					
					<div class="card-footer">
						<div class="card-author">
							<div class="author-avatar">A</div>
							<span>userA</span>
						</div>
						<div class="card-date">2025-08-27</div>
					</div>
				</div>
				
				종료된 과제 6
				<div class="challenge-card ended" data-status="ended" onclick="location.href='ChallengeDetail.jsp'">
					<div class="card-header">
						<div class="card-title-section">
							<h3 class="card-title">영단어 마스터 📚</h3>
						</div>
						<span class="status-badge ended">
							<span>✓</span>
							<span>종료</span>
						</span>
					</div>
					
					<div class="card-info">
						<div class="info-row">
							<div class="info-label">
								<span>📅</span>
								<span>기간</span>
							</div>
							<div class="info-value">2025-09-01 ~ 2025-09-07</div>
						</div>
						<div class="info-row">
							<div class="info-label">
								<span>🎯</span>
								<span>타입</span>
							</div>
							<div class="info-value">
								<span class="type-badge daily">☀️ 일간과제</span>
							</div>
						</div>
					</div>
					
					<div class="card-footer">
						<div class="card-author">
							<div class="author-avatar">D</div>
							<span>userD</span>
						</div>
						<div class="card-date">2025-08-27</div>
					</div>
				</div>
			</div>
			-->

			<!-- 페이지네이션 -->
			<!--
			<div class="pagination">
				<button class="page-btn active">1</button>
				<button class="page-btn">2</button>
				<button class="page-btn">3</button>
				<button class="page-btn">4</button>
				<button class="page-btn">5</button>
			</div>
			-->
		</div>
	</div>

	<script>
	// 필터 기능
	function filterChallenges(status, event) {
		const cards = document.querySelectorAll('.challenge-card');
		const tabs = document.querySelectorAll('.filter-tab');
		
		// 탭 활성화
		tabs.forEach(tab => tab.classList.remove('active'));
		event.target.closest('.filter-tab').classList.add('active');
		
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
</body>
</html>
