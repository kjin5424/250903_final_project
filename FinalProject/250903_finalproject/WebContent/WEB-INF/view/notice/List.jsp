<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String pageNum = request.getParameter("NoticeListPage");
    if(pageNum == null) pageNum = "1";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>사용자 공지사항 리스트</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 40px 20px; }
.container { max-width: 1200px; margin: 0 auto; }
.header { display: flex; align-items: center; margin-bottom: 30px; }
.page-title { font-size: 28px; font-weight: bold; color: #2d5a29; }

.table-container { background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); overflow: hidden; }
.notice-table { width: 100%; border-collapse: collapse; }
.notice-table thead { background: #f8faf9; }
.notice-table th { padding: 16px; text-align: left; font-weight: 600; color: #2d5a29; border-bottom: 2px solid #e8f5e6; }
.notice-table td { padding: 16px; border-bottom: 1px solid #f0f0f0; color: #333; }
.notice-table tbody tr { transition: all 0.2s ease; cursor: pointer; }
.notice-table tbody tr:hover { background: #f8faf9; }
.notice-number { font-weight: 600; color: #2d5a29; }
.notice-title { font-weight: 500; color: #333; max-width: 400px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.notice-title.pinned { display: flex; align-items: center; gap: 8px; }
.pin-badge { background: #ff6b6b; color: white; padding: 2px 8px; border-radius: 10px; font-size: 11px; font-weight: bold; }
.author, .views, .date { color: #666; font-size: 14px; }
.date { color: #999; font-size: 13px; }

.pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 30px; }
.page-btn { padding: 8px 14px; border: 1px solid #e0e0e0; background: white; border-radius: 6px; cursor: pointer; font-size: 14px; color: #666; text-decoration: none; transition: all 0.2s ease; }
.page-btn:hover { border-color: #a8d5a1; color: #2d5a29; }
.page-btn.active { background: #2d5a29; color: white; border-color: #2d5a29; }
.page-btn:disabled { cursor: not-allowed; opacity: 0.4; }

a { text-decoration: none; color: inherit; }
</style>
</head>
<body>
<!-- 상단 메뉴바 -->
<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
<div class="container">
	<div class="header">
		<h1 class="page-title">📢 공지사항</h1>
	</div>

	<div class="table-container">
		<table class="notice-table">
			<thead>
				<tr>
					<th style="width: 80px;">번호</th>
					<th style="width: 120px;">작성자</th>
					<th>제목</th>
					<th style="width: 120px;">게시일</th>
				</tr>
			</thead>
			<tbody>
				<tr onclick="location.href='Detail.jsp?noticeNum=23'">
					<td class="notice-number">23</td>
					<td class="author">관리자</td>
					<td>
						<div class="notice-title pinned">
							<span class="pin-badge">공지</span>
							<span>2025년 새해 맞이 서비스 업데이트 안내</span>
						</div>
					</td>
					<td class="date">2025-01-05</td>
				</tr>
				<tr onclick="location.href='Detail.jsp?noticeNum=22'">
					<td class="notice-number">22</td>
					<td class="author">관리자</td>
					<td>
						<div class="notice-title pinned">
							<span class="pin-badge">공지</span>
							<span>개인정보 처리방침 변경 안내</span>
						</div>
					</td>
					<td class="date">2025-01-03</td>
				</tr>
				<tr onclick="location.href='Detail.jsp?noticeNum=21'">
					<td class="notice-number">21</td>
					<td class="author">관리자</td>
					<td>
						<div class="notice-title pinned">
							<span class="pin-badge">공지</span>
							<span>서버 점검 일정 안내 (1월 15일)</span>
						</div>
					</td>
					<td class="date">2025-01-02</td>
				</tr>
				<tr onclick="location.href='Detail.jsp?noticeNum=20'">
					<td class="notice-number">20</td>
					<td class="author">운영팀</td>
					<td class="notice-title">모임 카테고리 추가 안내</td>
					<td class="date">2024-12-28</td>
				</tr>
				<tr onclick="location.href='Detail.jsp?noticeNum=19'">
					<td class="notice-number">19</td>
					<td class="author">관리자</td>
					<td class="notice-title">연말연시 고객센터 운영 시간 안내</td>
					<td class="date">2024-12-25</td>
				</tr>
				<tr onclick="location.href='Detail.jsp?noticeNum=18'">
					<td class="notice-number">18</td>
					<td class="author">운영팀</td>
					<td class="notice-title">신규 기능 업데이트 - 모임 일정 동기화</td>
					<td class="date">2024-12-20</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

    <div class="pagination">
        <button class="page-btn" disabled>◀</button>
        <button class="page-btn active">1</button>
        <a href="List.jsp?NoticeListPage=2" class="page-btn">2</a>
        <a href="List.jsp?NoticeListPage=3" class="page-btn">3</a>
        <button class="page-btn">▶</button>
    </div>
</div>

</body>
</html>
