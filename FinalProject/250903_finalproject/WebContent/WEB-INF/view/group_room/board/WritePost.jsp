<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!-- 게시판 글쓰기 버튼 클릭했을 때 화면 -->
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공모자들 - 글쓰기</title>
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .nav-left {
            display: flex; align-items: center; gap: 4px;
        }
        .logo-tab {
            background: #8bc683;
            color: white;
            padding: 0 20px;
            height: 36px;
            border-radius: 8px 8px 0 0;
            display: flex;
            align-items: center;
            font-weight: bold;
            cursor: pointer;
        }
        .tab {
            background: #8bc683;
            color: white;
            border: none;
            padding: 0 20px;
            height: 36px;
            border-radius: 8px 8px 0 0;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: flex;
            align-items: center;
        }
        .tab.active {
            background: #f5f7fa;
            color: #2d5a29;
            height: 40px;
        }
        .profile-btn {
            background: #2d5a29;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 6px;
            margin-left: auto;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .board-title {
            font-size: 24px;
            color: #2d5a29;
            font-weight: bold;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }
        .form-group input[type="text"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.2s;
        }
        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: #8bc683;
            outline: none;
        }
        textarea {
            resize: vertical;
            height: 250px;
        }
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        .btn {
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-primary {
            background: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background: #45a049;
        }
        .btn-secondary {
            background: #ccc;
            color: #333;
        }
        .btn-secondary:hover {
            background: #b0b0b0;
        }
    </style>
    <script>
        function submitPost() {
            const title = document.getElementById('title').value.trim();
            const category = document.getElementById('category').value;
            const content = document.getElementById('content').value.trim();

            if (!title) {
                alert("제목을 입력해주세요.");
                return;
            }
            if (!content) {
                alert("내용을 입력해주세요.");
                return;
            }

            alert("글이 등록되었습니다!");
            window.location.href = "/postlist.do"; // 등록 후 게시판으로 이동
        }
        function cancelWrite() {
            if (confirm("글쓰기를 취소하시겠습니까?")) {
                window.location.href = "/postlist.do";
            }
        }
    </script>
</head>
<body>
    <!-- 상단 네비게이션 -->
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab">로고 들어갈 자리</div>
            <a href="board.jsp" class="tab active">게시판</a>
            <a href="?page=groups" class="tab">모임구경</a>
            <a href="?page=creategroup" class="tab">모임 개설</a>
        </div>
        <a href="mypage.jsp" class="profile-btn">👤 마이페이지</a>
    </nav>

    <div class="container">
        <h1 class="board-title">✏  글쓰기</h1>

        <div class="form-group">
            <label for="category">카테고리</label>
            <select id="category">
                <option value="notice">공지</option>
                <option value="activity">활동</option>
                <option value="question">질문</option>
                <option value="resource">자료</option>
                <option value="free">자유</option>
            </select>
        </div>

        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" placeholder="제목을 입력하세요">
        </div>

        <div class="form-group">
            <label for="content">내용</label>
            <textarea id="content" placeholder="내용을 입력하세요"></textarea>
        </div>

        <div class="form-actions">
            <button class="btn btn-secondary" onclick="cancelWrite()">취소</button>
            <button class="btn btn-primary" onclick="submitPost()">등록</button>
        </div>
    </div>
</body>
</html>








