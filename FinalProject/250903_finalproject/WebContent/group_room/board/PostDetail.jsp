<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>공모자들 - 게시글 보기</title>

    <style>

        body {

            font-family: "Noto Sans KR", sans-serif;

            background: #f8fafc;

            margin: 0;

            padding: 0;

        }



        .container {

            width: 80%;

            max-width: 900px;

            margin: 60px auto;

            background: white;

            border-radius: 12px;

            box-shadow: 0 4px 10px rgba(0,0,0,0.08);

            padding: 40px;

        }



        .post-title {

            font-size: 26px;

            font-weight: bold;

            color: #222;

            margin-bottom: 10px;

        }



        .post-info {

            font-size: 14px;

            color: #777;

            margin-bottom: 25px;

            border-bottom: 1px solid #eee;

            padding-bottom: 10px;

        }



        .post-content {

            font-size: 17px;

            line-height: 1.8;

            color: #333;

            margin-bottom: 30px;

            white-space: pre-line; /* 줄바꿈 적용 */

        }



        .post-actions {

            display: flex;

            justify-content: space-between;

        }



        .btn {

            padding: 8px 16px;

            border: none;

            border-radius: 8px;

            font-size: 14px;

            cursor: pointer;

            transition: 0.2s;

        }



        .btn-back {

            background-color: #e0e7ff;

            color: #1e40af;

        }



        .btn-edit {

            background-color: #fef08a;

            color: #854d0e;

        }



        .btn-delete {

            background-color: #fecaca;

            color: #991b1b;

        }



        .btn:hover {

            opacity: 0.9;

        }



        .comment-section {

            border-top: 1px solid #eee;

            padding-top: 20px;

            margin-top: 30px;

        }



        .comment-title {

            font-weight: bold;

            margin-bottom: 10px;

        }



        .comment {

            background: #f9fafb;

            border-radius: 8px;

            padding: 10px 15px;

            margin-bottom: 10px;

        }



        .comment small {

            color: #888;

        }

    </style>

</head>

<body>

<div class="container">

    <div class="post-title">스터디 첫 모임 후기 😊</div>



    <div class="post-info">

        작성자: <strong>코딩마스터</strong> &nbsp;|&nbsp;

        작성일: 2025-10-19 &nbsp;|&nbsp;

        조회수: 123

    </div>



    <div class="post-content">

        안녕하세요! 오늘은 공모자들 스터디 첫 모임을 진행했습니다 🎉



        생각보다 많은 분들이 와주셔서 분위기가 정말 좋았어요.

        다음 주에는 알고리즘 문제풀이 중심으로 진행할 예정입니다.



        모두 수고 많으셨고, 앞으로도 함께 성장해요 💪

    </div>



    <div class="post-actions">

        <button class="btn btn-back" onclick="location.href='group_board_list.jsp'">목록으로</button>

        <div>

            <button class="btn btn-edit">수정</button>

            <button class="btn btn-delete">삭제</button>

        </div>

    </div>



    <div class="comment-section">

        <div class="comment-title">💬 댓글 (2)</div>



        <div class="comment">

            <strong>자바초보</strong> : 너무 유익했어요! 다음 주도 기대됩니다 😄  

            <br><small>2025-10-19 15:42</small>

        </div>



        <div class="comment">

            <strong>알고리즘러버</strong> : 문제 풀이 같이 해보니까 확실히 동기부여가 되네요!

            <br><small>2025-10-19 16:03</small>

        </div>



        <textarea rows="3" style="width:100%; margin-top:10px; border-radius:8px; padding:10px;" placeholder="댓글을 입력하세요..."></textarea>

        <button class="btn btn-back" style="margin-top:10px;">댓글 등록</button>

    </div>

</div>

</body>

</html>