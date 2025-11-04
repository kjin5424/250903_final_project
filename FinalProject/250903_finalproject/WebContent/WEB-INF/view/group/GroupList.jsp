<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	request.setAttribute("cp", cp);
%>
<!DOCTYPE html>
<html lang="ko">
<!-- CSS 파일 로드 (순서 중요!) -->
<link rel="stylesheet" href="<%=cp%>/css/variables.css">
<link rel="stylesheet" href="<%=cp%>/css/common.css">
<link rel="stylesheet" href="<%=cp%>/css/components.css">

<!-- JavaScript -->
<script>
	document.addEventListener('DOMContentLoaded', () => 
	{ 
	    // 즐겨찾기 버튼 토글
	    document.querySelectorAll('.favorite-btn').forEach(btn => 
	    {
	        btn.addEventListener('click', (e) => {
	            e.stopPropagation();
	            btn.classList.toggle('active');
	            btn.classList.toggle('inactive');
	        });
	    });
	    
		 // 마우스 휠로 가로 스크롤 제어
	    document.querySelectorAll('.meetings-container').forEach(container => 
	    {
	    	const minItemsForScroll = 3; // 3개 초과 시만 가로 스크롤 적용
	        const itemCount = container.children.length;
	    	
	        container.addEventListener('wheel', (e) => {
	            // 기본 세로 스크롤 방지
	            e.preventDefault();
	            
	            // 휠 내림(deltaY > 0) -> 오른쪽으로 스크롤
	            // 휠 올림(deltaY < 0) -> 왼쪽으로 스크롤
	            container.scrollLeft += e.deltaY;
	        });
	    });
	});
</script>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 목록 - 공모자들</title>

