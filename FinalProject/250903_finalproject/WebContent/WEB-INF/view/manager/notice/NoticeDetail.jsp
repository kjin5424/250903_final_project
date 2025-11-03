<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 페이지 정보 받기
	String pageNum = request.getParameter("NoticeListPage");
	
	if(pageNum==null)
		pageNum = "1";
	
	// 공지사항 게시물 번호 받기
	String noticeNum = request.getParameter("noticeNum");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 상세보기 - 공모자들</title>
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

.btn-edit {
	background: #8bc683;
	color: white;
}

.btn-edit:hover {
	background: #7ab872;
	transform: translateY(-2px);
}

.btn-delete {
	background: #ff6b6b;
	color: white;
}

.btn-delete:hover {
	background: #ff5252;
	transform: translateY(-2px);
}

.notice-container {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	overflow: hidden;
}

.notice-header {
	padding: 30px 40px;
	border-bottom: 2px solid #f0f0f0;
}

.notice-title-section {
	display: flex;
	align-items: flex-start;
	gap: 12px;
	margin-bottom: 20px;
}

.pin-badge {
	background: #ff6b6b;
	color: white;
	padding: 4px 12px;
	border-radius: 12px;
	font-size: 13px;
	font-weight: bold;
	flex-shrink: 0;
}

.notice-title {
	font-size: 28px;
	font-weight: bold;
	color: #333;
	line-height: 1.4;
	word-break: keep-all;
}

.notice-meta {
	display: flex;
	gap: 30px;
	flex-wrap: wrap;
	padding: 20px 40px;
	background: #f8faf9;
	border-bottom: 1px solid #e8f5e6;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 14px;
}

.meta-label {
	color: #666;
	font-weight: 500;
}

.meta-value {
	color: #333;
	font-weight: 600;
}

.meta-value.number {
	color: #2d5a29;
}

.notice-content {
	padding: 40px;
	min-height: 400px;
	line-height: 1.8;
	font-size: 16px;
	color: #333;
	word-break: keep-all;
}

.notice-content p {
	margin-bottom: 16px;
}

.notice-content ul,
.notice-content ol {
	margin-left: 24px;
	margin-bottom: 16px;
}

.notice-content li {
	margin-bottom: 8px;
}

.notice-footer {
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
	background: #2d5a29;
	color: white;
	padding: 12px 24px;
}

.btn-list:hover {
	background: #1f4019;
	transform: translateY(-2px);
}

.divider {
	height: 1px;
	background: #f0f0f0;
	margin: 0 40px;
}

/* 관리자 정보 박스 */
.admin-info-box {
	background: #fff9e6;
	border-left: 4px solid #2d5a29;
	padding: 16px 20px;
	margin: 0 40px 20px 40px;
	border-radius: 6px;
}

.admin-info-title {
	font-weight: 600;
	color: #2d5a29;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 6px;
}

