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
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #E9D9FF;
            padding: 40px 30px;
        }

        .header {
            background-color: #BFFCC6;
            padding: 20px;
            border-radius: 15px;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .container {
            background-color: #fff;
            padding: 25px;
            border-radius: 20px;
            max-width: 1400px;
            margin: 0 auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        .search-filter {
            margin-bottom: 25px;
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-filter label {
            font-weight: bold;
            margin-right: 5px;
        }

        input, select {
            padding: 8px 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .search-filter input {
            width: 200px;
        }

        .button {
            padding: 8px 16px;
            background-color: #BFFCC6;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
        }

        .button:hover {
            background-color: #A8EBB0;
        }

        .result-count {
            margin-bottom: 15px;
            font-size: 14px;
            color: #666;
        }

        .count-number {
            color: #1976D2;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
            border-radius: 10px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #BFFCC6;
            font-weight: bold;
            color: #333;
        }

        tbody tr:nth-child(odd) {
            background-color: #E6D6FF;
        }

        tbody tr:nth-child(even) {
            background-color: #F0E8FF;
        }

        tbody tr {
            cursor: pointer;
        }

        tbody tr:hover {
            background-color: #D5C5EE;
        }

        .title-cell {
            text-align: left;
            max-width: 400px;
        }

        .title-text {
            color: #333;
            text-decoration: none;
            display: block;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .title-text:hover {
            color: #1976D2;
            text-decoration: underline;
        }

        /* 상태 뱃지 */
        .status-badge {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-waiting {
            background-color: #FFF4E6;
            color: #E65100;
        }

        .status-answered {
            background-color: #E8F5E9;
            color: #2E7D32;
        }

        /* 회원 ID 링크 */
        .user-link {
            color: #1976D2;
            text-decoration: none;
            font-weight: 500;
        }

        .user-link:hover {
            text-decoration: underline;
        }

        /* 문의 유형 */
        .inquiry-type {
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: bold;
            background-color: #E1F5FE;
            color: #01579B;
            display: inline-block;
        }
    </style>
</head>
<body>
    <div class="header">관리자 문의 관리</div>
    <div class="container">
        <div class="search-filter">
            <label>접수자 아이디</label>
            <input type="text" id="searchUserId" placeholder="회원 아이디 검색">
            
            <label>답변 상태</label>
            <select id="statusFilter">
                <option value="">전체</option>
                <option value="waiting">답변대기</option>
                <option value="answered">답변완료</option>
            </select>

            <label>문의 유형</label>
            <select id="typeFilter">
                <option value="">전체</option>
                <option value="service">서비스 이용</option>
                <option value="payment">결제/환불</option>
                <option value="tech">기술 지원</option>
                <option value="etc">기타</option>
            </select>
            
            <button class="button" onclick="searchInquiries()">검색</button>
        </div>

        <div class="result-count">
            검색 결과: 총 <span class="count-number">8</span>건
        </div>

        <table>
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
                    <td><span class="inquiry-type">결제/환불</span></td>
                    <td class="title-cell">
                        <span class="title-text">결제 내역을 확인하고 싶습니다</span>
                    </td>
                    <td>
                        <a href="memberDetail.jsp?id=user006" class="user-link" onclick="event.stopPropagation()">user006</a>
                    </td>
                    <td>2024-09-25</td>
                    <td><span class="status-badge status-answered">답변완료</span></td>
                    <td>3</td>
                </tr>
                <tr onclick="location.href='inquiryDetail.jsp?id=INQ002'">
                    <td>INQ002</td>
                    <td><span class="inquiry-type">기술 지원</span></td>
                    <td class="title-cell">
                        <span class="title-text">모바일 앱에서 알림이 오지 않습니다</span>
                    </td>
                    <td>
                        <a href="memberDetail.jsp?id=user007" class="user-link" onclick="event.stopPropagation()">user007</a>
                    </td>
                    <td>2024-09-20</td>
                    <td><span class="status-badge status-waiting">답변대기</span></td>
                    <td>0</td>
                </tr>
                <tr onclick="location.href='inquiryDetail.jsp?id=INQ001'">
                    <td>INQ001</td>
                    <td><span class="inquiry-type">서비스 이용</span></td>
                    <td class="title-cell">
                        <span class="title-text">회원 탈퇴는 어떻게 하나요?</span>
                    </td>
                    <td>
                        <a href="memberDetail.jsp?id=user008" class="user-link" onclick="event.stopPropagation()">user008</a>
                    </td>
                    <td>2024-09-15</td>
                    <td><span class="status-badge status-answered">답변완료</span></td>
                    <td>1</td>
                </tr>
            </tbody>
        </table>
    </div>

    <script>
        function searchInquiries() {
            var userId = document.getElementById('searchUserId').value;
            var status = document.getElementById('statusFilter').value;
            var type = document.getElementById('typeFilter').value;
            
            // 실제로는 서버에 요청을 보내야 합니다
            console.log('검색 조건:', {
                userId: userId,
                status: status,
                type: type
            });
            
            alert('검색 기능은 서버 연동 후 작동합니다.');
        }
    </script>
</body>
</html>