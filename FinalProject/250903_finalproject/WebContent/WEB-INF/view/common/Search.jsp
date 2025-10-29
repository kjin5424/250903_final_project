<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>검색 기능</title>
<style>
/* 검색 섹션 전체 */
.search-section {
   /* background: white; */
   padding: 0px;
   margin: 60px 0px 30px 0px;
   border-radius: 12px;
   /* box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06); */
}

/* 검색 컨테이너 */
.search-container {
   position: relative;
   max-width: 100%;
   margin: 0 auto;
}

/* 검색바 래퍼 */
.search-bar-wrapper {
   display: flex;
   gap: 10px;
   margin-bottom: 20px;
}

/* 검색 입력창 */
.search-box {
   flex: 1;
   padding: 14px 20px 14px 45px;
   font-size: 15px;
   border: 2px solid #e0e0e0;
   border-radius: 8px;
   outline: none;
   transition: all 0.2s ease;
   background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="%23999" stroke-width="2"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>');
   background-repeat: no-repeat;
   background-position: 15px center;
   background-size: 18px;
}

.search-box:focus {
   border-color: #a8d5a1;
   box-shadow: 0 0 0 3px rgba(168, 213, 161, 0.1);
}

.search-box::placeholder {
   color: #999;
}

/* 검색 버튼 */
.search-btn {
   background: #2d5a29;
   color: white;
   border: none;
   padding: 14px 28px;
   border-radius: 8px;
   cursor: pointer;
   font-size: 15px;
   font-weight: 600;
   transition: all 0.2s ease;
   white-space: nowrap;
   display: flex;
   align-items: center;
   gap: 6px;
}

.search-btn:hover {
   background: #1f4019;
   transform: translateY(-1px);
   box-shadow: 0 4px 8px rgba(45, 90, 41, 0.2);
}

.search-btn:active {
   transform: translateY(0);
}

/* 필터 토글 버튼 */
.filter-toggle-btn {
   background: #f8faf9;
   color: #2d5a29;
   border: 2px solid #e8f5e6;
   padding: 14px 24px;
   border-radius: 8px;
   cursor: pointer;
   font-size: 15px;
   font-weight: 600;
   transition: all 0.2s ease;
   display: flex;
   align-items: center;
   gap: 8px;
   white-space: nowrap;
}

.filter-toggle-btn:hover {
   background: #e8f5e6;
   border-color: #a8d5a1;
}

.filter-toggle-btn.active {
   background: #e8f5e6;
   border-color: #2d5a29;
   color: #1f4019;
}

.filter-count {
   background: #2d5a29;
   color: white;
   padding: 2px 8px;
   border-radius: 12px;
   font-size: 12px;
   font-weight: bold;
}

/* 필터 패널 */
.filter-panel {
   display: none;
   background: #f8faf9;
   border-radius: 8px;
   padding: 20px;
   margin-top: 15px;
   border: 2px solid #e8f5e6;
   animation: slideDown 0.3s ease;
}

.filter-panel.show {
   display: block;
}

@keyframes slideDown {
   from {
      opacity: 0;
      transform: translateY(-10px);
   }
   to {
      opacity: 1;
      transform: translateY(0);
   }
}

/* 필터 그리드 */
.filter-grid {
   display: grid;
   grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
   gap: 20px;
}

/* 필터 섹션 */
.filter-section {
   background: white;
   padding: 15px;
   border-radius: 8px;
   border: 1px solid #e0e0e0;
}

.filter-section h4 {
   margin: 0 0 12px 0;
   font-size: 14px;
   color: #2d5a29;
   font-weight: 600;
   display: flex;
   align-items: center;
   gap: 6px;
}

.filter-section h4::before {
   content: '';
   width: 3px;
   height: 14px;
   background: #2d5a29;
   border-radius: 2px;
}

/* 체크박스 그룹 */
.checkbox-group {
   display: flex;
   flex-direction: column;
   gap: 8px;
}

