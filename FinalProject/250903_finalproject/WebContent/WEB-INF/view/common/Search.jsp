<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=cp%>/css/cssSearch/Search.css">
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jsSearch/Search.js"></script>
<title>검색 기능</title>
</head>
<body>

	<div class="search-section">
		<form action="search.do" method="post"
			onsubmit="return performSearch()">
			<div class="search-container">
				<!-- 검색바 -->
				<div class="search-bar-wrapper">
					<input type="text" id="searchBox" name="content" class="search-box"
						placeholder="모임 이름, 설명으로 검색하세요...">
					<button type="submit" id="searchBtn" class="search-btn">
						<span>🔍</span> <span>검색</span>
					</button>
					<button type="button" id="filterToggle" class="filter-toggle-btn"
						onclick="toggleFilter()">
						<span>⚙️</span> <span>필터</span> <span id="filterCountBadge"
							class="filter-count" style="display: none;">0</span>
					</button>
				</div>

				<!-- 선택된 필터 태그 표시 -->
				<div id="selectedFilters" class="selected-filters"></div>

				<!-- 필터 패널 -->
				<div id="filterPanel" class="filter-panel">
					<div class="filter-grid">

						<!-- 카테고리 필터 -->
						<div class="filter-section">
							<h4>📚 카테고리</h4>
							<div class="checkbox-group">
								<label class="custom-checkbox"> <input type="checkbox"
									value="독서" name="category" data-category="category"
									onchange="updateFilters()"> <span>📖 독서</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="어학" name="category" data-category="category"
									onchange="updateFilters()"> <span>🌐 어학</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="IT" name="category" data-category="category"
									onchange="updateFilters()"> <span>💻 IT</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="창업·취업" name="category" data-category="category"
									onchange="updateFilters()"> <span>🚀 창업·취업</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="자격증" name="category" data-category="category" onchange="updateFilters()">
									<span>📜 자격증</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="시험" name="category" data-category="category" onchange="updateFilters()">
									<span>✏️ 시험</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="취미" name="category" data-category="category" onchange="updateFilters()">
									<span>🎨 취미</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="기타" name="category" data-category="category" onchange="updateFilters()">
									<span>📌 기타</span>
								</label>
							</div>
						</div>

						<!-- 지역 필터 -->
						<div class="filter-section">
							<h4>🗺️ 지역</h4>
							<div class="checkbox-group">
								<label class="custom-checkbox"> <input type="checkbox"
									value="송도" name="region" data-category="region" onchange="updateFilters()">
									<span>송도</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="센트럴파크" name="region" data-category="region" onchange="updateFilters()">
									<span>센트럴파크</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="롯데월드" name="region" data-category="region" onchange="updateFilters()">
									<span>롯데월드</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="기타" name="region" data-category="region" onchange="updateFilters()">
									<span>기타</span>
								</label>
							</div>
						</div>

						<!-- 모임 유형 필터 -->
						<div class="filter-section">
							<h4>📍 모임 유형</h4>
							<div class="checkbox-group">
								<label class="custom-checkbox"> <input type="checkbox"
									value="온라인" name="onOffType" data-category="type" onchange="updateFilters()">
									<span>온라인</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="오프라인" name="onOffType" data-category="type" onchange="updateFilters()">
									<span>오프라인</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="혼합" name="onOffType" data-category="type" onchange="updateFilters()">
									<span>혼합 (온·오프라인)</span>
								</label>
							</div>
						</div>

						<!-- 상태 필터 -->
						<div class="filter-section">
							<h4>🚀 상태</h4>
							<div class="checkbox-group">
								<label class="custom-checkbox"> <input type="checkbox"
									value="신규 개설" name="status" data-category="status" onchange="updateFilters()">
									<span>신규 개설</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="모집 중" name="status" data-category="status" onchange="updateFilters()">
									<span>모집 중</span>
								</label> <label class="custom-checkbox"> <input type="checkbox"
									value="진행 중" name="status" data-category="status" onchange="updateFilters()">
									<span>진행 중</span>
								</label>
							</div>
						</div>
					</div>

					<!-- 필터 액션 버튼 -->
					<div class="filter-actions">
						<button type="submit" class="filter-btn primary" onclick="performSearch()">
							검색하기</button>
						<button class="filter-btn secondary" onclick="resetFilters()">초기화</button>
					</div>
				</div>
			</div>
		</form>
	</div>

</body>
</html>