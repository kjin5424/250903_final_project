<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고 관리 - 공모자들</title>
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

.tab-navigation {
	background: white;
	border-radius: 12px;
	padding: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	margin-bottom: 20px;
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
}

.tab-btn {
	flex: 1;
	min-width: 150px;
	padding: 12px 24px;
	background: transparent;
	border: none;
	border-radius: 8px;
	font-size: 15px;
	font-weight: 600;
	color: #666;
	cursor: pointer;
	transition: all 0.2s ease;
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}

.tab-btn:hover {
	background: #f8faf9;
}

.tab-btn.active {
	background: #2d5a29;
	color: white;
}

.tab-badge {
	background: #ff6b6b;
	color: white;
	padding: 2px 8px;
	border-radius: 10px;
	font-size: 12px;
	font-weight: bold;
}

.tab-btn.active .tab-badge {
	background: rgba(255, 255, 255, 0.3);
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

.table-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	overflow: hidden;
}

.report-table {
	width: 100%;
	border-collapse: collapse;
}

.report-table thead {
	background: #f8faf9;
}

.report-table th {
	padding: 16px;
	text-align: left;
	font-weight: 600;
	color: #2d5a29;
	border-bottom: 2px solid #e8f5e6;
	white-space: nowrap;
}

.report-table td {
	padding: 16px;
	border-bottom: 1px solid #f0f0f0;
	color: #333;
}

.report-table tbody tr {
	transition: all 0.2s ease;
}

.report-table tbody tr:hover {
	background: #f8faf9;
}

.reporter-id, .target-id {
	font-weight: 500;
	color: #2d5a29;
}

.category-badge {
	display: inline-block;
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: 600;
	white-space: nowrap;
}

.category-spam {
	background: #ffe0e0;
	color: #d32f2f;
}

.category-abuse {
	background: #fff3e0;
	color: #f57c00;
}

.category-inappropriate {
	background: #fce4ec;
	color: #c2185b;
}

.category-other {
	background: #e0e0e0;
	color: #666;
}

