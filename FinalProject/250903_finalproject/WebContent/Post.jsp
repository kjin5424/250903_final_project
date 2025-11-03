<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<!-- 모임장이 게시물 관리하는 페이지 -->
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 게시물/댓글 관리</title>
    <style>
        /* CSS 변수 정의 */
        :root {
            --max-width: 1200px;
            --spacing-xs: 4px;
            --spacing-sm: 8px;
            --spacing-md: 16px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 48px;
            --radius-sm: 4px;
            --radius-md: 8px;
            --radius-lg: 12px;
            --radius-full: 9999px;
            --color-primary: #4f46e5;
            --color-primary-dark: #4338ca;
            --color-primary-lighter: #eef2ff;
            --color-accent: #dc2626;
            --color-accent-dark: #b91c1c;
            --color-accent-light: #fee2e2;
            --color-white: #ffffff;
            --color-base: #f9fafb;
            --color-border: #e5e7eb;
            --color-border-light: #f3f4f6;
            --color-text-primary: #111827;
            --color-text-secondary: #6b7280;
            --color-text-tertiary: #9ca3af;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --transition-base: all 0.2s ease;
            --transition-fast: all 0.15s ease;
        }

        /* 기본 리셋 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background-color: var(--color-base);
            color: var(--color-text-primary);
            line-height: 1.6;
        }

        /* 네비게이션 바 */
        .navbar {
            background: var(--color-white);
            border-bottom: 1px solid var(--color-border);
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: var(--shadow-sm);
        }

        .navbar-inner {
            max-width: var(--max-width);
            margin: 0 auto;
            padding: 0 var(--spacing-lg);
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
        }

        .navbar-logo {
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
            text-decoration: none;
            font-size: 20px;
            font-weight: 800;
            color: var(--color-primary-dark);
        }

        .logo-icon {
            font-size: 24px;
        }

        .navbar-menu {
            display: flex;
            gap: var(--spacing-sm);
        }

        .menu-tab {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            padding: var(--spacing-sm) var(--spacing-md);
            text-decoration: none;
            color: var(--color-text-secondary);
            font-weight: 600;
            border-radius: var(--radius-md);
            transition: var(--transition-base);
        }

        .menu-tab:hover {
            background: var(--color-primary-lighter);
            color: var(--color-primary-dark);
        }

        .menu-tab.active {
            background: var(--color-primary);
            color: white;
        }

        .menu-icon {
            font-size: 18px;
        }

        .navbar-actions {
            display: flex;
            gap: var(--spacing-sm);
        }

        .profile-button {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: var(--color-primary-lighter);
            border-radius: var(--radius-full);
            text-decoration: none;
            transition: var(--transition-base);
        }

        .profile-button:hover {
            background: var(--color-primary);
        }

        .profile-icon {
            font-size: 20px;
        }

        /* 메인 컨테이너 */
        .management-container {
            max-width: var(--max-width);
            margin: var(--spacing-xl) auto;
            padding: 0 var(--spacing-lg);
        }

        /* 페이지 헤더 */
        .page-header-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: var(--spacing-xl);
            flex-wrap: wrap;
            gap: var(--spacing-md);
        }

        .header-left-side {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
        }

        .back-button {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: var(--color-white);
            border: 2px solid var(--color-border);
            border-radius: var(--radius-md);
            font-size: 20px;
            color: var(--color-text-secondary);
            cursor: pointer;
            transition: var(--transition-base);
        }

        .back-button:hover {
            background: var(--color-primary-lighter);
            border-color: var(--color-primary);
            color: var(--color-primary-dark);
        }

        .main-page-title {
            font-size: 32px;
            font-weight: 800;
            color: var(--color-text-primary);
            margin: 0;
        }

        /* 탭 네비게이션 */
        .tab-navigation {
            display: flex;
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-xl);
            border-bottom: 2px solid var(--color-border-light);
            flex-wrap: wrap;
        }

        .nav-tab-btn {
            padding: var(--spacing-md) var(--spacing-xl);
            background: transparent;
            border: none;
            border-bottom: 3px solid transparent;
            color: var(--color-text-secondary);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-base);
        }

        .nav-tab-btn:hover {
            color: var(--color-primary-dark);
            background: var(--color-primary-lighter);
        }

        .nav-tab-btn.active {
            color: var(--color-primary-dark);
            border-bottom-color: var(--color-primary-dark);
        }

        /* 필터 바 */
        .filter-section {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
            padding: var(--spacing-lg);
            background: var(--color-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            margin-bottom: var(--spacing-lg);
            flex-wrap: wrap;
        }

        .filter-dropdown {
            padding: 10px 14px;
            border: 2px solid var(--color-border);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-family: inherit;
            background: var(--color-white);
            cursor: pointer;
            transition: var(--transition-fast);
        }

        .filter-dropdown:focus {
            outline: none;
            border-color: var(--color-primary);
        }

        .search-wrapper {
            display: flex;
            gap: var(--spacing-sm);
            flex: 1;
            max-width: 400px;
        }

        .search-field {
            flex: 1;
            padding: 10px 14px;
            border: 2px solid var(--color-border);
            border-radius: var(--radius-md);
            font-size: 14px;
        }

        .search-field:focus {
            outline: none;
            border-color: var(--color-primary);
        }

        .search-button {
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
            padding: 10px 20px;
            background: var(--color-primary);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-base);
        }

        .search-button:hover {
            background: var(--color-primary-dark);
        }

        /* 테이블 컨테이너 */
        .content-table-container {
            background: var(--color-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            margin-bottom: var(--spacing-lg);
        }

        /* 테이블 */
        .content-table {
            width: 100%;
            border-collapse: collapse;
        }

        .content-table thead {
            background: var(--color-primary-lighter);
        }

        .content-table th {
            padding: var(--spacing-md) var(--spacing-lg);
            text-align: left;
            font-size: 14px;
            font-weight: 700;
            color: var(--color-primary-dark);
            border-bottom: 2px solid var(--color-primary);
        }

        .content-table tbody tr {
            border-bottom: 1px solid var(--color-border-light);
            transition: var(--transition-base);
        }

        .content-table tbody tr:hover {
            background: var(--color-primary-lighter);
        }

        .content-table td {
            padding: var(--spacing-md) var(--spacing-lg);
            font-size: 14px;
            color: var(--color-text-primary);
        }

        /* 체크박스 */
        .select-checkbox {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: var(--color-primary);
        }

        /* 카테고리 배지 */
        .board-category-badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            border-radius: var(--radius-full);
            font-size: 12px;
            font-weight: 700;
        }

        .badge-notice {
            background: var(--color-accent-light);
            color: var(--color-accent-dark);
        }

        .badge-activity {
            background: var(--color-primary-lighter);
            color: var(--color-primary-dark);
        }

        .badge-question {
            background: #e3f2fd;
            color: #1565c0;
        }

        .badge-resource {
            background: #fff3e0;
            color: #f57c00;
        }

        .badge-free {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        /* 제목 셀 */
        .title-cell {
            max-width: 400px;
        }

        .post-link {
            color: var(--color-text-primary);
            text-decoration: none;
            transition: color var(--transition-fast);
            display: block;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .post-link:hover {
            color: var(--color-primary-dark);
            text-decoration: underline;
        }

        /* 버튼 */
        .action-button {
            padding: 6px 12px;
            border: none;
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-base);
        }

        .delete-single-btn {
            background: var(--color-accent);
            color: white;
        }

        .delete-single-btn:hover {
            background: var(--color-accent-dark);
            transform: translateY(-1px);
        }

        /* 일괄 작업 바 */
        .bulk-action-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: var(--spacing-md) var(--spacing-lg);
            background: var(--color-base);
            border-bottom: 1px solid var(--color-border-light);
        }

        .selection-info {
            font-size: 14px;
            color: var(--color-text-secondary);
        }

        .selection-count {
            font-weight: 700;
            color: var(--color-primary-dark);
        }

        .bulk-actions {
            display: flex;
            gap: var(--spacing-sm);
        }

        .bulk-delete-btn {
            padding: 8px 16px;
            background: var(--color-accent);
            color: white;
            border: none;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition-base);
        }

        .bulk-delete-btn:hover {
            background: var(--color-accent-dark);
        }

        .bulk-delete-btn:disabled {
            background: var(--color-border);
            cursor: not-allowed;
        }

        /* 페이지네이션 */
        .pagination-section {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: var(--spacing-sm);
            padding: var(--spacing-lg);
        }

        .page-button {
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 40px;
            height: 40px;
            padding: 0 var(--spacing-sm);
            border: 2px solid var(--color-border);
            background: var(--color-white);
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            color: var(--color-text-secondary);
            cursor: pointer;
            transition: var(--transition-base);
        }

        .page-button:hover:not(:disabled) {
            border-color: var(--color-primary);
            color: var(--color-primary-dark);
        }

        .page-button.active {
            background: var(--color-primary);
            border-color: var(--color-primary);
            color: white;
        }

        .page-button:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        /* 반응형 */
        @media (max-width: 1024px) {
            .management-container {
                padding: var(--spacing-lg) var(--spacing-md);
            }
        }

        @media (max-width: 768px) {
            .navbar-menu {
                display: none;
            }

            .main-page-title {
                font-size: 24px;
            }

            .filter-section {
                flex-direction: column;
                align-items: stretch;
            }

            .search-wrapper {
                max-width: 100%;
            }

            .content-table-container {
                overflow-x: auto;
            }

            .content-table {
                min-width: 800px;
            }

            .bulk-action-bar {
                flex-direction: column;
                gap: var(--spacing-md);
            }
        }
    </style>
    <script>
        let selectedItems = new Set();

        function toggleTab(tabName) {
            document.querySelectorAll('.nav-tab-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            
            event.target.classList.add('active');
            
            selectedItems.clear();
            updateSelectionCount();
            
            console.log('Tab switched to:', tabName);
        }

        function toggleSelectAll() {
            const selectAll = document.getElementById('selectAll');
            const checkboxes = document.querySelectorAll('.item-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
                if (selectAll.checked) {
                    selectedItems.add(checkbox.value);
                } else {
                    selectedItems.delete(checkbox.value);
                }
            });
            
            updateSelectionCount();
        }

        function toggleSelect(id) {
            if (selectedItems.has(id)) {
                selectedItems.delete(id);
            } else {
                selectedItems.add(id);
            }
            updateSelectionCount();
        }

        function updateSelectionCount() {
            document.getElementById('selectionCount').textContent = selectedItems.size;
            document.getElementById('bulkDeleteBtn').disabled = selectedItems.size === 0;
        }

        function deleteSingle(id, title) {
            if (confirm(`"${title}"을(를) 삭제하시겠습니까?\n\n이 작업은 되돌릴 수 없습니다.`)) {
                alert('삭제되었습니다.');
                location.reload();
            }
        }

        function bulkDelete() {
            if (selectedItems.size === 0) {
                alert('삭제할 항목을 선택해주세요.');
                return;
            }
            
            if (confirm(`선택한 ${selectedItems.size}개의 항목을 삭제하시겠습니까?\n\n이 작업은 되돌릴 수 없습니다.`)) {
                alert(`${selectedItems.size}개의 항목이 삭제되었습니다.`);
                selectedItems.clear();
                updateSelectionCount();
                location.reload();
            }
        }

        function searchContent() {
            const searchType = document.getElementById('searchType').value;
            const keyword = document.getElementById('searchKeyword').value;
            
            if (!keyword.trim()) {
                alert('검색어를 입력해주세요.');
                return;
            }
            
            console.log('Searching:', searchType, keyword);
        }

        function goBack() {
            window.history.back();
        }

        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('searchKeyword').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    searchContent();
                }
            });
        });
    </script>
