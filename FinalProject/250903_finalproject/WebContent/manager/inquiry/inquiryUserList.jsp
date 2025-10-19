<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
    String userId = "user004";  // 예시용 (세션에서 가져올 값)
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 문의 목록</title>
    <style>
        :root {
            --spacing-xs: 4px;
            --spacing-sm: 8px;
            --spacing-md: 16px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
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
            --shadow-sm: 0 2px 6px rgba(0,0,0,0.08);
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4efff;
            color: var(--color-text-primary);
        }

        .user-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: var(--spacing-2xl) var(--spacing-lg);
        }

        .user-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: var(--spacing-md);
            margin-bottom: var(--spacing-xl);
        }

        .page-title {
            font-size: 28px;
            font-weight: 800;
            margin: 0;
        }

        .btn-inquiry {
            background: var(--color-primary);
            color: white;
            padding: 10px 20px;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            transition: all var(--transition-base);
        }

        .btn-inquiry:hover {
            background: var(--color-primary-dark);
            transform: translateY(-1px);
        }

        .table-container {
            background: var(--color-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: var(--color-primary-lighter);
        }

        th, td {
            padding: var(--spacing-md) var(--spacing-lg);
            font-size: 14px;
            text-align: left;
        }

        th {
            font-weight: 700;
            color: var(--color-primary-dark);
            border-bottom: 2px solid var(--color-primary);
        }

        tbody tr {
            border-bottom: 1px solid var(--color-border-light);
            transition: all var(--transition-base);
            cursor: pointer;
        }

        tbody tr:hover {
            background: var(--color-primary-lighter);
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 12px;
            border-radius: var(--radius-full);
            font-size: 12px;
            font-weight: 700;
        }

        .status-pending { background: var(--color-secondary-lighter); color: var(--color-secondary-dark); }
        .status-answered { background: var(--color-primary-lighter); color: var(--color-primary-dark); }

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

        .page-btn.active {
            background: var(--color-primary);
            border-color: var(--color-primary);
            color: white;
        }

        .page-btn:hover:not(.active) {
            border-color: var(--color-primary);
            color: var(--color-primary-dark);
        }

        @media (max-width: 768px) {
            .page-title { font-size: 22px; }
            table { min-width: 700px; }
            .table-container { overflow-x: auto; }
        }
        .user-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: var(--spacing-2xl) var(--spacing-lg);
    padding-top: 80px; /* ✅ 추가: 페이지 상단 여백 */
}
    </style>
</head>
<body>
    <div class="user-container">
        <div class="user-header">
            <h1 class="page-title">문의 내역</h1>
            <a href="<%= cp %>/userInquiryForm.jsp" class="btn-inquiry">＋ 문의 등록</a>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>문의번호</th>
                        <th>문의 유형</th>
                        <th>제목</th>
                        <th>등록일</th>
                        <th>답변 상태</th>
                        <th>답변 수</th>
                    </tr>
                </thead>
                <tbody>
                    <tr onclick="location.href='userInquiryDetail.jsp?id=INQ010'">
                        <td>INQ010</td>
                        <td>결제/환불</td>
                        <td>결제 취소 요청드립니다</td>
                        <td>2024-10-12</td>
                        <td><span class="status-badge status-answered">답변완료</span></td>
                        <td>2</td>
                    </tr>
                    <tr onclick="location.href='userInquiryDetail.jsp?id=INQ009'">
                        <td>INQ009</td>
                        <td>서비스 이용</td>
                        <td>모임 가입이 안 됩니다</td>
                        <td>2024-10-08</td>
                        <td><span class="status-badge status-pending">답변대기</span></td>
                        <td>0</td>
                    </tr>
                    <tr onclick="location.href='userInquiryDetail.jsp?id=INQ008'">
                        <td>INQ008</td>
                        <td>기타</td>
                        <td>닉네임 변경은 어디서 하나요?</td>
                        <td>2024-09-28</td>
                        <td><span class="status-badge status-answered">답변완료</span></td>
                        <td>1</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
            <button class="page-btn">→</button>
        </div>
    </div>
</body>
</html>
