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
/* 공통 스타일 */
:root {
    --color-primary: #B388FF;
    --color-primary-dark: #7E57C2;
    --color-primary-lighter: #EDE7F6;
    --color-secondary: #81C784;
    --color-secondary-dark: #388E3C;
    --color-secondary-lighter: #E8F5E9;
    --color-border-light: #eee;
    --color-white: #fff;
    --radius-md: 8px;
    --radius-lg: 14px;
    --radius-full: 999px;
    --shadow-sm: 0 2px 6px rgba(0,0,0,0.05);
    --shadow-md: 0 4px 12px rgba(0,0,0,0.1);
}

/* 컨테이너 */
.manager-container {
    max-width: 1600px;
    margin: 0 auto;
    padding: 32px;
    font-family: 'Noto Sans KR', sans-serif;
    background: var(--color-white);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
}

/* 페이지 헤더 */
.manager-header { margin-bottom: 32px; }
.manager-page-title { font-size: 28px; font-weight: 800; color: var(--color-primary-dark); }

/* 탭 */
.tab-menu { display: flex; gap: 8px; border-bottom: 2px solid var(--color-border-light); margin-bottom: 20px; }
.tab-button {
    padding: 12px 24px; border: none; background: var(--color-white); cursor: pointer; font-weight: 700;
    border-bottom: 3px solid transparent; border-radius: var(--radius-md) var(--radius-md) 0 0; transition: 0.3s;
}
.tab-button.active { border-bottom: 3px solid var(--color-primary); color: var(--color-primary-dark); background: var(--color-primary-lighter); }

/* 필터 */
.filter-bar { display: flex; flex-wrap: wrap; align-items: center; gap: 8px; padding: 12px 20px; background: var(--color-white); border-radius: var(--radius-lg); box-shadow: var(--shadow-sm); margin-bottom: 12px; }
.filter-bar label { font-weight: 600; margin-right: 4px; }
.filter-bar select, .filter-bar input { border: 2px solid var(--color-border-light); border-radius: var(--radius-md); padding: 8px 12px; font-size: 14px; }
.filter-bar button { padding: 8px 20px; border: none; border-radius: var(--radius-md); background: var(--color-secondary); color: var(--color-white); font-weight: 700; cursor: pointer; }
.filter-bar button:hover { background: var(--color-secondary-dark); }

