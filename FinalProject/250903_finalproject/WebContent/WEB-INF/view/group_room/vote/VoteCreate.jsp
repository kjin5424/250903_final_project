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
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>투표 등록</title>
<link rel="stylesheet" href="<%=cp %>/css_new/common_sample.css" />
<link rel="stylesheet" href="<%=cp %>/css_new/board_sample.css" />
<link rel="stylesheet" href="<%=cp %>/css_new/vote_sample.css" />
<link rel="stylesheet" href="<%=cp %>/css_new/home_sample.css" />

<style>
/* 폼 그룹 스타일 */
.form-group { margin-bottom: 24px; }
.form-label { 
    display: block; 
    margin-bottom: 8px; 
    font-weight: 600; 
    color: var(--color-text-primary); 
    font-size: 14px; 
}
.form-control { width: 100%; }
input[type="date"], input[type="time"] {
    width: 100%;
    padding: 12px 16px;
    border: 2px solid var(--color-border);
    border-radius: var(--radius-md);
    font-size: 14px;
    transition: all var(--transition-fast);
}
.radio-group { display: flex; gap: 20px; margin-top: 8px; }
.radio-label { display: flex; align-items: center; gap: 8px; cursor: pointer; }
.button-group { display: flex; gap: 12px; margin-top: 32px; }
.button-group .btn { flex: 1; }
</style>

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
		if(parseInt($(this).val()) <= 0)
		{
			alert("활동 시간은 최소 1 이상 입력해야 합니다.");
		}
	});
	
	$("#submitBtn").click(function()
	{
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
		}
		else
		{
			if(!$("#location").val())
			{
				alert("활동 장소를 입력해주세요.");
				return false;
			}
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
<c:import url="/WEB-INF/view/common/TopMenuBar.jsp"/>

<!-- 사이드바 -->
<c:import url="/WEB-INF/view/common/GroupSideBar.jsp"/>

<!-- 메인 콘텐츠 -->
<div class="main-container">
	<div class="board-container">
		<!-- 게시판 헤더 -->
		<div class="board-header">
			<h2 class="board-title">
				<span class="board-title-icon">🗳️</span>
				새 투표 만들기
			</h2>
		</div>
		
		<!-- 투표 생성 폼 -->
		<form action="voteinsert.do" method="get">
			<input type="hidden" name="groupApplyCode" value="${groupApplyCode}"/>
			<input type="hidden" name="joinCode" value="${joinCode}"/>
			
			<!-- 활동 내용 -->
			<div class="form-group">
				<label class="form-label" for="content">
					<span>📝</span> 활동 내용
				</label>
				<input type="text" 
				       id="content" 
				       name="content" 
				       class="form-control" 
				       placeholder="이번 활동의 주제를 적어주세요!" 
				       required/>
			</div>
			
			<!-- 활동 일자 -->
			<div class="form-group">
				<label class="form-label" for="date">
					<span>📅</span> 활동 일자
				</label>
				<input type="date" 
				       id="date" 
				       name="date" 
				       class="form-control" 
				       required/>
			</div>
			
			<!-- 시작 시간 -->
			<div class="form-group">
				<label class="form-label" for="start-time">
					<span>🕐</span> 시작 시간
				</label>
				<input type="time" 
				       id="start-time" 
				       name="start-time" 
				       class="form-control" 
				       required/>
			</div>
			
			<!-- 진행 시간 -->
			<div class="form-group">
				<label class="form-label" for="progress-time">
					<span>⏱️</span> 진행 시간
				</label>
				<select id="progress-time" 
				        name="progress-time" 
				        class="form-control" 
				        required>
					<option value="">선택하세요</option>
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
					<option value="6.5">6시간 30분</option>
				</select>
			</div>
			
			<!-- 진행 방식 -->
			<div class="form-group">
				<label class="form-label">
					<span>🌐</span> 진행 방식
				</label>
				<div class="radio-group">
					<label class="radio-label">
						<input type="radio" 
						       name="on_off" 
						       id="offline" 
						       value="offline" 
						       checked/>
						<span>오프라인</span>
					</label>
					<label class="radio-label">
						<input type="radio" 
						       name="on_off" 
						       id="online" 
						       value="online"/>
						<span>온라인</span>
					</label>
				</div>
			</div>
			
			<!-- 오프라인 장소 -->
			<div class="form-group input-location">
				<label class="form-label" for="location">
					<span>📍</span> 활동 장소
				</label>
				<input type="text" 
				       id="location" 
				       name="location" 
				       class="form-control" 
				       placeholder="오프라인 활동 장소를 입력하세요"/>
			</div>
			
			<!-- 온라인 링크 -->
			<div class="form-group input-uri">
				<label class="form-label" for="uri">
					<span>🔗</span> 화상회의 링크
				</label>
				<input type="text" 
				       id="uri" 
				       name="uri" 
				       class="form-control" 
				       placeholder="온라인 회의 주소를 입력하세요 (예: Zoom, Google Meet)"/>
			</div>
			
			<!-- 버튼 그룹 -->
			<div class="button-group">
				<button type="submit" class="btn btn-primary" id="submitBtn">
					<span>✓</span>
					<span>투표 등록하기</span>
				</button>
				<a href="votelist.do?groupApplyCode=${groupApplyCode}" style="flex: 1;">
					<button type="button" class="btn btn-ghost" style="width: 100%;">
						<span>←</span>
						<span>돌아가기</span>
					</button>
				</a>
			</div>
		</form>
	</div>
</div>

</body>
</html>
