<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>신고 상세보기 - 공모자들</title>
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
	max-width: 1000px;
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

.action-buttons {
	display: flex;
	gap: 10px;
}

.btn {
	padding: 10px 20px;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
	display: flex;
	align-items: center;
	gap: 6px;
	text-decoration: none;
}

.btn-process {
	background: #2d5a29;
	color: white;
}

.btn-process:hover {
	background: #1f4019;
	transform: translateY(-2px);
}

.btn-reject {
	background: #ff6b6b;
	color: white;
}

.btn-reject:hover {
	background: #ff5252;
	transform: translateY(-2px);
}

.report-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	overflow: hidden;
}

.report-header {
	padding: 30px 40px;
	border-bottom: 2px solid #f0f0f0;
}

.report-title-section {
	display: flex;
	align-items: flex-start;
	gap: 12px;
	margin-bottom: 20px;
}

.report-type-badge {
	background: #2d5a29;
	color: white;
	padding: 6px 14px;
	border-radius: 12px;
	font-size: 13px;
	font-weight: bold;
	flex-shrink: 0;
}

.report-title {
	font-size: 28px;
	font-weight: bold;
	color: #333;
	line-height: 1.4;
	word-break: keep-all;
}

.report-meta {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
	padding: 20px 40px;
	background: #f8faf9;
	border-bottom: 1px solid #e8f5e6;
}

