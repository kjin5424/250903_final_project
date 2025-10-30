<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 신고 완료</title>
    <style>
        /* 기존 신고 페이지와 동일한 CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
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
        .nav-left {
            display: flex;
            align-items: center;
            gap: 4px;
            flex: 1;
        }
        .logo-tab {
            background: #8bc683;
            color: white;
            padding: 0 20px;
            height: 36px;
            border-radius: 8px 8px 0 0;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .page-header {
            background: linear-gradient(135deg, #d32f2f 0%, #f44336 100%);
            color: white;
            padding: 40px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(211, 47, 47, 0.3);
            text-align: center;
        }
        .page-title {
            font-size: 32px;
            font-weight: bold;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 12px;
        }
        .header-description {
            margin-top: 15px;
            font-size: 16px;
            opacity: 0.9;
            line-height: 1.6;
        }
        .confirmation-box {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            text-align: center;
        }
        .confirmation-message {
            font-size: 18px;
            color: #333;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .btn-back, .btn-home {
            flex: 1;
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid #e0e0e0;
            background: white;
            color: #666;
        }
        .btn-back:hover, .btn-home:hover {
            border-color: #999;
            color: #333;
        }
        @media (max-width: 768px) {
            .page-header {
                padding: 25px 20px;
            }
            .page-title {
                font-size: 24px;
            }
            .button-group {
                flex-direction: column;
            }
        }
    </style>
    <script>
        function goBack() {
            history.back();
        }
        function goHome() {
            window.location.href = 'groupHome.action'; // 모임 홈 페이지로 이동
        }
    </script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab">
                <span>로고 들어갈 자리</span>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- 페이지 헤더 -->
        <div class="page-header">
            <div class="page-title">
                <span>✅</span>
                <span>신고 완료</span>
            </div>
            <div class="header-description">
                신고가 정상적으로 접수되었습니다.<br>
                모임장이 검토 후 조치가 이루어집니다.
            </div>
        </div>

        <!-- 확인 메시지 -->
        <div class="confirmation-box">
            <div class="confirmation-message">
                📌 신고 내용은 모임장에게 전달되었습니다.<br>
                허위 신고는 제재 대상이 될 수 있습니다.<br>
                감사합니다.
            </div>
            <div class="button-group">
                <button class="btn-back" onclick="goBack()">← 이전 페이지</button>
                <button class="btn-home" onclick="location.href='home.do'">모임 홈으로</button>
            </div>
        </div>
    </div>
</body>
</html>
