<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비공개 게시글 안내</title>

    <!-- 기존 사이트 CSS 포함 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    
    <!-- 게시글 뷰 스타일 -->
    <style>
        /* 사용자가 제공한 CSS 전체 삽입 (생략 가능) */
        /* 🔽 여기에 위에서 주신 긴 CSS를 그대로 붙여 넣으시면 됩니다 🔽 */
        /* --- CSS 시작 --- */
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
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .post-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        .post-header {
            padding: 40px 30px;
            border-bottom: 2px solid #f0f0f0;
            text-align: center;
        }
        .blind-icon {
            font-size: 60px;
            margin-bottom: 16px;
        }
        .blind-title {
            font-size: 24px;
            font-weight: 700;
            color: #f44336;
            margin-bottom: 12px;
        }
        .blind-description {
            font-size: 16px;
            color: #555;
            line-height: 1.7;
            margin-bottom: 20px;
        }
        .post-title-box {
            display: inline-block;
            padding: 10px 20px;
            background: #f8faf8;
            border: 2px solid #f44336;
            border-radius: 8px;
            font-weight: 600;
            color: #f44336;
            margin-top: 10px;
        }
        .post-actions {
            padding: 20px 30px;
            display: flex;
            justify-content: center;
            gap: 10px;
            border-top: 2px solid #f0f0f0;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }
        .btn-list {
            background: #4CAF50;
            color: white;
        }
        .btn-list:hover {
            background: #43A047;
            transform: translateY(-2px);
        }
        .btn-contact {
            background: #757575;
            color: white;
        }
        .btn-contact:hover {
            background: #616161;
            transform: translateY(-2px);
        }
        @media (max-width: 768px) {
            .post-header { padding: 30px 20px; }
            .blind-title { font-size: 20px; }
            .btn { width: 100%; }
            .post-actions { flex-direction: column; }
        }
        /* --- CSS 끝 --- */
    </style>
</head>
<body>

    <!-- 상단 네비게이션 -->
    <div class="navbar">
        <div class="nav-left">
            <div class="logo-tab" onclick="location.href='mainpage.do'">🌿 공모자들</div>
        </div>
    </div>

    <!-- 본문 컨테이너 -->
    <div class="container">
        <div class="post-container">
            <div class="post-header">
                <div class="blind-icon">🚫</div>
                <h1 class="blind-title">이 게시글은 비공개 상태입니다</h1>
                <p class="blind-description">
                    해당 게시글은 신고 접수로 인해<br>
                    관리자 검토 중이며 현재 열람이 불가능합니다.
                </p>

                <div class="post-title-box">
                    게시글 제목: ${post.title}
                </div>
            </div>

            <div class="post-actions">
                <a href="postlist.do" class="btn btn-list">📋 게시판으로 돌아가기</a>
                <a href="profilemodify.do" class="btn btn-contact">📞 고객센터 문의</a>

            </div>
        </div>
    </div>

</body>
</html>