/* 테이블 */
.table-container { background: var(--color-white); border-radius: var(--radius-lg); box-shadow: var(--shadow-sm); overflow: hidden; }
.manager-table { width: 100%; border-collapse: collapse; }
.manager-table thead { background: var(--color-primary-lighter); }
.manager-table th, .manager-table td { padding: 12px 16px; text-align: center; border-bottom: 1px solid var(--color-border-light); font-size: 14px; }
.manager-table tbody tr:hover { background: #f5f0ff; cursor: pointer; }

/* 배지 */
.status-badge, .report-type { display: inline-block; padding: 4px 10px; border-radius: var(--radius-full); font-size: 12px; font-weight: 700; }
.status-processing { background: #FFF3E0; color: #E65100; }
.status-closed { background: #E8F5E9; color: #2E7D32; }
.status-blind { background: #FCE4EC; color: #AD1457; }
.status-rejected { background: #E0E0E0; color: #555; }
.status-received { background: #E3F2FD; color: #1976D2; }
.status-appeal { background: #FFF9C4; color: #F57F17; }
.type-member { background: #E3F2FD; color: #1565C0; }
.type-content { background: #F3E5F5; color: #6A1B9A; }
.type-meeting { background: #FFF3E0; color: #E65100; }

/* 링크 */
.link-text { color: var(--color-primary-dark); text-decoration: none; font-weight: 600; }
.link-text:hover { text-decoration: underline; }

/* 탭 컨텐츠 */
.tab-content { display: none; }
.tab-content.active { display: block; }
</style>
</head>
<body>
<div class="manager-container">
    <div class="manager-header">
        <h1 class="manager-page-title">관리자 신고 관리</h1>
    </div>

    <div class="tab-menu">
        <button class="tab-button active" onclick="showTab('report')">일반 신고</button>
        <button class="tab-button" onclick="showTab('appeal')">소명 신청</button>
    </div>

    <!-- 일반 신고 -->
    <div id="report-tab" class="tab-content active">
        <div class="filter-bar">
            <label>신고 구분</label>
            <select id="reportType">
                <option value="">전체</option><option value="member">회원</option><option value="content">컨텐츠</option><option value="meeting">모임</option>
            </select>
            <label>처리 상태</label>
            <select id="statusFilter">
                <option value="">전체</option><option value="received">접수</option><option value="processing">처리중</option><option value="blind">블라인드</option><option value="closed">종결</option><option value="rejected">기각</option>
            </select>
            <label>접수자</label><input type="text" id="reporterId" placeholder="접수자 ID">
            <label>피신고 대상</label><input type="text" id="targetId" placeholder="대상 ID">
            <button onclick="searchReports()">검색</button>
        </div>

        <div class="table-container">
            <table class="manager-table">
                <thead>
                    <tr><th>신고번호</th><th>신고 구분</th><th>카테고리</th><th>접수자</th><th>피신고 대상</th><th>신고일자</th><th>상태</th></tr>
                </thead>
                <tbody>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT012'">
                        <td>RPT012</td><td><span class="report-type type-member">회원</span></td>
                        <td>욕설/비방/모욕/괴롭힘</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">user010</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">user015</a></td>
                        <td>2024-10-03</td><td><span class="status-badge status-processing">처리중</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT011'">
                        <td>RPT011</td><td><span class="report-type type-content">컨텐츠</span></td>
                        <td>광고/홍보/스팸</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">user008</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">게시글 #1234</a></td>
                        <td>2024-10-03</td><td><span class="status-badge status-blind">블라인드</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT010'">
                        <td>RPT010</td><td><span class="report-type type-meeting">모임</span></td>
                        <td>광고성 모임</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">user007</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">M005 (투자 모임)</a></td>
                        <td>2024-10-02</td><td><span class="status-badge status-received">접수</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT009'">
                        <td>RPT009</td><td><span class="report-type type-content">컨텐츠</span></td>
                        <td>부적절한 프로필 사진</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">user006</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">user020</a></td>
                        <td>2024-10-02</td><td><span class="status-badge status-processing">처리중</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT008'">
                        <td>RPT008</td><td><span class="report-type type-member">회원</span></td>
                        <td>성희롱/불쾌한 언행</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">user005</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">user018</a></td>
                        <td>2024-10-01</td><td><span class="status-badge status-closed">종결</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT007'">
                        <td>RPT007</td><td><span class="report-type type-content">컨텐츠</span></td>
                        <td>타인 비방/명예 훼손</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">user004</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">게시글 #1189</a></td>
                        <td>2024-09-30</td><td><span class="status-badge status-blind">블라인드</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT006'">
                        <td>RPT006</td><td><span class="report-type type-meeting">모임</span></td>
                        <td>회원 의견 무시한 운영</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">user003</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">M003 (독서 모임)</a></td>
                        <td>2024-09-28</td><td><span class="status-badge status-closed">종결</span></td>
                    </tr>
                    <tr onclick="location.href='reportDetail.jsp?id=RPT005'">
                        <td>RPT005</td><td><span class="report-type type-content">컨텐츠</span></td>
                        <td>음란성/선정적 내용</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">user002</a></td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">게시글 #1156</a></td>
                        <td>2024-09-25</td><td><span class="status-badge status-rejected">기각</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- 소명 신청 -->
    <div id="appeal-tab" class="tab-content">
        <div class="filter-bar">
            <label>신고 구분</label>
            <select id="appealType">
                <option value="">전체</option><option value="member">회원</option><option value="content">컨텐츠</option><option value="meeting">모임</option>
            </select>
            <label>소명 상태</label>
            <select id="appealStatus">
                <option value="">전체</option><option value="pending">승인대기</option><option value="approved">승인</option><option value="rejected">반려</option>
            </select>
            <label>신청자</label><input type="text" id="appealerId" placeholder="신청자 ID">
            <button onclick="searchAppeals()">검색</button>
        </div>

        <div class="table-container">
            <table class="manager-table">
                <thead>
                    <tr><th>소명번호</th><th>신고번호</th><th>구분</th><th>카테고리</th><th>신청자</th><th>일자</th><th>상태</th></tr>
                </thead>
                <tbody>
                    <tr onclick="location.href='appealManage.jsp?id=APL005'">
                        <td>APL005</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">RPT011</a></td>
                        <td><span class="report-type type-content">컨텐츠</span></td><td>광고/홍보/스팸</td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">user022</a></td>
                        <td>2024-10-03</td><td><span class="status-badge status-appeal">승인대기</span></td>
                    </tr>
                    <tr onclick="location.href='appealManage.jsp?id=APL004'">
                        <td>APL004</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">RPT008</a></td>
                        <td><span class="report-type type-member">회원</span></td><td>성희롱/불쾌한 언행</td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">user018</a></td>
                        <td>2024-10-02</td><td><span class="status-badge status-appeal">승인대기</span></td>
                    </tr>
                    <tr onclick="location.href='appealManage.jsp?id=APL003'">
                        <td>APL003</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">RPT007</a></td>
                        <td><span class="report-type type-content">컨텐츠</span></td><td>타인 비방/명예 훼손</td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">user019</a></td>
                        <td>2024-10-01</td><td><span class="status-badge status-closed">승인</span></td>
                    </tr>
                    <tr onclick="location.href='appealManage.jsp?id=APL002'">
                        <td>APL002</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">RPT004</a></td>
                        <td><span class="report-type type-member">회원</span></td><td>욕설/비방/모욕/괴롭힘</td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">user016</a></td>
                        <td>2024-09-28</td><td><span class="status-badge status-rejected">반려</span></td>
                    </tr>
                    <tr onclick="location.href='appealManage.jsp?id=APL001'">
                        <td>APL001</td><td><a href="#" class="link-text" onclick="event.stopPropagation()">RPT003</a></td>
                        <td><span class="report-type type-content">컨텐츠</span></td><td>거짓 정보/허위 사실 유포</td>
                        <td><a href="#" class="link-text" onclick="event.stopPropagation()">user014</a></td>
                        <td>2024-09-25</td><td><span class="status-badge status-appeal">승인대기</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
function showTab(tabName) {
    document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('active'));
    document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));
    event.target.classList.add('active');
    document.getElementById(tabName + '-tab').classList.add('active');
}
function searchReports(){ alert('검색 기능은 서버 연동 후 작동합니다.'); }
function searchAppeals(){ alert('검색 기능은 서버 연동 후 작동합니다.'); }
</script>
</body>
</html>
