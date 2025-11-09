<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!-- CSS 파일 로드 -->
<link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css">
<link rel="stylesheet" href="<%=cp%>/css_new/search_sample.css">


<!-- 검색 섹션 -->
<div class="search-section">
	<form action="search.do" method="post" onsubmit="return performSearch()">
		<div class="search-container">
			<!-- 검색바 -->
			<div class="search-bar-wrapper">
				<input type="text" id="searchBox" name="content" class="search-box"
					placeholder="모임 이름으로 검색하세요...">
				<button type="submit" id="searchBtn" class="search-btn">
					<span class="search-icon">🔍</span>
					<span>검색</span>
				</button>
				<button type="button" id="filterToggle" class="filter-toggle-btn"
					onclick="toggleFilter()">
					<span class="filter-icon">⚙️</span>
					<span>필터</span>
					<span id="filterCountBadge" class="filter-count-badge" style="display: none;">0</span>
				</button>
			</div>

			<!-- 선택된 필터 태그 표시 -->
			<div id="selectedFilters" class="selected-filters"></div>

			<!-- 필터 패널 -->
			<div id="filterPanel" class="filter-panel">
				<div class="filter-grid">

					<!-- 카테고리 필터 -->
					<div class="filter-section">
						<h4 class="filter-title">
							<span class="filter-icon">📚</span>
							카테고리
						</h4>
						<div class="checkbox-group">
							<label class="custom-checkbox">
								<input type="checkbox" value="독서" name="category" 
									data-category="category" onchange="updateFilters()">
								<span class="checkbox-label">📖 독서</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="어학" name="category" 
									data-category="category" onchange="updateFilters()">
								<span class="checkbox-label">🌐 어학</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="IT" name="category" 
									data-category="category" onchange="updateFilters()">
								<span class="checkbox-label">💻 IT</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="창업·취업" name="category" 
									data-category="category" onchange="updateFilters()">
								<span class="checkbox-label">🚀 창업·취업</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="자격증" name="category" 
									data-category="category" onchange="updateFilters()">
								<span class="checkbox-label">📜 자격증</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="시험" name="category" 
									data-category="category" onchange="updateFilters()">
								<span class="checkbox-label">📝 시험</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="취미" name="category" 
									data-category="category" onchange="updateFilters()">
								<span class="checkbox-label">🎨 취미</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="기타" name="category" 
									data-category="category" onchange="updateFilters()">
								<span class="checkbox-label">📌 기타</span>
							</label>
						</div>
					</div>

					<!-- 지역 필터 -->
					<div class="filter-section">
						<h4 class="filter-title">
							<span class="filter-icon">🗺️</span>
							지역
						</h4>
						<div class="checkbox-group">
							<label class="custom-checkbox">
								<input type="checkbox" value="서울" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">서울</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="경기" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">경기</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="부산" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">부산</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="인천" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">인천</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="대구" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">대구</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="광주" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">광주</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="대전" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">대전</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="울산" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">울산</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="제주" name="region" 
									data-category="region" onchange="updateFilters()">
								<span class="checkbox-label">제주</span>
							</label>
						</div>
					</div>

					<!-- 모임 유형 필터 -->
					<div class="filter-section">
						<h4 class="filter-title">
							<span class="filter-icon">📍</span>
							모임 유형
						</h4>
						<div class="checkbox-group">
							<label class="custom-checkbox">
								<input type="checkbox" value="온라인" name="type" 
									data-category="type" onchange="updateFilters()">
								<span class="checkbox-label">온라인</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="오프라인" name="type" 
									data-category="type" onchange="updateFilters()">
								<span class="checkbox-label">오프라인</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="복합" name="type" 
									data-category="type" onchange="updateFilters()">
								<span class="checkbox-label">복합 (온·오프라인)</span>
							</label>
						</div>
					</div>

					<!-- 상태 필터 -->
					<div class="filter-section">
						<h4 class="filter-title">
							<span class="filter-icon">🚀</span>
							상태
						</h4>
						<div class="checkbox-group">
							<label class="custom-checkbox">
								<input type="checkbox" value="신규개설" name="status" 
									data-category="status" onchange="updateFilters()">
								<span class="checkbox-label">신규 개설</span>
							</label>
							<label class="custom-checkbox">
								<input type="checkbox" value="진행중" name="status" 
									data-category="status" onchange="updateFilters()">
								<span class="checkbox-label">진행 중</span>
							</label>
						</div>
					</div>
				</div>

				<!-- 필터 액션 버튼 -->
				<div class="filter-actions">
					<button type="submit" class="filter-btn primary" onclick="performSearch()">
						<span>🔍</span>
						검색하기
					</button>
					<button type="button" class="filter-btn secondary" onclick="resetFilters()">
						<span>↻</span>
						초기화
					</button>
				</div>
			</div>
		</div>
	</form>
