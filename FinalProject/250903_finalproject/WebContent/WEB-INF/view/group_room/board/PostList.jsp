<%@ page contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" %>
<% 
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판 - 공모자들</title>

<!-- CSS 파일 임포트 -->
<link rel="stylesheet" href="<%=cp %>/css_new/home_sample.css" />
<link rel="stylesheet" href="<%=cp %>/ccss_new/common_sample.css">
<link rel="stylesheet" href="<%=cp %>/ccss_new/board_sample.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    let currentCategory = 'all';

    $(document).ready(function() {
        // 엔터키로 검색
        $('#searchKeyword').keypress(function(e) {
            if (e.key === 'Enter') {
                searchPosts();
            }
        });
    });

    // 탭 전환
    function switchTab(tab) {
        currentCategory = tab;
        
        // 모든 탭 비활성화
        const tabs = document.querySelectorAll('.board-tab');
        tabs.forEach(t => t.classList.remove('active'));
        
        // 선택된 탭 활성화
        event.target.classList.add('active');
        
        // 게시글 필터링
        filterPosts();
    }

    // 게시글 필터링
    function filterPosts() {
        const posts = document.querySelectorAll('.post-item:not(.pinned)');
        
        posts.forEach(post => {
            const category = post.querySelector('.post-category');
            if (!category) {
                post.style.display = 'grid';
                return;
            }
            
            const categoryText = category.textContent.trim();
            
            if (currentCategory === 'all') {
                post.style.display = 'grid';
            } else if (currentCategory === 'notice' && categoryText === '공지') {
                post.style.display = 'grid';
            } else if (currentCategory === 'activity' && categoryText === '활동') {
                post.style.display = 'grid';
            } else if (currentCategory === 'question' && categoryText === '질문') {
                post.style.display = 'grid';
            } else if (currentCategory === 'resource' && categoryText === '자료') {
                post.style.display = 'grid';
            } else if (currentCategory === 'free' && categoryText === '자유') {
                post.style.display = 'grid';
            } else {
                post.style.display = 'none';
            }
        });
        // 게시글이 하나도 없으면 빈 상태 표시
        checkEmptyState();
    }

    // 빈 상태 확인
    function checkEmptyState() {
        const posts = document.querySelectorAll('.post-item');
        let visibleCount = 0;
        
        posts.forEach(post => {
            if (post.style.display !== 'none') {
                visibleCount++;
            }
        });

        const postList = document.querySelector('.post-list');
        let emptyState = document.querySelector('.empty-state');
        
        if (visibleCount === 0) {
            if (!emptyState) {
                emptyState = document.createElement('div');
                emptyState.className = 'empty-state';
                emptyState.innerHTML = '<div class="empty-state-icon">📭</div>'
                 + '<div class="empty-state-text">게시글이 없습니다</div>';
                postList.appendChild(emptyState);
            }
        } else {
            if (emptyState) {
                emptyState.remove();
            }
        }
    }

    // 게시글 보기
    function viewPost(postCode) {
     	window.location.href = 'postdetail.do?postCode=' + postCode;
    }

    // 게시글 작성
    function writePost() {
        window.location.href = 'postwrite.do';
    }

    // 게시글 검색
    function searchPosts() {
        const searchType = document.getElementById('searchType').value;
        const searchKeyword = document.getElementById('searchKeyword').value;
        
        if (!searchKeyword.trim()) {
            alert('검색어를 입력해주세요.');
            return;
        }
        
        var url = "searchpost.do";
        url = url + "?searchType=" + searchType
                  + "&searchKeyword=" + encodeURIComponent(searchKeyword);
        window.location.href = url;
    }
