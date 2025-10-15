<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>문의 관리 - 공모자들</title>
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

.stat-value.warning {
	color: #ff6b6b;
}

.filter-bar {
	background: white;
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	margin-bottom: 20px;
	display: flex;
	gap: 12px;
	align-items: center;
	flex-wrap: wrap;
}

.filter-select {
	padding: 10px 14px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	cursor: pointer;
	transition: all 0.2s ease;
}

.filter-select:focus {
	outline: none;
	border-color: #a8d5a1;
}

.search-box {
	display: flex;
	gap: 8px;
	flex: 1;
	max-width: 400px;
}

.search-input {
	flex: 1;
	padding: 10px 14px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	transition: all 0.2s ease;
}

.search-input:focus {
	outline: none;
	border-color: #a8d5a1;
}

.btn-search {
	padding: 10px 20px;
	background: #2d5a29;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
	white-space: nowrap;
}

.btn-search:hover {
	background: #1f4019;
}

.table-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	overflow: hidden;
}

.inquiry-table {
	width: 100%;
	border-collapse: collapse;
}

.inquiry-table thead {
	background: #f8faf9;
}

.inquiry-table th {
	padding: 16px;
	text-align: left;
	font-weight: 600;
	color: #2d5a29;
	border-bottom: 2px solid #e8f5e6;
	cursor: pointer;
	user-select: none;
	white-space: nowrap;
}

