<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 쪽지함</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
        }
        .navbar {
            background: #a8d5a1;
            display: flex;
            align-items: center;
            padding: 0 20px;
            height: 48px;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            gap: 4px;
        }
        .nav-left { display: flex; align-items: center; gap: 4px; flex: 1; }
        .nav-right { display: flex; align-items: center; margin-left: auto; }
        .logo-tab { background: #8bc683; color: white; padding: 0 20px; height: 36px; border-radius: 8px 8px 0 0; display: flex; align-items: center; gap: 8px; font-weight: bold; font-size: 16px; cursor: pointer; }
        .tab { background: #8bc683; color: white; border: none; padding: 0 24px; height: 36px; border-radius: 8px 8px 0 0; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.2s ease; text-decoration: none; display: flex; align-items: center; }
        .tab.active { background: #f5f7fa; color: #2d5a29; height: 40px; }
        .profile-btn { background: #2d5a29; color: white; border: none; padding: 8px 20px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500; text-decoration: none; display: flex; align-items: center; gap: 6px; }

        .container { max-width: 1400px; margin: 30px auto; padding: 0 20px; }

        /* 쪽지 섹션 */
        .message-section {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }
        .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .section-title { font-size: 20px; font-weight: bold; color: #2d5a29; display: flex; align-items: center; gap: 8px; }
        .tab-btns { display: flex; gap: 10px; }
        .tab-btns button { padding: 8px 15px; border: none; border-radius: 6px; font-size: 14px; font-weight: 500; cursor: pointer; background: #e0e0e0; transition: all 0.3s; }
        .tab-btns button.active { background: #4CAF50; color: white; }
        .tab-btns button:hover { background: #8bc683; color: white; }

        .message-list { margin-top: 20px; }
        .message-item {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .message-item:hover { background: #f8faf8; }
        .message-item:last-child { border-bottom: none; }

        .msg-sender { font-weight: 600; color: #333; }
        .msg-title { margin-left: 10px; color: #555; flex: 1; }
        .msg-time { font-size: 12px; color: #999; }

        .message-content {
            margin-top: 20px;
            padding: 20px;
            background: #f0f8ff;
            border-radius: 8px;
            line-height: 1.6;
            display: none;
        }

        @media (max-width: 768px) {
            .message-item { flex-direction: column; align-items: flex-start; gap: 5px; }
        }
    </style>
    <script>
        let currentTab = 'inbox';

        function showTab(tab) {
            currentTab = tab;
            document.querySelectorAll('.tab-btns button').forEach(btn => btn.classList.remove('active'));
            document.getElementById(tab + '-btn').classList.add('active');

            document.querySelectorAll('.message-item').forEach(item => {
                if(item.dataset.type === tab) {
                    item.style.display = 'flex';
                } else {
                    item.style.display = 'none';
                }
            });

            document.querySelectorAll('.message-content').forEach(content => content.style.display = 'none');
        }

        function viewMessage(id) {
            const content = document.getElementById('msg-content-' + id);
            if(content.style.display === 'block') {
                content.style.display = 'none';
            } else {
                document.querySelectorAll('.message-content').forEach(c => c.style.display = 'none');
                content.style.display = 'block';
            }
        }

        window.onload = function() {
            showTab('inbox'); // 기본은 받은 쪽지
        }
    </script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab">로고 들어갈 자리</div>
            <a href="group_home.jsp" class="tab">모임 홈</a>
            <a href="board.jsp" class="tab">게시판</a>
            <a href="mypage.jsp" class="tab">마이페이지</a>
            <a href="message.jsp" class="tab active">쪽지함</a>
        </div>
        <div class="nav-right">
            <a href="mypage.jsp" class="profile-btn">👤 마이페이지</a>
        </div>
    </nav>

    <div class="container">
        <div class="message-section">
            <div class="section-header">
                <h2 class="section-title">✉️ 쪽지함</h2>
                <div class="tab-btns">
                    <button id="inbox-btn" onclick="showTab('inbox')">받은 쪽지</button>
                    <button id="sent-btn" onclick="showTab('sent')">보낸 쪽지</button>
                </div>
            </div>

            <div class="message-list">
                <!-- 받은 쪽지 더미 -->
                <div class="message-item" data-type="inbox" onclick="viewMessage(1)">
                    <span class="msg-sender">이유빙빙</span>
                    <span class="msg-title">모임 별로입니다.</span>
                    <span class="msg-time">2024-10-12</span>
                </div>
                <div class="message-content" id="msg-content-1">
                    안녕하세요! 이번 주 스터디 일정은 목요일 19:00~21:00입니다. 온라인으로 진행 예정이니 참고해주세요.
                </div>

                <div class="message-item" data-type="inbox" onclick="viewMessage(2)">
                    <span class="msg-sender">알고리즘초보</span>
                    <span class="msg-title">질문 있습니다!</span>
                    <span class="msg-time">2024-10-11</span>
                </div>
                <div class="message-content" id="msg-content-2">
                    어쩌구 저쩌구
                </div>

                <!-- 보낸 쪽지 더미 -->
                <div class="message-item" data-type="sent" onclick="viewMessage(3)">
                    <span class="msg-sender">나</span>
                    <span class="msg-title">스터디 일정 확인했습니다</span>
                    <span class="msg-time">2024-10-12</span>
                </div>
                <div class="message-content" id="msg-content-3">
                    감사합니다! 목요일에 꼭 참여하겠습니다.
                </div>

                <div class="message-item" data-type="sent" onclick="viewMessage(4)">
                    <span class="msg-sender">나</span>
                    <span class="msg-title">질문 답변 드립니다</span>
                    <span class="msg-time">2024-10-11</span>
                </div>
                <div class="message-content" id="msg-content-4">
                   어쩌구 저쩌구 
                </div>
            </div>
        </div>
    </div>
</body>
</html>
