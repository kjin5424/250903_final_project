<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 신고 관리</title>
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
            max-width: 1600px;
            margin: 0 auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        /* 탭 메뉴 */
        .tab-menu {
            display: flex;
            gap: 5px;
            margin-bottom: 25px;
            border-bottom: 2px solid #E6D6FF;
        }

        .tab-button {
            padding: 12px 24px;
            background-color: transparent;
            border: none;
            border-bottom: 3px solid transparent;
            cursor: pointer;
            font-size: 15px;
            font-weight: bold;
            transition: all 0.3s;
        }

        .tab-button:hover {
            background-color: #F0E8FF;
        }

        .tab-button.active {
            border-bottom-color: #BFFCC6;
            background-color: #F0E8FF;
        }

        /* 탭 컨텐츠 */
        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* 검색 필터 */
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
            width: 180px;
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

        /* 결과 카운트 */
        .result-count {
            margin-bottom: 15px;
            font-size: 14px;
            color: #666;
        }

        .count-number {
            color: #1976D2;
            font-weight: bold;
        }

        /* 테이블 */
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

        /* 링크 */
        .link-text {
            color: #1976D2;
            text-decoration: none;
            font-weight: 500;
        }

        .link-text:hover {
            text-decoration: underline;
        }

        /* 신고 구분 뱃지 */
        .report-type {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .type-member {
            background-color: #E3F2FD;
            color: #1565C0;
        }

        .type-content {
            background-color: #F3E5F5;
            color: #6A1B9A;
        }

        .type-meeting {
            background-color: #FFF3E0;
            color: #E65100;
        }

        /* 상태 뱃지 */
        .status-badge {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-received {
            background-color: #E3F2FD;
            color: #1976D2;
        }

        .status-processing {
            background-color: #FFF4E6;
            color: #E65100;
        }

        .status-blind {
            background-color: #FCE4EC;
            color: #C2185B;
        }

        .status-closed {
            background-color: #E8F5E9;
            color: #2E7D32;
        }

        .status-rejected {
            background-color: #F5F5F5;
            color: #757575;
        }

        .status-appeal {
            background-color: #FFF9C4;
            color: #F57F17;
        }

        /* 카테고리 */
        .category-text {
            font-size: 12px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="header">관리자 신고 관리</div>
    <div class="container">
        <!-- 탭 메뉴 -->
        <div class="tab-menu">
            <button class="tab-button active" onclick="showTab('report')">일반 신고</button>
            <button class="tab-button" onclick="showTab('appeal')">소명 신청</button>
        </div>

        <!-- 탭 1: 일반 신고 -->
        <div id="report-tab" class="tab-content active">
            <div class="search-filter">
                <label>신고 구분</label>
                <select id="reportType">
                    <option value="">전체</option>
                    <option value="member">회원</option>
                    <option value="content">컨텐츠</option>
                    <option value="meeting">모임</option>
                </select>
                
                <label>처리 상태</label>
                <select id="statusFilter">
                    <option value="">전체</option>
                    <option value="received">접수</option>
                    <option value="processing">처리중</option>
                    <option value="blind">블라인드</option>
                    <option value="closed">종결</option>
                    <option value="rejected">기각</option>
                </select>

                <label>접수자</label>
                <input type="text" id="reporterId" placeholder="접수자 아이디">

                <label>피신고 대상</label>
                <input type="text" id="targetId" placeholder="대상 아이디/코드">
                
                <button class="button" onclick="searchReports()">검색</button>
            </div>

            <div class="result-count">
                검색 결과: 총 <span class="count-number">12</span>건
            </div>

            <table>
                <thead>
                    <tr>
                        <th>신고번호</th>
                        <th>신고 구분</th>
                        <th>신고 카테고리</th>
                        <th>접수자</th>
                        <th>피신고 대상</th>
                        <th>신고 일자</th>
                        <th>처리 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT012'">
                        <td>RPT012</td>
                        <td><span class="report-type type-member">회원</span></td>
                        <td class="category-text">욕설/비방/모욕/괴롭힘</td>
                        <td><a href="memberDetail.jsp?id=user010" class="link-text" onclick="event.stopPropagation()">user010</a></td>
                        <td><a href="memberDetail.jsp?id=user015" class="link-text" onclick="event.stopPropagation()">user015</a></td>
                        <td>2024-10-03</td>
                        <td><span class="status-badge status-processing">처리중</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT011'">
                        <td>RPT011</td>
                        <td><span class="report-type type-content">컨텐츠</span></td>
                        <td class="category-text">광고/홍보/스팸</td>
                        <td><a href="memberDetail.jsp?id=user008" class="link-text" onclick="event.stopPropagation()">user008</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">게시글 #1234</a></td>
                        <td>2024-10-03</td>
                        <td><span class="status-badge status-blind">블라인드</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT010'">
                        <td>RPT010</td>
                        <td><span class="report-type type-meeting">모임</span></td>
                        <td class="category-text">광고성 모임</td>
                        <td><a href="memberDetail.jsp?id=user007" class="link-text" onclick="event.stopPropagation()">user007</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">M005 (투자 모임)</a></td>
                        <td>2024-10-02</td>
                        <td><span class="status-badge status-received">접수</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT009'">
                        <td>RPT009</td>
                        <td><span class="report-type type-content">컨텐츠</span></td>
                        <td class="category-text">부적절한 프로필 사진</td>
                        <td><a href="memberDetail.jsp?id=user006" class="link-text" onclick="event.stopPropagation()">user006</a></td>
                        <td><a href="memberDetail.jsp?id=user020" class="link-text" onclick="event.stopPropagation()">user020</a></td>
                        <td>2024-10-02</td>
                        <td><span class="status-badge status-processing">처리중</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT008'">
                        <td>RPT008</td>
                        <td><span class="report-type type-member">회원</span></td>
                        <td class="category-text">성희롱/불쾌한 언행</td>
                        <td><a href="memberDetail.jsp?id=user005" class="link-text" onclick="event.stopPropagation()">user005</a></td>
                        <td><a href="memberDetail.jsp?id=user018" class="link-text" onclick="event.stopPropagation()">user018</a></td>
                        <td>2024-10-01</td>
                        <td><span class="status-badge status-closed">종결</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT007'">
                        <td>RPT007</td>
                        <td><span class="report-type type-content">컨텐츠</span></td>
                        <td class="category-text">타인 비방/명예 훼손</td>
                        <td><a href="memberDetail.jsp?id=user004" class="link-text" onclick="event.stopPropagation()">user004</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">게시글 #1189</a></td>
                        <td>2024-09-30</td>
                        <td><span class="status-badge status-blind">블라인드</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT006'">
                        <td>RPT006</td>
                        <td><span class="report-type type-meeting">모임</span></td>
                        <td class="category-text">회원 의견 무시한 운영</td>
                        <td><a href="memberDetail.jsp?id=user003" class="link-text" onclick="event.stopPropagation()">user003</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">M003 (독서 모임)</a></td>
                        <td>2024-09-28</td>
                        <td><span class="status-badge status-closed">종결</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT005'">
                        <td>RPT005</td>
                        <td><span class="report-type type-content">컨텐츠</span></td>
                        <td class="category-text">음란성/선정적 내용</td>
                        <td><a href="memberDetail.jsp?id=user002" class="link-text" onclick="event.stopPropagation()">user002</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">게시글 #1156</a></td>
                        <td>2024-09-25</td>
                        <td><span class="status-badge status-rejected">기각</span></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 탭 2: 소명 신청 -->
        <div id="appeal-tab" class="tab-content">
            <div class="search-filter">
                <label>신고 구분</label>
                <select id="appealType">
                    <option value="">전체</option>
                    <option value="member">회원</option>
                    <option value="content">컨텐츠</option>
                    <option value="meeting">모임</option>
                </select>

                <label>소명 상태</label>
                <select id="appealStatus">
                    <option value="">전체</option>
                    <option value="pending">승인대기</option>
                    <option value="approved">승인</option>
                    <option value="rejected">반려</option>
                </select>

                <label>신청자</label>
                <input type="text" id="appealerId" placeholder="신청자 아이디">
                
                <button class="button" onclick="searchAppeals()">검색</button>
            </div>

            <div class="result-count">
                검색 결과: 총 <span class="count-number">5</span>건
            </div>

            <table>
                <thead>
                    <tr>
                        <th>소명번호</th>
                        <th>원 신고번호</th>
                        <th>신고 구분</th>
                        <th>신고 카테고리</th>
                        <th>신청자</th>
                        <th>신청 일자</th>
                        <th>소명 상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr onclick="location.href='appealManage.jsp?id=APL005'">
                        <td>APL005</td>
                        <td><a href="reportDetail.jsp?id=RPT011" class="link-text" onclick="event.stopPropagation()">RPT011</a></td>
                        <td><span class="report-type type-content">컨텐츠</span></td>
                        <td class="category-text">광고/홍보/스팸</td>
                        <td><a href="memberDetail.jsp?id=user022" class="link-text" onclick="event.stopPropagation()">user022</a></td>
                        <td>2024-10-03</td>
                        <td><span class="status-badge status-appeal">승인대기</span></td>
                    </tr>
                    <tr onclick="location.href='appealManage.jsp?id=APL004'">
                        <td>APL004</td>
                        <td><a href="reportDetail.jsp?id=RPT008" class="link-text" onclick="event.stopPropagation()">RPT008</a></td>
                        <td><span class="report-type type-member">회원</span></td>
                        <td class="category-text">성희롱/불쾌한 언행</td>
                        <td><a href="memberDetail.jsp?id=user018" class="link-text" onclick="event.stopPropagation()">user018</a></td>
                        <td>2024-10-02</td>
                        <td><span class="status-badge status-appeal">승인대기</span></td>
                    </tr>
                    <tr onclick="location.href='appealManage.jsp?id=APL003'">
                        <td>APL003</td>
                        <td><a href="reportDetail.jsp?id=RPT007" class="link-text" onclick="event.stopPropagation()">RPT007</a></td>
                        <td><span class="report-type type-content">컨텐츠</span></td>
                        <td class="category-text">타인 비방/명예 훼손</td>
                        <td><a href="memberDetail.jsp?id=user019" class="link-text" onclick="event.stopPropagation()">user019</a></td>
                        <td>2024-10-01</td>
                        <td><span class="status-badge status-closed">승인</span></td>
                    </tr>
                    <tr onclick="location.href='appealManage.jsp?id=APL002'">
                        <td>APL002</td>
                        <td><a href="reportDetail.jsp?id=RPT004" class="link-text" onclick="event.stopPropagation()">RPT004</a></td>
                        <td><span class="report-type type-member">회원</span></td>
                        <td class="category-text">욕설/비방/모욕/괴롭힘</td>
                        <td><a href="memberDetail.jsp?id=user016" class="link-text" onclick="event.stopPropagation()">user016</a></td>
                        <td>2024-09-28</td>
                        <td><span class="status-badge status-rejected">반려</span></td>
                    </tr>
                    <tr onclick="location.href='appealManage.jsp?id=APL001'">
                        <td>APL001</td>
                        <td><a href="reportDetail.jsp?id=RPT003" class="link-text" onclick="event.stopPropagation()">RPT003</a></td>
                        <td><span class="report-type type-content">컨텐츠</span></td>
                        <td class="category-text">거짓 정보/허위 사실 유포</td>
                        <td><a href="memberDetail.jsp?id=user014" class="link-text" onclick="event.stopPropagation()">user014</a></td>
                        <td>2024-09-25</td>
                        <td><span class="status-badge status-appeal">승인대기</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function showTab(tabName) {
            // 모든 탭 버튼의 active 클래스 제거
            var buttons = document.querySelectorAll('.tab-button');
            buttons.forEach(function(btn) {
                btn.classList.remove('active');
            });

            // 모든 탭 컨텐츠 숨김
            var contents = document.querySelectorAll('.tab-content');
            contents.forEach(function(content) {
                content.classList.remove('active');
            });

            // 선택된 탭 활성화
            event.target.classList.add('active');
            document.getElementById(tabName + '-tab').classList.add('active');
        }

        function searchReports() {
            var reportType = document.getElementById('reportType').value;
            var status = document.getElementById('statusFilter').value;
            var reporterId = document.getElementById('reporterId').value;
            var targetId = document.getElementById('targetId').value;
            
            console.log('검색 조건:', {
                reportType: reportType,
                status: status,
                reporterId: reporterId,
                targetId: targetId
            });
            
            alert('검색 기능은 서버 연동 후 작동합니다.');
        }

        function searchAppeals() {
            var appealType = document.getElementById('appealType').value;
            var appealStatus = document.getElementById('appealStatus').value;
            var appealerId = document.getElementById('appealerId').value;
            
            console.log('검색 조건:', {
                appealType: appealType,
                appealStatus: appealStatus,
                appealerId: appealerId
            });
            
            alert('검색 기능은 서버 연동 후 작동합니다.');
        }
    </script>
</body>
</html>