.inquiry-table th:hover {
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

.inquiry-table td {
	padding: 16px;
	border-bottom: 1px solid #f0f0f0;
	color: #333;
}

.inquiry-table tbody tr {
	transition: all 0.2s ease;
}

.inquiry-table tbody tr:hover {
	background: #f8faf9;
}

.inquiry-number {
	font-weight: 600;
	color: #2d5a29;
}

.user-id {
	font-weight: 500;
	color: #2d5a29;
}

.inquiry-title {
	font-weight: 500;
	color: #333;
	max-width: 400px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	cursor: pointer;
	transition: color 0.2s ease;
}

.inquiry-title:hover {
	color: #2d5a29;
	text-decoration: underline;
}

.date-text {
	color: #999;
	font-size: 13px;
}

.status-badge {
	display: inline-block;
	padding: 6px 14px;
	border-radius: 16px;
	font-size: 13px;
	font-weight: 600;
	white-space: nowrap;
}

.status-pending {
	background: #fff3e0;
	color: #f57c00;
}

.status-answered {
	background: #e8f5e9;
	color: #388e3c;
}

.action-buttons {
	display: flex;
	gap: 8px;
}

.btn-action {
	padding: 6px 14px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	font-size: 13px;
	font-weight: 500;
	transition: all 0.2s ease;
}

.btn-view {
	background: #8bc683;
	color: white;
}

.btn-view:hover {
	background: #7ab872;
	transform: translateY(-1px);
}

.btn-answer {
	background: #2d5a29;
	color: white;
}

.btn-answer:hover {
	background: #1f4019;
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

.empty-state {
	text-align: center;
	padding: 60px 20px;
	color: #999;
}

.empty-state-icon {
	font-size: 64px;
	margin-bottom: 16px;
}

/* 반응형 */
@media (max-width: 1024px) {
	.inquiry-table {
		font-size: 14px;
	}
	
	.inquiry-table th,
	.inquiry-table td {
		padding: 12px 8px;
	}
	
	.inquiry-title {
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
	
	.inquiry-table {
		min-width: 900px;
	}
	
	.stats-bar {
		gap: 20px;
	}
	
	.filter-bar {
		flex-direction: column;
		align-items: stretch;
	}
	
	.search-box {
		max-width: 100%;
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
		
		// 필터 파라미터
		String statusFilter = request.getParameter("status");
		if (statusFilter == null) statusFilter = "all";
		
		// 검색어
		String searchKeyword = request.getParameter("keyword");
		if (searchKeyword == null) searchKeyword = "";
	%>
	
	<div class="container">
		<div class="header">
			<div class="header-left">
				<a href="<%=cp %>/manager/main/ManagerMain.jsp" class="back-btn">←</a>
				<h1 class="page-title">💬 문의 관리</h1>
			</div>
		</div>
		
		<div class="stats-bar">
			<div class="stat-item">
				<span class="stat-label">전체 문의</span>
				<span class="stat-value">45</span>
			</div>
			<div class="stat-item">
				<span class="stat-label">답변 대기</span>
				<span class="stat-value warning">12</span>
			</div>
			<div class="stat-item">
				<span class="stat-label">답변 완료</span>
				<span class="stat-value">33</span>
			</div>
			<div class="stat-item">
				<span class="stat-label">오늘 접수</span>
				<span class="stat-value">5</span>
			</div>
		</div>
		
		<!-- 필터 바 -->
		<div class="filter-bar">
			<span style="font-weight: 600; color: #333;">필터:</span>
			<select class="filter-select" onchange="filterByStatus(this.value)">
				<option value="all" <%= "all".equals(statusFilter) ? "selected" : "" %>>전체</option>
				<option value="pending" <%= "pending".equals(statusFilter) ? "selected" : "" %>>답변대기</option>
				<option value="answered" <%= "answered".equals(statusFilter) ? "selected" : "" %>>답변완료</option>
			</select>
			
			<div class="search-box">
				<input 
					type="text" 
					class="search-input" 
					id="searchInput"
					placeholder="제목 또는 작성자로 검색"
					value="<%= searchKeyword %>"
				>
				<button class="btn-search" onclick="searchInquiry()">🔍 검색</button>
			</div>
		</div>
		
		<div class="table-container">
			<table class="inquiry-table">
				<thead>
					<tr>
						<th style="width: 80px;">
							<div class="sort-header <%= "number".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('number')">
								<span>번호</span>
								<span class="sort-icon">▼</span>
							</div>
						</th>
						<th style="width: 120px;">
							<div class="sort-header <%= "user".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('user')">
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
						<th style="width: 130px;">
							<div class="sort-header <%= "date".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('date')">
								<span>작성일</span>
								<span class="sort-icon">▼</span>
							</div>
						</th>
						<th style="width: 100px;">
							<div class="sort-header <%= "status".equals(sortBy) ? "active " + sortOrder : "" %>" 
							     onclick="sortTable('status')">
								<span>답변상태</span>
								<span class="sort-icon">▼</span>
							</div>
						</th>
						<th style="width: 150px; text-align: center;">관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="inquiry-number">45</td>
						<td class="user-id">user123</td>
						<td class="inquiry-title" onclick="viewInquiry(45)">회원탈퇴는 어떻게 하나요?</td>
						<td class="date-text">2025-01-10 14:30</td>
						<td><span class="status-badge status-pending">답변대기</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(45)">상세보기</button>
								<button class="btn-action btn-answer" onclick="answerInquiry(45)">답변하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">44</td>
						<td class="user-id">member456</td>
						<td class="inquiry-title" onclick="viewInquiry(44)">모임 생성 방법을 알려주세요</td>
						<td class="date-text">2025-01-10 11:20</td>
						<td><span class="status-badge status-pending">답변대기</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(44)">상세보기</button>
								<button class="btn-action btn-answer" onclick="answerInquiry(44)">답변하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">43</td>
						<td class="user-id">user789</td>
						<td class="inquiry-title" onclick="viewInquiry(43)">신고 처리 결과가 궁금합니다</td>
						<td class="date-text">2025-01-09 16:45</td>
						<td><span class="status-badge status-answered">답변완료</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(43)">상세보기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">42</td>
						<td class="user-id">testuser</td>
						<td class="inquiry-title" onclick="viewInquiry(42)">결제 오류 문의드립니다</td>
						<td class="date-text">2025-01-09 14:20</td>
						<td><span class="status-badge status-pending">답변대기</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(42)">상세보기</button>
								<button class="btn-action btn-answer" onclick="answerInquiry(42)">답변하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">41</td>
						<td class="user-id">admin</td>
						<td class="inquiry-title" onclick="viewInquiry(41)">프로필 사진 변경이 안됩니다</td>
						<td class="date-text">2025-01-09 10:15</td>
						<td><span class="status-badge status-answered">답변완료</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(41)">상세보기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">40</td>
						<td class="user-id">user999</td>
						<td class="inquiry-title" onclick="viewInquiry(40)">비밀번호 찾기가 안되요</td>
						<td class="date-text">2025-01-08 18:30</td>
						<td><span class="status-badge status-answered">답변완료</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(40)">상세보기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">39</td>
						<td class="user-id">member111</td>
						<td class="inquiry-title" onclick="viewInquiry(39)">모임 참가비 환불 요청</td>
						<td class="date-text">2025-01-08 15:20</td>
						<td><span class="status-badge status-pending">답변대기</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(39)">상세보기</button>
								<button class="btn-action btn-answer" onclick="answerInquiry(39)">답변하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">38</td>
						<td class="user-id">user555</td>
						<td class="inquiry-title" onclick="viewInquiry(38)">닉네임 변경 횟수 제한이 있나요?</td>
						<td class="date-text">2025-01-08 13:10</td>
						<td><span class="status-badge status-answered">답변완료</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(38)">상세보기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">37</td>
						<td class="user-id">newuser</td>
						<td class="inquiry-title" onclick="viewInquiry(37)">회원가입이 안됩니다</td>
						<td class="date-text">2025-01-08 10:05</td>
						<td><span class="status-badge status-pending">답변대기</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(37)">상세보기</button>
								<button class="btn-action btn-answer" onclick="answerInquiry(37)">답변하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td class="inquiry-number">36</td>
						<td class="user-id">member888</td>
						<td class="inquiry-title" onclick="viewInquiry(36)">모임 승인은 얼마나 걸리나요?</td>
						<td class="date-text">2025-01-07 17:40</td>
						<td><span class="status-badge status-answered">답변완료</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewInquiry(36)">상세보기</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="pagination">
			<button class="page-btn" disabled>◀</button>
			<button class="page-btn active">1</button>
			<button class="page-btn">2</button>
			<button class="page-btn">3</button>
			<button class="page-btn">4</button>
			<button class="page-btn">5</button>
			<button class="page-btn">▶</button>
		</div>
	</div>
	
	<script>
		// 정렬
		function sortTable(column) {
			const currentSort = '<%= sortBy %>';
			const currentOrder = '<%= sortOrder %>';
			
			let newOrder = 'asc';
			if (column === currentSort) {
				newOrder = currentOrder === 'asc' ? 'desc' : 'asc';
			}
			
			window.location.href = '?sort=' + column + '&order=' + newOrder + '&status=<%= statusFilter %>&keyword=<%= searchKeyword %>';
		}
		
		// 필터링
		function filterByStatus(status) {
			window.location.href = '?status=' + status + '&sort=<%= sortBy %>&order=<%= sortOrder %>&keyword=<%= searchKeyword %>';
		}
		
		// 검색
		function searchInquiry() {
			const keyword = document.getElementById('searchInput').value.trim();
			window.location.href = '?keyword=' + encodeURIComponent(keyword) + '&status=<%= statusFilter %>&sort=<%= sortBy %>&order=<%= sortOrder %>';
		}
		
		// 엔터키 검색
		document.getElementById('searchInput').addEventListener('keypress', function(e) {
			if (e.key === 'Enter') {
				searchInquiry();
			}
		});
		
		// 문의 상세보기
		function viewInquiry(id) {
			window.location.href = 'admin_inquiry_detail.jsp?id=' + id;
		}
		
		// 답변하기
		function answerInquiry(id) {
			window.location.href = 'admin_inquiry_answer.jsp?id=' + id;
		}
	</script>
</body>
</html>