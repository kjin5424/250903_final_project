<%@page import="com.test.mybatis.dto.ChallengeInfoDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.test.mybatis.dto.ActivityDTO"%>
<%@page import="com.test.mybatis.dto.GroupDTO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	GroupDTO group = (GroupDTO)request.getAttribute("groupInfo");	

	float totalAttendance = Float.valueOf(group.getTotalAttendance());
	float checkChallenge = Float.valueOf(group.getCheckChallenge());	
	
	ChallengeInfoDTO challenge = (ChallengeInfoDTO)request.getAttribute("challenge");
	
	String challengePercent = "";
	
	if(challenge!=null)
	{
		int challengeCheck = Integer.parseInt(challenge.getChallengeCheck());
		int challengeDetail = Integer.parseInt(challenge.getChallengeDetail());
		int challengeMember = Integer.parseInt(challenge.getChallengeMember());
		challengePercent = String.valueOf((challengeCheck / (challengeMember * challengeDetail)) * 100);
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 홈</title>
    
    <!-- CSS 파일 임포트 -->
    <link rel="stylesheet" href="css_new/common_sample.css">
    <link rel="stylesheet" href="css_new/topmenubar_sample.css">
    <link rel="stylesheet" href="css_new/home_sample.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        function goToBoard() {
            window.location.href = 'board.jsp';
        }

        function goToMembers() {
            window.location.href = 'member_list.jsp';
        }

        function goToManage() {
            window.location.href = 'group_edit.jsp';
        }
        
        function goToLevel() {
            window.location.href = 'level.jsp';
        }

        function viewPost(postId) {
            window.location.href = 'board_detail.jsp?id=' + postId;
        }

        function participateVote(voteId) {
            window.location.href = 'vote_detail.jsp?id=' + voteId;
        }

        function viewChallenge(challengeId) {
            window.location.href = 'challenge_detail.jsp?id=' + challengeId;
        }

        function editIntro() {
        	if (confirm("한 줄 자기소개를 수정(등록)하시겠습니까?")) 
    		{
    			return true;
    		}
    		return false;
        }
    </script>