</head>
<body>
	<!-- 상단바 (그라디언트 영역) -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

	<!-- Outer Wrapper (그라디언트 영역) -->
	<div class="outerwrapper">
		<!-- Inner Wrapper (연회색 영역) -->
		<div class="inner-wrapper">
			<div class="content">

				<%
					// 현재 선택된 카테고리 (파라미터로 받기)
				String selectedCategory = request.getParameter("category");
				if (selectedCategory == null)
					selectedCategory = "all";
				%>

				<!-- 카테고리 필터 섹션 -->
				<div class="category-filter-section">
					<div class="category-tags">
						<a href="?category=all"
							class="category-btn <%="all".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">📚</span> <span>전체</span>
						</a> <a href="?category=reading"
							class="category-btn <%="reading".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">📖</span> <span>독서</span>
						</a> <a href="?category=language"
							class="category-btn <%="language".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">🌐</span> <span>어학</span>
						</a> <a href="?category=it"
							class="category-btn <%="it".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">💻</span> <span>IT</span>
						</a> <a href="?category=startup"
							class="category-btn <%="startup".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">🚀</span> <span>창업·취업</span>
						</a> <a href="?category=license"
							class="category-btn <%="license".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">📜</span> <span>자격증</span>
						</a> <a href="?category=exam"
							class="category-btn <%="exam".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">📝</span> <span>시험</span>
						</a> <a href="?category=hobby"
							class="category-btn <%="hobby".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">🎨</span> <span>취미</span>
						</a>
					</div>
				</div>

				<!-- 검색 섹션 (선택사항) -->
				<jsp:include page="/WEB-INF/view/common/Search.jsp" />

				<!-- IT 카테고리 섹션 -->
				<div class="section category-section">
					<div class="section-header">
						<h2 class="section-title">💻 IT</h2>
					</div>
					
					<div class="meetings-container scroll-container">
						<!-- 모임 카드 컨테이너 -->
						<c:forEach var="group" items="${groupList}">
							<div class="meeting-card" 
								onclick="location.href='grouplistdetail.do?groupCode=${group.groupApplyCode}'">
								<div class="meeting-image">
									<c:choose>
										<c:when test="${group.savePath != null }">
											<img src="<%=cp %>/img/group/${group.savePath}" />
										</c:when>
										<c:when test="${group.topicType eq '1'}">
											📖
										</c:when>
										<c:when test="${group.topicType eq '2'}">
											🌐
										</c:when>
										<c:when test="${group.topicType eq '3'}">
											💻
										</c:when>
										<c:when test="${group.topicType eq '4'}">
											🚀
										</c:when>
										<c:when test="${group.topicType eq '5'}">
											📜
										</c:when>
										<c:when test="${group.topicType eq '6'}">
											📝
										</c:when>
										<c:when test="${group.topicType eq '7'}">
											🎨
										</c:when>
										<c:otherwise>
											88
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${group.currentMemberCount < group.headCount}">
											<span class="badge badge-recruiting badge-absolute">모집중</span>
										</c:when>
										<c:otherwise>
											<span class="badge badge-recruiting badge-absolute">모집완료</span>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="meeting-info" data-groupCode="${group.groupApplyCode }">
									<h3 class="meeting-title">${group.groupTitle }</h3>
									<p class="meeting-description">${group.groupContent }</p>
									<div class="meeting-meta">
										<div class="meta-item">
											<span class="meta-icon">👥</span> <span>${group.currentMemberCount}/${group.headCount }명</span>
										</div>
										<div class="meta-item">
											<span class="meta-icon">📅</span> <span>주기 : ${group.frequency }</span>
										</div>
										<div class="meta-item">
											<span class="meta-icon">📍</span> <span>${group.onOff }</span><br>
										</div>
										<div class="meta-item">
											<c:choose>
												<c:when test="${group.region != null}">
													<span>모임 지역 : ${group.region }</span>
												</c:when>
											</c:choose>
										</div>
									</div>
									<div class="meeting-footer">
										<div class="tags">
											<!-- 하트 우측하단 용 공백 div -->
											<!-- 삭제해도 무방 -->
										</div>
										<button class="favorite-btn inactive">♥</button>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>

				<!-- 자격증 카테고리 섹션 -->
				<div class="section category-section">
					<div class="section-header">
						<h2 class="section-title">📜 자격증</h2>
						<span class="section-count">3</span>
					</div>

					<div class="meetings-container scroll-container">
						<div class="meeting-card">
							<div class="meeting-image">
								💼 <span class="badge badge-recruiting badge-absolute">모집중</span>
							</div>
							<div class="meeting-info">
								<h3 class="meeting-title">정보처리기사 준비반</h3>
								<p class="meeting-description">2025년 상반기 정보처리기사 시험 대비 스터디</p>
								<div class="meeting-meta">
									<div class="meta-item">
										<span class="meta-icon">👥</span> <span>9/12명</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📅</span> <span>매주 월, 목 20:00</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📍</span> <span>온라인</span>
									</div>
								</div>
								<div class="meeting-footer">
									<div class="tags">
										<span class="tag">자격증</span> <span class="tag">IT</span>
									</div>
									<button class="favorite-btn inactive">♥</button>
								</div>
							</div>
						</div>

						<div class="meeting-card">
							<div class="meeting-image">
								🌐 <span class="lock-icon">🔒</span> <span
									class="badge badge-closed badge-absolute">모집완료</span>
							</div>
							<div class="meeting-info">
								<h3 class="meeting-title">토익 900+ 달성</h3>
								<p class="meeting-description">3개월 안에 토익 900점 이상 목표 스터디</p>
								<div class="meeting-meta">
									<div class="meta-item">
										<span class="meta-icon">👥</span> <span>6/6명</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📅</span> <span>매일 06:00</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📍</span> <span>온라인</span>
									</div>
								</div>
								<div class="meeting-footer">
									<div class="tags">
										<span class="tag">영어</span> <span class="tag">토익</span>
									</div>
									<button class="favorite-btn inactive">♥</button>
								</div>
							</div>
						</div>

						<div class="meeting-card">
							<div class="meeting-image">
								🏛️ <span class="badge badge-applying badge-absolute">참여신청중</span>
							</div>
							<div class="meeting-info">
								<h3 class="meeting-title">공인중개사 스터디</h3>
								<p class="meeting-description">32회 공인중개사 시험 합격을 위한 그룹 스터디</p>
								<div class="meeting-meta">
									<div class="meta-item">
										<span class="meta-icon">👥</span> <span>5/8명</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📅</span> <span>매주 화, 금 19:00</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📍</span> <span>종로 스터디카페</span>
									</div>
								</div>
								<div class="meeting-footer">
									<div class="tags">
										<span class="tag">부동산</span> <span class="tag">자격증</span>
									</div>
									<button class="favorite-btn active">♥</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 취미/특기 카테고리 섹션 -->
				<div class="section category-section">
					<div class="section-header">
						<h2 class="section-title">🎯 취미/특기</h2>
						<span class="section-count">4</span>
					</div>

					<div class="meetings-container scroll-container">
						<div class="meeting-card">
							<div class="meeting-image">
								📷 <span class="badge badge-recruiting badge-absolute">모집중</span>
							</div>
							<div class="meeting-info">
								<h3 class="meeting-title">사진 촬영 동아리</h3>
								<p class="meeting-description">주말마다 출사하며 사진 실력을 향상시키는 모임</p>
								<div class="meeting-meta">
									<div class="meta-item">
										<span class="meta-icon">👥</span> <span>12/15명</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📅</span> <span>매주 토 09:00</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📍</span> <span>서울 각지</span>
									</div>
								</div>
								<div class="meeting-footer">
									<div class="tags">
										<span class="tag">사진</span> <span class="tag">출사</span>
									</div>
									<button class="favorite-btn inactive">♥</button>
								</div>
							</div>
						</div>

						<div class="meeting-card">
							<div class="meeting-image">
								🎸 <span class="badge badge-recruiting badge-absolute">모집중</span>
							</div>
							<div class="meeting-info">
								<h3 class="meeting-title">밴드 멤버 모집</h3>
								<p class="meeting-description">록 밴드 키보디스트, 베이시스트 모집합니다</p>
								<div class="meeting-meta">
									<div class="meta-item">
										<span class="meta-icon">👥</span> <span>3/5명</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📅</span> <span>매주 수 19:00</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📍</span> <span>홍대 연습실</span>
									</div>
								</div>
								<div class="meeting-footer">
									<div class="tags">
										<span class="tag">밴드</span> <span class="tag">음악</span>
									</div>
									<button class="favorite-btn active">♥</button>
								</div>
							</div>
						</div>

						<div class="meeting-card">
							<div class="meeting-image">
								⚽ <span class="badge badge-recruiting badge-absolute">모집중</span>
							</div>
							<div class="meeting-info">
								<h3 class="meeting-title">주말 풋살 클럽</h3>
								<p class="meeting-description">매주 일요일 아침 풋살하는 친목 클럽</p>
								<div class="meeting-meta">
									<div class="meta-item">
										<span class="meta-icon">👥</span> <span>16/20명</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📅</span> <span>매주 일 08:00</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📍</span> <span>잠실 체육관</span>
									</div>
								</div>
								<div class="meeting-footer">
									<div class="tags">
										<span class="tag">풋살</span> <span class="tag">운동</span>
									</div>
									<button class="favorite-btn inactive">♥</button>
								</div>
							</div>
						</div>

						<div class="meeting-card">
							<div class="meeting-image">
								🎨 <span class="badge badge-recruiting badge-absolute">모집중</span>
							</div>
							<div class="meeting-info">
								<h3 class="meeting-title">취미 드로잉 클래스</h3>
								<p class="meeting-description">인물화, 풍경화 등 함께 그리는 드로잉 모임</p>
								<div class="meeting-meta">
									<div class="meta-item">
										<span class="meta-icon">👥</span> <span>6/10명</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📅</span> <span>매주 토 15:00</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📍</span> <span>신촌 아트센터</span>
									</div>
								</div>
								<div class="meeting-footer">
									<div class="tags">
										<span class="tag">그림</span> <span class="tag">예술</span>
									</div>
									<button class="favorite-btn inactive">♥</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>