.reason-text {
	max-width: 300px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	color: #666;
	font-size: 14px;
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

.status-processing {
	background: #e3f2fd;
	color: #1976d2;
}

.status-completed {
	background: #e8f5e9;
	color: #388e3c;
}

.status-rejected {
	background: #f5f5f5;
	color: #666;
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

.btn-process {
	background: #2d5a29;
	color: white;
}

.btn-process:hover {
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
	.report-table {
		font-size: 14px;
	}
	
	.report-table th,
	.report-table td {
		padding: 12px 8px;
	}
	
	.reason-text {
		max-width: 200px;
	}
}

@media (max-width: 768px) {
	.page-title {
		font-size: 24px;
	}
	
	.table-container {
		overflow-x: auto;
	}
	
	.report-table {
		min-width: 900px;
	}
	
	.stats-bar {
		gap: 20px;
	}
	
	.tab-btn {
		min-width: 120px;
		font-size: 14px;
	}
}
</style>
</head>
<body>
	<%
		// 현재 탭 파라미터 받기
		String currentTab = request.getParameter("tab");
		if (currentTab == null) currentTab = "member";
		
		// 필터 파라미터
		String statusFilter = request.getParameter("status");
		if (statusFilter == null) statusFilter = "all";
	%>
	
	<div class="container">
		<div class="header">
			<div class="header-left">
				<a href="<%=cp %>/manager/main/ManagerMain.jsp" class="back-btn">←</a>
				<h1 class="page-title">📋 신고 관리</h1>
			</div>
		</div>
		
		<!-- 탭 네비게이션 -->
		<div class="tab-navigation">
			<a href="?tab=member" class="tab-btn <%= "member".equals(currentTab) ? "active" : "" %>">
				<span>👤</span>
				<span>회원신고</span>
				<span class="tab-badge">12</span>
			</a>
			<a href="?tab=meeting" class="tab-btn <%= "meeting".equals(currentTab) ? "active" : "" %>">
				<span>📚</span>
				<span>모임신고</span>
				<span class="tab-badge">5</span>
			</a>
			<a href="?tab=content" class="tab-btn <%= "content".equals(currentTab) ? "active" : "" %>">
				<span>📝</span>
				<span>콘텐츠신고</span>
				<span class="tab-badge">8</span>
			</a>
		</div>
		
		<!-- 통계 바 -->
		<div class="stats-bar">
			<div class="stat-item">
				<span class="stat-label">전체 신고</span>
				<% if ("member".equals(currentTab)) { %>
					<span class="stat-value">12</span>
				<% } else if ("meeting".equals(currentTab)) { %>
					<span class="stat-value">5</span>
				<% } else { %>
					<span class="stat-value">8</span>
				<% } %>
			</div>
			<div class="stat-item">
				<span class="stat-label">처리 대기</span>
				<% if ("member".equals(currentTab)) { %>
					<span class="stat-value warning">7</span>
				<% } else if ("meeting".equals(currentTab)) { %>
					<span class="stat-value warning">3</span>
				<% } else { %>
					<span class="stat-value warning">5</span>
				<% } %>
			</div>
			<div class="stat-item">
				<span class="stat-label">처리 완료</span>
				<% if ("member".equals(currentTab)) { %>
					<span class="stat-value">5</span>
				<% } else if ("meeting".equals(currentTab)) { %>
					<span class="stat-value">2</span>
				<% } else { %>
					<span class="stat-value">3</span>
				<% } %>
			</div>
		</div>
		
		<!-- 필터 바 -->
		<div class="filter-bar">
			<span style="font-weight: 600; color: #333;">필터:</span>
			<select class="filter-select" onchange="filterByStatus(this.value)">
				<option value="all" <%= "all".equals(statusFilter) ? "selected" : "" %>>전체</option>
				<option value="pending" <%= "pending".equals(statusFilter) ? "selected" : "" %>>대기중</option>
				<option value="processing" <%= "processing".equals(statusFilter) ? "selected" : "" %>>처리중</option>
				<option value="completed" <%= "completed".equals(statusFilter) ? "selected" : "" %>>완료</option>
				<option value="rejected" <%= "rejected".equals(statusFilter) ? "selected" : "" %>>반려</option>
			</select>
		</div>
		
		<!-- 회원신고 테이블 -->
		<% if ("member".equals(currentTab)) { %>
		<div class="table-container">
			<table class="report-table">
				<thead>
					<tr>
						<th style="width: 80px;">번호</th>
						<th style="width: 120px;">신고자</th>
						<th style="width: 120px;">신고대상</th>
						<th style="width: 130px;">신고분류</th>
						<th>신고사유</th>
						<th style="width: 110px;">신고일</th>
						<th style="width: 100px;">처리여부</th>
						<th style="width: 150px;">관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>12</td>
						<td class="reporter-id">user123</td>
						<td class="target-id">baduser01</td>
						<td><span class="category-badge category-abuse">욕설/비방</span></td>
						<td class="reason-text">채팅에서 지속적으로 욕설을 사용함</td>
						<td class="date-text">2025-01-10</td>
						<td><span class="status-badge status-pending">대기중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(12, 'member')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(12)">처리하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>11</td>
						<td class="reporter-id">member456</td>
						<td class="target-id">spammer99</td>
						<td><span class="category-badge category-spam">스팸/광고</span></td>
						<td class="reason-text">모임마다 상품 판매 광고를 지속적으로 올림</td>
						<td class="date-text">2025-01-09</td>
						<td><span class="status-badge status-processing">처리중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(11, 'member')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(11)">처리하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>10</td>
						<td class="reporter-id">admin</td>
						<td class="target-id">faker123</td>
						<td><span class="category-badge category-inappropriate">부적절한 프로필</span></td>
						<td class="reason-text">프로필 사진이 음란물</td>
						<td class="date-text">2025-01-08</td>
						<td><span class="status-badge status-completed">처리완료</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(10, 'member')">상세보기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>9</td>
						<td class="reporter-id">user789</td>
						<td class="target-id">troll007</td>
						<td><span class="category-badge category-abuse">욕설/비방</span></td>
						<td class="reason-text">다른 회원들에게 지속적인 괴롭힘</td>
						<td class="date-text">2025-01-07</td>
						<td><span class="status-badge status-pending">대기중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(9, 'member')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(9)">처리하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>8</td>
						<td class="reporter-id">member111</td>
						<td class="target-id">scammer88</td>
						<td><span class="category-badge category-other">사기/금전요구</span></td>
						<td class="reason-text">모임비를 받고 활동하지 않음</td>
						<td class="date-text">2025-01-06</td>
						<td><span class="status-badge status-pending">대기중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(8, 'member')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(8)">처리하기</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<!-- 모임신고 테이블 -->
		<% } else if ("meeting".equals(currentTab)) { %>
		<div class="table-container">
			<table class="report-table">
				<thead>
					<tr>
						<th style="width: 80px;">번호</th>
						<th style="width: 120px;">신고자</th>
						<th style="width: 150px;">신고대상 모임</th>
						<th style="width: 130px;">신고분류</th>
						<th>신고사유</th>
						<th style="width: 110px;">신고일</th>
						<th style="width: 100px;">처리여부</th>
						<th style="width: 150px;">관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>5</td>
						<td class="reporter-id">user555</td>
						<td class="target-id">알고리즘스터디</td>
						<td><span class="category-badge category-spam">스팸/광고</span></td>
						<td class="reason-text">스터디 명목으로 강의 판매</td>
						<td class="date-text">2025-01-09</td>
						<td><span class="status-badge status-pending">대기중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(5, 'meeting')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(5)">처리하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>4</td>
						<td class="reporter-id">member222</td>
						<td class="target-id">투자모임</td>
						<td><span class="category-badge category-other">사기의심</span></td>
						<td class="reason-text">투자 명목으로 금전 요구</td>
						<td class="date-text">2025-01-08</td>
						<td><span class="status-badge status-processing">처리중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(4, 'meeting')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(4)">처리하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>3</td>
						<td class="reporter-id">user888</td>
						<td class="target-id">부업모임</td>
						<td><span class="category-badge category-inappropriate">부적절한 내용</span></td>
						<td class="reason-text">다단계 영업 목적의 모임</td>
						<td class="date-text">2025-01-07</td>
						<td><span class="status-badge status-completed">처리완료</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(3, 'meeting')">상세보기</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<!-- 콘텐츠신고 테이블 -->
		<% } else { %>
		<div class="table-container">
			<table class="report-table">
				<thead>
					<tr>
						<th style="width: 80px;">번호</th>
						<th style="width: 120px;">신고자</th>
						<th style="width: 150px;">신고대상 게시글</th>
						<th style="width: 130px;">신고분류</th>
						<th>신고사유</th>
						<th style="width: 110px;">신고일</th>
						<th style="width: 100px;">처리여부</th>
						<th style="width: 150px;">관리</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>8</td>
						<td class="reporter-id">user333</td>
						<td class="target-id">게시글#1234</td>
						<td><span class="category-badge category-inappropriate">음란물</span></td>
						<td class="reason-text">게시글에 음란한 이미지 포함</td>
						<td class="date-text">2025-01-10</td>
						<td><span class="status-badge status-pending">대기중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(8, 'content')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(8)">처리하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>7</td>
						<td class="reporter-id">member777</td>
						<td class="target-id">게시글#1189</td>
						<td><span class="category-badge category-spam">스팸/광고</span></td>
						<td class="reason-text">상업적 광고 게시글</td>
						<td class="date-text">2025-01-09</td>
						<td><span class="status-badge status-pending">대기중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(7, 'content')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(7)">처리하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>6</td>
						<td class="reporter-id">user999</td>
						<td class="target-id">댓글#5678</td>
						<td><span class="category-badge category-abuse">욕설/비방</span></td>
						<td class="reason-text">댓글에 타인을 비방하는 내용</td>
						<td class="date-text">2025-01-08</td>
						<td><span class="status-badge status-processing">처리중</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(6, 'content')">상세보기</button>
								<button class="btn-action btn-process" onclick="processReport(6)">처리하기</button>
							</div>
						</td>
					</tr>
					<tr>
						<td>5</td>
						<td class="reporter-id">admin</td>
						<td class="target-id">게시글#1001</td>
						<td><span class="category-badge category-other">저작권 침해</span></td>
						<td class="reason-text">타인의 저작물을 무단으로 사용</td>
						<td class="date-text">2025-01-07</td>
						<td><span class="status-badge status-completed">처리완료</span></td>
						<td>
							<div class="action-buttons">
								<button class="btn-action btn-view" onclick="viewReport(5, 'content')">상세보기</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<% } %>
		
		<div class="pagination">
			<button class="page-btn" disabled>◀</button>
			<button class="page-btn active">1</button>
			<button class="page-btn">2</button>
			<button class="page-btn">3</button>
			<button class="page-btn">▶</button>
		</div>
	</div>
	
	<script>
		// 필터링
		function filterByStatus(status) {
			const currentTab = '<%= currentTab %>';
			window.location.href = '?tab=' + currentTab + '&status=' + status;
		}
		
		// 신고 상세보기
		function viewReport(id, type) {
			window.location.href = 'admin_report_detail.jsp?id=' + id + '&type=' + type;
		}
		
		// 신고 처리하기
		function processReport(id) {
			if (confirm('이 신고를 처리하시겠습니까?')) {
				window.location.href = 'admin_report_process.jsp?id=' + id;
			}
		}
	</script>
</body>
</html>