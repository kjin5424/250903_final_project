<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들 - 게시물 수정</title>

<!-- CSS 파일 임포트 -->
<link rel="stylesheet" href="css_new/common_sample.css">
<link rel="stylesheet" href="css_new/topmenubar_sample.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    /* 글쓰기 페이지 전용 스타일 */
    .write-container {
        max-width: 900px;
        margin: var(--spacing-2xl) auto;
        padding: 0 var(--spacing-lg);
    }

    .write-form {
        background: var(--color-white);
        border-radius: var(--radius-lg);
        box-shadow: var(--shadow-md);
        padding: var(--spacing-xl);
    }

    .write-title {
        font-size: 24px;
        color: var(--color-text-primary);
        font-weight: 700;
        margin-bottom: var(--spacing-xl);
        display: flex;
        gap: var(--spacing-sm);
    }

    .form-actions {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: var(--spacing-md);
        margin-top: var(--spacing-xl);
    }
    
    #content{
    	min-height:300px;
    }

    /* 반응형 */
    @media (max-width: 768px) {
        .write-container {
            padding: 0 var(--spacing-md);
            margin: var(--spacing-lg) auto;
        }

        .write-form {
            padding: var(--spacing-lg);
        }

        .write-title {
            font-size: 20px;
        }

        .form-actions {
            flex-direction: column;
        }

        .form-actions .btn {
            width: 100%;
        }
    }
</style>

<script type="text/javascript">
$(function()
{
	$("#submitBtn").click(function()
	{
		var boardCategory = $("#boardCategory").val();
		var subject = $("#subject").val().trim();
		var content = $("#content").val().trim();
		
        if (!subject) {
        	alert(boardCategory);
            alert("제목을 입력해주세요.");
            $("#subject").focus();
            return;
        }
        if (!content) {
            alert("내용을 입력해주세요.");
            $("#content").focus();
            return;
        }
        
        $("#formAction").submit();
	})
	$("#cancelBtn").click(function()
	{
		var postCode = $("#postCode").val();
	
		if (confirm("수정을 취소하시겠습니까?")) {
	        $(location).attr('href', "<%=cp%>/postdetail.do?postCode=" + postCode);
	    }
	})
})
</script>



</head>
<body>
    <!-- ================================================
         상단 메뉴바
         ================================================ -->
    <!-- 상단바 (그라디언트 영역) -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

    <!-- 메인 컨텐츠 -->
    <div class="write-container">
        <div class="write-form">
            <h1 class="write-title">✏️ 게시물 수정</h1>

			<form action="posteditOk.do" id="formAction">
            <div class="form-group">
            
                <label for="boardCategory">카테고리</label>
				<select id="boardCategory" name="boardCategory">
				    <option value="notice" ${"공지" == post.boardCategory ? "selected='selected'" : ""}>공지</option>
				    <option value="activity" ${"활동" == post.boardCategory ? "selected='selected'" : ""}>활동</option>
				    <option value="question" ${"질문" == post.boardCategory ? "selected='selected'" : ""}>질문</option>
				    <option value="resource" ${"자료" == post.boardCategory ? "selected='selected'" : ""}>자료</option>
				    <option value="free" ${"자유" == post.boardCategory ? "selected='selected'" : ""}>자유</option>
				</select>
            </div>

            <div class="form-group mt-lg">
                <label for="subject">제목</label>
                <input type="text" id="subject" name="subject" value="${post.subject }" placeholder="제목을 입력하세요">
                <input type="hidden" id="postCode" name="postCode" value="${post.postCode }"/>
            </div>

            <div class="form-group mt-lg">
                <label for="content">내용</label>
                <textarea id="content" name="content" placeholder="내용을 입력하세요">${post.content}</textarea>
            </div>

            <div class="form-actions">
                <button type="button" class="btn btn-ghost" id="cancelBtn">취소</button>
                <button type="button" class="btn btn-primary" id="submitBtn">✅ 수정하기</button>
            </div>
            </form>
        </div>
    </div>
</body>
</html>
