<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 목록에서 넘어온 게시물 번호
    String noticeNum = request.getParameter("noticeNum");
    if (noticeNum == null) noticeNum = "23";

    // 실제 DB 조회 (예시 데이터)
    String title = "2025년 새해 맞이 서비스 업데이트 안내";
    String author = "관리자";
    String date = "2025-01-05";
    int views = 1523;
    int noticeNumber = Integer.parseInt(noticeNum);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 상세보기</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 40px 20px; }
.container { max-width: 1200px; margin: 0 auto; }
.page-title { font-size: 28px; font-weight: bold; color: #2d5a29; margin-bottom: 20px; }
.notice-container { background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); overflow: hidden; }
.notice-header { padding: 30px 40px; border-bottom: 2px solid #e8f5e6; }
.notice-title { font-size: 28px; font-weight: bold; color: #333; line-height: 1.4; word-break: keep-all; }
.notice-meta { display: flex; gap: 30px; flex-wrap: wrap; padding: 20px 40px; background: #f8faf9; border-bottom: 1px solid #e8f5e6; }
.meta-item { display: flex; align-items: center; gap: 6px; font-size: 14px; color: #666; }
.meta-value { color: #2d5a29; font-weight: 600; }
.notice-content { padding: 40px; font-size: 16px; line-height: 1.8; color: #333; word-break: keep-all; }
.notice-content p { margin-bottom: 16px; }
.notice-content ul { margin-left: 24px; margin-bottom: 16px; }
.notice-content li { margin-bottom: 8px; }
.footer-buttons { display: flex; justify-content: flex-start; gap: 10px; padding: 20px 40px; }
.btn-list { background: #2d5a29; color: white; padding: 12px 24px; border-radius: 8px; text-decoration: none; display: flex; align-items: center; gap: 6px; transition: all 0.2s ease; }
.btn-list:hover { background: #1f4019; transform: translateY(-2px); }

/* 반응형 */
@media (max-width: 768px) {
    .container { padding: 20px 10px; }
    .page-title { font-size: 24px; }
    .notice-header, .notice-meta, .notice-content, .footer-buttons { padding: 20px; }
    .notice-title { font-size: 22px; }
}
</style>
</head>
<body>
<div class="container">
    <h1 class="page-title">📢 공지사항</h1>
    
    <div class="notice-container">
        <div class="notice-header">
            <h2 class="notice-title"><%= title %></h2>
        </div>
        
        <div class="notice-meta">
            <div class="meta-item">번호: <span class="meta-value"><%= noticeNumber %></span></div>
            <div class="meta-item">작성자: <span class="meta-value"><%= author %></span></div>
            <div class="meta-item">작성일: <span class="meta-value"><%= date %></span></div>
            <div class="meta-item">조회수: <span class="meta-value"><%= String.format("%,d", views) %></span></div>
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
                <li>적용: 2025-01-05 오전 6시</li>
                <li>서비스 점검: 약 2시간</li>
                <li>점검 중 일시적 이용 제한 가능</li>
            </ul>
            <p>모바일 앱 최신 버전 업데이트 필요. 문제 발생 시 고객센터 문의.</p>
            <p style="margin-top: 30px; color: #666; font-size: 14px;">- 공모자들 운영팀 드림</p>
        </div>
        
        <div class="footer-buttons">
            <!-- 목록으로 이동 -->
            <a href="List.jsp?NoticeListPage=1" class="btn-list">📋 목록으로</a>
        </div>
    </div>
</div>
</body>
</html>
