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
<!-- <span class="badge badge-applying badge-absolute">참여신청중</span> -->


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
						</a> <a href="?category=etc"
							class="category-btn <%="etc".equals(selectedCategory) ? "active" : ""%>">
							<span class="category-tag-icon">📌</span> <span>기타</span>
						</a>
					</div>
				</div>

				<!-- 검색 섹션 (선택사항) -->
				<jsp:include page="/WEB-INF/view/common/Search.jsp" />

				<%
				if ("".equals(selectedCategory) || "all".equals(selectedCategory) || selectedCategory == null)
				{
				%>
				<!-- 전체 카테고리 섹션 -->
				<div class="section category-section">
					<div class="section-header">
						<h2 class="section-title">📚 전체</h2>
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
											<span class="badge badge-recruiting badge-absolute">모집중</span>
										</c:when>
										<c:otherwise>
											<span class="badge badge-closed badge-absolute">모집완료</span>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="meeting-info"
									data-groupCode="${group.groupApplyCode }">
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
												<c:otherwise>
													<span style="visibility: hidden;">space</span>
												</c:otherwise>
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
				
				<div class="section category-section">
					<div class="section-header">
						<h2 class="section-title"><%=categoryImg[categoryNum] %> <%=categoryList[categoryNum] %></h2>
					</div>

					<div class="meetings-container scroll-container">
						<!-- 모임 카드 컨테이너 -->
						<c:forEach var="group" items="${groupRandomList}">
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
											<span class="badge badge-recruiting badge-absolute">모집중</span>
										</c:when>
										<c:otherwise>
											<span class="badge badge-closed badge-absolute">모집완료</span>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="meeting-info"
									data-groupCode="${group.groupApplyCode }">
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
												<c:otherwise>
													<span style="visibility: hidden;">space</span>
												</c:otherwise>
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
				<%
				}
				else
				{
				%>
				<!-- 특정 카테고리 -->
				<div class="section category-section">
					<div class="section-header">
						<h2 class="section-title"><%=categoryImg[categoryNum] %> <%=categoryList[categoryNum] %></h2>
					</div>

					<div class="meetings-container scroll-container">
						<!-- 모임 카드 컨테이너 -->
						<c:forEach var="group" items="${groupList}" begin="0" end="4">
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
											<span class="badge badge-recruiting badge-absolute">모집중</span>
										</c:when>
										<c:otherwise>
											<span class="badge badge-closed badge-absolute">모집완료</span>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="meeting-info"
									data-groupCode="${group.groupApplyCode }">
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
												<c:otherwise>
													<span style="visibility: hidden;">space</span>
												</c:otherwise>
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
				<%
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>