</head>
<body>
    <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

    <div class="container">
        <!-- 모임 헤더 -->
        <div class="group-header">
            <div class="group-header-top">
                <div class="group-title-area">
                    <h1 class="group-title">${groupInfo.groupTitle}</h1>
                    <button class="group-level" onclick="location.href='level.do?${groupInfo.groupApplyCode}'" title="레벨 현황을 자세히 확인할 수 있어요">
                        Lv.${groupInfo.groupLevel}
                    </button>
                </div>
                <div class="group-actions">
                    <button class="btn-header" onclick="location.href='postlist.do?groupApplyCode=${groupInfo.groupApplyCode}'">
                        	📋 게시판
                    </button>
                    <button class="btn-header" onclick="location.href='challengelist.do?groupApplyCode=${groupInfo.groupApplyCode}'">
                        	🏆 도전과제
                    </button>
                    <button class="btn-header" onclick="location.href='memberlist.do?groupApplyCode=${groupInfo.groupApplyCode}'">
                        	👥 모임원
                    </button>
                    <button class="btn-header" onclick="location.href='messagelist.do'">
                      		  ✉️ 쪽지
                    </button>
                    <button class="btn-header" onclick="location.href='managelist.do?groupApplyCode=${groupInfo.groupApplyCode}'">
                       		 ⚙️ 관리
                    </button>
                    <button class="btn-report" onclick="location.href='reportgroup.do?groupApplyCode=${groupInfo.groupApplyCode}'" title="신고">
					    	🚨
					</button>
                </div>
            </div><!-- .group-header-top -->
            
            <div class="group-dates">
                <div class="date-item">
                    <span class="date-icon">🎉</span>
                    <c:choose>
                        <c:when test="${not empty groupInfo.openDate}">
                            <span class="date-label">모임 시작일:</span>
                            <span class="date-value">${groupInfo.openDate}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="date-label">모임 개설신청일:</span>
                            <span class="date-value">${groupInfo.createdDate}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <c:if test="${not empty groupInfo.joinDate}">
                    <div class="date-item">
                        <span class="date-icon">👋</span>
                        <span class="date-label">내 가입일:</span>    
                        <span class="date-value">${groupInfo.joinDate}</span>
                    </div>
                </c:if>
            </div>
            
            <div class="group-stats">
                <div class="stat-card">
                    <div class="stat-value">${groupInfo.currentMemberCount}/${groupInfo.headCount}</div>
                    <div class="stat-label">모임원</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value"><%=String.format("%.0f%%", totalAttendance) %></div>
                    <div class="stat-label">전체 출석률</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value"><%=String.format("%.0f%%", checkChallenge) %></div>
                    <div class="stat-label">도전과제 달성률</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">${groupInfo.totalActivity}</div>
                    <div class="stat-label">누적 활동</div>
                </div>
            </div>
        </div>

        <div class="main-grid">
            <!-- 왼쪽 컬럼 -->
            <div>
                <!-- 공지사항 -->
                <div class="section-wrapper">
                    <div class="section-header">
                        <h2 class="section-title">📢 공지사항</h2>
                        <button class="btn-more" onclick="location.href='postlist.do?groupApplyCode=?${groupInfo.groupApplyCode}'">
                            더보기 →
                        </button>
                    </div>
                    <c:choose>
                        <c:when test="${not empty post}">
                            <c:forEach var="postDTO" items="${post}">
                                <div class="notice-item" onclick="location.href='postdetail.do?postCode=${postDTO.postCode}'">
                                    <div class="notice-title">${postDTO.subject}</div>
                                    <div class="notice-meta">${postDTO.nickName} · ${postDTO.createdDate}</div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-message">등록된 공지가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 진행중인 투표 -->
                <div class="section-wrapper">
                    <div class="section-header">
                        <h2 class="section-title">🗳️ 진행중인 투표</h2>
                        <button class="btn-more" onclick="location.href='votelist.do?groupApplyCode=${groupInfo.groupApplyCode}'">
                            더보기 →
                        </button>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty activity}">
                            <c:forEach var="activityDTO" items="${activity}">
                                <div class="vote-card">
                                    <div class="vote-header">
                                        <div class="vote-title">${activityDTO.content}</div>
                                        <div class="vote-status">진행중</div>
                                    </div>
                                    <div class="vote-info">
                                        <div class="vote-info-item">
                                            <span>📅</span>
                                            <span>${activityDTO.activeDate}</span>
                                        </div>
                                        <div class="vote-info-item">
                                            <span>📍</span>
                                            <span>${activityDTO.onOffLine}</span>
                                        </div>
                                    </div>
                                    <div class="vote-progress">
                                        <div class="vote-progress-bar">
                                            <div class="vote-progress-fill" style="width: ${Integer.parseInt(activityDTO.registrants) / Integer.parseInt(activityDTO.totalMember) * 100}%;"></div>
                                        </div>
                                        <div class="vote-progress-text">
                                            참여: ${activityDTO.registrants}명 / 미참여: ${Integer.parseInt(activityDTO.totalMember) - Integer.parseInt(activityDTO.registrants)}명
                                        </div>
                                    </div>
                                    <button class="btn-vote" onclick="participateVote(1)">투표하기</button>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-message">진행중인 투표가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 오른쪽 컬럼 -->
            <div>
                <!-- 모임 히스토리 -->
                <div class="history-link-section" onclick="location.href='history.do?groupApplyCode=${groupInfo.groupApplyCode}'">
				    <div class="history-icon">🕰️</div>
				    <div class="history-content">
				        <div class="history-title">모임 히스토리</div>
				        <div class="history-desc">우리 모임의 활동 기록을 확인해보세요</div>
				    </div>
				    <div class="history-arrow">→</div>
				</div>

                <!-- 도전 과제 -->
                <div class="section-wrapper">
				<c:if test="${not empty checkMember }">
					<div class="challenge-section">
						<div class="section-header">
							<h2 class="section-title">🏆 진행중인 도전과제</h2>
							<button class="btn-more"
								onclick="location.href='challengelist.do?groupApplyCode=${groupInfo.groupApplyCode}'">더보기
								→</button>
						</div>

						<div class="challenge-card">
							<c:choose>
								<c:when test="${not empty challenge }">
									<div class="challenge-title">${challenge.title }</div>
									<div class="challenge-progress">
										<div class="challenge-progress-text">${challenge.datePercent }
											${challenge.status }</div>
										<div class="challenge-progress-bar">
											<div class="challenge-progress-fill"
												style="width: <%=challengePercent%>%;"></div>
										</div>
									</div>
									<div class="challenge-info">
										<span>참여: ${challenge.challengeMember }명</span> <span>평균
											달성률: <%=challengePercent%>%
										</span>
									</div>
									<button class="btn-challenge" onclick="viewChallenge(1)">인증하기</button>
								</c:when>
								<c:otherwise>
		                        	진행중인 도전과제가 없습니다.
		                        </c:otherwise>
							</c:choose>
						</div>


					</div>
				</c:if>
			</div>

                <!-- 알림 -->
                <div class="section-wrapper">
                    <div class="section-header">
                        <h2 class="section-title">🔔 알림</h2>
                    </div>
                    <div class="notification-item">
                        <div class="notification-icon icon-notice">📢</div>
                        <div class="notification-content">
                            <div class="notification-text">새로운 공지사항이 등록되었습니다.</div>
                            <div class="notification-time">10분 전</div>
                        </div>
                    </div>
                    <div class="notification-item">
                        <div class="notification-icon icon-vote">🗳️</div>
                        <div class="notification-content">
                            <div class="notification-text">10월 3주차 정기 모임 투표가 시작되었습니다.</div>
                            <div class="notification-time">1시간 전</div>
                        </div>
                    </div>
                    <div class="notification-item">
                        <div class="notification-icon icon-challenge">🏆</div>
                        <div class="notification-content">
                            <div class="notification-text">도전과제 인증 알림: 오늘의 문제를 풀어보세요!</div>
                            <div class="notification-time">3시간 전</div>
                        </div>
                    </div>
                </div>

                <!-- 내 한줄소개 -->
                <div class="section-wrapper">
				<c:if test="${not empty checkMember }">
					<div class="intro-section">
						<div class="section-header">
							<h2 class="section-title">✍️ 내 한줄소개</h2>
						</div>
						<c:choose>
							<c:when test="${not empty selfIntro }">
								<form action="updateIntroduce.do" onsubmit="return editIntro()"  method="post">
									<input type="hidden" value="${checkMember }" name="joinCode">
									<input type="hidden" value="${groupInfo.groupApplyCode}" name="groupApplyCode">
									<div class="my-intro">
										<div class="intro-label">나의 소개</div>
										<input type="text" name="introduce" class="intro-text" id="comment" value="${selfIntro.introduce }">
									</div>
									<button type="submit" class="btn-edit-intro">수정하기</button>
								</form>
							</c:when>
							<c:otherwise>
								<form action="updateIntroduce.do" onsubmit="return editIntro()"  method="post">
									<input type="hidden" value="${checkMember }" name="joinCode">
									<input type="hidden" value="${groupInfo.groupApplyCode}" name="groupApplyCode">
									<div class="my-intro">
										<div class="intro-label">나의 소개</div>
										<input type="text" name="introduce" class="intro-text" id="comment" value="등록된 소개가 없습니다.">
									</div>
									<button type="submit" class="btn-edit-intro">등록하기</button>
								</form>
							</c:otherwise>
						</c:choose>
					</div>
				</c:if>
				</div>

            </div>
        </div>
    </div>
</body>
</html>
