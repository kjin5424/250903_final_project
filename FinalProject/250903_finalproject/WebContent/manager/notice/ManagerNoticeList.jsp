<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 페이지 정보 받기
	String pageNum = request.getParameter("NoticeListPage");

	if(pageNum==null)
		pageNum = "1";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 관리 - 공모자들</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: #f5f7fa;
	padding: 40px 20px;
}

.container {
	max-width: 1400px;
	margin: 0 auto;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	flex-wrap: wrap;
	gap: 20px;
}

.header-left {
	display: flex;
	align-items: center;
	gap: 15px;
}

.back-btn {
	background: #e8f5e6;
	color: #2d5a29;
	border: none;
	padding: 10px 16px;
	border-radius: 8px;
	cursor: pointer;
	font-size: 20px;
	transition: all 0.2s ease;
	text-decoration: none;
	display: flex;
	align-items: center;
}

.back-btn:hover {
	background: #d4ecd1;
	transform: translateX(-3px);
}

.page-title {
	font-size: 32px;
	font-weight: bold;
	color: #2d5a29;
}

.create-btn {
	background: #2d5a29;
	color: white;
	border: none;
	padding: 12px 24px;
	border-radius: 8px;
	cursor: pointer;
	font-size: 15px;
	font-weight: 600;
	transition: all 0.2s ease;
	display: flex;
	align-items: center;
	gap: 8px;
	text-decoration: none;
}

.create-btn:hover {
	background: #1f4019;
	transform: translateY(-2px);
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.stats-bar {
	background: white;
	padding: 20px 30px;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	margin-bottom: 20px;
	display: flex;
	gap: 40px;
	flex-wrap: wrap;
}

.stat-item {
	display: flex;
	align-items: center;
	gap: 10px;
}

.stat-label {
	color: #666;
	font-size: 14px;
}

.stat-value {
	color: #2d5a29;
	font-size: 20px;
	font-weight: bold;
}

.table-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	overflow: hidden;
}

.notice-table {
	width: 100%;
	border-collapse: collapse;
}

.notice-table thead {
	background: #f8faf9;
}

.notice-table th {
	padding: 16px;
	text-align: left;
	font-weight: 600;
	color: #2d5a29;
	border-bottom: 2px solid #e8f5e6;
	cursor: pointer;
	user-select: none;
	white-space: nowrap;
}

.notice-table th:hover {
	background: #e8f5e6;
}

.sort-header {
	display: flex;
	align-items: center;
	gap: 6px;
}

.sort-icon {
	font-size: 12px;
	color: #999;
	transition: all 0.2s ease;
}

.sort-header.active .sort-icon {
	color: #2d5a29;
}

.sort-header.asc .sort-icon {
	transform: rotate(180deg);
}

.notice-table td {
	padding: 16px;
	border-bottom: 1px solid #f0f0f0;
	color: #333;
}

.notice-table tbody tr {
	transition: all 0.2s ease;
}

.notice-table tbody tr:hover {
	background: #f8faf9;
}

.notice-number {
	font-weight: 600;
	color: #2d5a29;
}

.notice-title {
	font-weight: 500;
	color: #333;
	max-width: 400px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.notice-title.pinned {
	display: flex;
	align-items: center;
	gap: 8px;
}

.pin-badge {
	background: #ff6b6b;
	color: white;
	padding: 2px 8px;
	border-radius: 10px;
	font-size: 11px;
	font-weight: bold;
}

.author {
	color: #666;
	font-size: 14px;
}

.views {
	color: #666;
	font-size: 14px;
}

.date {
	color: #999;
	font-size: 13px;
}

.action-buttons {
	display: flex;
	gap: 8px;
}

.btn {
	padding: 6px 14px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	font-size: 13px;
	font-weight: 500;
	transition: all 0.2s ease;
}

.btn-edit {
	background: #8bc683;
	color: white;
}

.btn-edit:hover {
	background: #7ab872;
	transform: translateY(-1px);
}

.btn-delete {
	background: #ff6b6b;
	color: white;
}

.btn-delete:hover {
	background: #ff5252;
	transform: translateY(-1px);
}

.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	margin-top: 30px;
}

.page-btn {
	padding: 8px 14px;
	border: 1px solid #e0e0e0;
	background: white;
	border-radius: 6px;
	cursor: pointer;
	font-size: 14px;
	color: #666;
	transition: all 0.2s ease;
}

.page-btn:hover {
	border-color: #a8d5a1;
	color: #2d5a29;
}

.page-btn.active {
	background: #2d5a29;
	color: white;
	border-color: #2d5a29;
}

.page-btn:disabled {
	cursor: not-allowed;
	opacity: 0.4;
}

a
{
	text-decoration: none;
}

/* 반응형 */
@media (max-width: 1024px) {
	.notice-table {
		font-size: 14px;
	}
	
	.notice-table th,
	.notice-table td {
		padding: 12px 8px;
	}
	
	.notice-title {
		max-width: 250px;
	}
}

