<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	request.setAttribute("cp", cp);

	String categoryList[] = {"", "독서", "어학", "IT", "창업·취업"
			, "자격증", "시험", "취미", "기타"};
	String categoryImg[] = {"", "📖", "🌐", "💻", "🚀", "📜", "📝", "🎨", "📌"};
	
	int categoryNum = 0;
	try
	{
		categoryNum = Integer.parseInt((String)request.getAttribute("categoryNum"));
	}
	catch (Exception e)
	{
		System.out.println(e.toString());
	}
	
	// 현재 선택된 카테고리 (파라미터로 받기)
	String selectedCategory = request.getParameter("category");
	if (selectedCategory == null)
		selectedCategory = "all";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 목록 - 공모자들</title>

<!-- CSS 파일 로드 -->
<link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css">
<link rel="stylesheet" href="<%=cp%>/css_new/grouplist_sample.css">

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
	        });
	    });
	    
		// 마우스 휠로 가로 스크롤 제어 (속도 개선)
	    document.querySelectorAll('.meetings-container').forEach(container => 
	    {
	        container.addEventListener('wheel', (e) => {
	            // 기본 세로 스크롤 방지
	            e.preventDefault();
	            
	            // 휠 내림(deltaY > 0) -> 오른쪽으로 스크롤
	            // 휠 올림(deltaY < 0) -> 왼쪽으로 스크롤
	            // 속도를 3배로 증가
	            container.scrollLeft += e.deltaY * 3;
	        });
	    });
	});
