<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String meetingCode = "M001";
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
<title>모임 수정</title>
<style>
    :root {
        --color-primary: #5c6ac4;
        --color-primary-light: #dbe1f5;
        --color-primary-dark: #3c4aad;
        --color-accent-light: #ffe5e8;
        --color-green: #bffcc6;
        --color-bg: #f4efff;
        --shadow-sm: 0 2px 6px rgba(0,0,0,0.08);
        --radius-md: 8px;
        --radius-lg: 16px;
        --transition: 0.2s ease-in-out;
    }

    body {
        margin: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background: var(--color-bg);
        color: #222;
        padding-top: 80px;
    }

    .container {
        max-width: 1000px;
        margin: 0 auto;
        background: white;
        padding: 40px 50px;
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow-sm);
    }

    .page-title {
        font-size: 28px;
        font-weight: 800;
        color: var(--color-primary-dark);
        text-align: center;
        margin-bottom: 40px;
    }

    form {
        display: grid;
        grid-template-columns: 1fr 2fr;
        gap: 16px 24px;
    }

    label {
        font-weight: 700;
        color: #666;
        align-self: center;
    }

    input[type="text"],
    textarea {
        width: 100%;
        padding: 10px 12px;
        border: 2px solid var(--color-primary-light);
        border-radius: var(--radius-md);
        font-size: 14px;
        font-family: inherit;
        resize: none;
        transition: border var(--transition), box-shadow var(--transition);
    }

    input:focus,
    textarea:focus {
        border-color: var(--color-primary);
        box-shadow: 0 0 0 3px rgba(92, 106, 196, 0.15);
        outline: none;
    }

    input[readonly] {
        background: #f9f9f9;
        color: #777;
        border-color: #ddd;
        cursor: not-allowed;
    }

    textarea {
        height: 120px;
        line-height: 1.5;
    }

    .action-buttons {
        grid-column: 1 / span 2;
        display: flex;
        justify-content: center;
        gap: 16px;
        margin-top: 32px;
    }

    .btn {
        padding: 12px 24px;
        border: none;
        border-radius: var(--radius-md);
        font-weight: 700;
        cursor: pointer;
        font-size: 14px;
        transition: all var(--transition);
        text-decoration: none;
        display: inline-block;
        box-shadow: var(--shadow-sm);
    }

    .btn-cancel {
        background: var(--color-green);
        color: #222;
    }

    .btn-save {
        background: var(--color-primary-light);
        color: var(--color-primary-dark);
    }

    .btn:hover {
        transform: translateY(-2px);
        opacity: 0.9;
    }

    @media (max-width: 768px) {
        form {
            grid-template-columns: 1fr;
        }
        .btn {
            width: 100%;
            text-align: center;
        }
    }
</style>
</head>
<body>
<div class="container">
    <h1 class="page-title">모임 정보 수정</h1>

    <form action="updateMeeting.jsp" method="post">
        <label>모임 코드:</label>
        <input type="text" name="meetingCode" value="<%= meetingCode %>" readonly>

        <label>모임명:</label>
        <input type="text" name="meetingName" value="<%= meetingName %>">

        <label>모임장:</label>
        <input type="text" name="leader" value="<%= leader %>" readonly>

        <label>상태:</label>
        <input type="text" name="status" value="<%= status %>">

        <label>카테고리:</label>
        <input type="text" name="category" value="<%= category %>">

        <label>난이도:</label>
        <input type="text" name="difficulty" value="<%= difficulty %>">

        <label>참여인원:</label>
        <input type="text" name="participantCount" value="<%= participantCount %> / <%= maxParticipants %>명" readonly>

        <label>누적 활동:</label>
        <input type="text" name="activityCount" value="<%= activityCount %>" readonly>

        <label>생성일:</label>
        <input type="text" name="createdDate" value="<%= createdDate %>" readonly>

        <label>활동 시간:</label>
        <input type="text" name="schedule" value="<%= schedule %>">

        <label>지역:</label>
        <input type="text" name="location" value="<%= location %>">

        <label>모임 설명:</label>
        <textarea name="description"><%= description %></textarea>

        <div class="action-buttons">
            <button type="submit" class="btn btn-save">저장</button>
            <a href="adminMeetingDetail.jsp?code=<%= meetingCode %>" class="btn btn-cancel">취소</a>
        </div>
    </form>
</div>
</body>
</html>