@media (max-width: 768px) {
	.container {
		padding: 0 10px;
	}
	
	.page-title {
		font-size: 24px;
	}
	
	.table-container {
		overflow-x: auto;
	}
	
	.notice-table {
		min-width: 900px;
	}
	
	.stats-bar {
		gap: 20px;
	}
}
</style>
</head>
<body>
	<%
		// 정렬 파라미터 받기
		String sortBy = request.getParameter("sort");
		String sortOrder = request.getParameter("order");
		if (sortBy == null) sortBy = "number";
		if (sortOrder == null) sortOrder = "desc";
	%>
	
	<div class="container">
		<div class="header">
			<div class="header-left">
				<a href="../main/ManagerMain.jsp" class="back-btn">←</a>
				<h1 class="page-title">📢 공지사항 관리</h1>
			</div>
			<a href="NoticeWrite.jsp" class="create-btn">
				<span>✏️</span>
				<span>새 공지사항 작성</span>
			</a>
		</div>
		
		<div class="stats-bar">
			<div class="stat-item">
				<span class="stat-label">전체 공지</span>
				<span class="stat-value">23</span>
			</div>
			<div class="stat-item">
				<span class="stat-label">상단 고정</span>
				<span class="stat-value">3</span>
			</div>
			<div class="stat-item">
				<span class="stat-label">오늘 조회수</span>
				<span class="stat-value">1,847</span>
			</div>
		</div>
		
		<div class="table-container">
			<table class="notice-table">
				<thead>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<th style="width: 80px;">
							<div class="sort-header <%= "number".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('number')">
								<span>번호</span>
								<span class="sort-icon">▼</span>
							</div>
						</th>
						<th style="width: 120px;">
							<div class="sort-header <%= "author".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('author')">
								<span>작성자</span>
								<span class="sort-icon">▼</span>
							</div>
						</th>
						<th>
							<div class="sort-header <%= "title".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('title')">
								<span>제목</span>
								<span class="sort-icon">▼</span>
							</div>
						</th>
						<th style="width: 100px;">
							<div class="sort-header <%= "views".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('views')">
								<span>조회수</span>
								<span class="sort-icon">▼</span>
							</div>
						</th>
						<th style="width: 120px;">
							<div class="sort-header <%= "date".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('date')">
								<span>게시일</span>
								<span class="sort-icon">▼</span>
							</div>
						</th>
						<th style="width: 150px; text-align: center;">관리</th>
					</tr>
				</thead>
				<tbody>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">23</td>
						<td class="author">관리자</td>
						<td>
							<div class="notice-title pinned">
								<span class="pin-badge">공지</span>
								<span>2025년 새해 맞이 서비스 업데이트 안내</span>
							</div>
						</td>
						<td class="views">1,523</td>
						<td class="date">2025-01-05</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(23)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(23)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">22</td>
						<td class="author">관리자</td>
						<td>
							<div class="notice-title pinned">
								<span class="pin-badge">공지</span>
								<span>개인정보 처리방침 변경 안내</span>
							</div>
						</td>
						<td class="views">987</td>
						<td class="date">2025-01-03</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(22)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(22)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">21</td>
						<td class="author">관리자</td>
						<td>
							<div class="notice-title pinned">
								<span class="pin-badge">공지</span>
								<span>서버 점검 일정 안내 (1월 15일)</span>
							</div>
						</td>
						<td class="views">756</td>
						<td class="date">2025-01-02</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(21)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(21)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">20</td>
						<td class="author">운영팀</td>
						<td class="notice-title">모임 카테고리 추가 안내</td>
						<td class="views">432</td>
						<td class="date">2024-12-28</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(20)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(20)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">19</td>
						<td class="author">관리자</td>
						<td class="notice-title">연말연시 고객센터 운영 시간 안내</td>
						<td class="views">612</td>
						<td class="date">2024-12-25</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(19)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(19)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">18</td>
						<td class="author">운영팀</td>
						<td class="notice-title">신규 기능 업데이트 - 모임 일정 동기화</td>
						<td class="views">891</td>
						<td class="date">2024-12-20</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(18)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(18)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">17</td>
						<td class="author">관리자</td>
						<td class="notice-title">부적절한 콘텐츠 신고 기능 강화</td>
						<td class="views">523</td>
						<td class="date">2024-12-15</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(17)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(17)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">16</td>
						<td class="author">운영팀</td>
						<td class="notice-title">모임 후기 작성 이벤트 진행</td>
						<td class="views">1,234</td>
						<td class="date">2024-12-10</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(16)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(16)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">15</td>
						<td class="author">관리자</td>
						<td class="notice-title">이용약관 개정 안내</td>
						<td class="views">678</td>
						<td class="date">2024-12-05</td>
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(15)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(15)">삭제</button>
							</div>
						</td>
					</tr>
					<tr onclick="location.href='ManagerNoticeOpen.jsp?noticeNum=14'">
						<td class="notice-number">14</td>
						
						<td class="author">운영팀</td>
						<td class="notice-title">모바일 앱 출시 예정 안내</td>
						<td class="views">2,156</td>
						<td class="date">2024-12-01</td>
						
						<td>
							<div class="action-buttons">
								<button class="btn btn-edit" onclick="event.stopPropagation(); editNotice(14)">수정</button>
								<button class="btn btn-delete" onclick="event.stopPropagation(); deleteNotice(14)">삭제</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<!-- 나중에 페이징 처리 하면서 반복문으로 빼고, 자동화 할 구문 -->
		<div class="pagination">
			<button class="page-btn" disabled>◀</button>
			<button class="page-btn active">1</button>
			<a href="ManagerNoticeList.jsp?NoticeListPage=2" class="page-btn">2</a>
			<a href="ManagerNoticeList.jsp?NoticeListPage=3" class="page-btn">3</a>
			<button class="page-btn">▶</button>
		</div>
	</div>
	
	<script>
		function sortTable(column) {
			const currentSort = '<%= sortBy %>';
			const currentOrder = '<%= sortOrder %>';
			
			let newOrder = 'asc';
			if (column === currentSort) {
				newOrder = currentOrder === 'asc' ? 'desc' : 'asc';
			}
			
			window.location.href = '?sort=' + column + '&order=' + newOrder;
		}
		
		function editNotice(id) {
			window.location.href = 'NoticeModify.jsp?id=' + id;
		}
		
		function deleteNotice(id) {
			if (confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
				// 삭제 처리 로직
				alert('공지사항 ' + id + '번이 삭제되었습니다.');
				location.reload();
			}
		}
	</script>
</body>
</html>