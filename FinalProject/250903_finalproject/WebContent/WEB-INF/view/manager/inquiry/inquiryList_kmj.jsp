<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 문의 목록</title>
    <style>
        /* ================================================
           관리자 페이지 공통 스타일
        ================================================ */

        :root {
            --spacing-xs: 4px;
            --spacing-sm: 8px;
            --spacing-md: 16px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 48px;
            --radius-md: 8px;
            --radius-lg: 16px;
            --radius-full: 999px;
            --color-white: #fff;
            --color-primary: #5c6ac4;
            --color-primary-lighter: #dbe1f5;
            --color-primary-dark: #3c4aad;
            --color-secondary: #ffb74d;
            --color-secondary-lighter: #fff3e0;
            --color-secondary-dark: #ff9800;
            --color-accent: #ff4081;
            --color-accent-dark: #e0005a;
            --color-border: #e0e0e0;
            --color-border-light: #f0f0f0;
            --color-text-primary: #222;
            --color-text-secondary: #666;
            --transition-base: 0.2s ease-in-out;
            --transition-fast: 0.1s ease-in-out;
            --shadow-sm: 0 2px 6px rgba(0,0,0,0.08);
            --shadow-md: 0 4px 12px rgba(0,0,0,0.12);
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4efff;
            color: var(--color-text-primary);
        }

        .manager-container {
            max-width: 1600px;
            margin: 0 auto;
            padding: var(--spacing-2xl) var(--spacing-lg);
        }

        .manager-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-xl);
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
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
            color: var(--color-text-secondary);
            text-decoration: none;
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .back-btn:hover {
            background: var(--color-primary-lighter);
            border-color: var(--color-primary);
            color: var(--color-primary-dark);
        }

        .manager-page-title {
            font-size: 32px;
            font-weight: 800;
            margin: 0;
        }

        .filter-bar {
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

        .search-box {
            display: flex;
            gap: var(--spacing-sm);
            flex: 1;
            max-width: 400px;
        }

        .search-input {
            flex: 1;
            padding: 10px 14px;
            border: 2px solid var(--color-border);
            border-radius: var(--radius-md);
            font-size: 14px;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--color-primary);
        }

        .btn-search {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px 20px;
            background: var(--color-primary);
            color: var(--color-white);
            border: none;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .btn-search:hover {
            background: var(--color-primary-dark);
        }

        .filter-select {
            padding: 10px 14px;
            border: 2px solid var(--color-border);
            border-radius: var(--radius-md);
            font-size: 14px;
            background: var(--color-white);
            cursor: pointer;
            transition: all var(--transition-fast);
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--color-primary);
        }

        .table-container {
            background: var(--color-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
            margin-bottom: var(--spacing-lg);
        }

        .manager-table {
            width: 100%;
            border-collapse: collapse;
        }

        .manager-table thead {
            background: var(--color-primary-lighter);
        }

        .manager-table th, .manager-table td {
            padding: var(--spacing-md) var(--spacing-lg);
            font-size: 14px;
            text-align: left;
        }

        .manager-table th {
            font-weight: 700;
            color: var(--color-primary-dark);
            border-bottom: 2px solid var(--color-primary);
        }

        .manager-table tbody tr {
            border-bottom: 1px solid var(--color-border-light);
            transition: all var(--transition-base);
            cursor: pointer;
        }

        .manager-table tbody tr:hover {
            background: var(--color-primary-lighter);
        }

        .status-badge, .type-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: var(--radius-full);
            font-size: 12px;
            font-weight: 700;
        }

        .status-pending { background: var(--color-secondary-lighter); color: var(--color-secondary-dark); }
        .status-answered { background: var(--color-primary-lighter); color: var(--color-primary-dark); }
        .type-content { background: var(--color-secondary-lighter); color: var(--color-secondary-dark); }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: var(--spacing-sm);
            padding: var(--spacing-lg);
        }

        .page-btn {
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
            transition: all var(--transition-base);
        }

        .page-btn:hover:not(:disabled) {
            border-color: var(--color-primary);
            color: var(--color-primary-dark);
        }

        .page-btn.active {
            background: var(--color-primary);
            border-color: var(--color-primary);
            color: white;
        }

        @media (max-width: 1024px) {
            .manager-container { padding: var(--spacing-lg) var(--spacing-md); }
        }

        @media (max-width: 768px) {
            .manager-header { flex-direction: column; align-items: flex-start; }
            .manager-page-title { font-size: 24px; }
            .filter-bar { flex-direction: column; align-items: stretch; }
            .search-box { max-width: 100%; }
            .table-container { overflow-x: auto; }
            .manager-table { min-width: 600px; }
        }
    </style>