/* 커스텀 체크박스 */
.custom-checkbox {
   display: flex;
   align-items: center;
   cursor: pointer;
   padding: 6px 8px;
   border-radius: 6px;
   transition: background 0.2s ease;
}

.custom-checkbox:hover {
   background: #f5f7fa;
}

.custom-checkbox input[type="checkbox"] {
   appearance: none;
   width: 18px;
   height: 18px;
   border: 2px solid #d0d0d0;
   border-radius: 4px;
   margin-right: 10px;
   cursor: pointer;
   position: relative;
   transition: all 0.2s ease;
   flex-shrink: 0;
}

.custom-checkbox input[type="checkbox"]:checked {
   background: #2d5a29;
   border-color: #2d5a29;
}

.custom-checkbox input[type="checkbox"]:checked::after {
   content: '✓';
   position: absolute;
   color: white;
   font-size: 12px;
   font-weight: bold;
   top: 50%;
   left: 50%;
   transform: translate(-50%, -50%);
}

.custom-checkbox label {
   cursor: pointer;
   font-size: 14px;
   color: #333;
   user-select: none;
}

/* 필터 액션 버튼 */
.filter-actions {
   display: flex;
   gap: 10px;
   margin-top: 20px;
   padding-top: 15px;
   border-top: 1px solid #e0e0e0;
}

.filter-btn {
   padding: 10px 20px;
   border-radius: 6px;
   border: none;
   cursor: pointer;
   font-size: 14px;
   font-weight: 600;
   transition: all 0.2s ease;
}

.filter-btn.primary {
   background: #2d5a29;
   color: white;
   flex: 1;
}

.filter-btn.primary:hover {
   background: #1f4019;
}

.filter-btn.secondary {
   background: white;
   color: #666;
   border: 1px solid #d0d0d0;
}

.filter-btn.secondary:hover {
   background: #f5f7fa;
}

/* 선택된 필터 태그 */
.selected-filters {
   display: flex;
   flex-wrap: wrap;
   gap: 8px;
   margin-top: 15px;
   padding: 12px;
   background: white;
   border-radius: 8px;
   border: 1px solid #e8f5e6;
   min-height: 20px;
}

.selected-filters:empty {
   display: none;
}

.filter-tag {
   display: inline-flex;
   align-items: center;
   gap: 6px;
   background: #e8f5e6;
   color: #2d5a29;
   padding: 6px 12px;
   border-radius: 16px;
   font-size: 13px;
   font-weight: 500;
}

.filter-tag .remove-btn {
   cursor: pointer;
   font-weight: bold;
   color: #2d5a29;
   opacity: 0.7;
   transition: opacity 0.2s;
   font-size: 16px;
   line-height: 1;
}

.filter-tag .remove-btn:hover {
   opacity: 1;
}

/* 반응형 */
@media (max-width: 768px) {
   .search-section {
      padding: 20px 15px;
      margin: 15px;
   }
   
   .search-bar-wrapper {
      flex-direction: column;
   }
   
   .filter-toggle-btn,
   .search-btn {
      width: 100%;
      justify-content: center;
   }
   
   .filter-grid {
      grid-template-columns: 1fr;
   }
   
   .filter-actions {
      flex-direction: column;
   }
   
   .filter-btn {
      width: 100%;
   }
}
</style>
</head>
<body>