</head>
<body>
    <!-- 상단 네비게이션 -->
    <nav class="navbar">
        <div class="navbar-inner">
            <a href="#" class="navbar-logo">
                <span class="logo-icon">🌱</span>
                <span class="logo-text">공모자들</span>
            </a>
            
            <div class="navbar-menu">
                <a href="?page=notice" class="menu-tab">
                    <span class="menu-icon">📢</span>
                    공지사항
                </a>
                <a href="?page=groups" class="menu-tab">
                    <span class="menu-icon">👥</span>
                    모임구경
                </a>
                <a href="?page=creategroup" class="menu-tab">
                    <span class="menu-icon">➕</span>
                    모임 개설
                </a>
                <a href="?page=mygroups" class="menu-tab active">
                    <span class="menu-icon">📚</span>
                    내 모임
                </a>
            </div>
            
            <div class="navbar-actions">
                <a href="mypage.jsp" class="profile-button">
                    <span class="profile-icon">👤</span>
                </a>
            </div>
        </div>
    </nav>

    <div class="management-container">
        <!-- 페이지 헤더 -->
        <div class="page-header-section">
            <div class="header-left-side">
                <button class="back-button" onclick="goBack()">←</button>
                <h1 class="main-page-title">게시물/댓글 관리</h1>
            </div>
        </div>

        <!-- 탭 네비게이션 -->
        <div class="tab-navigation">
            <button class="nav-tab-btn active" onclick="toggleTab('posts')">게시물</button>
        </div>

        <!-- 필터 바 -->
        <div class="filter-section">
            <select id="boardType" class="filter-dropdown">
                <option value="all">전체 게시판</option>
                <option value="notice">공지</option>
                <option value="activity">활동</option>
                <option value="question">질문</option>
                <option value="resource">자료</option>
                <option value="free">자유</option>
            </select>

            <select id="dateFilter" class="filter-dropdown">
                <option value="all">전체 기간</option>
                <option value="today">오늘</option>
                <option value="week">최근 1주일</option>
                <option value="month">최근 1개월</option>
                <option value="3months">최근 3개월</option>
            </select>

            <div class="search-wrapper">
                <select id="searchType" class="filter-dropdown">
                    <option value="title">제목</option>
                    <option value="author">작성자</option>
                    <option value="content">내용</option>
                </select>
                <input type="text" id="searchKeyword" class="search-field" placeholder="검색어를 입력하세요">
                <button class="search-button" onclick="searchContent()">
                    <span>🔍</span>
                    <span>검색</span>
                </button>
            </div>
        </div>

        <!-- 테이블 컨테이너 -->
        <div class="content-table-container">
            <!-- 일괄 작업 바 -->
            <div class="bulk-action-bar">
                <div class="selection-info">
                    선택된 항목: <span id="selectionCount" class="selection-count">0</span>개
                </div>
                <div class="bulk-actions">
                    <button id="bulkDeleteBtn" class="bulk-delete-btn" onclick="bulkDelete()" disabled>
                        선택 항목 삭제
                    </button>
                </div>
            </div>

            <!-- 테이블 -->
            <table class="content-table">
                <thead>
                    <tr>
                        <th style="width: 50px;">
                            <input type="checkbox" id="selectAll" class="select-checkbox" onchange="toggleSelectAll()">
                        </th>
                        <th style="width: 100px;">게시판</th>
                        <th>제목</th>
                        <th style="width: 120px;">작성자</th>
                        <th style="width: 120px;">작성일</th>
                        <th style="width: 100px;">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 게시물 1 -->
                    <tr>
                        <td>
                            <input type="checkbox" class="item-checkbox select-checkbox" value="1" onchange="toggleSelect('1')">
                        </td>
                        <td>
                            <span class="board-category-badge badge-activity">활동</span>
                        </td>
                        <td class="title-cell">
                            <a href="board_detail.jsp?id=1" class="post-link">
                                백준 1234번 풀이 공유합니다
                            </a>
                        </td>
                        <td>개발자지망생</td>
                        <td>2024-10-12</td>
                        <td>
                            <button class="action-button delete-single-btn" onclick="deleteSingle('1', '백준 1234번 풀이 공유합니다')">
                                삭제
                            </button>
                        </td>
                    </tr>

                    <!-- 게시물 2 -->
                    <tr>
                        <td>
                            <input type="checkbox" class="item-checkbox select-checkbox" value="2" onchange="toggleSelect('2')">
                        </td>
                        <td>
                            <span class="board-category-badge badge-question">질문</span>
                        </td>
                        <td class="title-cell">
                            <a href="board_detail.jsp?id=2" class="post-link">
                                DP 문제 접근 방법 질문드립니다
                            </a>
                        </td>
                        <td>알고리즘초보</td>
                        <td>2024-10-11</td>
                        <td>
                            <button class="action-button delete-single-btn" onclick="deleteSingle('2', 'DP 문제 접근 방법 질문드립니다')">
                                삭제
                            </button>
                        </td>
                    </tr>

                    <!-- 게시물 3 -->
                    <tr>
                        <td>
                            <input type="checkbox" class="item-checkbox select-checkbox" value="3" onchange="toggleSelect('3')">
                        </td>
                        <td>
                            <span class="board-category-badge badge-resource">자료</span>
                        </td>
                        <td class="title-cell">
                            <a href="board_detail.jsp?id=3" class="post-link">
                                유용한 알고리즘 사이트 모음
                            </a>
                        </td>
                        <td>코드러버</td>
                        <td>2024-10-10</td>
                        <td>
                            <button class="action-button delete-single-btn" onclick="deleteSingle('3', '유용한 알고리즘 사이트 모음')">
                                삭제
                            </button>
                        </td>
                    </tr>

                    <!-- 게시물 4 -->
                    <tr>
                        <td>
                            <input type="checkbox" class="item-checkbox select-checkbox" value="4" onchange="toggleSelect('4')">
                        </td>
                        <td>
                            <span class="board-category-badge badge-free">자유</span>
                        </td>
                        <td class="title-cell">
                            <a href="board_detail.jsp?id=4" class="post-link">
                                오늘 스터디 너무 재밌었어요!
                            </a>
                        </td>
                        <td>자바마스터</td>
                        <td>2024-10-10</td>
                        <td>
                            <button class="action-button delete-single-btn" onclick="deleteSingle('4', '오늘 스터디 너무 재밌었어요!')">
                                삭제
                            </button>
                        </td>
                    </tr>

                    <!-- 게시물 5 -->
                    <tr>
                        <td>
                            <input type="checkbox" class="item-checkbox select-checkbox" value="5" onchange="toggleSelect('5')">
                        </td>
                        <td>
                            <span class="board-category-badge badge-activity">활동</span>
                        </td>
                        <td class="title-cell">
                            <a href="board_detail.jsp?id=5" class="post-link">
                                프로그래머스 레벨 2 문제 풀이
                            </a>
                        </td>
                        <td>파이썬러버</td>
                        <td>2024-10-09</td>
                        <td>
                            <button class="action-button delete-single-btn" onclick="deleteSingle('5', '프로그래머스 레벨 2 문제 풀이')">
                                삭제
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- 페이지네이션 -->
            <div class="pagination-section">
                <button class="page-button" disabled>◀</button>
                <button class="page-button active">1</button>
                <button class="page-button">2</button>
                <button class="page-button">3</button>
                <button class="page-button">4</button>
                <button class="page-button">5</button>
                <button class="page-button">▶</button>
            </div>
        </div>
    </div>
</body>
</html>