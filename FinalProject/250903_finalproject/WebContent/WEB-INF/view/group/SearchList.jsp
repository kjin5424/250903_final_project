<%@page import="java.util.ArrayList"%>
<%@page import="com.test.mybatis.dto.GroupDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	request.setAttribute("cp", cp);
%>
<%
	ArrayList<GroupDTO> groupList = (ArrayList<GroupDTO>) request.getAttribute("groupList");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=cp%>/css/cssSearch/SearchList.css">
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
				검색 결과<br>
				<c:if test="${filter.content eq null}">
					내용 : <span class="search-keyword-text"> ${filter.content } </span>
				</c:if>
				<br>
				<c:forEach var="item" items="${filter.category }">
					<span class="search-keyword-text"> ${item } </span>
				</c:forEach>
				<c:forEach var="item" items="${filter.region }">
					<span class="search-keyword-text"> ${item } </span>
				</c:forEach>
				<c:forEach var="item" items="${filter.type }">
					<span class="search-keyword-text"> ${item } </span>
				</c:forEach>
				<c:forEach var="item" items="${filter.status }">
					<span class="search-keyword-text"> ${item } </span>
				</c:forEach>
			</div>
			<div class="search-count">
				총 <span class="search-count-num"> <%=groupList.size()%>
				</span>개의 모임을 찾았습니다.
			</div>
		</div>

		<c:import url="/WEB-INF/view/common/Search.jsp" />
	</div>

	<!-- 필터 섹션 -->
<%--
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
--%>
	<div class="content">
		<%
			if (groupList.size() == 0) {
		%>
		<!-- 검색 결과 없음 -->
		<div class="empty-results">
			<div class="empty-icon">😥</div>
			<div class="empty-title">검색 결과가 없습니다</div>
			<div class="empty-description">
				'${filter.content }'에 대한 검색 결과를 찾을 수 없습니다.<br> 다른 키워드로 다시
				검색해보세요.
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
			<c:forEach var="group" items="${groupList}">
				<div class="meeting-card"
					onclick="location.href='grouplistdetail.do?groupCode=${group.groupApplyCode}'">
					<div class="meeting-image">
						<c:choose>
							<c:when test="${group.savePath != null }">
								<img src="<%=cp %>/img/group/${group.savePath}" />
							</c:when>
							<c:when test="${group.topicType eq '1'}"> 📖 </c:when>
							<c:when test="${group.topicType eq '2'}"> 🌐 </c:when>
							<c:when test="${group.topicType eq '3'}"> 💻 </c:when>
							<c:when test="${group.topicType eq '4'}"> 🚀 </c:when>
							<c:when test="${group.topicType eq '5'}"> 📜 </c:when>
							<c:when test="${group.topicType eq '6'}"> 📝 </c:when>
							<c:when test="${group.topicType eq '7'}"> 🎨 </c:when>
							<c:otherwise> 📌 </c:otherwise>
						</c:choose>
						<c:if test="${group.password ne null }">
							<span class="lock-icon">🔒</span>
						</c:if>
						<c:choose>
							<c:when test="${group.currentMemberCount < group.headCount}">
								<span class="meeting-status">모집중</span>
							</c:when>
							<c:otherwise>
								<span class="meeting-status">모집완료</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">${group.groupTitle }</h3>
						<p class="meeting-description">${group.groupContent }</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">📚</span> <span>범주 : ${group.topic }</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">👥</span> <span>${group.currentMemberCount}/${group.headCount }명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span> <span>주기 :	${group.frequency }</span>
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
		
		<!-- 페이지네이션 -->
		<!--
		<div class="pagination">
			<button class="page-btn" disabled>◀</button>
			<button class="page-btn active">1</button>
			<button class="page-btn">2</button>
			<button class="page-btn">3</button>
			<button class="page-btn">▶</button>
		</div>
		-->
		<%
			}
		%>
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