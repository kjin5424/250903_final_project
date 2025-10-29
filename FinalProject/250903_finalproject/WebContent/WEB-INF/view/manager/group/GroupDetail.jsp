<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    String meetingCode = request.getParameter("code");
    if (meetingCode == null) meetingCode = "M001";

    // DB에서 가져올 예시 데이터
    String meetingName = "요리 스터디모임";
    String leader = "김철수";
    String status = "활동중";
    String category = "취미/요리";
    String difficulty = "중급";
    int participantCount = 12;
    int maxParticipants = 15;
    int activityCount = 8;
    String createdDate = "2025-01-10";
    String schedule = "매주 토요일 14:00~17:00";
    String location = "서울 강남";
    String description = "맛있는 요리를 함께 배우고 공유하는 모임입니다.\n주 1회 오프라인 모임을 진행하며, 서로 레시피를 공유하고 시식회를 가집니다.";
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 모임 상세보기</title>
<style>
/* 기존 List.jsp/관리자 공통 스타일 기반 */
body { margin:0; font-family:"Segoe UI", Arial, sans-serif; background:#F4EFFF; padding:40px 20px; color:#333; }
.container { max-width:1000px; margin:0 auto; background:white; padding:32px; border-radius:16px; box-shadow:0 4px 8px rgba(0,0,0,0.08); }
.header { font-size:28px; font-weight:800; text-align:center; margin-bottom:32px; }
.detail-grid { display:grid; grid-template-columns:1fr 2fr; gap:20px; margin-bottom:32px; }
.detail-label { font-weight:700; color:#666; }
.detail-value { color:#222; }
.description-box { background:#F4EFFF; padding:20px; border-radius:12px; line-height:1.6; margin-bottom:24px; }
.action-buttons { display:flex; gap:12px; flex-wrap:wrap; }
.button { padding:10px 24px; border:none; border-radius:8px; font-weight:700; cursor:pointer; font-size:14px; transition:0.2s; text-decoration:none; display:inline-block; }
.btn-back { background:#BFFCC6; color:#222; }
.btn-edit { background:#FFB3BA; color:#222; }
.btn-delete { background:#E6D6FF; color:#222; }
.button:hover { opacity:0.9; transform:translateY(-1px); }
@media (max-width:768px){ .detail-grid{ grid-template-columns:1fr; } .action-buttons{ flex-direction:column; } .button{ width:100%; } }
</style>
</head>
<body>
<div class="header">모임 상세보기</div>
<div class="container">

    <div class="detail-grid">
        <div class="detail-label">모임 코드:</div>
        <div class="detail-value"><%= meetingCode %></div>

        <div class="detail-label">모임명:</div>
        <div class="detail-value"><%= meetingName %></div>

        <div class="detail-label">모임장:</div>
        <div class="detail-value"><%= leader %></div>

        <div class="detail-label">상태:</div>
        <div class="detail-value"><%= status %></div>

        <div class="detail-label">카테고리:</div>
        <div class="detail-value"><%= category %></div>

        <div class="detail-label">난이도:</div>
        <div class="detail-value"><%= difficulty %></div>

        <div class="detail-label">참여인원:</div>
        <div class="detail-value"><%= participantCount %> / <%= maxParticipants %>명</div>

        <div class="detail-label">누적 활동:</div>
        <div class="detail-value"><%= activityCount %>회</div>

        <div class="detail-label">생성일:</div>
        <div class="detail-value"><%= createdDate %></div>

        <div class="detail-label">활동 시간:</div>
        <div class="detail-value"><%= schedule %></div>

        <div class="detail-label">지역:</div>
        <div class="detail-value"><%= location %></div>
    </div>

    <div class="description-box">
        <strong>모임 설명:</strong>
        <p><%= description %></p>
    </div>

    <div class="action-buttons">
        <a href="adminMeetingList.jsp" class="button btn-back">🔙 목록으로</a>
        <a href="editMeeting.jsp?code=<%= meetingCode %>" class="button btn-edit">✏️ 수정</a>
        <a href="deleteMeeting.jsp?code=<%= meetingCode %>" class="button btn-delete">🗑 삭제</a>
    </div>

</div>
</body>
</html>
