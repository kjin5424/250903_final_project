<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page language="java" %>
<!-- 게시판 조회 화면 생성 -->

<!DOCTYPE html>

<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>공모자들 - 게시판</title>

    <style>

        * {

            margin: 0;

            padding: 0;

            box-sizing: border-box;

        }

        body {

            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

            background: #f5f7fa;

        }

        .navbar {

            background: #a8d5a1;

            display: flex;

            align-items: center;

            padding: 0 20px;

            height: 48px;

            position: sticky;

            top: 0;

            z-index: 1000;

            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

            gap: 4px;

        }

        .nav-left {

            display: flex;

            align-items: center;

            gap: 4px;

            flex: 1;

        }

        .nav-right {

            display: flex;

            align-items: center;

            margin-left: auto;

        }

        .logo-tab {

            background: #8bc683;

            color: white;

            padding: 0 20px;

            height: 36px;

            border-radius: 8px 8px 0 0;

            display: flex;

            align-items: center;

            gap: 8px;

            font-weight: bold;

            font-size: 16px;

            cursor: pointer;

        }

        .tab {

            background: #8bc683;

            color: white;

            border: none;

            padding: 0 24px;

            height: 36px;

            border-radius: 8px 8px 0 0;

            cursor: pointer;

            font-size: 14px;

            font-weight: 500;

            transition: all 0.2s ease;

            text-decoration: none;

            display: flex;

            align-items: center;

        }

        .tab.active {

            background: #f5f7fa;

            color: #2d5a29;

            height: 40px;

        }

        .profile-btn {

            background: #2d5a29;

            color: white;

            border: none;

            padding: 8px 20px;

            border-radius: 6px;

            cursor: pointer;

            font-size: 14px;

            font-weight: 500;

            text-decoration: none;

            display: flex;

            align-items: center;

            gap: 6px;

        }



        .container {

            max-width: 1200px;

            margin: 30px auto;

            padding: 0 20px;

        }



        /* 공지사항 고정 영역 */

        .post-item.pinned {

            background: #fff8e1;

            border: 2px solid #ffd54f;

            border-radius: 8px;

            margin-bottom: 5px;

        }

        .post-item.pinned:hover {

            background: #fff3e0;

        }

        .post-item.pinned .post-number {

            color: #f57c00;

            font-weight: bold;

        }

        .pinned-icon {

            color: #f57c00;

            margin-right: 5px;

            font-weight: bold;

        }



        /* 게시판 컨테이너 */

        .board-container {

            background: white;

            border-radius: 12px;

            padding: 30px;

            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

        }



        /* 게시판 헤더 */

        .board-header {

            display: flex;

            justify-content: space-between;

            align-items: center;

            margin-bottom: 20px;

            padding-bottom: 20px;

            border-bottom: 2px solid #e0e0e0;

        }

        .board-title {

            font-size: 24px;

            color: #2d5a29;

            font-weight: bold;

        }

        .board-actions {

            display: flex;

            gap: 10px;

        }

        .btn {

            padding: 10px 20px;

            border: none;

            border-radius: 8px;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

            transition: all 0.3s;

            text-decoration: none;

            display: inline-flex;

            align-items: center;

            gap: 6px;

        }

        .btn-primary {

            background: #4CAF50;

            color: white;

        }

        .btn-primary:hover {

            background: #45a049;

            transform: translateY(-2px);

            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);

        }



        /* 탭 네비게이션 */

        .board-tabs {

            display: flex;

            gap: 10px;

            margin-bottom: 20px;

            border-bottom: 2px solid #e0e0e0;

            flex-wrap: wrap;

        }

        .board-tab {

            padding: 12px 24px;

            background: transparent;

            border: none;

            border-bottom: 3px solid transparent;

            color: #666;

            font-size: 15px;

            font-weight: 600;

            cursor: pointer;

            transition: all 0.3s;

        }

        .board-tab:hover {

            color: #2d5a29;

            background: #f0f8f0;

        }

        .board-tab.active {

            color: #2d5a29;

            border-bottom-color: #2d5a29;

        }



        /* 검색 및 필터 */

        .search-filter {

            display: flex;

            gap: 10px;

            margin-bottom: 20px;

            flex-wrap: wrap;

        }

        .search-box {

            flex: 1;

            display: flex;

            gap: 10px;

        }

        .search-select {

            padding: 10px;

            border: 2px solid #e0e0e0;

            border-radius: 8px;

            font-size: 14px;

            min-width: 120px;

        }

        .search-input {

            flex: 1;

            padding: 10px 15px;

            border: 2px solid #e0e0e0;

            border-radius: 8px;

            font-size: 14px;

        }

        .search-input:focus {

            outline: none;

            border-color: #8bc683;

        }

        .btn-search {

            padding: 10px 30px;

            background: #2d5a29;

            color: white;

            border: none;

            border-radius: 8px;

            font-size: 14px;

            font-weight: 600;

            cursor: pointer;

        }

        .btn-search:hover {

            background: #1f4019;

        }



        /* 게시글 리스트 */

        .post-list {

            margin-top: 20px;

        }

        .post-header {

            display: grid;

            grid-template-columns: 80px 1fr 120px 100px 80px;

            padding: 15px 20px;

            background: #f8faf8;

            border-radius: 8px 8px 0 0;

            font-weight: 600;

            color: #666;

            font-size: 14px;

            text-align: center;

        }

        .post-header > div:nth-child(2) {

            text-align: left;

        }

        .post-item {

            display: grid;

            grid-template-columns: 80px 1fr 120px 100px 80px;

            padding: 18px 20px;

            border-bottom: 1px solid #f0f0f0;

            cursor: pointer;

            transition: all 0.3s;

            align-items: center;

            text-align: center;

        }

        .post-item:hover {

            background: #f8faf8;

        }

        .post-number {

            color: #999;

            font-size: 14px;

        }

        .post-title-area {

            text-align: left;

            display: flex;

            align-items: center;

            gap: 10px;

        }

        .post-category {

            padding: 4px 10px;

            border-radius: 12px;

            font-size: 12px;

            font-weight: 600;

            flex-shrink: 0;

        }

        .category-notice {

            background: #f44336;

            color: white;

        }

        .category-activity {

            background: #4CAF50;

            color: white;

        }

        .category-question {

            background: #2196f3;

            color: white;

        }

        .category-resource {

            background: #ff9800;

            color: white;

        }

        .category-free {

            background: #9c27b0;

            color: white;

        }

        .post-title {

            font-size: 15px;

            color: #333;

            font-weight: 500;

        }

        .post-title:hover {

            color: #2d5a29;

            text-decoration: underline;

        }

        .post-comment-count {

            color: #ff6b6b;

            font-weight: 600;

            margin-left: 5px;

        }

        .post-attachment {

            margin-left: 5px;

            color: #999;

        }

        .post-author {

            color: #666;

            font-size: 14px;

        }

        .post-date {

            color: #999;

            font-size: 13px;

        }

        .post-views {

            color: #999;

            font-size: 13px;

        }



        /* 페이지네이션 */

        .pagination {

            display: flex;

            justify-content: center;

            align-items: center;

            gap: 8px;

            margin-top: 30px;

        }

        .page-btn {

            padding: 8px 12px;

            border: 1px solid #e0e0e0;

            background: white;

            color: #666;

            border-radius: 6px;

            cursor: pointer;

            font-size: 14px;

            transition: all 0.3s;

        }

        .page-btn:hover {

            background: #f0f8f0;

            border-color: #8bc683;

            color: #2d5a29;

        }

        .page-btn.active {

            background: #2d5a29;

            color: white;

            border-color: #2d5a29;

        }



        .empty-state {

            text-align: center;

            padding: 60px 20px;

            color: #999;

            grid-column: 1 / -1;

        }

        .empty-state-icon {

            font-size: 60px;

            margin-bottom: 15px;

        }

        .empty-state-text {

            font-size: 18px;

        }



        @media (max-width: 768px) {

            .board-container {

                padding: 20px 15px;

            }

            .post-header,

            .post-item {

                grid-template-columns: 1fr;

                text-align: left !important;

                gap: 8px;

            }

            .post-header > div:nth-child(1),

            .post-header > div:nth-child(4),

            .post-header > div:nth-child(5) {

                display: none;

            }

            .post-number,

            .post-date,

            .post-views {

                display: none;

            }

            .post-author {

                font-size: 12px;

            }

            .search-box {

                flex-direction: column;

            }

        }

    </style>

    <script>

        let currentCategory = 'all';



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

                    emptyState.innerHTML = `

                        <div class="empty-state-icon">📭</div>

                        <div class="empty-state-text">게시글이 없습니다</div>

                    `;

                    postList.appendChild(emptyState);

                }

            } else {

                if (emptyState) {

                    emptyState.remove();

                }

            }

        }



        function viewPost(postId) {

            window.location.href = 'board_detail.jsp?id=' + postId;

        }



        function writePost() {

            window.location.href = 'board_write.jsp';

        }



        function searchPosts() {

            const searchType = document.getElementById('searchType').value;

            const searchKeyword = document.getElementById('searchKeyword').value;

            

            if (!searchKeyword.trim()) {

                alert('검색어를 입력해주세요.');

                return;

            }

            

            console.log('검색:', searchType, searchKeyword);

            // 실제로는 서버에 검색 요청

        }



        // 엔터키로 검색

        document.addEventListener('DOMContentLoaded', function() {

            document.getElementById('searchKeyword').addEventListener('keypress', function(e) {

                if (e.key === 'Enter') {

                    searchPosts();

                }

            });

        });

    </script>

</head>

<body>

    <nav class="navbar">

        <div class="nav-left">

            <div class="logo-tab">

                <span>로고 들어갈 자리</span>

            </div>

            <a href="?page=notice" class="tab">공지사항</a>

            <a href="?page=groups" class="tab">모임구경</a>

            <a href="?page=creategroup" class="tab">모임 개설</a>

            <a href="?page=mygroups" class="tab active">내 모임</a>

        </div>

        <div class="nav-right">

            <a href="mypage.jsp" class="profile-btn">

                <span>👤</span>

                <span>마이페이지</span>

            </a>

        </div>

    </nav>



    <div class="container">

        <!-- 게시판 메인 -->

        <div class="board-container">

            <div class="board-header">

                <h1 class="board-title">📋 게시판</h1>

                <div class="board-actions">

                    <button class="btn btn-primary" onclick="location.href='writepost.do'">

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

                    <button class="btn-search" onclick="searchPosts()">🔍 검색</button>

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

</body>

</html>