</script>
</head>
<body>
    <!-- 상단바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
	
	<!-- 사이드바 -->
	<c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />

    <!-- ================================================
         메인 컨테이너
         ================================================ -->
    <div class="main-container">
        <div class="board-container">
            <!-- 게시판 헤더 -->
            <div class="board-header">
                <h1 class="board-title">
                    <span class="board-title-icon">📋</span>
                    게시판
                </h1>
                <div class="board-actions">
                    <button class="btn btn-primary" onclick="location.href='<%=cp%>/postwrite.do'">
                        	✏️ 글쓰기
                    </button>
                </div>
            </div>

            <!-- 카테고리 탭 -->
            <div class="board-tabs">
                <button class="board-tab active" onclick="switchTab('all')">전체</button>
                <button class="board-tab" onclick="switchTab('notice')">공지</button>
                <button class="board-tab" onclick="switchTab('activity')">활동</button>
                <button class="board-tab" onclick="switchTab('question')">질문</button>
                <button class="board-tab" onclick="switchTab('resource')">자료</button>
                <button class="board-tab" onclick="switchTab('free')">자유</button>
            </div>

            <!-- 검색 -->
            <div class="search-filter">
                <div class="search-box">
                    <select id="searchType" class="search-select">
                        <option value="title">제목</option>
                        <option value="author">작성자</option>
                        <option value="content">내용</option>
                    </select>
                    <input type="text" id="searchKeyword" class="search-input" placeholder="검색어를 입력하세요">
                    <button class="btn-search" onclick="searchPosts()">
                        	🔍 검색
                    </button>
                </div>
            </div>
            

            <!-- 게시글 리스트 -->
            <div class="post-list">
                <div class="post-header">
                    <div>번호</div>
                    <div>제목</div>
                    <div>작성자</div>
                    <div>작성일</div>
                </div><!-- post-header -->
                
                <!-- 고정 공지사항 -->
                <c:forEach var="dto" items="${noticeList}">
                	<div class="post-item pinned" onclick="viewPost(${dto.postCode })">
	                    <div class="post-number">📌</div>
	                    <div class="post-title-area">
	                        <span class="post-category category-notice">${dto.boardCategory }</span>
	                        <span class="post-title">${dto.subject }
	                            <span class="post-comment-count">[${dto.commentCount }]</span>
	                        </span>
	                    </div>
	                    <div class="post-author">${dto.nickName }</div>	
	                    <div class="post-date">${dto.createdDate }</div>
                	</div>	
                </c:forEach>
                
                <!-- 일반 게시글 -->
                <c:forEach var="dto" items="${list }">
                	<div class="post-item" onclick="viewPost(${dto.postCode })">
                		<c:set var="i" value="${i+1 }"/>
                		<c:set var="postNumber" value="${start + i -1 }"/>
	                    <div class="post-number">${postNumber }</div>
	                    <div class="post-title-area">
	                    	<c:if test="${dto.boardCategory=='공지' }">
		                        <span class="post-category category-notice">${dto.boardCategory }</span>
	                    	</c:if>
	                    	<c:if test="${dto.boardCategory=='활동'}">
		                        <span class="post-category category-activity">${dto.boardCategory }</span>
	                    	</c:if>
	                    	<c:if test="${dto.boardCategory=='질문' }">
		                        <span class="post-category category-question">${dto.boardCategory }</span>
	                    	</c:if>
	                    	<c:if test="${dto.boardCategory=='자료' }">
		                        <span class="post-category category-resource">${dto.boardCategory }</span>
	                    	</c:if>
	                    	<c:if test="${dto.boardCategory=='자유' }">
		                        <span class="post-category category-free">${dto.boardCategory }</span>
	                    	</c:if>
	                        <span class="post-title">${dto.subject }
	                            <span class="post-comment-count">[${dto.commentCount }]</span>
	                        </span>
	                    </div>
	                    <div class="post-author">${dto.nickName }</div>
	                    <div class="post-date">${dto.createdDate }</div>
                	</div>
                </c:forEach>

	            <!-- 페이지네이션 -->
	            <div class="pagination">
	            ${pageIndexList } 
	            <!-- 
	                <button class="page-btn">◀</button>
	                <button class="page-btn active">1</button>
	                <button class="page-btn">2</button>
	                <button class="page-btn">3</button>
	                <button class="page-btn">4</button>
	                <button class="page-btn">5</button>
	                <button class="page-btn">▶</button>
	             -->
	            </div><!-- pagination -->
	        </div><!-- post-list -->
    	</div><!-- board-container -->
	</div><!-- main-container -->
</body>
</html>
