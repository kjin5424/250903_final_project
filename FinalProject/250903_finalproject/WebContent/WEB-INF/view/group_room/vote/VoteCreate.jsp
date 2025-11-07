<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비정기 투표 등록</title>
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="<%=cp%>/css/css_vote/votecreate.css">
<link rel="stylesheet" href="<%=cp%>/css/topsidecontent.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
$(function()
{
	$(".input-uri").css("display", "none");
	
	$("input[name='on_off']").change(function()
	{
		if($(this).val()=="online")
		{
			$(".input-location").css("display", "none");
			$(".input-uri").css("display", "block");
		}
		else if($(this).val()=="offline")
		{
			$(".input-uri").css("display", "none");
			$(".input-location").css("display", "block");
		}
	});
	
	$("#progress-time").keyup(function()
	{
		//alert("확인");
		if(parseInt($(this).val()) <= 0)
		{
			alert("활동 시간은 최소 1 이상 입력해야 합니다.");
		}
	});
	
	$("#submitBtn").click(function()
	{
		
		alert($("#start-time").val());
		
		
		//alert("확인");
		const inputDateString = $("#date").val();
		
		if(!$("#date").val())
		{
			alert("활동일을 선택해주세요.");
			return false;
		}
		
		const now = new Date();
		checkDate = now.setDate(now.getDate() + 4)		
		const inputDate = new Date(inputDateString);
		
		if(inputDate <= checkDate)
		{
			alert("활동은 등록일로부터 최소 3일 이후로 가능합니다.");
			return false;
		}
		
		if(!$("#start-time").val())
		{
			alert("활동시작 시간을 선택해주세요.");
			return false;
		}
		
		var checkOnOff = $("input[name='on_off']:checked").val();
		
		if(checkOnOff=="online")
		{
			if(!$("#uri").val())
			{
				alert("화상회의 주소를 입력해주세요.");
				return false;
			}
			const address = $("#uri").val();
		}
		else
		{
			if(!$("#location").val())
			{
				alert("활동 장소를 입력해주세요.");
				return false;
			}
			const address = $("#location").val();	
		}
		
		if(!$("#content").val())
		{
			alert("활동 내용을 입력하세요.");
			return false;
		}
		
		return true;
		
	});
	
	
});
</script>
</head>
<body>
	<!-- 상단 메뉴바 -->
	<div class="topmenubar">
		<c:import url="/WEB-INF/view/common/TopMenuBar.jsp"></c:import>
	</div>

	<!-- 좌측 메뉴바 + 본문 -->
	<div class="container">
		<div class="sidebar">
			<c:import url="/WEB-INF/view/group_room/SideBar.jsp"></c:import>
		</div>

		<div class="main">
			<form action="voteinsert.do" method="get">
				<input type="hidden" name="groupApplyCode" value="${groupApplyCode }"/>
				<input type="hidden" name="joinCode" value="${joinCode}"/>
				<div class="input-group">
					<label for="date">일자</label> <input type="date" id="date"
						name="date" required="required">
				</div>
				<div class="input-group">
					<label for="start-time">시작 시간</label> <input type="time"
						id="start-time" name="start-time">
				</div>
				
				<div class="input-group">
					<label>
						활동 내용
						<input type="text" name="content" id="content" placeholder="이번 활동의 주제를 적어주세요!"/>	
					</label>
				</div>
				
				<div class="input-group">
					<label for="progress-time">진행 시간</label> 
					
					<select id="progress-time" name="progress-time" required="required">
						<option value="1">1시간</option>
						<option value="1.5">1시간 30분</option>
						<option value="2">2시간</option>
						<option value="2.5">2시간 30분</option>
						<option value="3">3시간</option>
						<option value="3.5">3시간 30분</option>
						<option value="4">4시간</option>
						<option value="4.5">4시간 30분</option>
						<option value="5">5시간</option>
						<option value="5.5">5시간 30분</option>
						<option value="6">6시간</option>
						<option value="7.5">6시간 30분</option>						
					</select>
				</div>

					<!-- <input type="number" id="progress-time" name="progress-time" required="required"> -->

				<div class="input-group input-radio">
					<label for="offline">
						<input type="radio" name="on_off" id="offline" value="offline" checked="checked"/> 오프라인
					</label> 
					<label for="online"> 
						<input type="radio" name="on_off"id="online" value="online" /> 온라인
					</label>
				</div>

				<div class="input-group input-location">
					<label>지역<input type="text" id="location" name="location" placeholder="지역 입력"></label>
				</div>
				<div class="input-group input-uri">
					<label>링크<input type="text" id="uri" name="uri"placeholder="온라인 주소 입력"></label>
				</div>
				<div class="button-group">
					<button type="submit" class="btn-submit" id="submitBtn">등록 하기</button>
					<a href="VoteList.jsp">
					<button type="button" class="btn-back">돌아가기</button></a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>