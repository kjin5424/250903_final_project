<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>VoteSample.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		
		$("#submitBtn").click(function() {
			
			if ($("input[name='voteResult']:checked").length === 0)
			{
				  alert('라디오 버튼을 선택해주세요.');
				  return;
			}
			
			$("#voteForm").submit();
		});
		
		$("#voteForm tr").click(function() {
			$(this).find("input[type='radio']").prop("checked", true);
		});
		
	});
</script>
</head>
<body>

<span>최근 투표</span>
<span>20xx년 xx월 xx일 (ㅇ)요일 19:00 ~ 22:00</span>
<form id="voteForm" action="vote.action">
	<table>
		<tr>
			<td>참여<input type="radio" name="voteResult" value="0"></td>
		</tr>
		<tr>
			<td>미참<input type="radio" name="voteResult" value="1"></td>
		</tr>
		<tr>
			<td><button type="button" id="submitBtn">제출</button></td>
		</tr>
	</table>
</form>
<a href="vote.action?groupId=${param.groupId }">
	<button>투표 더보기</button>
</a>

</body>
</html>