.admin-info-content {
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
	
	.notice-header,
	.notice-meta,
	.notice-content,
	.notice-footer {
		padding: 20px;
	}
	
	.admin-info-box {
		margin: 0 20px 20px 20px;
	}
	
	.divider {
		margin: 0 20px;
	}
	
	.notice-title {
		font-size: 22px;
	}
	
	.notice-meta {
		gap: 15px;
	}
	
	.notice-footer {
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
}
</style>
</head>
<body>
	<%
		// 공지사항 ID 받기 (예시)
		String noticeId = request.getParameter("id");
		if (noticeId == null) noticeId = "23";
		
		// 실제로는 DB에서 조회
		boolean isPinned = true;
		String title = "2025년 새해 맞이 서비스 업데이트 안내";
		String author = "관리자";
		String date = "2025-01-05";
		int views = 1523;
		int noticeNumber = 23;
	%>
	
	<div class="container">
		<div class="header">
			<div class="header-left">
				<a href="ManagerNoticeList.jsp?NoticeListPage=1" class="back-btn">←</a>
				<h1 class="page-title">공지사항 상세보기</h1>
			</div>
			<div class="action-buttons">
				<button class="btn btn-edit" onclick="editNotice(<%= noticeId %>)">
					<span>✏️</span>
					<span>수정</span>
				</button>
				<button class="btn btn-delete" onclick="deleteNotice(<%= noticeId %>)">
					<span>🗑️</span>
					<span>삭제</span>
				</button>
			</div>
		</div>
		
		<div class="notice-container">
			<div class="notice-header">
				<div class="notice-title-section">
					<% if (isPinned) { %>
					<span class="pin-badge">📌 상단고정</span>
					<% } %>
					<h2 class="notice-title"><%= title %></h2>
				</div>
			</div>
			
			<div class="notice-meta">
				<div class="meta-item">
					<span class="meta-label">게시물 번호</span>
					<span class="meta-value number">#<%= noticeNumber %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">작성자</span>
					<span class="meta-value"><%= author %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">작성일</span>
					<span class="meta-value"><%= date %></span>
				</div>
				<div class="meta-item">
					<span class="meta-label">조회수</span>
					<span class="meta-value number"><%= String.format("%,d", views) %></span>
				</div>
			</div>
			
			<div class="admin-info-box">
				<div class="admin-info-title">
					<span>🛡️</span>
					<span>관리자 전용 페이지</span>
				</div>
				<div class="admin-info-content">
					이 페이지는 관리자만 접근할 수 있습니다. 우측 상단의 수정/삭제 버튼으로 공지사항을 관리할 수 있습니다.
				</div>
			</div>
			
			<div class="notice-content">
				<p>안녕하세요, 공모자들 운영팀입니다.</p>
				
				<p>2025년 새해를 맞이하여 더 나은 서비스를 제공하기 위해 다음과 같은 업데이트를 진행하였습니다.</p>
				
				<p><strong>주요 업데이트 내용:</strong></p>
				
				<ul>
					<li><strong>모임 검색 기능 개선</strong>: 키워드, 지역, 카테고리별 상세 검색이 가능해졌습니다.</li>
					<li><strong>알림 기능 추가</strong>: 내가 참여한 모임의 새 소식을 실시간으로 받아볼 수 있습니다.</li>
					<li><strong>프로필 커스터마이징</strong>: 프로필 사진과 소개글을 자유롭게 수정할 수 있습니다.</li>
					<li><strong>모임 후기 시스템</strong>: 참여한 모임에 대한 후기를 작성하고 공유할 수 있습니다.</li>
					<li><strong>UI/UX 개선</strong>: 더 직관적이고 사용하기 편한 인터페이스로 개선되었습니다.</li>
				</ul>
				
				<p><strong>업데이트 일정:</strong></p>
				<ul>
					<li>업데이트 적용: 2025년 1월 5일 (일) 오전 6시</li>
					<li>서비스 점검 시간: 약 2시간 예상</li>
					<li>점검 중에는 일시적으로 서비스 이용이 제한될 수 있습니다.</li>
				</ul>
				
				<p><strong>추가 안내사항:</strong></p>
				<p>모바일 앱은 스토어에서 최신 버전으로 업데이트해주시기 바랍니다. 업데이트 후에도 문제가 지속되는 경우 고객센터로 문의해주시면 신속하게 도와드리겠습니다.</p>
				
				<p>앞으로도 더 나은 서비스를 제공할 수 있도록 최선을 다하겠습니다.</p>
				
				<p>감사합니다.</p>
				
				<p style="margin-top: 30px; color: #666; font-size: 14px;">
					- 공모자들 운영팀 드림
				</p>
			</div>
			
			<div class="notice-footer">
				<div class="footer-info">
					최종 수정일: 2025-01-05 14:23
				</div>
				<div class="footer-buttons">
					<a href="noticelist.do" class="btn btn-list">
						<span>📋</span>
						<span>목록으로</span>
					</a>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		// 수정 페이지로 이동
		function editNotice(id) {
		    if (confirm('이 공지사항을 수정하시겠습니까?')) {
		        window.location.href = 'noticemodify.do?noticeNum=' + id;
		    }
		}
		
		// 삭제 처리
		function deleteNotice(id) {
			if (confirm('정말로 이 공지사항을 삭제하시겠습니까?\n삭제된 내용은 복구할 수 없습니다.')) {
				// 재확인
				if (confirm('삭제를 진행하시겠습니까?')) {
					// 실제로는 서버로 삭제 요청
					alert('공지사항이 삭제되었습니다.');
					window.location.href = 'ManagerNoticeList.jsp';
				}
			}
		}
		
		// 조회수 증가 (페이지 로드시 1회)
		window.addEventListener('load', function() {
			// 실제로는 서버에 조회수 증가 요청
			console.log('조회수 증가 요청: 공지사항 ID <%= noticeId %>');
		});
	</script>
</body>
</html>