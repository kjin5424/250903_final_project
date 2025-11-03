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
    <link rel="stylesheet" href="css_new/common_sample.css">
    <link rel="stylesheet" href="css_new/topmenubar_sample.css">
    <link rel="stylesheet" href="css_new/board_sample.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <!-- ================================================
         상단 메뉴바
         ================================================ -->
    <!-- 상단바 (그라디언트 영역) -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

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
                    <button class="btn btn-primary" onclick="location.href='<%=cp%>/board/write'">
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
                    <div>조회</div>
                </div>

                <!-- 고정 공지사항 -->
                <div class="post-item pinned" onclick="viewPost(1)">
                    <div class="post-number">📌</div>
                    <div class="post-title-area">
                        <span class="post-category category-notice">공지</span>
                        <span class="post-title">📢 이번 주 스터디 일정 안내
                            <span class="post-comment-count">[8]</span>
                        </span>
                    </div>
                    <div class="post-author">코딩마스터</div>
                    <div class="post-date">2024-10-10</div>
                    <div class="post-views">234</div>
                </div>

                <div class="post-item pinned" onclick="viewPost(2)">
                    <div class="post-number">📌</div>
                    <div class="post-title-area">
                        <span class="post-category category-notice">공지</span>
                        <span class="post-title">🎉 모임 레벨 3 달성! 축하합니다
                            <span class="post-comment-count">[15]</span>
                        </span>
                    </div>
                    <div class="post-author">코딩마스터</div>
                    <div class="post-date">2024-10-08</div>
                    <div class="post-views">312</div>
                </div>

                <div class="post-item pinned" onclick="viewPost(3)">
                    <div class="post-number">📌</div>
                    <div class="post-title-area">
                        <span class="post-category category-notice">공지</span>
                        <span class="post-title">⚠️ 모임 규칙 안내 (필독)</span>
                    </div>
                    <div class="post-author">코딩마스터</div>
                    <div class="post-date">2024-10-05</div>
                    <div class="post-views">456</div>
                </div>

                <!-- 일반 게시글 -->
                <div class="post-item" onclick="viewPost(4)">
                    <div class="post-number">15</div>
                    <div class="post-title-area">
                        <span class="post-category category-activity">활동</span>
                        <span class="post-title">백준 1234번 풀이 공유합니다
                            <span class="post-comment-count">[5]</span>
                        </span>
                    </div>
                    <div class="post-author">개발자지망생</div>
                    <div class="post-date">2024-10-12</div>
                    <div class="post-views">127</div>
                </div>

                <div class="post-item" onclick="viewPost(5)">
                    <div class="post-number">14</div>
                    <div class="post-title-area">
                        <span class="post-category category-question">질문</span>
                        <span class="post-title">DP 문제 접근 방법 질문드립니다
                            <span class="post-comment-count">[12]</span>
                        </span>
                    </div>
                    <div class="post-author">알고리즘초보</div>
                    <div class="post-date">2024-10-11</div>
                    <div class="post-views">89</div>
                </div>

                <div class="post-item" onclick="viewPost(6)">
                    <div class="post-number">13</div>
                    <div class="post-title-area">
                        <span class="post-category category-resource">자료</span>
                        <span class="post-title">유용한 알고리즘 사이트 모음
                            <span class="post-attachment">📎</span>
                            <span class="post-comment-count">[3]</span>
                        </span>
                    </div>
                    <div class="post-author">코드러버</div>
                    <div class="post-date">2024-10-10</div>
                    <div class="post-views">156</div>
                </div>

                <div class="post-item" onclick="viewPost(7)">
                    <div class="post-number">12</div>
                    <div class="post-title-area">
                        <span class="post-category category-free">자유</span>
                        <span class="post-title">오늘 스터디 너무 재밌었어요!
                            <span class="post-comment-count">[8]</span>
                        </span>
                    </div>
                    <div class="post-author">자바마스터</div>
                    <div class="post-date">2024-10-10</div>
                    <div class="post-views">73</div>
                </div>

                <div class="post-item" onclick="viewPost(8)">
                    <div class="post-number">11</div>
                    <div class="post-title-area">
                        <span class="post-category category-activity">활동</span>
                        <span class="post-title">프로그래머스 레벨 2 문제 풀이</span>
                    </div>
                    <div class="post-author">파이썬러버</div>
                    <div class="post-date">2024-10-09</div>
                    <div class="post-views">94</div>
                </div>

                <div class="post-item" onclick="viewPost(9)">
                    <div class="post-number">10</div>
                    <div class="post-title-area">
                        <span class="post-category category-question">질문</span>
                        <span class="post-title">시간 복잡도 계산 질문
                            <span class="post-comment-count">[7]</span>
                        </span>
                    </div>
                    <div class="post-author">신입개발자</div>
                    <div class="post-date">2024-10-08</div>
                    <div class="post-views">112</div>
                </div>

                <div class="post-item" onclick="viewPost(10)">
                    <div class="post-number">9</div>
                    <div class="post-title-area">
                        <span class="post-category category-resource">자료</span>
                        <span class="post-title">이번 주 학습 자료 공유
                            <span class="post-attachment">📎</span>
                        </span>
                    </div>
                    <div class="post-author">코딩마스터</div>
                    <div class="post-date">2024-10-07</div>
                    <div class="post-views">145</div>
                </div>

                <div class="post-item" onclick="viewPost(11)">
                    <div class="post-number">8</div>
                    <div class="post-title-area">
                        <span class="post-category category-free">자유</span>
                        <span class="post-title">다들 어떤 IDE 사용하시나요?
                            <span class="post-comment-count">[15]</span>
                        </span>
                    </div>
                    <div class="post-author">개발자지망생</div>
                    <div class="post-date">2024-10-06</div>
                    <div class="post-views">203</div>
                </div>

                <div class="post-item" onclick="viewPost(12)">
                    <div class="post-number">7</div>
                    <div class="post-title-area">
                        <span class="post-category category-activity">활동</span>
                        <span class="post-title">BFS/DFS 정리 노트</span>
                    </div>
                    <div class="post-author">알고리즘초보</div>
                    <div class="post-date">2024-10-05</div>
                    <div class="post-views">167</div>
                </div>

                <div class="post-item" onclick="viewPost(13)">
                    <div class="post-number">6</div>
                    <div class="post-title-area">
                        <span class="post-category category-question">질문</span>
                        <span class="post-title">재귀 함수 이해가 안 돼요 ㅠㅠ
                            <span class="post-comment-count">[9]</span>
                        </span>
                    </div>
                    <div class="post-author">코드러버</div>
                    <div class="post-date">2024-10-04</div>
                    <div class="post-views">134</div>
                </div>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <button class="page-btn">◀</button>
                <button class="page-btn active">1</button>
                <button class="page-btn">2</button>
                <button class="page-btn">3</button>
                <button class="page-btn">4</button>
                <button class="page-btn">5</button>
                <button class="page-btn">▶</button>
            </div>
        </div>
    </div>

    <script>
        let currentCategory = 'all';

        $(document).ready(function() {
            // 모바일 메뉴 토글
            $('.mobile-menu-toggle').click(function() {
                $(this).toggleClass('active');
                $('.navbar-menu').toggleClass('active');
            });
            
            // 스크롤 시 헤더 스타일 변경
            $(window).scroll(function() {
                if ($(this).scrollTop() > 50) {
                    $('.navbar').addClass('scrolled');
                } else {
                    $('.navbar').removeClass('scrolled');
                }
            });
            
            // 프로필 드롭다운
            $('.profile-button').click(function(e) {
                e.stopPropagation();
                $('.dropdown-menu').toggleClass('show');
            });
            
            // 드롭다운 외부 클릭 시 닫기
            $(document).click(function() {
                $('.dropdown-menu').removeClass('show');
            });
            
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

            // 고정 공지사항은 항상 표시
            const pinnedPosts = document.querySelectorAll('.post-item.pinned');
            pinnedPosts.forEach(post => {
                if (currentCategory === 'all' || currentCategory === 'notice') {
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
                    emptyState.innerHTML = '
                        <div class="empty-state-icon">📭</div>
                        <div class="empty-state-text">게시글이 없습니다</div>
                    ';
                    postList.appendChild(emptyState);
                }
            } else {
                if (emptyState) {
                    emptyState.remove();
                }
            }
        }

        // 게시글 보기
        function viewPost(postId) {
            window.location.href = '<%=cp%>/board/detail?id=' + postId;
        }

        // 게시글 작성
        function writePost() {
            window.location.href = '<%=cp%>/board/write';
        }

        // 게시글 검색
        function searchPosts() {
            const searchType = document.getElementById('searchType').value;
            const searchKeyword = document.getElementById('searchKeyword').value;
            
            if (!searchKeyword.trim()) {
                alert('검색어를 입력해주세요.');
                return;
            }
            
            // 실제로는 서버에 검색 요청
            console.log('검색:', searchType, searchKeyword);
            window.location.href = '<%=cp%>/board?searchType=' + searchType + '&keyword=' + encodeURIComponent(searchKeyword);
        }
    </script>
</body>
</html>
