<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시물/댓글 관리 - 공모자들</title>
    <link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css" />
    <link rel="stylesheet" href="<%=cp%>/css_new/board_sample.css" />
    <style>
/* 게시물 관리 페이지 전용 스타일 */
.management-header {
	display: flex;
	align-items: center;
	gap: var(--spacing-md);
	margin-bottom: var(--spacing-xl);
}

.back-btn {
	display: flex;
	align-items: center;
	justify-content: center;
	width: 40px;
	height: 40px;
	background: var(--color-white);
	border: 2px solid var(--color-border);
	border-radius: var(--radius-md);
	font-size: 20px;
	cursor: pointer;
	transition: all var(--transition-base);
}

.back-btn:hover {
	background: var(--color-primary-lighter);
	border-color: var(--color-primary);
	color: var(--color-primary-dark);
}

.bulk-action-bar {
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: var(--spacing-md) var(--spacing-lg);
	background: var(--color-base);
	border-bottom: 2px solid var(--color-border-light);
	border-radius: var(--radius-md) var(--radius-md) 0 0;
}

.selection-info {
	font-size: 14px;
	color: var(--color-text-secondary);
}

.selection-count {
	font-weight: 700;
	color: var(--color-primary-dark);
	font-size: 18px;
}

/* 게시물 탭 레이아웃: 체크박스(50px) 게시판(70px) 제목(1fr) 작성자(120px) 작성일(120px) 댓글(70px) 관리(100px) */
.post-list.posts-view .post-header,
.post-list.posts-view .post-item {
	grid-template-columns: 50px 70px 1fr 120px 120px 70px 100px;
}

/* 댓글 탭 레이아웃: 체크박스(50px) 게시판(70px) 제목(0.6fr) 댓글내용(1.4fr) 작성자(120px) 작성일(120px) 관리(100px) */
.post-list.comments-view .post-header,
.post-list.comments-view .post-item {
	grid-template-columns: 50px 70px 0.6fr 1.4fr 120px 120px 100px;
}

/* 제목 말줄임 처리 */
.post-title-area {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.post-title-area .post-link {
	display: block;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

/* 댓글 내용 말줄임 처리 */
.comment-content {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	color: var(--color-text-secondary);
}

/* 탭 전환 시 보이기/숨기기 */
.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}
    </style>
    <script>
        let selectedItems = new Set();
        let currentTab = 'posts'; // 현재 활성 탭

        function toggleTab(tabName) {
            // 탭 버튼 활성화
            document.querySelectorAll('.board-tab').forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            // 탭 컨텐츠 전환
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));
            document.getElementById(tabName + '-content').classList.add('active');
            
            currentTab = tabName;
            selectedItems.clear();
            updateSelectionCount();
        }

        function toggleSelectAll() {
            const selectAll = document.getElementById('selectAll-' + currentTab);
            const checkboxes = document.querySelectorAll('#' + currentTab + '-content .item-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
                if (selectAll.checked) selectedItems.add(checkbox.value);
                else selectedItems.delete(checkbox.value);
            });
            updateSelectionCount();
        }

        function toggleSelect(id) {
            if (selectedItems.has(id)) selectedItems.delete(id);
            else selectedItems.add(id);
            updateSelectionCount();
        }

        function updateSelectionCount() {
            document.getElementById('selectionCount').textContent = selectedItems.size;
            document.getElementById('bulkDeleteBtn').disabled = selectedItems.size === 0;
        }

        function deleteSingle(id, title) {
            if(confirm('"' + title + '"을(를) 삭제하시겠습니까?\n\n이 작업은 되돌릴 수 없습니다.')){
                alert('삭제되었습니다.');
                location.reload();
            }
        }

        function bulkDelete() {
            if(selectedItems.size === 0){ alert('삭제할 항목을 선택해주세요.'); return; }
            if(confirm('선택한 ' + selectedItems.size + '개의 항목을 삭제하시겠습니까?\n\n이 작업은 되돌릴 수 없습니다.')){
                alert(selectedItems.size + '개의 항목이 삭제되었습니다.');
                selectedItems.clear();
                updateSelectionCount();
                location.reload();
            }
        }

        function searchContent() {
            const searchType = document.getElementById('searchType').value;
            const keyword = document.getElementById('searchKeyword').value;
            if(!keyword.trim()){ alert('검색어를 입력해주세요.'); return; }
            console.log('Searching:', searchType, keyword);
        }

        function goBack() { window.history.back(); }

        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('searchKeyword').addEventListener('keypress', function(e) {
                if(e.key === 'Enter') searchContent();
            });
        });
    </script>
