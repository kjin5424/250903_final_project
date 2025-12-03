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
<title>공모자들 - 글쓰기</title>

<!-- CSS 파일 임포트 -->
<link rel="stylesheet" href="<%=cp %>/css_new/common_sample.css">
<link rel="stylesheet" href="<%=cp %>/css_new/writepage.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
position = '${position}';

$(function()
{
	$("#boardCategory").change(function()
	{
		if ($("#boardCategory option:selected").val()=="notice")
		{
			if (position != '모임장' && position != '부모임장')
			{
				alert("공지를 작성할 권한이 없습니다.");
				$("#boardCategory").val("select");
				return;
			}
		}
	})
	$("#submitBtn").click(function()
	{
		var boardCategory = $("#boardCategory").val();
		var subject = $("#subject").val().trim();
		var content = $("#content").val().trim();
		
		if (boardCategory == "select") {
            alert("카테고리를 선택하세요.");
            $("#boardCategory").focus();
            return;
        }
        if (!subject) {
            alert("제목을 입력해주세요.");
            $("#subject").focus();
            return;
        }
        if (!content) {
            alert("내용을 입력해주세요.");
            $("#content").focus();
            return;
        }
        if ((position != '모임장' && position != '부모임장')
        		&& $("#boardCategory").val()=='notice')
		{
			alert("공지를 작성할 권한이 없습니다.");
			$("#boardCategory").val("select");
			return;
		}
        
        $("#formAction").submit();
	})
	$("#cancelBtn").click(function()
	{
		if (confirm("글쓰기를 취소하시겠습니까?")) {
			$(location).attr("href", "<%=cp%>/postlist.do?groupApplyCode=" + ${groupApplyCode});
		}
	})
})
</script>
</head>
<body>
<!-- 상단바 (그라디언트 영역) -->
<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
<!-- 사이드바 -->
<c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />

<!-- 메인 컨텐츠 -->
 <div class="write-container">
     <div class="write-form">
         <h1 class="write-title">✏️ 글쓰기</h1>

		<form action="postwriteOk.do" id="formAction">
	         <div class="form-group">
	             <label for="boardCategory">카테고리</label>
	             <select id="boardCategory" name="boardCategory">
	             	<option value="select">선택하세요</option>
	                 <option value="notice">공지</option>
	                 <option value="activity">활동</option>
	                 <option value="question">질문</option>
	                 <option value="resource">자료</option>
	                 <option value="free">자유</option>
	             </select>
	         </div>
	
	         <div class="form-group mt-lg">
	             <label for="subject">제목</label>
	             <input type="text" id="subject" name="subject" placeholder="제목을 입력하세요">
	         </div>
	
	         <div class="form-group mt-lg">
	             <label for="content">내용</label>
	             <textarea id="content" name="content" placeholder="내용을 입력하세요"></textarea>
	             <input type="hidden" name="joinCode" value="${joinCode }">
	        </div>
	
	        <div class="form-actions">
	            <button type="button" class="btn btn-ghost" id="cancelBtn">취소</button>
	            <button type="button" class="btn btn-primary" id="submitBtn">✅ 등록</button>
	        </div>
        </form>
    </div>
</div>
</body>
</html>