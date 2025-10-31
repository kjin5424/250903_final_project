<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 게시글 상세보기</title>
    <style>
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
        .nav-right {
            display: flex;
            align-items: center;
            margin-left: auto;
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
        .tab {
            background: #8bc683;
            color: white;
            border: none;
            padding: 0 24px;
            height: 36px;
            border-radius: 8px 8px 0 0;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s ease;
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
            font-weight: 500;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* 게시글 컨테이너 */
        .post-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        /* 게시글 헤더 */
        .post-header {
            padding: 30px;
            border-bottom: 2px solid #f0f0f0;
        }
        .post-category {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 15px;
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .category-notice {
            background: #f44336;
            color: white;
        }
        .category-activity {
            background: #4CAF50;
            color: white;
        }
        .category-question {
            background: #2196f3;
            color: white;
        }
        .category-resource {
            background: #ff9800;
            color: white;
        }
        .category-free {
            background: #9c27b0;
            color: white;
        }
        .post-title {
            font-size: 26px;
            color: #2d5a29;
            font-weight: bold;
            margin-bottom: 20px;
            line-height: 1.4;
        }
        .post-meta {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            color: #666;
            font-size: 14px;
        }
        .post-meta-item {
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .post-author-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .author-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #8bc683;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
        }
        .author-name {
            font-weight: 600;
            color: #333;
        }

        /* 게시글 본문 */
        .post-content {
            padding: 40px 30px;
            border-bottom: 2px solid #f0f0f0;
            min-height: 300px;
            line-height: 1.8;
            font-size: 15px;
            color: #333;
        }

     

        /* 버튼 영역 */
        .post-actions {
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f0f0f0;
        }
        .reaction-buttons {
            display: flex;
            gap: 10px;
        }
        .btn-reaction {
            padding: 10px 20px;
            border: 2px solid #e0e0e0;
            background: white;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .btn-reaction:hover {
            border-color: #8bc683;
            background: #f0f8f0;
        }
        .btn-reaction.active {
            border-color: #4CAF50;
            background: #e8f5e9;
            color: #4CAF50;
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
            transition: all 0.3s;
        }
        .btn-edit {
            background: #2196F3;
            color: white;
        }
        .btn-edit:hover {
            background: #1976D2;
            transform: translateY(-2px);
        }
        .btn-delete {
            background: #f44336;
            color: white;
        }
        .btn-delete:hover {
            background: #d32f2f;
            transform: translateY(-2px);
        }

        /* 댓글 섹션 */
        .comments-section {
            padding: 30px;
        }
        .comments-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d5a29;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .comment-count {
            color: #4CAF50;
        }

        /* 댓글 작성 */
        .comment-write {
            background: #f8faf8;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 30px;
        }
        .comment-textarea {
            width: 100%;
            padding: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            font-size: 14px;
            resize: vertical;
            min-height: 100px;
            font-family: inherit;
            margin-bottom: 10px;
        }
        .comment-textarea:focus {
            outline: none;
            border-color: #8bc683;
        }
        .comment-submit-area {
            display: flex;
            justify-content: flex-end;
        }
        .btn-submit-comment {
            padding: 10px 30px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-submit-comment:hover {
            background: #45a049;
            transform: translateY(-2px);
        }

        /* 댓글 리스트 */
        .comment-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .comment-item {
            padding: 20px;
            background: #f8faf8;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
        }
        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        .comment-author-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .comment-author-name {
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        .comment-date {
            font-size: 12px;
            color: #999;
        }
        .comment-actions {
            display: flex;
            gap: 8px;
        }
        .btn-comment-action {
            padding: 4px 10px;
            background: transparent;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 12px;
            cursor: pointer;
            color: #666;
            transition: all 0.3s;
        }
        .btn-comment-action:hover {
            background: white;
            border-color: #8bc683;
            color: #2d5a29;
        }
        .comment-content {
            font-size: 14px;
            color: #333;
            line-height: 1.6;
        }

        /* 하단 네비게이션 */
        .bottom-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
        }
        .btn-list {
            padding: 12px 30px;
            background: #757575;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-list:hover {
            background: #616161;
            transform: translateY(-2px);
        }
        .prev-next-nav {
            display: flex;
            gap: 15px;
        }
        .nav-link {
            padding: 10px 20px;
            background: white;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            color: #666;
        }
        .nav-link:hover {
            border-color: #8bc683;
            background: #f0f8f0;
            color: #2d5a29;
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 15px;
            }
            .post-header,
            .post-content,
            .post-actions,
            .comments-section {
                padding: 20px 15px;
            }
            .post-title {
                font-size: 20px;
            }
            .post-actions {
                flex-direction: column;
                gap: 15px;
                align-items: stretch;
            }
            .reaction-buttons,
            .action-buttons {
                justify-content: center;
            }
            .bottom-nav {
                flex-direction: column;
                gap: 15px;
            }
            .prev-next-nav {
                width: 100%;
                flex-direction: column;
            }
            .nav-link {
                text-align: center;
            }
        }
    </style>
    <script>
        function toggleReaction(type) {
            const btn = event.target.closest('.btn-reaction');
            btn.classList.toggle('active');
            
            // 실제로는 서버에 좋아요/공감 요청
            console.log('Reaction:', type);
        }

        function editPost() {
            if (confirm('게시글을 수정하시겠습니까?')) {
                window.location.href = 'board_edit.jsp?id=1';
            }
        }

        function deletePost() {
            if (confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
                alert('게시글이 삭제되었습니다.');
                window.location.href = 'postlist.do';
            }
        }

        function submitComment() {
            const textarea = document.getElementById('commentText');a
            const content = textarea.value.trim();
            
            if (!content) {
                alert('댓글 내용을 입력해주세요.');
                return;
            }
            
            // 실제로는 서버에 댓글 등록 요청
            alert('댓글이 등록되었습니다.');
            textarea.value = '';
            
            // 댓글 목록 새로고침 (실제로는 동적으로 추가)
        }

        function editComment(commentId) {
            alert('댓글 수정 기능 (준비중)');
        }

        function deleteComment(commentId) {
            if (confirm('댓글을 삭제하시겠습니까?')) {
                alert('댓글이 삭제되었습니다.');
                // 실제로는 서버에 삭제 요청 후 DOM 업데이트
            }
        }

       

        function downloadFile(filename) {
            alert('다운로드: ' + filename);
            // 실제 다운로드 처리
        }
    </script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab">
                <span>로고 들어갈 자리</span>
            </div>
            <a href="?page=notice" class="tab">공지사항</a>
            <a href="?page=groups" class="tab">모임구경</a>
            <a href="?page=creategroup" class="tab">모임 개설</a>
            <a href="?page=mygroups" class="tab active">내 모임</a>
        </div>
        <div class="nav-right">
            <a href="mypage.jsp" class="profile-btn">
                <span>👤</span>
                <span>마이페이지</span>
            </a>
        </div>
    </nav>

    <div class="container">
        <div class="post-container">
            <!-- 게시글 헤더 -->
            <div class="post-header">
                <span class="post-category category-notice">공지</span>
                <h1 class="post-title">📢 이번 주 스터디 일정 안내</h1>
                <div class="post-meta">
                    <div class="post-meta-item post-author-info">
                        <div class="author-avatar">코</div>
                        <span class="author-name">코딩마스터</span>
                    </div>
                    <div class="post-meta-item">
                        📅 2024-10-10 14:30
                    </div>
               
                    <div class="post-meta-item">
                        💬 8
                    </div>
                </div>
            </div>

            <!-- 게시글 본문 -->
            <div class="post-content">
                <p>안녕하세요, 모임원 여러분! 👋</p>
                <br>
                <p>이번 주 스터디 일정을 안내드립니다.</p>
                <br>
                <p><strong>📅 일시:</strong> 2024년 10월 15일 (화) 오후 7시</p>
                <p><strong>📍 장소:</strong> 강남역 스터디룸 (상세 주소는 별도 공지)</p>
                <p><strong>📚 주제:</strong> 동적 프로그래밍 심화 학습</p>
                <br>
                <p><strong>준비사항:</strong></p>
                <ul style="margin-left: 20px; margin-top: 10px;">
                    <li>백준 1234번, 5678번 문제 풀어오기</li>
                    <li>DP 개념 정리 노트 준비</li>
                    <li>노트북 및 충전기 필수</li>
                </ul>
                <br>
                <p>참석 여부는 댓글로 남겨주세요!</p>
                <p>많은 참여 부탁드립니다. 😊</p>
                <br>
                <p>감사합니다.</p>
            </div>

        

            <!-- 반응 및 액션 버튼 -->
            <div class="post-actions">
               
                <div class="action-buttons">
                    <button class="btn btn-edit" onclick="editPost()">✏️ 수정</button>
                    <button class="btn btn-delete" onclick="deletePost()">🗑️ 삭제</button>
                </div>
            </div>

            <!-- 댓글 섹션 -->
            <div class="comments-section">
                <h3 class="comments-title">
                    💬 댓글 <span class="comment-count">8</span>
                </h3>

                <!-- 댓글 작성 -->
                <div class="comment-write">
                    <textarea id="commentText" class="comment-textarea" 
                              placeholder="댓글을 입력하세요..."></textarea>
                    <div class="comment-submit-area">
                        <button class="btn-submit-comment" onclick="submitComment()">
                            💬 댓글 작성
                        </button>
                    </div>
                </div>

                <!-- 댓글 리스트 -->
                <div class="comment-list">
                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author-info">
                                <div class="author-avatar">개</div>
                                <div>
                                    <div class="comment-author-name">개발자지망생</div>
                                    <div class="comment-date">2024-10-10 15:20</div>
                                </div>
                            </div>
                            <div class="comment-actions">
                             
                                <button class="btn-comment-action" onclick="deleteComment(1)">삭제</button>
                            </div>
                        </div>
                        <div class="comment-content">
                            참석하겠습니다! 문제 미리 풀어갈게요 👍
                        </div>
                    </div>

                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author-info">
                                <div class="author-avatar">알</div>
                                <div>
                                    <div class="comment-author-name">알고리즘초보</div>
                                    <div class="comment-date">2024-10-10 16:45</div>
                                </div>
                            </div>
                            <div class="comment-actions">
                              
                                <button class="btn-comment-action" onclick="deleteComment(2)">삭제</button>
                            </div>
                        </div>
                        <div class="comment-content">
                            저도 참석합니다! DP 열심히 공부해갈게요 😊
                        </div>
                    </div>

                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author-info">
                                <div class="author-avatar">자</div>
                                <div>
                                    <div class="comment-author-name">자바마스터</div>
                                    <div class="comment-date">2024-10-10 17:30</div>
                                </div>
                            </div>
                            <div class="comment-actions">
                              
                                <button class="btn-comment-action" onclick="deleteComment(3)">삭제</button>
                            </div>
                        </div>
                        <div class="comment-content">
                            혹시 늦을 것 같은데 7시 30분까지는 도착 가능할까요?
                        </div>
                    </div>

                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author-info">
                                <div class="author-avatar">코</div>
                                <div>
                                    <div class="comment-author-name">코딩마스터</div>
                                    <div class="comment-date">2024-10-10 17:45</div>
                                </div>
                            </div>
                            <div class="comment-actions">
                              
                                <button class="btn-comment-action" onclick="deleteComment(4)">삭제</button>
                            </div>
                        </div>
                        <div class="comment-content">
                            @자바마스터 네, 괜찮습니다! 미리 연락 주셔서 감사합니다 👌
                        </div>
                    </div>

                    <div class="comment-item">
                        <div class="comment-header">
                            <div class="comment-author-info">
                                <div class="author-avatar">파</div>
                                <div>
                                    <div class="comment-author-name">파이썬러버</div>
                                    <div class="comment-date">2024-10-10 18:10</div>
                                </div>
                            </div>
                            <div class="comment-actions">
                                
                                <button class="btn-comment-action" onclick="deleteComment(5)">삭제</button>
                            </div>
                        </div>
                        <div class="comment-content">
                            참석합니다! 이번 주제 너무 기대돼요 🔥
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 하단 네비게이션 -->
        <div class="bottom-nav">
            <button class="btn-list" onclick="location.href='postlist.do'">📋 목록으로</button>
            <div class="prev-next-nav">
                <a href="#" class="nav-link">◀ 이전글</a>
                <a href="#" class="nav-link">다음글 ▶</a>
            </div>
        </div>
    </div>
</body>
</html>