</head>
<body>
    <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
    
    <!-- 사이드바 -->
    <c:import url="/WEB-INF/view/common/GroupSideBar.jsp"></c:import>

    <!-- 메인 콘텐츠 -->
    <div class="main-container">
        <div class="board-container">
            <!-- 페이지 헤더 -->
            <div class="management-header">
                <button class="back-btn" onclick="goBack()">←</button>
                <h2 class="board-title">
                    <span class="board-title-icon">⚙️</span>
                    게시물/댓글 관리
                </h2>
            </div>

            <!-- 탭 네비게이션 -->
            <div class="board-tabs">
                <button class="board-tab active" onclick="toggleTab('posts')">📝 게시물</button>
                <button class="board-tab" onclick="toggleTab('comments')">💬 댓글</button>
            </div>

            <!-- 검색 및 필터 -->
            <div class="search-filter">
                <select id="boardType" class="search-select">
                    <option value="all">전체 게시판</option>
                    <option value="notice">공지</option>
                    <option value="activity">활동</option>
                    <option value="question">질문</option>
                    <option value="resource">자료</option>
                    <option value="free">자유</option>
                </select>

                <select id="dateFilter" class="search-select">
                    <option value="all">전체 기간</option>
                    <option value="today">오늘</option>
                    <option value="week">최근 1주일</option>
                    <option value="month">최근 1개월</option>
                    <option value="3months">최근 3개월</option>
                </select>

                <div class="search-box">
                    <select id="searchType" class="search-select">
                        <option value="title">제목</option>
                        <option value="author">작성자</option>
                        <option value="content">내용</option>
                    </select>
                    <input type="text" id="searchKeyword" class="search-input" placeholder="검색어를 입력하세요">
                    <button class="btn-search" onclick="searchContent()">
                        <span>🔍</span>
                        <span>검색</span>
                    </button>
                </div>
            </div>

            <!-- 일괄 작업 바 -->
            <div class="bulk-action-bar">
                <div class="selection-info">
                    선택된 항목: <span id="selectionCount" class="selection-count">0</span>개
                </div>
                <div>
                    <button id="bulkDeleteBtn" class="btn btn-accent btn-sm" onclick="bulkDelete()" disabled>
                        선택 항목 삭제
                    </button>
                </div>
            </div>

            <!-- 게시물 탭 컨텐츠 -->
            <div id="posts-content" class="tab-content active">
                <div class="post-list posts-view">
                    <div class="post-header">
                        <div>
                            <input type="checkbox" id="selectAll-posts" onchange="toggleSelectAll()">
                        </div>
                        <div>게시판</div>
                        <div>제목</div>
                        <div>작성자</div>
                        <div>작성일</div>
                        <div>댓글</div>
                        <div>관리</div>
                    </div>

                    <c:forEach var="post" items="${postList}">
                        <div class="post-item">
                            <div>
                                <input type="checkbox" class="item-checkbox" value="${post.postCode}" 
                                       onchange="toggleSelect('${post.postCode}')">
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${post.boardCategory == '공지'}">
                                        <span class="post-category category-notice">${post.boardCategory}</span>
                                    </c:when>
                                    <c:when test="${post.boardCategory == '활동'}">
                                        <span class="post-category category-activity">${post.boardCategory}</span>
                                    </c:when>
                                    <c:when test="${post.boardCategory == '질문'}">
                                        <span class="post-category category-question">${post.boardCategory}</span>
                                    </c:when>
                                    <c:when test="${post.boardCategory == '자료'}">
                                        <span class="post-category category-resource">${post.boardCategory}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="post-category category-free">${post.boardCategory}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="post-title-area">
                                <a href="postDetail.jsp?postCode=${post.postCode}" class="post-link">
                                    ${post.subject}
                                </a>
                            </div>
                            <div class="post-author">${post.nickName}</div>
                            <div class="post-date">${post.createdDate}</div>
                            <div class="post-views">
                                <span class="post-comment-count">${post.commentCount}</span>
                            </div>
                            <div>
                                <button class="btn btn-accent btn-sm" 
                                        onclick="deleteSingle('${post.postCode}', '${post.subject}')">
                                    삭제
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button class="page-btn" disabled>◀</button>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <button class="page-btn ${i == currentPage ? 'active' : ''}">${i}</button>
                    </c:forEach>
                    <button class="page-btn">▶</button>
                </div>
            </div>

            <!-- 댓글 탭 컨텐츠 -->
            <div id="comments-content" class="tab-content">
                <div class="post-list comments-view">
                    <div class="post-header">
                        <div>
                            <input type="checkbox" id="selectAll-comments" onchange="toggleSelectAll()">
                        </div>
                        <div>게시판</div>
                        <div>게시글</div>
                        <div>댓글 내용</div>
                        <div>작성자</div>
                        <div>작성일</div>
                        <div>관리</div>
                    </div>

                    <c:forEach var="comment" items="${commentList}">
                        <div class="post-item">
                            <div>
                                <input type="checkbox" class="item-checkbox" value="${comment.commentCode}" 
                                       onchange="toggleSelect('${comment.commentCode}')">
                            </div>
                            <div>
                                <c:choose>
                                    <c:when test="${comment.boardCategory == '공지'}">
                                        <span class="post-category category-notice">${comment.boardCategory}</span>
                                    </c:when>
                                    <c:when test="${comment.boardCategory == '활동'}">
                                        <span class="post-category category-activity">${comment.boardCategory}</span>
                                    </c:when>
                                    <c:when test="${comment.boardCategory == '질문'}">
                                        <span class="post-category category-question">${comment.boardCategory}</span>
                                    </c:when>
                                    <c:when test="${comment.boardCategory == '자료'}">
                                        <span class="post-category category-resource">${comment.boardCategory}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="post-category category-free">${comment.boardCategory}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="post-title-area">
                                <a href="postDetail.jsp?postCode=${comment.postCode}" class="post-link">
                                    ${comment.postSubject}
                                </a>
                            </div>
                            <div class="comment-content">
                                ${comment.content}
                            </div>
                            <div class="post-author">${comment.nickName}</div>
                            <div class="post-date">${comment.createdDate}</div>
                            <div>
                                <button class="btn btn-accent btn-sm" 
                                        onclick="deleteSingle('${comment.commentCode}', '댓글')">
                                    삭제
                                </button>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- 페이지네이션 -->
                <div class="pagination">
                    <button class="page-btn" disabled>◀</button>
                    <c:forEach begin="1" end="${totalCommentPages}" var="i">
                        <button class="page-btn ${i == currentCommentPage ? 'active' : ''}">${i}</button>
                    </c:forEach>
                    <button class="page-btn">▶</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
