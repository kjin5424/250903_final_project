<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>투표 리스트(정기+비정기)</title>
<link rel="stylesheet" href="<%=cp %>/css/css_vote/votelist.css" />
<link rel="stylesheet" href="<%=cp%>/css/topsidecontent.css" />
<script type="text/javascript" src="https://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
    
    $(function() {
    	
    	// 확인
    	//alert("그냥 띄우기");
        var errorType = parseInt("${errorType}", 10);

        // message가 빈 값이 아니라면 alert 띄우기
        if (errorType) 
        {
            if (errorType===1)
        	{
            	alert("로그인 후 이용 가능합니다.");
        	}
            else if(errorType===2)
           	{
            	alert("활동 등록은 해당 모임의 구성원만 가능합니다.");
           	}
        }
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
			<!-- 진행중인 투표 -->
			<c:if test="${not empty activityList }">
			<c:forEach var="activityDTO" items="${activityList }">
			<div class="card">
				<div class="card-header">
					<span class="title">${activityDTO.status }</span> 
					<span class="date-range">투표기간 : ${activityDTO.createdDate }
						~ ${activityDTO.limitVoteDate }</span>
				</div>

				<div class="meta">
					<span>총: ${activityDTO.totalMember }명</span> | <span>참여투표자: ${activityDTO.registrants }명</span>
				</div>
				<div class="meta">${activityDTO.activeDate} ~ ${activityDTO.activeEndTime }</div>
				<div class="meta">${activityDTO.onOffLine }</div>
				<div class="meta">장소(화상회의 주소) : ${activityDTO.place }</div>

				<div class="progress-section">
					<div class="progress-label">
						<label><span>참여 <input type="radio" name="vote" value="1"></span></label>
						<span>${activityDTO.registrants }명 (${activityDTO.registrants / activityDTO.totalMember * 100 }%)</span>
					</div>
					<div class="progress-bar blue" style="width: 80%;"></div>
				</div>

				<div class="progress-section">
					<div class="progress-label">
						<label><span>미참 <input type="radio" name="vote" value="0"></span></label>
						<span>${activityDTO.totalMember - activityDTO.registrants }명 (${(activityDTO.totalMember - activityDTO.registrants) / activityDTO.totalMember * 100 }%)</span>
					</div>
					<div class="progress-bar gray" style="width: 20%;"></div>
				</div>

				<div class="button-group">
					<button id="delete-btn">삭제</button>
					<a href="VoteModify.jsp">
					<button id="edit-btn">수정</button></a>
					<button id="submit-btn">제출</button>
				</div>
			</div>
			</c:forEach>
			</c:if>
			
			<div class="create-vote-wrapper">
				<a href="votecreate.do?groupApplyCode=${groupApplyCode }">
				<button class="create-vote-btn">+ 새 투표 만들기</button></a>
			</div>

			<!-- 페이지네이션 -->
			<div class="pagination">
				${pageIndexList }
			</div>

		</div>

	</div>
</body>
</html>
