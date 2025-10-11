<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 메인 - 공모자들</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, #f5f7fa 0%, #e8f5e6 100%);
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 20px;
}

.admin-header {
	text-align: center;
	margin-bottom: 50px;
}

.admin-title {
	font-size: 36px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 10px;
}

.admin-subtitle {
	font-size: 16px;
	color: #666;
}

.admin-container {
	max-width: 900px;
	width: 100%;
}

.menu-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 30px;
}

.menu-card {
	background: white;
	border-radius: 16px;
	padding: 40px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	cursor: pointer;
	transition: all 0.3s ease;
	text-align: center;
	position: relative;
	overflow: hidden;
}

.menu-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 4px;
	background: linear-gradient(90deg, #a8d5a1, #8bc683);
	transform: scaleX(0);
	transition: transform 0.3s ease;
}

.menu-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.menu-card:hover::before {
	transform: scaleX(1);
}

.menu-icon {
	font-size: 64px;
	margin-bottom: 20px;
	display: block;
}

.menu-title {
	font-size: 24px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 12px;
}

.menu-description {
	font-size: 14px;
	color: #666;
	line-height: 1.6;
	margin-bottom: 20px;
}

.menu-stats {
	display: flex;
	justify-content: center;
	gap: 20px;
	margin-top: 20px;
	padding-top: 20px;
	border-top: 1px solid #f0f0f0;
}

.stat-item {
	text-align: center;
}

.stat-number {
	font-size: 20px;
	font-weight: bold;
	color: #2d5a29;
	display: block;
	margin-bottom: 4px;
}

.stat-label {
	font-size: 12px;
	color: #999;
}

.badge {
	position: absolute;
	top: 15px;
	right: 15px;
	background: #ff6b6b;
	color: white;
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: bold;
}

.logout-btn {
	position: absolute;
	top: 20px;
	right: 20px;
	background: #2d5a29;
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 8px;
	cursor: pointer;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.2s ease;
	text-decoration: none;
	display: flex;
	align-items: center;
	gap: 6px;
}

.logout-btn:hover {
	background: #1f4019;
	transform: translateY(-2px);
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

/* 반응형 */
@media (max-width: 768px) {
	.admin-title {
		font-size: 28px;
	}
	
	.menu-grid {
		grid-template-columns: 1fr;
		gap: 20px;
	}
	
	.menu-card {
		padding: 30px;
	}
	
	.menu-icon {
		font-size: 48px;
	}
	
	.menu-title {
		font-size: 20px;
	}
	
	.logout-btn {
		position: static;
		margin-top: 30px;
	}
	
	body {
		justify-content: flex-start;
		padding-top: 40px;
	}
}

@media (max-width: 480px) {
	.menu-stats {
		flex-direction: column;
		gap: 10px;
	}
}
</style>
</head>
<body>
	<%
		// 관리자 세션 체크 (예시)
		// String adminId = (String) session.getAttribute("adminId");
		// if (adminId == null) {
		//     response.sendRedirect("login.jsp");
		//     return;
		// }
	%>
	
	<a href="logout.jsp" class="logout-btn">
		<span>🚪</span>
		<span>로그아웃</span>
	</a>
	
	<div class="admin-header">
		<h1 class="admin-title">🛡️ 관리자 페이지</h1>
		<p class="admin-subtitle">공모자들 플랫폼 관리 시스템</p>
	</div>
	
	<div class="admin-container">
		<div class="menu-grid">
			<!-- 회원관리 -->
			<a href="admin_members.jsp" style="text-decoration: none;">
				<div class="menu-card">
					<span class="menu-icon">👥</span>
					<h2 class="menu-title">회원관리</h2>
					<p class="menu-description">
						회원 정보 조회, 수정, 삭제<br>
						회원 등급 관리 및 활동 내역 확인
					</p>
					<div class="menu-stats">
						<div class="stat-item">
							<span class="stat-number">1,247</span>
							<span class="stat-label">전체 회원</span>
						</div>
						<div class="stat-item">
							<span class="stat-number">89</span>
							<span class="stat-label">신규 회원</span>
						</div>
					</div>
				</div>
			</a>
			
			<!-- 신고처리 -->
			<a href="<%=cp %>/manager/report/ReportList.jsp" style="text-decoration: none;">
				<div class="menu-card">
					<span class="badge">12</span>
					<span class="menu-icon">📋</span>
					<h2 class="menu-title">신고처리</h2>
					<p class="menu-description">
						신고 내역 확인 및 조치<br>
						수위에 맞는 제재 혹은 반려
					</p>
					<div class="menu-stats">
						<div class="stat-item">
							<span class="stat-number">5</span>
							<span class="stat-label">신규 신고</span>
						</div>
					</div>
				</div>
			</a>
			
			<!-- 문의처리 -->
			<a href="<%=cp %>/manager/inquiry/InquiryList.jsp" style="text-decoration: none;">
				<div class="menu-card">
					<span class="badge">12</span>
					<span class="menu-icon">📋</span>
					<h2 class="menu-title">문의처리</h2>
					<p class="menu-description">
						사용자 문의 처리<br>
						질의에 대한 답변 작성
					</p>
					<div class="menu-stats">
						<div class="stat-item">
							<span class="stat-number">12</span>
							<span class="stat-label">미처리 문의</span>
						</div>
					</div>
				</div>
			</a>
			
			<!-- 모임관리 -->
			<a href="admin_meetings.jsp" style="text-decoration: none;">
				<div class="menu-card">
					<span class="menu-icon">📚</span>
					<h2 class="menu-title">모임관리</h2>
					<p class="menu-description">
						모임 승인 및 관리<br>
						부적절한 모임 모니터링 및 제재
					</p>
					<div class="menu-stats">
						<div class="stat-item">
							<span class="stat-number">156</span>
							<span class="stat-label">활성 모임</span>
						</div>
						<div class="stat-item">
							<span class="stat-number">8</span>
							<span class="stat-label">승인 대기</span>
						</div>
					</div>
				</div>
			</a>
			
			<!-- 공지사항 작성 -->
			<a href="<%=cp %>/manager/notice/ManagerNoticeList.jsp" style="text-decoration: none;">
				<div class="menu-card">
					<span class="menu-icon">📢</span>
					<h2 class="menu-title">공지사항 작성</h2>
					<p class="menu-description">
						공지사항 작성, 수정, 삭제<br>
						중요 알림 및 업데이트 관리
					</p>
					<div class="menu-stats">
						<div class="stat-item">
							<span class="stat-number">23</span>
							<span class="stat-label">전체 공지</span>
						</div>
						<div class="stat-item">
							<span class="stat-number">3</span>
							<span class="stat-label">상단 고정</span>
						</div>
					</div>
				</div>
			</a>
		</div>
	</div>
	
	<script>
		// 카드 클릭 효과
		document.querySelectorAll('.menu-card').forEach(card => {
			card.addEventListener('click', function(e) {
				// 부모 a 태그가 있으면 자동으로 이동
				if (!this.parentElement.href) {
					e.preventDefault();
					alert('해당 메뉴는 준비 중입니다.');
				}
			});
		});
	</script>
</body>
</html>