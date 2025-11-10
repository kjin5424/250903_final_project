<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 히스토리</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        .navbar { background: #a8d5a1; display: flex; align-items: center; padding: 0 20px; height: 48px; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 4px rgba(0,0,0,0.1); gap: 4px; }
        .nav-left { display: flex; align-items: center; gap: 4px; flex: 1; }
        .logo-tab { background: #8bc683; color: white; padding: 0 20px; height: 36px; border-radius: 8px 8px 0 0; display: flex; align-items: center; gap: 8px; font-weight: bold; font-size: 16px; cursor: pointer; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .page-header { background: linear-gradient(135deg, #2d5a29 0%, #4a8a42 100%); color: white; padding: 40px; border-radius: 12px; margin-bottom: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .header-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .page-title { font-size: 32px; font-weight: bold; display: flex; align-items: center; gap: 12px; }
        .btn-back { background: rgba(255,255,255,0.2); color: white; border: 2px solid white; padding: 10px 20px; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.3s; text-decoration: none; }
        .btn-back:hover { background: white; color: #2d5a29; }
        .group-name { font-size: 18px; opacity: 0.9; }

        .tab-menu { display: flex; gap: 10px; margin-bottom: 30px; border-bottom: 2px solid #e0e0e0; background: white; padding: 0 20px; border-radius: 12px 12px 0 0; flex-wrap: wrap; }
        .tab-item { padding: 15px 25px; cursor: pointer; font-weight: 600; color: #666; border-bottom: 3px solid transparent; transition: all 0.3s; position: relative; bottom: -2px; }
        .tab-item:hover { color: #2d5a29; }
        .tab-item.active { color: #2d5a29; border-bottom-color: #2d5a29; }

        .content-section { background: white; border-radius: 0 0 12px 12px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .tab-content { display: none; }
        .tab-content.active { display: block; }

        /* 타임라인 스타일 */
        .timeline { position: relative; padding: 20px 0; }
        .timeline:before { content: ''; position: absolute; left: 30px; top: 0; bottom: 0; width: 3px; background: linear-gradient(to bottom, #8bc683, #e0e0e0); }
        .timeline-item { position: relative; padding-left: 70px; margin-bottom: 30px; }
        .timeline-date { position: absolute; left: 0; top: 0; width: 60px; text-align: center; }
        .timeline-dot { width: 18px; height: 18px; background: #4CAF50; border-radius: 50%; border: 3px solid white; box-shadow: 0 0 0 3px #8bc683; margin: 0 auto 5px; }
        .timeline-date-text { font-size: 11px; color: #666; font-weight: 600; }
        .timeline-content { background: #f8faf8; padding: 20px; border-radius: 12px; border: 2px solid #e0e0e0; transition: all 0.3s; }
        .timeline-content:hover { border-color: #8bc683; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .timeline-title { font-size: 16px; font-weight: bold; color: #2d5a29; margin-bottom: 8px; display: flex; align-items: center; gap: 8px; }
        .timeline-category { display: inline-block; background: #e3f2fd; color: #1565c0; padding: 3px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
        .timeline-description { color: #666; font-size: 14px; line-height: 1.6; margin-top: 8px; }
        .timeline-meta { display: flex; gap: 15px; margin-top: 10px; font-size: 13px; color: #999; flex-wrap: wrap; }

        /* 투표 히스토리 */
        .vote-result { display: flex; gap: 15px; margin-top: 12px; }
        .vote-option { flex: 1; padding: 10px; background: white; border-radius: 8px; text-align: center; }
        .vote-count { font-size: 20px; font-weight: bold; color: #2d5a29; }
        .vote-label { font-size: 12px; color: #666; }
        .vote-bar { height: 6px; background: #e0e0e0; border-radius: 3px; margin-top: 8px; overflow: hidden; }
        .vote-bar-fill { height: 100%; background: #4CAF50; border-radius: 3px; transition: width 0.3s; }

        /* 도전과제 히스토리 */
        .challenge-progress { margin-top: 12px; }
        .progress-bar { height: 30px; background: #e0e0e0; border-radius: 15px; overflow: hidden; position: relative; }
        .progress-fill { height: 100%; background: linear-gradient(90deg, #4CAF50, #8bc683); border-radius: 15px; transition: width 0.3s; display: flex; align-items: center; justify-content: center; }
        .progress-text { position: absolute; left: 50%; top: 50%; transform: translate(-50%, -50%); font-weight: bold; font-size: 13px; color: #333; }

        /* 통계 카드 */
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: #f8faf8; padding: 25px; border-radius: 12px; text-align: center; border: 2px solid #e0e0e0; }
        .stat-value { font-size: 32px; font-weight: bold; color: #2d5a29; margin-bottom: 8px; }
        .stat-label { font-size: 14px; color: #666; }

        /* 레벨업 표시 */
        .level-up-badge { display: inline-block; background: linear-gradient(135deg, #ffd54f, #ffb300); color: #f57c00; padding: 5px 12px; border-radius: 15px; font-size: 12px; font-weight: bold; margin-left: 10px; animation: pulse 2s infinite; }
        @keyframes pulse { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.05); } }

        @media (max-width: 768px) {
            .page-header { padding: 25px 20px; }
            .page-title { font-size: 24px; }
            .header-top { flex-direction: column; gap: 15px; align-items: flex-start; }
            .timeline:before { left: 20px; }
            .timeline-item { padding-left: 60px; }
            .vote-result { flex-direction: column; }
        }
    </style>
</head>
<body>
<!-- 상단바 -->
<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

<!-- 사이드바 -->
<c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />

    <div class="container">
        <div class="page-header">
            <div class="header-top">
                <div>
                    <div class="page-title"><span>📜</span><span>모임 히스토리</span></div>
                    <div class="group-name">알고리즘 정복 스터디</div>
                </div>
                <button class="btn-back" onclick="history.back()">← 뒤로 가기</button>
            </div>
        </div>

        <div class="tab-menu">
            <div class="tab-item active" onclick="switchTab('all')">전체</div>
            <div class="tab-item" onclick="switchTab('member')">모임 및 권한</div>
            <div class="tab-item" onclick="switchTab('level')">레벨</div>
        </div>

        <div class="content-section">
            <!-- 전체 히스토리 -->
            <div id="all-tab" class="tab-content active">
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-value">${countActivity }</div>
                        <div class="stat-label">총 활동 횟수</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">${countChallenge }</div>
                        <div class="stat-label">도전과제 완료</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">Lv.${groupLevel }</div>
                        <div class="stat-label">현재 레벨</div>
                    </div>
                </div>
                
               <div class="timeline">
			   <c:if test="${not empty history}">
			       <c:forEach var="historyDTO" items="${history}">
			           <div class="timeline-item">
			               <div class="timeline-date">
			                   <div class="timeline-dot"></div>
			                   <div class="timeline-date-text">
			                       ${historyDTO.updateDate}
			                   </div>
			               </div>
			               <div class="timeline-content">
			                   <div class="timeline-title">
			                       <div class="timeline-content">
			                            <div class="timeline-title">
			                                <span>
			                                
			                                <c:choose>
					                               <c:when test="${historyDTO.type eq 'JOIN'}">🥳 신규회원!</c:when>
					                               <c:when test="${historyDTO.type eq 'LEVEL'}">🆙 레벨업!</c:when>
					                               <c:when test="${historyDTO.type eq 'ACTIVITY'}">🗳️ 활동 등록!</c:when>
					                               <c:when test="${historyDTO.type eq 'CHALLENGE'}">🎯 도전과제 등록!</c:when>
					                               <c:when test="${historyDTO.type eq 'POSITION'}">👑 권한 변경</c:when>
					                               <c:otherwise>♻️ 모임정보 변경!</c:otherwise>
					                        </c:choose>

											</span>
			                                <span class="timeline-category">
					                           <c:choose>
					                               <c:when test="${historyDTO.type eq 'JOIN'}">가입</c:when>
					                               <c:when test="${historyDTO.type eq 'LEVEL'}">레벨</c:when>
					                               <c:when test="${historyDTO.type eq 'ACTIVITY'}">활동</c:when>
					                               <c:when test="${historyDTO.type eq 'CHALLENGE'}">도전과제</c:when>
					                               <c:when test="${historyDTO.type eq 'POSITION'}">역할</c:when>
					                               <c:otherwise>모임정보 변경!</c:otherwise>
					                        </c:choose>
				                           </span>
			                            </div>
			                            <div class="timeline-description">
					                       <span>${historyDTO.history}</span>
			                            </div>
			                        </div>
			                   </div>
			                    
			               </div>
			           </div>
			       </c:forEach>
			   </c:if>
			    
			   <c:if test="${empty history}">
			       <div style="text-align: center; padding: 60px 20px; color: #999;">
			           <div style="font-size: 48px; margin-bottom: 15px;">📭</div>
			           <div>아직 히스토리가 없습니다.</div>
			       </div>
			   </c:if>
			</div>
		    </div>
               

            <!-- 모임 및 권한 히스토리 -->
            <div id="member-tab" class="tab-content">
            	
                <div class="timeline">
                	<c:if test="${not empty notLevelHistory }">
                		<c:forEach var="notLevel" items="${notLevelHistory }">
		                   <div class="timeline-item">
			               <div class="timeline-date">
			                   <div class="timeline-dot"></div>
			                   <div class="timeline-date-text">
			                       ${notLevel.updateDate}
			                   </div>
			               </div>
			               <div class="timeline-content">
			                   <div class="timeline-title">
			                       <div class="timeline-content">
			                            <div class="timeline-title">
			                                <span>
			                                
			                                <c:choose>
					                               <c:when test="${notLevel.type eq 'JOIN'}">🥳 신규회원!</c:when>
					                               <c:when test="${notLevel.type eq 'ACTIVITY'}">🗳️ 활동 등록!</c:when>
					                               <c:when test="${notLevel.type eq 'CHALLENGE'}">🎯 도전과제 등록!</c:when>
					                               <c:when test="${notLevel.type eq 'POSITION'}">👑 권한 변경</c:when>
					                               <c:otherwise>♻️ 모임정보 변경!</c:otherwise>
					                        </c:choose>

											</span>
			                                <span class="timeline-category">
					                           <c:choose>
					                               <c:when test="${notLevel.type eq 'JOIN'}">가입</c:when>
					                               <c:when test="${notLevel.type eq 'ACTIVITY'}">활동</c:when>
					                               <c:when test="${notLevel.type eq 'CHALLENGE'}">도전과제</c:when>
					                               <c:when test="${notLevel.type eq 'POSITION'}">역할</c:when>
					                               <c:otherwise>모임정보 변경!</c:otherwise>
					                        </c:choose>
				                           </span>
			                            </div>
			                            <div class="timeline-description">
					                       <span>${notLevel.history}</span>
			                            </div>
			                        </div>
			                   </div>
			                    
			               </div>
			           </div>
		               </c:forEach>
                    </c:if>
					
                  
                </div>
            </div>

            <!-- 레벨 히스토리 -->
            <div id="level-tab" class="tab-content">
                <div class="timeline">
                	<c:if test="${not empty levelHistory }">
                		<c:forEach var="level" items="${levelHistory }">
		                    <div class="timeline-item">
					               <div class="timeline-date">
					                   <div class="timeline-dot"></div>
					                   <div class="timeline-date-text">
					                       ${level.updateDate}
					                   </div>
					               </div>
					               <div class="timeline-content">
					                   <div class="timeline-title">
					                       <div class="timeline-content">
					                            <div class="timeline-title">
					                                <span>
					                               	🆙 레벨업!
													</span>
					                                <span class="timeline-category">
					                               레벨
						                           </span>
					                            </div>
					                            <div class="timeline-description">
							                       <span>${level.history}</span>
					                            </div>
					                        </div>
					                   </div>
					                    
					               </div>
					           </div>
                    </c:forEach>
					</c:if>
                </div>
            </div>
            
            <!-- level -->
            
        </div>
    </div>

    <script>
        function switchTab(tabName) {
            // 모든 탭 비활성화
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));
            
            // 선택한 탭 활성화
            document.getElementById(tabName + '-tab').classList.add('active');
            event.target.classList.add('active');
        }
    </script>
</body>
</html>