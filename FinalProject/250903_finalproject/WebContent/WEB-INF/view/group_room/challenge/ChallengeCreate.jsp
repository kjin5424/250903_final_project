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
<title>도전과제 작성 화면</title>
<link rel="stylesheet" href="<%=cp%>/css/css_challenge/challengecreate.css" />
<link rel="stylesheet" href="<%=cp%>/css/topsidecontent.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function()
	{
		$(".radio-group input[type='radio']").change(function()
		{
			if ($(this).val() == "daily")
			{
				$(".input-week").css("display", "none")
				$(".input-day").css("display", "block");
			} else if ($(this).val() == "weekly")
			{
				$(".input-day").css("display", "none");
				$(".input-week").css("display", "block");
			}
		});

		$(".btn-submit").click(function(e)
		{
			// 제목 입력값 가져오기
			let title = $("#title").val().trim();
			if (!title)
			{
				alert("제목을 입력하세요.");
				return;
			}
			
			// 시작 날짜 입력값 가져오기
			let startDate = $("#date").val();

			// 1) 비어있는지 확인
			if (!startDate)
			{
				alert("시작 날짜를 선택해주세요.");
				return;
			}

			// 2) 오늘 기준 +3일 이후인지 확인
			let selected = new Date(startDate);
			let today = new Date();
			today.setHours(0, 0, 0, 0); // 시간 초기화
			let minDate = new Date(today);
			minDate.setDate(minDate.getDate() + 3); // +3일 조건

			if (selected < minDate)
			{
				alert("시작 날짜는 오늘 기준 3일 이후여야 합니다.");
				return;
			}

			// 도전과제 타입 가져오기
			let selectedType = $("input[name='challengeType']:checked").val();

			if (!selectedType)
			{
				alert("일일/주간 도전과제를 선택해주세요.");
				return;
			}

			// 일일 도전과제 선택 시
			if (selectedType == "daily")
			{
				let isEmpty = false;
				$(".input-day input[type='text']").each(function()
				{
					if ($(this).val().trim() === "")
						isEmpty = true;
				});

				if (isEmpty)
				{
					alert("1~7일차 내용을 모두 입력해주세요.");
					return;
				}
			}

			// 주간 도전과제 선택 시
			if (selectedType == "weekly")
			{
				let isEmpty = false;
				$(".input-week input[type='text']").each(function()
				{
					if ($(this).val().trim() === "")
						isEmpty = true;
				});

				if (isEmpty)
				{
					alert("1~5주차 내용을 모두 입력해주세요.");
					return;
				}
			}

			document.forms[0].submit();
		});
	});
</script>
</head>
<body>
	<div class="topmenubar">
		<c:import url="/WEB-INF/view/common/TopMenuBar.jsp"></c:import>
	</div>

	<div class="container">
		<div class="sidebar">
			<c:import url="/WEB-INF/view/group_room/SideBar.jsp"></c:import>
		</div>

		<div class="main">
			<form action="challengecreate.do" method="post">
				<div class="input-field">
					<label for="title">제목</label> <input type="text" id="title"
						name="title" placeholder="제목을 입력하세요" required="required">
				</div>

				<div class="input-field">
					<label for="startdate">시작 날짜</label> <input type="date"
						name="startDate" id="date" required="required">
				</div>

				<div class="input-field">
					<label for="content">내용</label>
					<textarea id="content" cols="30" rows="5" name="content"
						placeholder="도전과제 설명을 입력해주세요..."></textarea>
				</div>

				<div class="radio-group">
					<label><input type="radio" name="challengeType"
						value="daily"> 일일 도전과제(7일)</label> <label><input
						type="radio" name="challengeType" value="weekly"> 주간
						도전과제(5주)</label>
				</div>


				<div class="input-day">
					<div class="input-field">
						<label for="day1">1일차</label> <input type="text" id="day1"
							name="day1" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="day2">2일차</label> <input type="text" id="day2"
							name="day2" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="day3">3일차</label> <input type="text" id="day3"
							name="day3" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="day4">4일차</label> <input type="text" id="day4"
							name="day4" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="day5">5일차</label> <input type="text" id="day5"
							name="day5" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="day6">6일차</label> <input type="text" id="day6"
							name="day6"placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="day7">7일차</label> <input type="text" id="day7"
							name="day7" placeholder="내용을 입력하세요">
					</div>
				</div>

				<div class="input-week">
					<div class="input-field">
						<label for="week1">1주차</label> <input type="text" id="week1"
							name="week1" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="week2">2주차</label> <input type="text" id="week2"
							name="week2" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="week3">3주차</label> <input type="text" id="week3"
							name="week3" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="week4">4주차</label> <input type="text" id="week4"
							name="week4" placeholder="내용을 입력하세요">
					</div>
					<div class="input-field">
						<label for="week5">5주차</label> <input type="text" id="week5"
							name="week5" placeholder="내용을 입력하세요">
					</div>
				</div>

				<div class="button-group">
					<button type="button" class="btn-submit">등록 하기</button>
					<a href="challengelist.do">
						<button class="btn-reset">돌아가기</button>
					</a>
				</div>

			</form>
		</div>
	</div>
</body>
</html>