.meta-item {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.meta-label {
	color: #666;
	font-size: 13px;
	font-weight: 500;
}

.meta-value {
	color: #333;
	font-size: 15px;
	font-weight: 600;
}

.meta-value.highlight {
	color: #2d5a29;
	font-size: 16px;
}

.category-badge {
	display: inline-block;
	padding: 6px 12px;
	border-radius: 14px;
	font-size: 13px;
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

.report-content {
	padding: 40px;
}

.content-section {
	margin-bottom: 30px;
}

.content-section-title {
	font-size: 18px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 15px;
	padding-bottom: 10px;
	border-bottom: 2px solid #e8f5e6;
}

.content-text {
	line-height: 1.8;
	font-size: 15px;
	color: #333;
	word-break: keep-all;
	background: #f8faf9;
	padding: 20px;
	border-radius: 8px;
	border-left: 4px solid #a8d5a1;
}

.target-preview {
	background: #fff9e6;
	border: 2px solid #ffc107;
	border-radius: 10px;
	padding: 20px;
	margin-top: 15px;
}

.target-preview-title {
	font-weight: 600;
	color: #f57c00;
	margin-bottom: 12px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.target-preview-content {
	color: #666;
	font-size: 14px;
	line-height: 1.6;
}

.evidence-images {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
	gap: 15px;
	margin-top: 15px;
}

.evidence-image {
	width: 100%;
	height: 200px;
	background: #f0f0f0;
	border-radius: 8px;
	display: flex;
	align-items: center;
	justify-content: center;
	color: #999;
	font-size: 48px;
	border: 2px solid #e0e0e0;
	cursor: pointer;
	transition: all 0.2s ease;
}

.evidence-image:hover {
	border-color: #a8d5a1;
	transform: scale(1.02);
}

.admin-notes {
	background: #e8f5e6;
	border-left: 4px solid #2d5a29;
	padding: 20px;
	border-radius: 8px;
	margin-top: 20px;
}

.admin-notes-title {
	font-weight: 600;
	color: #2d5a29;
	margin-bottom: 10px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.admin-notes-content {
	color: #666;
	font-size: 14px;
	line-height: 1.6;
}

.report-footer {
	padding: 30px 40px;
	border-top: 2px solid #f0f0f0;
	background: #f8faf9;
	display: flex;
	justify-content: space-between;
	align-items: center;
	flex-wrap: wrap;
	gap: 20px;
}

.footer-info {
	font-size: 13px;
	color: #999;
}

.footer-buttons {
	display: flex;
	gap: 10px;
}

.btn-list {
	background: #8bc683;
	color: white;
	padding: 12px 24px;
}

.btn-list:hover {
	background: #7ab872;
	transform: translateY(-2px);
}

.warning-box {
	background: #ffebee;
	border-left: 4px solid #ff6b6b;
	padding: 16px 20px;
	margin: 0 40px 20px 40px;
	border-radius: 6px;
}

.warning-box-title {
	font-weight: 600;
	color: #d32f2f;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.warning-box-content {
	font-size: 14px;
	color: #666;
	line-height: 1.6;
}

/* 반응형 */
@media (max-width: 768px) {
	body {
		padding: 20px 10px;
	}
	
	.page-title {
		font-size: 24px;
	}
	
	.header {
		flex-direction: column;
		align-items: flex-start;
	}
	
	.action-buttons {
		width: 100%;
	}
	
	.btn {
		flex: 1;
		justify-content: center;
	}
	
	.report-header,
	.report-meta,
	.report-content,
	.report-footer {
		padding: 20px;
	}
	
	.warning-box,
	.admin-notes {
		margin: 0 20px 20px 20px;
	}
	
	.report-title {
		font-size: 22px;
	}
	
	.report-meta {
		grid-template-columns: 1fr;
		gap: 15px;
	}
	
	.report-footer {
		flex-direction: column;
		align-items: stretch;
	}
	
	.footer-buttons {
		width: 100%;
	}
	
	.btn-list {
		width: 100%;
		justify-content: center;
	}
	
	.evidence-images {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>
	<%
		// 신고 ID와 타입 받기
		String reportId = request.getParameter("id");
		String reportType = request.getParameter("type");
		if (reportId == null) reportId = "12";
		if (reportType == null) reportType = "member";
		
		// 실제로는 DB에서 조회
		String reportNumber = reportId;
		String reporterUserId = "user123";
		String targetUserId = "baduser01";
		String category = "욕설/비방";
		String categoryClass = "category-abuse";
		String status = "대기중";
		String statusClass = "status-pending";
		String reportDate = "2025-01-10 14:30:25";
		String reason = "채팅에서 지속적으로 욕설을 사용하고 다른 회원들을 비방합니다. 여러 차례 경고했지만 행동을 고치지 않고 있습니다.";
		String targetContent = "해당 회원이 모임 채팅방에서 사용한 부적절한 언어: \"이 XX들아\", \"XX나 하지마\" 등의 욕설을 반복적으로 사용함.";
		
		String typeTitle = "";
		String typeIcon = "";
		if ("member".equals(reportType)) {
			typeTitle = "회원";
			typeIcon = "👤";
		} else if ("meeting".equals(reportType)) {
			typeTitle = "모임";
			typeIcon = "📚";
		} else {
			typeTitle = "콘텐츠";
			typeIcon = "📝";
		}
	%>
	
	<div class="container">
		<div class="header">
			<div class="header-left">
				<a href="admin_report_list.jsp?tab=<%= reportType %>" class="back-btn">←</a>
				<h1 class="page-title">신고 상세보기</h1>
			</div>
			<% if ("대기중".equals(status) || "처리중".equals(status)) { %>
			<div class="action-buttons">
				<button class="btn btn-process" onclick="processReport('<%= reportId %>')">
					<span>✓</span>
					<span>처리완료</span>
				</button>
				<button class="btn btn-reject" onclick="rejectReport('<%= reportId %>')">
					<span>✕</span>
					<span>신고반려</span>
				</button>
			</div>
			<% } %>
		</div>
		
		<div class="report-container">
			<div class="report-header">
				<div class="report-title-section">
					<span class="report-type-badge"><%= typeIcon %> <%= typeTitle %></span>
					<h2 class="report-title">신고번호 #<%= reportNumber %></h2>
				</div>
			</div>
			
			<div class="report-meta">
				<div class="meta-item">
					<span class="meta-label">신고자 아이디</span>
					<span class="meta-value highlight"><%= reporterUserId %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">신고대상 아이디</span>
					<span class="meta-value highlight"><%= targetUserId %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">신고분류</span>
					<span class="meta-value">
						<span class="category-badge <%= categoryClass %>"><%= category %></span>
					</span>
				</div>
				<div class="meta-item">
					<span class="meta-label">신고일시</span>
					<span class="meta-value"><%= reportDate %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">처리상태</span>
					<span class="meta-value">
						<span class="status-badge <%= statusClass %>"><%= status %></span>
					</span>
				</div>
				<div class="meta-item">
					<span class="meta-label">신고 유형</span>
					<span class="meta-value"><%= typeTitle %></span>
				</div>
			</div>
			
			<% if ("대기중".equals(status)) { %>
			<div class="warning-box">
				<div class="warning-box-title">
					<span>⚠️</span>
					<span>처리 대기 중</span>
				</div>
				<div class="warning-box-content">
					이 신고는 아직 처리되지 않았습니다. 신고 내용을 확인하고 적절한 조치를 취해주세요.
				</div>
			</div>
			<% } %>
			
			<div class="report-content">
				<!-- 신고 사유 -->
				<div class="content-section">
					<h3 class="content-section-title">📋 신고 사유</h3>
					<div class="content-text">
						<%= reason %>
					</div>
				</div>
				
				<!-- 이전 신고 이력 -->
				<div class="content-section">
					<h3 class="content-section-title">📊 신고 대상의 이전 신고 이력</h3>
					<div class="content-text">
						<strong>총 신고 횟수:</strong> 3회<br>
						<strong>최근 신고일:</strong> 2025-01-08<br>
						<strong>처리 결과:</strong> 경고 2회, 정지 1회<br><br>
						해당 회원은 과거에도 유사한 신고를 받은 이력이 있습니다. 반복적인 문제 행동으로 판단됩니다.
					</div>
				</div>
				
				<% if (!"대기중".equals(status)) { %>
				<!-- 관리자 처리 내역 -->
				<div class="admin-notes">
					<div class="admin-notes-title">
						<span>🛡️</span>
						<span>관리자 처리 내역</span>
					</div>
					<div class="admin-notes-content">
						<strong>처리 일시:</strong> 2025-01-10 16:45:30<br>
						<strong>처리 관리자:</strong> admin01<br>
						<strong>조치 사항:</strong> 해당 회원에게 7일 활동 정지 처분<br>
						<strong>처리 의견:</strong> 신고 내용이 명확하고 증거가 충분함. 반복적인 규정 위반으로 활동 정지 처분함.
					</div>
				</div>
				<% } %>
			</div>
			
			<div class="report-footer">
				<div class="footer-info">
					신고 접수일: <%= reportDate %>
				</div>
				<div class="footer-buttons">
					<a href="<%=cp %>/manager/report/ReportList.jsp?tab=<%= reportType %>" class="btn btn-list">
						<span>📋</span>
						<span>목록으로</span>
					</a>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		// 신고 처리
		function processReport(id) {
			const reason = prompt('처리 의견을 입력해주세요:');
			if (reason === null) return;
			
			if (!reason.trim()) {
				alert('처리 의견을 입력해주세요.');
				return;
			}
			
			const action = prompt('조치 사항을 입력해주세요 (예: 경고, 7일 정지, 영구정지):');
			if (action === null) return;
			
			if (!action.trim()) {
				alert('조치 사항을 입력해주세요.');
				return;
			}
			
			if (confirm('신고를 처리 완료하시겠습니까?\n\n조치: ' + action + '\n의견: ' + reason)) {
				// 실제로는 서버로 처리 요청
				alert('신고가 처리 완료되었습니다.');
				location.reload();
			}
		}
		
		// 신고 반려
		function rejectReport(id) {
			const reason = prompt('반려 사유를 입력해주세요:');
			if (reason === null) return;
			
			if (!reason.trim()) {
				alert('반려 사유를 입력해주세요.');
				return;
			}
			
			if (confirm('이 신고를 반려하시겠습니까?\n\n사유: ' + reason)) {
				// 실제로는 서버로 반려 요청
				alert('신고가 반려되었습니다.');
				window.location.href = 'admin_report_list.jsp?tab=<%= reportType %>';
			}
		}
		
		// 이미지 크게 보기
		function viewImage(imageNum) {
			alert('이미지 ' + imageNum + '을(를) 크게 보는 기능 (구현 예정)');
			// 실제로는 이미지 뷰어 팝업이나 모달로 표시
		}
	</script>
</body>
</html>