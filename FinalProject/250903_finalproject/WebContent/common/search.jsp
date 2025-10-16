<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>검색 기능</title>

<style>

body {

   font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

   background: #f5f7fa;

   padding: 40px;

}



/* 검색창 컨테이너 - flex로 버튼과 나란히 */

.search-container {

   position: relative;

   max-width: 600px;

   margin: 0 auto;

   display: flex;

   gap: 8px;

}



/* 검색 입력창 */

.search-box {

   flex: 1;

   padding: 12px 16px;

   font-size: 16px;

   border: 2px solid #8bc683;

   border-radius: 8px;

   outline: none;

   transition: all 0.3s ease;

}

.search-box:focus {

   border-color: #2d5a29;

   box-shadow: 0 0 6px rgba(45,90,41,0.4);

}



/* 검색 버튼  */

.search-btn {

    background: #2d5a29;

    color: white;

    border: none;

    padding: 12px 20px;

    border-radius: 8px;

    cursor: pointer;

    font-size: 14px;

    font-weight: 500;

    transition: 0.2s;

}

.search-btn:hover {

    background: #1f4019;

    transform: translateY(-1px);

    box-shadow: 0 2px 4px rgba(0,0,0,0.2);

}



/* 필터 패널 */

.filter-panel {

   display: none;

   position: absolute;

   top: 100%;

   left: 0;

   width: 100%;

   background: #fff;

   border: 1px solid #ddd;

   border-radius: 8px;

   margin-top: 6px;

   padding: 15px;

   box-shadow: 0 4px 10px rgba(0,0,0,0.1);

   z-index: 100;

}

.filter-section { margin-bottom: 12px; }

.filter-section h4 { margin-bottom: 6px; font-size: 14px; color: #2d5a29; }

.filter-section input[type="checkbox"] {

   margin-right: 6px;

   cursor: pointer;

}

</style>

</head>

<body>



<div class="search-container">

   <input type="text" id="searchBox" class="search-box" placeholder="검색어를 입력하세요...">

   <button id="searchBtn" class="search-btn">검색</button>

   <div id="filterPanel" class="filter-panel">

      <!-- 모임 유형 -->

      <div class="filter-section">

         <h4>모임 유형</h4>

         <input type="checkbox" value="online"> 온라인

         <input type="checkbox" value="offline"> 오프라인

      </div>

      <!-- 지역 -->

      <div class="filter-section">

         <h4>지역</h4>

         <input type="checkbox" value="서울"> 송도

         <input type="checkbox" value="부산"> 센트럴파크

         <input type="checkbox" value="대구"> 롯데월드

         <input type="checkbox" value="기타"> 기타

      </div>

      <!-- 상태 -->

      <div class="filter-section">

         <h4>상태</h4>

         <input type="checkbox" value="new"> 신규 개설

         <input type="checkbox" value="recruit"> 모집 중

      </div>

      <!-- 카테고리 -->

      <div class="filter-section">

         <h4>카테고리</h4>

         <input type="checkbox" value="독서"> 독서

         <input type="checkbox" value="어학"> 어학

         <input type="checkbox" value="IT"> IT

         <input type="checkbox" value="창업·취업"> 창업·취업

         <input type="checkbox" value="자격증"> 자격증

         <input type="checkbox" value="시험"> 시험

         <input type="checkbox" value="취미"> 취미

         <input type="checkbox" value="기타"> 기타

      </div>

   </div>

</div>



<script>

const searchBox = document.getElementById("searchBox");

const filterPanel = document.getElementById("filterPanel");

const searchBtn = document.getElementById("searchBtn");



// 검색창 클릭 시 → 필터 패널 열기

searchBox.addEventListener("focus", () => {

   filterPanel.style.display = "block";

});



// 바깥 클릭 시 필터 패널 닫기

document.addEventListener("click", (e) => {

   if (!document.querySelector(".search-container").contains(e.target)) {

      filterPanel.style.display = "none";

   }

});



// 검색 버튼 클릭 시 → 선택된 필터와 검색어 출력 (임시)

searchBtn.addEventListener("click", () => {

   const keyword = searchBox.value.trim();

   const checkboxes = filterPanel.querySelectorAll('input[type="checkbox"]:checked');

   const selected = Array.from(checkboxes).map(cb => cb.value);

   alert("검색어: " + keyword + "\n선택 필터: " + selected.join(", "));

});

</script>



</body>

</html>