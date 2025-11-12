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
<title>도전과제 작성 - 공모자들</title>
<link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css" />
<link rel="stylesheet" href="<%=cp%>/css_new/board_sample.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<style>
/* 도전과제 작성 페이지 전용 스타일 */
.form-group {
	margin-bottom: var(--spacing-lg);
}

.form-label {
	display: block;
	font-weight: 600;
	color: var(--color-text-primary);
	margin-bottom: var(--spacing-sm);
	font-size: 15px;
}

.radio-group {
	display: flex;
	gap: var(--spacing-lg);
	margin-bottom: var(--spacing-lg);
}

.radio-group label {
	display: flex;
	align-items: center;
	gap: var(--spacing-sm);
	cursor: pointer;
	font-weight: 500;
	color: var(--color-text-secondary);
}

.radio-group input[type="radio"] {
	width: 18px;
	height: 18px;
	cursor: pointer;
}

.input-day, .input-week {
	display: none;
	gap: var(--spacing-md);
	flex-direction: column;
	margin-bottom: var(--spacing-lg);
}

.button-group {
	display: flex;
	gap: var(--spacing-md);
	justify-content: flex-end;
	margin-top: var(--spacing-xl);
	padding-top: var(--spacing-lg);
	border-top: 2px solid var(--color-border-light);
}
</style>
<script type="text/javascript">
	$(function()
	{
		$(".radio-group input[type='radio']").change(function()
		{
			if ($(this).val() == "daily")
			{
				$(".input-week").css("display", "none")
				$(".input-day").css("display", "flex");
			} else if ($(this).val() == "weekly")
			{
				$(".input-day").css("display", "none");
				$(".input-week").css("display", "flex");
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
	<!-- 상단 메뉴바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
	
	<!-- 사이드바 -->
	<c:import url="/WEB-INF/view/common/GroupSideBar.jsp"></c:import>

	<!-- 메인 콘텐츠 -->
	<div class="main-container">
		<div class="board-container">
			<div class="board-header">
				<h2 class="board-title">
					<span class="board-title-icon">📝</span>
					도전과제 작성
				</h2>
			</div>

			<form action="challengecreate.do" method="post">
				<input type="hidden" name="groupApplyCode" value="${param.groupApplyCode}">
				
				<div class="form-group">
					<label for="title" class="form-label">제목</label>
					<input type="text" id="title" name="title" 
						placeholder="제목을 입력하세요" required="required">
				</div>

				<div class="form-group">
					<label for="date" class="form-label">시작 날짜</label>
					<input type="date" name="startDate" id="date" required="required">
				</div>

				<div class="form-group">
					<label for="content" class="form-label">내용</label>
					<textarea id="content" name="content" 
						placeholder="도전과제 설명을 입력해주세요..."></textarea>
				</div>

				<div class="form-group">
					<label class="form-label">도전과제 유형</label>
					<div class="radio-group">
						<label>
							<input type="radio" name="challengeType" value="daily">
							일일 도전과제 (7일)
						</label>
						<label>
							<input type="radio" name="challengeType" value="weekly">
							주간 도전과제 (5주)
						</label>
					</div>
				</div>

				<div class="input-day">
					<div class="form-group">
						<label for="day1" class="form-label">1일차</label>
						<input type="text" id="day1" name="day1" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="day2" class="form-label">2일차</label>
						<input type="text" id="day2" name="day2" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="day3" class="form-label">3일차</label>
						<input type="text" id="day3" name="day3" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="day4" class="form-label">4일차</label>
						<input type="text" id="day4" name="day4" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="day5" class="form-label">5일차</label>
						<input type="text" id="day5" name="day5" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="day6" class="form-label">6일차</label>
						<input type="text" id="day6" name="day6" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="day7" class="form-label">7일차</label>
						<input type="text" id="day7" name="day7" placeholder="내용을 입력하세요">
					</div>
				</div>

				<div class="input-week">
					<div class="form-group">
						<label for="week1" class="form-label">1주차</label>
						<input type="text" id="week1" name="week1" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="week2" class="form-label">2주차</label>
						<input type="text" id="week2" name="week2" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="week3" class="form-label">3주차</label>
						<input type="text" id="week3" name="week3" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="week4" class="form-label">4주차</label>
						<input type="text" id="week4" name="week4" placeholder="내용을 입력하세요">
					</div>
					<div class="form-group">
						<label for="week5" class="form-label">5주차</label>
						<input type="text" id="week5" name="week5" placeholder="내용을 입력하세요">
					</div>
				</div>

				<div class="button-group">
					<a href="challengelist.do">
						<button type="button" class="btn btn-ghost">돌아가기</button>
					</a>
					<button type="button" class="btn btn-primary btn-submit">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