<div class="search-section">
   <div class="search-container">
      <!-- 검색바 -->
      <div class="search-bar-wrapper">
         <input 
            type="text" 
            id="searchBox" 
            class="search-box" 
            placeholder="모임 이름, 태그, 설명으로 검색하세요..."
         >
         <button id="searchBtn" class="search-btn" onclick="performSearch()">
            <span>🔍</span>
            <span>검색</span>
         </button>
         <button id="filterToggle" class="filter-toggle-btn" onclick="toggleFilter()">
            <span>⚙️</span>
            <span>필터</span>
            <span id="filterCountBadge" class="filter-count" style="display: none;">0</span>
         </button>
      </div>

      <!-- 선택된 필터 태그 표시 -->
      <div id="selectedFilters" class="selected-filters"></div>

      <!-- 필터 패널 -->
      <div id="filterPanel" class="filter-panel">
         <div class="filter-grid">
            <!-- 모임 유형 필터 -->
            <div class="filter-section">
               <h4>📍 모임 유형</h4>
               <div class="checkbox-group">
                  <label class="custom-checkbox">
                     <input type="checkbox" value="온라인" data-category="type" onchange="updateFilters()">
                     <span>온라인</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="오프라인" data-category="type" onchange="updateFilters()">
                     <span>오프라인</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="혼합" data-category="type" onchange="updateFilters()">
                     <span>혼합 (온·오프라인)</span>
                  </label>
               </div>
            </div>

            <!-- 지역 필터 -->
            <div class="filter-section">
               <h4>🗺️ 지역</h4>
               <div class="checkbox-group">
                  <label class="custom-checkbox">
                     <input type="checkbox" value="송도" data-category="region" onchange="updateFilters()">
                     <span>송도</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="센트럴파크" data-category="region" onchange="updateFilters()">
                     <span>센트럴파크</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="롯데월드" data-category="region" onchange="updateFilters()">
                     <span>롯데월드</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="기타" data-category="region" onchange="updateFilters()">
                     <span>기타</span>
                  </label>
               </div>
            </div>

            <!-- 상태 필터 -->
            <div class="filter-section">
               <h4>🚀 상태</h4>
               <div class="checkbox-group">
                  <label class="custom-checkbox">
                     <input type="checkbox" value="신규 개설" data-category="status" onchange="updateFilters()">
                     <span>신규 개설</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="모집 중" data-category="status" onchange="updateFilters()">
                     <span>모집 중</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="진행 중" data-category="status" onchange="updateFilters()">
                     <span>진행 중</span>
                  </label>
               </div>
            </div>

            <!-- 카테고리 필터 -->
            <div class="filter-section">
               <h4>📚 카테고리</h4>
               <div class="checkbox-group">
                  <label class="custom-checkbox">
                     <input type="checkbox" value="독서" data-category="category" onchange="updateFilters()">
                     <span>📖 독서</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="어학" data-category="category" onchange="updateFilters()">
                     <span>🌐 어학</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="IT" data-category="category" onchange="updateFilters()">
                     <span>💻 IT</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="창업·취업" data-category="category" onchange="updateFilters()">
                     <span>🚀 창업·취업</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="자격증" data-category="category" onchange="updateFilters()">
                     <span>📜 자격증</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="시험" data-category="category" onchange="updateFilters()">
                     <span>✏️ 시험</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="취미" data-category="category" onchange="updateFilters()">
                     <span>🎨 취미</span>
                  </label>
                  <label class="custom-checkbox">
                     <input type="checkbox" value="기타" data-category="category" onchange="updateFilters()">
                     <span>📌 기타</span>
                  </label>
               </div>
            </div>
         </div>

         <!-- 필터 액션 버튼 -->
         <div class="filter-actions">
            <button class="filter-btn primary" onclick="applyFilters()">필터 적용하기</button>
            <button class="filter-btn secondary" onclick="resetFilters()">초기화</button>
         </div>
      </div>
   </div>
</div>

<script>
// 선택된 필터를 저장하는 객체
let selectedFilters = {
   type: [],
   region: [],
   status: [],
   category: []
};

// 필터 패널 토글
function toggleFilter() {
   const panel = document.getElementById('filterPanel');
   const toggleBtn = document.getElementById('filterToggle');
   
   if (panel.classList.contains('show')) {
      panel.classList.remove('show');
      toggleBtn.classList.remove('active');
   } else {
      panel.classList.add('show');
      toggleBtn.classList.add('active');
   }
}

// 필터 업데이트
function updateFilters() {
   const checkboxes = document.querySelectorAll('.filter-panel input[type="checkbox"]');
   
   // 선택된 필터 초기화
   selectedFilters = {
      type: [],
      region: [],
      status: [],
      category: []
   };
   
   // 체크된 항목 수집
   checkboxes.forEach(checkbox => {
      if (checkbox.checked) {
         const category = checkbox.dataset.category;
         const value = checkbox.value;
         selectedFilters[category].push(value);
      }
   });
   
   // 선택된 필터 태그 표시
   displaySelectedFilters();
   
   // 필터 개수 배지 업데이트
   updateFilterCountBadge();
}

