<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String noticeNum = request.getParameter("noticeNum");
    if (noticeNum == null) noticeNum = "23";

    int num = Integer.parseInt(noticeNum);

    String title = "";
    String author = "";
    String date = "";
    String content = "";

    switch(num) {
        case 23:
            title = "2025년 새해 맞이 서비스 업데이트 안내";
            author = "관리자";
            date = "2025-01-05";
            content = "<p>안녕하세요, 공모자들 운영팀입니다.</p>"
                    + "<p>2025년 새해를 맞이하여 다음과 같은 서비스 업데이트를 진행했습니다.</p>"
                    + "<ul><br>"
                    + "<li>모임 검색 기능 개선</li>"
                    + "<li>알림 기능 추가</li>"
                    + "<li>프로필 커스터마이징 지원</li>"
                    + "<li>모임 관리 기능 개선</li>"
                    + "<li>모임 간 대화 기능 개선</li>"
                    + "<li>주기적 모듈 업데이트</li>"
                    + "</ul>";
            break;
        case 22:
            title = "개인정보 처리방침 변경 안내";
            author = "관리자";
            date = "2025-01-03";
            content = "<p>안녕하세요, 공모자들입니다.</p>"
                    + "<p>법령 개정에 따라 개인정보 처리방침이 다음과 같이 변경됩니다.</p>"
                    + "<ul><li>변경일자: 2025-01-10</li><li>주요 변경 내용: 수집 항목 및 보유 기간</li></ul>";
            break;
        case 21:
            title = "서버 점검 일정 안내 (1월 15일)";
            author = "관리자";
            date = "2025-01-02";
            content = "<p>1월 15일 오전 2시부터 6시까지 서버 점검이 예정되어 있습니다.</p>"
                    + "<p>이 시간 동안 서비스 이용이 제한될 수 있습니다.</p>";
            break;
        case 20:
            title = "모임 카테고리 추가 안내";
            author = "운영팀";
            date = "2024-12-28";
            content = "<p>‘문화·예술’, ‘운동·건강’ 카테고리가 새롭게 추가되었습니다.</p>";
            break;
        case 19:
            title = "연말연시 고객센터 운영 시간 안내";
            author = "관리자";
            date = "2024-12-25";
            content = "<p>연말연시 기간 중 고객센터 운영 시간이 단축됩니다.</p>";
            break;
        case 18:
            title = "신규 기능 업데이트 - 모임 일정 동기화";
            author = "운영팀";
            date = "2024-12-20";
            content = "<p>모임 일정을 캘린더와 동기화할 수 있는 기능이 추가되었습니다.</p>";
            break;
        default:
            title = "공지사항을 찾을 수 없습니다.";
            content = "<p>잘못된 접근입니다.</p>";
            break;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= title %></title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 40px 20px; }
.container { max-width: 1200px; margin: 0 auto; }
.page-title { font-size: 28px; font-weight: bold; color: #2d5a29; margin-bottom: 20px; }
.notice-container { background: white; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); overflow: hidden; }
.notice-header { padding: 30px 40px; border-bottom: 2px solid #e8f5e6; }
.notice-title { font-size: 28px; font-weight: bold; color: #333; }
.notice-meta { display: flex; gap: 30px; padding: 20px 40px; background: #f8faf9; border-bottom: 1px solid #e8f5e6; }
.meta-item { font-size: 14px; color: #666; }
.meta-value { color: #2d5a29; font-weight: 600; }
.notice-content { padding: 40px; font-size: 16px; line-height: 1.8; color: #333; word-break: keep-all; }
.footer-buttons { padding: 20px 40px; }
.btn-list { background: #2d5a29; color: white; padding: 12px 24px; border-radius: 8px; text-decoration: none; }
.btn-list:hover { background: #1f4019; }
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
            <div class="meta-item">번호: <span class="meta-value"><%= num %></span></div>
            <div class="meta-item">작성자: <span class="meta-value"><%= author %></span></div>
            <div class="meta-item">작성일: <span class="meta-value"><%= date %></span></div>
        </div>
        <div class="notice-content">
            <%= content %>
        </div>
        <div class="footer-buttons">
            <a href="List.jsp" class="btn-list">📋 목록으로</a>
        </div>
    </div>
</div>
</body>
</html>
