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
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=cp %>/css/cssSearch/SearchList.css">
<title>검색 결과 - 공모자들</title>
<style>

</style>
</head>
<body>
	<!-- 상단바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

	<%
		// 검색어 받기
	String keyword = request.getParameter("keyword");
	if (keyword == null)
		keyword = "";
	keyword = keyword.trim();

	// 필터 받기
	String category = request.getParameter("category");
	String status = request.getParameter("status");
	String sort = request.getParameter("sort");

	if (category == null)
		category = "all";
	if (status == null)
		status = "all";
	if (sort == null)
		sort = "recent";

	// 검색 결과 개수 (실제로는 DB에서 조회)
	int resultCount = keyword.isEmpty() ? 0 : 15;
	%>

	<!-- 검색 헤더 -->
	<div class="search-header">
		<div class="search-info">
			<div class="search-keyword">
				'<span class="search-keyword-text"><%=keyword.isEmpty() ? "검색어를 입력하세요" : keyword%></span>'
				검색 결과
			</div>
			<%
				if (!keyword.isEmpty()) {
			%>
			<div class="search-count">
				총 <span class="search-count-num"><%=resultCount%></span>개의 모임을
				찾았습니다.
			</div>
			<%
				}
			%>
		</div>

		<form action="" method="get" class="search-bar-container">
			<input type="text" name="keyword" class="search-input"
				placeholder="모임 이름, 태그, 설명으로 검색하세요" value="<%=keyword%>">
			<button type="submit" class="search-btn">🔍 검색</button>
		</form>
	</div>

	<!-- 필터 섹션 -->
	<div class="filter-section">
		<span class="filter-label">필터:</span> <select class="filter-select"
			onchange="applyFilter('category', this.value)">
			<option value="all" <%="all".equals(category) ? "selected" : ""%>>전체
				카테고리</option>
			<option value="reading"
				<%="reading".equals(category) ? "selected" : ""%>>📖 독서</option>
			<option value="language"
				<%="language".equals(category) ? "selected" : ""%>>🌐 어학</option>
			<option value="it" <%="it".equals(category) ? "selected" : ""%>>💻
				IT</option>
			<option value="startup"
				<%="startup".equals(category) ? "selected" : ""%>>🚀 창업·취업</option>
			<option value="license"
				<%="license".equals(category) ? "selected" : ""%>>📜 자격증</option>
			<option value="exam" <%="exam".equals(category) ? "selected" : ""%>>✏️
				시험</option>
			<option value="hobby" <%="hobby".equals(category) ? "selected" : ""%>>🎨
				취미</option>
			<option value="etc" <%="etc".equals(category) ? "selected" : ""%>>📌
				기타</option>
		</select> <select class="filter-select"
			onchange="applyFilter('status', this.value)">
			<option value="all" <%="all".equals(status) ? "selected" : ""%>>전체
				상태</option>
			<option value="recruiting"
				<%="recruiting".equals(status) ? "selected" : ""%>>모집중</option>
			<option value="ongoing"
				<%="ongoing".equals(status) ? "selected" : ""%>>진행중</option>
		</select> <select class="filter-select"
			onchange="applyFilter('sort', this.value)">
			<option value="recent" <%="recent".equals(sort) ? "selected" : ""%>>최신순</option>
			<option value="popular" <%="popular".equals(sort) ? "selected" : ""%>>인기순</option>
			<option value="deadline"
				<%="deadline".equals(sort) ? "selected" : ""%>>마감임박순</option>
		</select>
	</div>

	<div class="content">
		<%
			if (keyword.isEmpty()) {
		%>
		<!-- 검색어 없음 -->
		<div class="empty-results">
			<div class="empty-icon">🔍</div>
			<div class="empty-title">검색어를 입력해주세요</div>
			<div class="empty-description">관심있는 모임의 이름, 태그, 설명으로 검색할 수
				있습니다.</div>
		</div>
		<%
			} else if (resultCount == 0) {
		%>
		<!-- 검색 결과 없음 -->
		<div class="empty-results">
			<div class="empty-icon">😥</div>
			<div class="empty-title">검색 결과가 없습니다</div>
			<div class="empty-description">
				'<%=keyword%>'에 대한 검색 결과를 찾을 수 없습니다.<br> 다른 키워드로 다시 검색해보세요.
			</div>

			<div class="empty-suggestions">
				<div class="suggestions-title">검색 TIP</div>
				<ul class="suggestions-list">
					<li>단어의 철자가 정확한지 확인해보세요</li>
					<li>더 일반적인 검색어로 다시 검색해보세요</li>
					<li>다른 키워드를 사용해보세요</li>
					<li>카테고리 필터를 변경해보세요</li>
				</ul>
			</div>
		</div>
		<%
			} else {
		%>
		<!-- 검색 결과 -->
		<div class="results-grid">
			<!-- 검색 결과 카드 1 -->
			<div class="meeting-card">
				<div class="meeting-image">
					💻 <span class="meeting-status">모집중</span>
				</div>
				<div class="meeting-info">
					<h3 class="meeting-title">
						<span class="highlight">알고리즘</span> 정복 스터디
					</h3>
					<p class="meeting-description">
						매주 3문제씩 풀고 코드 리뷰하는 <span class="highlight">알고리즘</span> 스터디입니다.
					</p>
					<div class="meeting-meta">
						<div class="meta-item">
							<span class="meta-icon">👥</span> <span>8/10명</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📅</span> <span>매주 월, 수 19:00</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📍</span> <span>온라인</span>
						</div>
					</div>
					<div class="meeting-tags">
						<span class="tag">알고리즘</span> <span class="tag">Python</span>
					</div>
				</div>
			</div>

			<!-- 검색 결과 카드 2 -->
			<div class="meeting-card">
				<div class="meeting-image">
					📖 <span class="meeting-status">모집중</span>
				</div>
				<div class="meeting-info">
					<h3 class="meeting-title">Java Spring 마스터</h3>
					<p class="meeting-description">Spring Boot로 실전 프로젝트를 만들어보는 스터디</p>
					<div class="meeting-meta">
						<div class="meta-item">
							<span class="meta-icon">👥</span> <span>5/8명</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📅</span> <span>매주 토 14:00</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📍</span> <span>강남역 스터디카페</span>
						</div>
					</div>
					<div class="meeting-tags">
						<span class="tag">Java</span> <span class="tag">Spring</span>
					</div>
				</div>
			</div>

			<!-- 검색 결과 카드 3 -->
			<div class="meeting-card">
				<div class="meeting-image">
					🎨 <span class="meeting-status">진행중</span>
				</div>
				<div class="meeting-info">
					<h3 class="meeting-title">React 실전 프로젝트</h3>
					<p class="meeting-description">React로 실제 서비스를 만들어보는 프로젝트형 스터디</p>
					<div class="meeting-meta">
						<div class="meta-item">
							<span class="meta-icon">👥</span> <span>6/6명</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📅</span> <span>매주 수 20:00</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📍</span> <span>온라인</span>
						</div>
					</div>
					<div class="meeting-tags">
						<span class="tag">React</span> <span class="tag">프론트엔드</span>
					</div>
				</div>
			</div>

			<!-- 검색 결과 카드 4 -->
			<div class="meeting-card">
				<div class="meeting-image">
					🗄️ <span class="meeting-status">모집중</span>
				</div>
				<div class="meeting-info">
					<h3 class="meeting-title">데이터베이스 심화</h3>
					<p class="meeting-description">MySQL, PostgreSQL 성능 최적화 스터디</p>
					<div class="meeting-meta">
						<div class="meta-item">
							<span class="meta-icon">👥</span> <span>3/6명</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📅</span> <span>매주 목 19:30</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📍</span> <span>온라인</span>
						</div>
					</div>
					<div class="meeting-tags">
						<span class="tag">Database</span> <span class="tag">SQL</span>
					</div>
				</div>
			</div>

			<!-- 검색 결과 카드 5 -->
			<div class="meeting-card">
				<div class="meeting-image">
					🤖 <span class="meeting-status">모집중</span>
				</div>
				<div class="meeting-info">
					<h3 class="meeting-title">AI/ML 입문반</h3>
					<p class="meeting-description">파이썬으로 시작하는 머신러닝 기초 스터디</p>
					<div class="meeting-meta">
						<div class="meta-item">
							<span class="meta-icon">👥</span> <span>7/10명</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📅</span> <span>매주 화, 목 20:00</span>
						</div>
						<div class="meta-item">
							<span class="meta-icon">📍</span> <span>온라인</span>
						</div>
					</div>
					<div class="meeting-tags">
						<span class="tag">AI</span> <span class="tag">머신러닝</span>
					</div>
				</div>
			</div>

			<!-- 검색 결과 카드 6 -->
			<div class="meeting-card">
				<div class="meeting-image">
					📷 <span class="meeting-status">모집중</span>
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
					<div class="meeting-tags">
						<span class="tag">사진</span> <span class="tag">출사</span>
					</div>
				</div>
			</div>
		</div>

		<!-- 페이지네이션 -->
		<div class="pagination">
			<button class="page-btn" disabled>◀</button>
			<button class="page-btn active">1</button>
			<button class="page-btn">2</button>
			<button class="page-btn">3</button>
			<button class="page-btn">▶</button>
		</div>
		<%
			}
		%>
		<!-- 검색 결과 -->
		<div class="results-grid">
			<c:forEach var="group" items="${groupList}" begin="0" end="15">
				<div class="meeting-card">
					<div class="meeting-image">
						💻 <span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">${group.groupTitle }</h3>
						<p class="meeting-description">${group.groupContent }</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">📚</span> <span>범주 :
									${group.topic }</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">👥</span> <span>${group.currentMemberCount}/${group.headCount }명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span> <span>주기 :
									${group.frequency }</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span> <span>${group.onOff }</span><br>
							</div>
							<div class="meta-item">
								<c:choose>
									<c:when test="${group.region != null}">
										<span>모임 지역 : ${group.region }</span>
									</c:when>
									<c:otherwise>
										<span style="visibility: hidden;">space</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>

	<script>
		// 필터 적용
		function applyFilter(filterType, value)
		{
			const urlParams = new URLSearchParams(window.location.search);
			urlParams.set(filterType, value);
			window.location.href = '?' + urlParams.toString();
		}
	</script>
</body>
</html>