</head>
<body>
    <div class="manager-container">
        <!-- 페이지 헤더 -->
        <div class="manager-header">
            <div class="header-left">
                <a href="<%= cp %>/adminDashboard.jsp" class="back-btn">←</a>
                <h1 class="manager-page-title">관리자 문의 목록</h1>
            </div>
        </div>

        <!-- 필터 & 검색 바 -->
        <div class="filter-bar">
            <div class="search-box">
                <input type="text" id="searchUserId" class="search-input" placeholder="회원 아이디 검색">
                <button class="btn-search" onclick="searchInquiries()">검색</button>
            </div>
            <select id="statusFilter" class="filter-select">
                <option value="">전체</option>
                <option value="waiting">답변대기</option>
                <option value="answered">답변완료</option>
            </select>
            <select id="typeFilter" class="filter-select">
                <option value="">전체</option>
                <option value="service">서비스 이용</option>
                <option value="payment">결제/환불</option>
                <option value="tech">기술 지원</option>
                <option value="etc">기타</option>
            </select>
        </div>

        <!-- 문의 테이블 -->
        <div class="table-container">
            <table class="manager-table">
                <thead>
                    <tr>
                        <th>문의번호</th>
                        <th>문의 유형</th>
                        <th>제목</th>
                        <th>접수자 아이디</th>
                        <th>접수 일자</th>
                        <th>답변 상태</th>
                        <th>답변 수</th>
                    </tr>
                </thead>
                <tbody>
                    <tr onclick="location.href='inquiryDetail.jsp?id=INQ003'">
                        <td>INQ003</td>
                        <td><span class="type-badge type-content">결제/환불</span></td>
                        <td>결제 내역을 확인하고 싶습니다</td>
                        <td><a href="memberDetail.jsp?id=user006" onclick="event.stopPropagation()">user006</a></td>
                        <td>2024-09-25</td>
                        <td><span class="status-badge status-answered">답변완료</span></td>
                        <td>3</td>
                    </tr>
                    <tr onclick="location.href='inquiryDetail.jsp?id=INQ002'">
                        <td>INQ002</td>
                        <td><span class="type-badge type-content">기술 지원</span></td>
                        <td>모바일 앱에서 알림이 오지 않습니다</td>
                        <td><a href="memberDetail.jsp?id=user007" onclick="event.stopPropagation()">user007</a></td>
                        <td>2024-09-20</td>
                        <td><span class="status-badge status-pending">답변대기</span></td>
                        <td>0</td>
                    </tr>
                    <tr onclick="location.href='inquiryDetail.jsp?id=INQ001'">
                        <td>INQ001</td>
                        <td><span class="type-badge type-content">서비스 이용</span></td>
                        <td>회원 탈퇴는 어떻게 하나요?</td>
                        <td><a href="memberDetail.jsp?id=user008" onclick="event.stopPropagation()">user008</a></td>
                        <td>2024-09-15</td>
                        <td><span class="status-badge status-answered">답변완료</span></td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
            <button class="page-btn">→</button>
        </div>
    </div>

    <script>
        function searchInquiries() {
            var userId = document.getElementById('searchUserId').value;
            var status = document.getElementById('statusFilter').value;
            var type = document.getElementById('typeFilter').value;

            console.log('검색 조건:', { userId, status, type });
            alert('검색 기능은 서버 연동 후 작동합니다.');
        }
    </script>
</body>
</html>