// 선택된 필터 태그 표시
function displaySelectedFilters() {
   const container = document.getElementById('selectedFilters');
   container.innerHTML = '';
   
   const categoryLabels = {
      type: '유형',
      region: '지역',
      status: '상태',
      category: '카테고리'
   };
   
   for (const [key, values] of Object.entries(selectedFilters)) {
      values.forEach(value => {
         const tag = document.createElement('div');
         tag.className = 'filter-tag';
         tag.innerHTML = `
            <span>${categoryLabels[key]}: ${value}</span>
            <span class="remove-btn" onclick="removeFilter('${key}', '${value}')">×</span>
         `;
         container.appendChild(tag);
      });
   }
}

// 개별 필터 제거
function removeFilter(category, value) {
   // 체크박스 해제
   const checkboxes = document.querySelectorAll(`input[data-category="${category}"]`);
   checkboxes.forEach(checkbox => {
      if (checkbox.value === value) {
         checkbox.checked = false;
      }
   });
   
   // 필터 업데이트
   updateFilters();
}

// 필터 개수 배지 업데이트
function updateFilterCountBadge() {
   const badge = document.getElementById('filterCountBadge');
   const totalCount = Object.values(selectedFilters).flat().length;
   
   if (totalCount > 0) {
      badge.textContent = totalCount;
      badge.style.display = 'inline-block';
   } else {
      badge.style.display = 'none';
   }
}

// 필터 적용
function applyFilters() {
   console.log('적용된 필터:', selectedFilters);
   
   // 실제 구현 시 서버로 필터 정보 전송
   // 예: location.href = '?filters=' + JSON.stringify(selectedFilters);
   
   alert('필터가 적용되었습니다!\n\n' + 
         '선택된 필터: ' + Object.values(selectedFilters).flat().join(', '));
   
   // 필터 패널 닫기
   toggleFilter();
}

// 필터 초기화
function resetFilters() {
   // 모든 체크박스 해제
   const checkboxes = document.querySelectorAll('.filter-panel input[type="checkbox"]');
   checkboxes.forEach(checkbox => {
      checkbox.checked = false;
   });
   
   // 선택된 필터 초기화
   selectedFilters = {
      type: [],
      region: [],
      status: [],
      category: []
   };
   
   // UI 업데이트
   displaySelectedFilters();
   updateFilterCountBadge();
}

// 검색 실행
function performSearch() {
   const keyword = document.getElementById('searchBox').value.trim();
   
   if (!keyword) {
      alert('검색어를 입력해주세요.');
      document.getElementById('searchBox').focus();
      return;
   }
   
   console.log('검색어:', keyword);
   console.log('필터:', selectedFilters);
   
   // 실제 구현 시 서버로 검색 요청
   // 예: location.href = 'SearchList.jsp?keyword=' + encodeURIComponent(keyword) + 
   //                     '&filters=' + encodeURIComponent(JSON.stringify(selectedFilters));
   
   alert('검색을 시작합니다!\n\n검색어: ' + keyword);
}

// 엔터키로 검색
document.addEventListener('DOMContentLoaded', function() {
   const searchBox = document.getElementById('searchBox');
   
   searchBox.addEventListener('keypress', function(e) {
      if (e.key === 'Enter') {
         performSearch();
      }
   });
   
   // 초기 필터 상태 설정
   updateFilters();
});

// 외부 클릭 시 필터 패널 닫기 (선택사항)
document.addEventListener('click', function(e) {
   const panel = document.getElementById('filterPanel');
   const container = document.querySelector('.search-section');
   const toggleBtn = document.getElementById('filterToggle');
   
   if (!container.contains(e.target) && panel.classList.contains('show')) {
      panel.classList.remove('show');
      toggleBtn.classList.remove('active');
   }
});
</script>

</body>
</html>