</script>
</head>
<body>

	<!-- 상단바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

	<!-- 메인 컨텐츠 -->
	<div class="content">

		<!-- 페이지 헤더 -->
		<div class="page-header">
			<h1 class="page-title">함께 성장하는 스터디 모임</h1>
			<p class="page-description">다양한 분야의 스터디 모임을 찾아보고, 함께 공부하며 성장하세요!</p>
		</div>

		<!-- 카테고리 필터 섹션 -->
		<div class="category-filter-section">
			<div class="category-tags">
				<a href="?category=all"
					class="category-tag <%="all".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">📚</span> 
					<span>전체</span>
				</a> 
				<a href="?category=reading"
					class="category-tag <%="reading".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">📖</span> 
					<span>독서</span>
				</a> 
				<a href="?category=language"
					class="category-tag <%="language".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">🌐</span> 
					<span>어학</span>
				</a> 
				<a href="?category=it"
					class="category-tag <%="it".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">💻</span> 
					<span>IT</span>
				</a> 
				<a href="?category=startup"
					class="category-tag <%="startup".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">🚀</span> 
					<span>창업·취업</span>
				</a> 
				<a href="?category=license"
					class="category-tag <%="license".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">📜</span> 
					<span>자격증</span>
				</a> 
				<a href="?category=exam"
					class="category-tag <%="exam".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">📝</span> 
					<span>시험</span>
				</a> 
				<a href="?category=hobby"
					class="category-tag <%="hobby".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">🎨</span> 
					<span>취미</span>
				</a> 
				<a href="?category=etc"
					class="category-tag <%="etc".equals(selectedCategory) ? "active" : ""%>">
					<span class="category-tag-icon">📌</span> 
					<span>기타</span>
				</a>
			</div>
		<!-- 검색 섹션 -->
		<jsp:include page="/WEB-INF/view/common/Search.jsp" />
		</div><!-- .category-filter-section -->


		<%
		if ("".equals(selectedCategory) || "all".equals(selectedCategory) || selectedCategory == null)
		{
		%>
		<!-- 전체 카테고리 섹션 -->
		<div class="category-section">
			<div class="category-header">
				<div class="category-title-wrapper">
					<h2 class="category-title">📚 전체</h2>
					<span class="category-count">${groupList.size()}개</span>
				</div>
			</div>

			<div class="meetings-container">
				<c:forEach var="group" items="${groupList}">
					<div class="meeting-card"
						onclick="location.href='grouplistdetail.do?groupCode=${group.groupApplyCode}'">
						<div class="meeting-image">
							<c:choose>
								<c:when test="${group.savePath != null }">
									<img src="<%=cp %>/img/group/${group.savePath}" alt="${group.groupTitle}" />
								</c:when>
								<c:otherwise>
							        <c:choose>
							            <c:when test="${group.topicType eq '1'}"> 📖 </c:when>
							            <c:when test="${group.topicType eq '2'}"> 🌐 </c:when>
							            <c:when test="${group.topicType eq '3'}"> 💻 </c:when>
							            <c:when test="${group.topicType eq '4'}"> 🚀 </c:when>
							            <c:when test="${group.topicType eq '5'}"> 📜 </c:when>
							            <c:when test="${group.topicType eq '6'}"> 📝 </c:when>
							            <c:when test="${group.topicType eq '7'}"> 🎨 </c:when>
							            <c:otherwise> 📌 </c:otherwise>
							        </c:choose>
							    </c:otherwise>
							</c:choose>
							<c:if test="${group.password ne null }">
								<span class="lock-icon">🔒</span>
							</c:if>
							<c:choose>
								<c:when test="${group.currentMemberCount < group.headCount}">
									<span class="meeting-status recruiting">모집중</span>
								</c:when>
								<c:otherwise>
									<span class="meeting-status full">모집완료</span>
								</c:otherwise>
							</c:choose>
						</div>
						
						<div class="meeting-info">
							<h3 class="meeting-title">${group.groupTitle}</h3>
							<p class="meeting-description">${group.groupContent}</p>
							
							<div class="meeting-meta">
								<div class="meta-item">
									<span class="meta-icon">📚</span> 
									<span>${group.topic}</span>
								</div>
								<div class="meta-item">
									<span class="meta-icon">👥</span> 
									<span>${group.currentMemberCount}/${group.headCount}명</span>
								</div>
								<div class="meta-item">
									<span class="meta-icon">📅</span> 
									<span> ${group.frequency}</span>
								</div>
								<div class="meta-item">
									<span class="meta-icon">📍</span> 
									<span>${group.onOff}</span>
								</div>
								<div class="meta-item">
									<c:choose>
										<c:when test="${group.region != null}">
											<span class="meta-icon">🏢</span> 
											<span>${group.region}</span>
										</c:when>
										<c:otherwise>
											<span style="visibility: hidden;">space</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							
							<div class="meeting-tags">
								<button class="favorite-btn" onclick="event.stopPropagation();">
									<span class="favorite-icon">♥</span>
								</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<!-- 랜덤 카테고리 섹션 -->
		<c:if test="${categoryNum > 0 && groupRandomList != null && groupRandomList.size() > 0}">
			<div class="category-section">
				<div class="category-header">
					<div class="category-title-wrapper">
						<h2 class="category-title"><%=categoryImg[categoryNum] %> <%=categoryList[categoryNum] %></h2>
						<span class="category-count">${groupRandomList.size()}개</span>
					</div>
				</div>

				<div class="meetings-container">
					<c:forEach var="group" items="${groupRandomList}">
						<div class="meeting-card"
							onclick="location.href='grouplistdetail.do?groupCode=${group.groupApplyCode}'">
							<div class="meeting-image">
								<c:choose>
									<c:when test="${group.savePath != null }">
										<img src="<%=cp %>/img/group/${group.savePath}" alt="${group.groupTitle}" />
									</c:when>
									<c:otherwise>
								        <c:choose>
								            <c:when test="${group.topicType eq '1'}"> 📖 </c:when>
								            <c:when test="${group.topicType eq '2'}"> 🌐 </c:when>
								            <c:when test="${group.topicType eq '3'}"> 💻 </c:when>
								            <c:when test="${group.topicType eq '4'}"> 🚀 </c:when>
								            <c:when test="${group.topicType eq '5'}"> 📜 </c:when>
								            <c:when test="${group.topicType eq '6'}"> 📝 </c:when>
								            <c:when test="${group.topicType eq '7'}"> 🎨 </c:when>
								            <c:otherwise> 📌 </c:otherwise>
								        </c:choose>
								    </c:otherwise>
								</c:choose>
								<c:if test="${group.password ne null }">
									<span class="lock-icon">🔒</span>
								</c:if>
								<c:choose>
									<c:when test="${group.currentMemberCount < group.headCount}">
										<span class="meeting-status recruiting">모집중</span>
									</c:when>
									<c:otherwise>
										<span class="meeting-status full">모집완료</span>
									</c:otherwise>
								</c:choose>
							</div>
							
							<div class="meeting-info">
								<h3 class="meeting-title">${group.groupTitle}</h3>
								<p class="meeting-description">${group.groupContent}</p>
								
								<div class="meeting-meta">
									<div class="meta-item">
										<span class="meta-icon">📚</span> 
										<span>범주 : ${group.topic}</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">👥</span> 
										<span>${group.currentMemberCount}/${group.headCount}명</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📅</span> 
										<span>주기 : ${group.frequency}</span>
									</div>
									<div class="meta-item">
										<span class="meta-icon">📍</span> 
										<span>${group.onOff}</span>
									</div>
									<div class="meta-item">
										<c:choose>
											<c:when test="${group.region != null}">
												<span>모임 지역 : ${group.region}</span>
											</c:when>
											<c:otherwise>
												<span style="visibility: hidden;">space</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="meeting-tags">
									<button class="favorite-btn" onclick="event.stopPropagation();">
										<span class="favorite-icon">♥</span>
									</button>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:if>
		
		<%
		}
		else
		{
		%>
		<!-- 특정 카테고리 선택 시 -->
		<div class="category-section">
			<div class="category-header">
				<div class="category-title-wrapper">
					<h2 class="category-title"><%=categoryImg[categoryNum] %> <%=categoryList[categoryNum] %></h2>
					<span class="category-count">${groupList.size()}개</span>
				</div>
			</div>

			<div class="meetings-container">
				<c:forEach var="group" items="${groupList}">
					<div class="meeting-card"
						onclick="location.href='grouplistdetail.do?groupCode=${group.groupApplyCode}'">
						<div class="meeting-image">
							<c:choose>
								<c:when test="${group.savePath != null }">
									<img src="<%=cp %>/img/group/${group.savePath}" alt="${group.groupTitle}" />
								</c:when>
								<c:otherwise>
							        <c:choose>
							            <c:when test="${group.topicType eq '1'}"> 📖 </c:when>
							            <c:when test="${group.topicType eq '2'}"> 🌐 </c:when>
							            <c:when test="${group.topicType eq '3'}"> 💻 </c:when>
							            <c:when test="${group.topicType eq '4'}"> 🚀 </c:when>
							            <c:when test="${group.topicType eq '5'}"> 📜 </c:when>
							            <c:when test="${group.topicType eq '6'}"> 📝 </c:when>
							            <c:when test="${group.topicType eq '7'}"> 🎨 </c:when>
							            <c:otherwise> 📌 </c:otherwise>
							        </c:choose>
							    </c:otherwise>
							</c:choose>
							<c:if test="${group.password ne null }">
								<span class="lock-icon">🔒</span>
							</c:if>
							<c:choose>
								<c:when test="${group.currentMemberCount < group.headCount}">
									<span class="meeting-status recruiting">모집중</span>
								</c:when>
								<c:otherwise>
									<span class="meeting-status full">모집완료</span>
								</c:otherwise>
							</c:choose>
						</div>
						
						<div class="meeting-info">
							<h3 class="meeting-title">${group.groupTitle}</h3>
							<p class="meeting-description">${group.groupContent}</p>
							
							<div class="meeting-meta">
								<div class="meta-item">
									<span class="meta-icon">📚</span> 
									<span>범주 : ${group.topic}</span>
								</div>
								<div class="meta-item">
									<span class="meta-icon">👥</span> 
									<span>${group.currentMemberCount}/${group.headCount}명</span>
								</div>
								<div class="meta-item">
									<span class="meta-icon">📅</span> 
									<span>주기 : ${group.frequency}</span>
								</div>
								<div class="meta-item">
									<span class="meta-icon">📍</span> 
									<span>${group.onOff}</span>
								</div>
								<div class="meta-item">
									<c:choose>
										<c:when test="${group.region != null}">
											<span>모임 지역 : ${group.region}</span>
										</c:when>
										<c:otherwise>
											<span style="visibility: hidden;">space</span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							
							<div class="meeting-tags">
								<button class="favorite-btn" onclick="event.stopPropagation();">
									<span class="favorite-icon">♥</span>
								</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>