</div>

<!-- JavaScript -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jsSearch/Search.js"></script>
<script type="text/javascript">
// 필터 토글 함수
function toggleFilter() {
    const filterPanel = document.getElementById('filterPanel');
    const filterToggle = document.getElementById('filterToggle');
    const isActive = filterPanel.classList.contains('active');
    
    if (isActive) {
        // 필터 닫기
        filterPanel.classList.remove('active');
        filterToggle.classList.remove('active');
    } else {
        // 필터 열기
        filterPanel.classList.add('active');
        filterToggle.classList.add('active');
        
        // 필터 패널이 화면 중앙에 오도록 스크롤
        setTimeout(() => {
            const panelRect = filterPanel.getBoundingClientRect();
            const windowHeight = window.innerHeight;
            const panelTop = panelRect.top + window.pageYOffset;
            const panelHeight = panelRect.height;
            
            // 패널의 중앙이 화면 중앙에 오도록 계산
            const scrollTo = panelTop - (windowHeight / 2) + (panelHeight / 2);
            
            window.scrollTo({
                top: scrollTo,
                behavior: 'smooth'
            });
        }, 100); // 애니메이션 시작 후 스크롤
    }
}

// updateFilters 함수가 없으면 추가
if (typeof updateFilters !== 'function') {
    function updateFilters() {
        const selectedFiltersDiv = document.getElementById('selectedFilters');
        const checkboxes = document.querySelectorAll('.custom-checkbox input[type="checkbox"]:checked');
        const countBadge = document.getElementById('filterCountBadge');
        
        // 선택된 필터 태그 표시
        selectedFiltersDiv.innerHTML = '';
        checkboxes.forEach(checkbox => {
            const tag = document.createElement('span');
            tag.className = 'filter-tag';
            tag.innerHTML = checkbox.value + ' <span class="filter-tag-close" onclick="removeFilter(this, \'' + checkbox.name + '\', \'' + checkbox.value + '\')">×</span>';
            selectedFiltersDiv.appendChild(tag);
        });
        
        // 필터 카운트 업데이트
        if (checkboxes.length > 0) {
            countBadge.textContent = checkboxes.length;
            countBadge.style.display = 'inline-block';
        } else {
            countBadge.style.display = 'none';
        }
    }
}

// 필터 제거 함수
function removeFilter(element, name, value) {
    const checkbox = document.querySelector('input[name="' + name + '"][value="' + value + '"]');
    if (checkbox) {
        checkbox.checked = false;
        updateFilters();
    }
}

// resetFilters 함수가 없으면 추가
if (typeof resetFilters !== 'function') {
    function resetFilters() {
        document.querySelectorAll('.custom-checkbox input[type="checkbox"]').forEach(checkbox => {
            checkbox.checked = false;
        });
        updateFilters();
    }
}

// performSearch 함수가 없으면 추가
if (typeof performSearch !== 'function') {
    function performSearch() {
        // 실제 검색 로직은 Search.js에서 처리
        return true;
    }
}
</script>

