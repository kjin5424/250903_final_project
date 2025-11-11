<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 출석 관리</title>
    
    <!-- CSS Import -->
    <link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css">
    <link rel="stylesheet" href="css_new/home_sample.css">
    <link rel="stylesheet" href="<%=cp%>/ccss_new/manager_sample.css">
    <link rel="stylesheet" href="<%=cp%>/css_new/grouproommanage.css">
    
    <style>
        /* 알림 메시지 */
        .alert-info {
            background: var(--color-primary-lighter);
            border-left: 4px solid var(--color-primary);
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            margin-bottom: var(--spacing-xl);
            font-size: 14px;
            color: var(--color-primary-deep);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        /* 통계 그리드 - hover 효과 제거 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
        }

        .stat-card {
            background: var(--color-white);
            padding: var(--spacing-lg);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
            gap: var(--spacing-sm);
        }

        .stat-label {
            font-size: 14px;
            color: var(--color-text-secondary);
            font-weight: 500;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: var(--color-text-primary);
        }

        .stat-value.success {
            color: var(--color-primary-dark);
        }

        /* 활동 카드 - VoteList.jsp와 동일한 구조 */
        .activity-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-xl);
        }

        .activity-card {
            border: 1px solid var(--color-border);
            border-radius: var(--radius-md);
            padding: 16px;
            background: var(--color-white);
            cursor: pointer;
            transition: all var(--transition-base);
        }

        .activity-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }

        .activity-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .activity-title {
            font-weight: 700;
            font-size: 16px;
            color: var(--color-text-primary);
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            transition: all var(--transition-base);
        }

        .activity-card:hover .activity-title {
            white-space: normal;
            overflow: visible;
        }

        .activity-date {
            font-size: 14px;
            color: var(--color-text-secondary);
        }

        .activity-info {
            font-size: 13px;
            color: var(--color-text-secondary);
            margin-bottom: 4px;
        }

        .activity-info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .attendance-rate {
            font-size: 18px;
            font-weight: 700;
            color: var(--color-primary-dark);
        }

        .attendance-rate.zero {
        	font-weignt: 900;
            color: var(--color-accent);
        }

        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 2000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
        }

        .modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: var(--color-white);
            border-radius: var(--radius-lg);
            width: 90%;
            max-width: 900px;
            max-height: 85vh;
            overflow-y: auto;
            box-shadow: var(--shadow-xl);
            animation: slideInUp var(--transition-base);
        }

        .modal-header {
            background: linear-gradient(135deg, var(--color-primary), var(--color-primary-dark));
            color: white;
            padding: var(--spacing-xl);
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-title {
            font-size: 24px;
            font-weight: 700;
        }

        .modal-close {
            background: transparent;
            border: none;
            color: white;
            font-size: 28px;
            cursor: pointer;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: var(--radius-md);
            transition: all var(--transition-fast);
        }

        .modal-close:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .modal-body {
            padding: var(--spacing-xl);
        }

        /* 출석 테이블 */
        .attendance-table {
            width: 100%;
            border-collapse: collapse;
        }

        .attendance-table thead {
            background: var(--color-primary-lighter);
        }

        .attendance-table th {
            padding: var(--spacing-md);
            text-align: center;
            font-weight: 600;
            color: var(--color-primary-dark);
            border-bottom: 2px solid var(--color-primary);
            font-size: 14px;
        }

        .attendance-table td {
            padding: var(--spacing-md);
            border-bottom: 1px solid var(--color-border-light);
            font-size: 14px;
            text-align: center;
        }

        .attendance-table td:first-child {
            text-align: left;
        }

        .attendance-table tbody tr {
            transition: background var(--transition-fast);
        }

        .attendance-table tbody tr:hover {
            background: var(--color-base);
        }

        .member-info {
            display: flex;
            align-items: center;
            gap: var(--spacing-md);
        }

        .member-avatar {
            width: 40px;
            height: 40px;
            border-radius: var(--radius-full);
            background: linear-gradient(135deg, var(--color-primary), var(--color-primary-dark));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 16px;
            flex-shrink: 0;
        }

        .member-details {
            flex: 1;
        }

        .member-name {
            font-weight: 600;
            color: var(--color-text-primary);
            margin-bottom: 2px;
        }

        .member-role {
            font-size: 12px;
            color: var(--color-text-secondary);
        }

        .attendance-status-buttons {
            display: flex;
            gap: var(--spacing-sm);
            justify-content: center;
        }

        .status-btn {
            padding: 8px 16px;
            border: 2px solid var(--color-border);
            border-radius: var(--radius-md);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
            background: var(--color-white);
            color: var(--color-text-secondary);
        }

        .status-btn:hover {
            border-color: var(--color-primary);
        }

        .status-btn.active.present {
            background: var(--color-primary);
            color: white;
            border-color: var(--color-primary);
        }

        .status-btn.active.absent {
            background: var(--color-accent);
            color: white;
            border-color: var(--color-accent);
        }

        .rate-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: var(--radius-full);
            font-size: 13px;
            font-weight: 600;
        }

        .rate-high {
            background: var(--color-primary-lighter);
            color: var(--color-primary-dark);
        }

        .rate-medium {
            background: #fff3e0;
            color: #f57c00;
        }

        .rate-low {
            background: var(--color-accent-light);
            color: var(--color-accent-dark);
        }

        .modal-footer {
            padding: var(--spacing-xl);
            border-top: 1px solid var(--color-border-light);
            display: flex;
            justify-content: center;
            gap: var(--spacing-md);
        }

        @media (max-width: 768px) {
            .activity-cards {
                grid-template-columns: 1fr;
            }

            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .modal-content {
                width: 95%;
                max-height: 90vh;
            }

            .attendance-table {
                font-size: 12px;
            }

            .status-btn {
                padding: 6px 12px;
                font-size: 12px;
            }
        }
    </style>
    
    <script>
        // 출석 데이터
        const attendanceData = {};
        let hasChanges = false;

        function openAttendanceModal(activityId, activityTitle, activityDate) {
            const modal = document.getElementById('attendanceModal');
            const modalTitle = document.getElementById('modalActivityDate');
            modalTitle.textContent = activityDate + ' 활동 출석 체크';
            modal.classList.add('show');
            document.body.style.overflow = 'hidden';
        }

        function closeAttendanceModal() {
            const modal = document.getElementById('attendanceModal');
            modal.classList.remove('show');
            document.body.style.overflow = '';
        }

        function setAttendance(memberId, status) {
            if (!attendanceData[memberId]) {
                attendanceData[memberId] = {};
            }
            attendanceData[memberId].status = status;
            
            // 버튼 활성화 상태 변경
            const buttons = document.querySelectorAll(`[data-member="${memberId}"]`);
            buttons.forEach(btn => {
                btn.classList.remove('active', 'present', 'absent');
                if (btn.getAttribute('data-status') === status) {
                    btn.classList.add('active', status);
                }
            });
            
            hasChanges = true;
        }

        function saveAttendance() {
            if (!hasChanges) {
                alert('변경된 내용이 없습니다.');
                return;
            }

            // 서버로 전송
            console.log('저장할 데이터:', attendanceData);

            alert('출석이 저장되었습니다.');
            hasChanges = false;
            closeAttendanceModal();
            
            // 카드 정보 업데이트
            updateActivityCard();
        }

        function updateActivityCard() {
            // 실제로는 서버에서 최신 데이터를 받아와서 카드 정보를 업데이트
            // 여기서는 간단히 alert로 표시
        }

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            const modal = document.getElementById('attendanceModal');
            if (event.target === modal) {
                closeAttendanceModal();
            }
        }
    </script>
</head>
<body>
    <!-- 상단바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
	
	<!-- 사이드바 -->
	<c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />

    <div class="container">
	    <!-- 페이지 헤더 -->
	    <div class="page-header-custom">
	        <div class="header-top">
	            <div>
	                <div class="page-title-custom">
	                    <span>📋</span>
	                    <span>출석 관리</span>
	                    <span class="role-badge">모임장</span>
	                </div>
	                <div class="group-name">알고리즘 정복 스터디</div>
	            </div>
	            <a href="managelist.do" class="btn-back-custom">
	                <span>←</span>
	                <span>관리 메뉴로</span>
	            </a>
	        </div>
	    </div>
	
	    <!-- 알림 -->
	    <div class="alert-info">
	        <span>ℹ️</span>
	        <span>출석체크를 진행하지 않은 활동은 출석률이 0%로 표시됩니다.</span>
	    </div>
	
	    <!-- 통계 -->
	    <div class="stats-grid">
	        <div class="stat-card">
	            <div class="stat-label">👥 전체 모임원</div>
	            <div class="stat-value">7명</div>
	        </div>
	        <div class="stat-card">
	            <div class="stat-label">✅ 평균 출석률</div>
	            <div class="stat-value success">85%</div>
	        </div>
	        <div class="stat-card">
	            <div class="stat-label">📅 누적 모임 횟수</div>
	            <div class="stat-value">12회</div>
	        </div>
	        <div class="stat-card">
	            <div class="stat-label">🎯 평균 참석 인원</div>
	            <div class="stat-value">6명</div>
	        </div>
	    </div>
	
	    <!-- 활동 카드 그리드 -->
	    <div class="activity-cards">
	        <!-- 활동 카드 1 -->
	        <div class="activity-card" onclick="openAttendanceModal(1, '주간 알고리즘 문제 풀이 및 코드 리뷰', '2024-10-17 (목)')">
	            <div class="activity-header">
	                <span class="activity-title">주간 알고리즘 문제 풀이 및 코드 리뷰</span>
	                <span class="activity-date">2024-10-17</span>
	            </div>
	            <div class="activity-info">총: 7명 | 투표자: 7명</div>
	            <div class="activity-info">19:00 ~ 21:00</div>
	            <div class="activity-info">장소: 강남역 스터디카페</div>
	            
	            <div class="activity-info-row">
	                <span>👥 참여 응답 인원</span>
	                <span>7명</span>
	            </div>
	            <div class="activity-info-row">
	                <span>✅ 출석 확인 인원</span>
	                <span>5명</span>
	            </div>
	            <div class="activity-info-row">
	                <span>📊 출석률</span>
	                <span class="attendance-rate">71%</span>
	            </div>
	        </div>
	
	        <!-- 활동 카드 2 -->
	        <div class="activity-card" onclick="openAttendanceModal(2, '백준 골드 문제 집중 스터디', '2024-10-10 (목)')">
	            <div class="activity-header">
	                <span class="activity-title">백준 골드 문제 집중 스터디</span>
	                <span class="activity-date">2024-10-10</span>
	            </div>
	            <div class="activity-info">총: 7명 | 투표자: 7명</div>
	            <div class="activity-info">19:00 ~ 21:00</div>
	            <div class="activity-info">장소: 강남역 스터디카페</div>
	            
	            <div class="activity-info-row">
	                <span>👥 참여 응답 인원</span>
	                <span>7명</span>
	            </div>
	            <div class="activity-info-row">
	                <span>✅ 출석 확인 인원</span>
	                <span>6명</span>
	            </div>
	            <div class="activity-info-row">
	                <span>📊 출석률</span>
	                <span class="attendance-rate">86%</span>
	            </div>
	        </div>
	
	        <!-- 활동 카드 3 -->
	        <div class="activity-card" onclick="openAttendanceModal(3, '온라인 코딩 테스트 대비 모의고사', '2024-10-03 (목)')">
	            <div class="activity-header">
	                <span class="activity-title">온라인 코딩 테스트 대비 모의고사</span>
	                <span class="activity-date">2024-10-03</span>
	            </div>
	            <div class="activity-info">총: 6명 | 투표자: 6명</div>
	            <div class="activity-info">19:00 ~ 21:00</div>
	            <div class="activity-info">장소: 온라인</div>
	            
	            <div class="activity-info-row">
	                <span>👥 참여 응답 인원</span>
	                <span>6명</span>
	            </div>
	            <div class="activity-info-row">
	                <span>✅ 출석 확인 인원</span>
	                <span>6명</span>
	            </div>
	            <div class="activity-info-row">
	                <span>📊 출석률</span>
	                <span class="attendance-rate">100%</span>
	            </div>
	        </div>
	
	        <!-- 활동 카드 4 - 출석률 0% -->
	        <div class="activity-card" onclick="openAttendanceModal(4, '자료구조와 알고리즘 기본 복습', '2024-09-26 (목)')">
	            <div class="activity-header">
	                <span class="activity-title">자료구조와 알고리즘 기본 복습</span>
	                <span class="activity-date">2024-09-26</span>
	            </div>
	            <div class="activity-info">총: 7명 | 투표자: 7명</div>
	            <div class="activity-info">19:00 ~ 21:00</div>
	            <div class="activity-info">장소: 강남역 스터디카페</div>
	            
	            <div class="activity-info-row">
	                <span>👥 참여 응답 인원</span>
	                <span>7명</span>
	            </div>
	            <div class="activity-info-row">
	                <span>✅ 출석 확인 인원</span>
	                <span>0명</span>
	            </div>
	            <div class="activity-info-row">
	                <span>📊 출석률</span>
	                <span class="attendance-rate zero">0%</span>
	            </div>
	        </div>
	    </div>
    </div>

    <!-- 출석 체크 모달 -->
    <div id="attendanceModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title" id="modalActivityDate">출석 체크</h2>
                <button class="modal-close" onclick="closeAttendanceModal()">×</button>
            </div>
            <div class="modal-body">
                <table class="attendance-table">
                    <thead>
                        <tr>
                            <th>모임원</th>
                            <th>누적 출석률</th>
                            <th>출석 상태</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="member-info">
                                    <div class="member-avatar">코</div>
                                    <div class="member-details">
                                        <div class="member-name">코딩마스터</div>
                                        <div class="member-role">모임장</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="rate-badge rate-high">92%</span></td>
                            <td>
                                <div class="attendance-status-buttons">
                                    <button class="status-btn" data-member="1" data-status="present" onclick="setAttendance(1, 'present')">출석</button>
                                    <button class="status-btn active absent" data-member="1" data-status="absent" onclick="setAttendance(1, 'absent')">결석</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="member-info">
                                    <div class="member-avatar">개</div>
                                    <div class="member-details">
                                        <div class="member-name">개발자지망생</div>
                                        <div class="member-role">모임원</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="rate-badge rate-high">88%</span></td>
                            <td>
                                <div class="attendance-status-buttons">
                                    <button class="status-btn" data-member="2" data-status="present" onclick="setAttendance(2, 'present')">출석</button>
                                    <button class="status-btn active absent" data-member="2" data-status="absent" onclick="setAttendance(2, 'absent')">결석</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="member-info">
                                    <div class="member-avatar">알</div>
                                    <div class="member-details">
                                        <div class="member-name">알고리즘초보</div>
                                        <div class="member-role">모임원</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="rate-badge rate-medium">75%</span></td>
                            <td>
                                <div class="attendance-status-buttons">
                                    <button class="status-btn" data-member="3" data-status="present" onclick="setAttendance(3, 'present')">출석</button>
                                    <button class="status-btn active absent" data-member="3" data-status="absent" onclick="setAttendance(3, 'absent')">결석</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="member-info">
                                    <div class="member-avatar">자</div>
                                    <div class="member-details">
                                        <div class="member-name">자바마스터</div>
                                        <div class="member-role">모임원</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="rate-badge rate-high">90%</span></td>
                            <td>
                                <div class="attendance-status-buttons">
                                    <button class="status-btn" data-member="4" data-status="present" onclick="setAttendance(4, 'present')">출석</button>
                                    <button class="status-btn active absent" data-member="4" data-status="absent" onclick="setAttendance(4, 'absent')">결석</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="member-info">
                                    <div class="member-avatar">파</div>
                                    <div class="member-details">
                                        <div class="member-name">파이썬러버</div>
                                        <div class="member-role">모임원</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="rate-badge rate-high">83%</span></td>
                            <td>
                                <div class="attendance-status-buttons">
                                    <button class="status-btn" data-member="5" data-status="present" onclick="setAttendance(5, 'present')">출석</button>
                                    <button class="status-btn active absent" data-member="5" data-status="absent" onclick="setAttendance(5, 'absent')">결석</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="member-info">
                                    <div class="member-avatar">웹</div>
                                    <div class="member-details">
                                        <div class="member-name">웹개발자</div>
                                        <div class="member-role">모임원</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="rate-badge rate-low">65%</span></td>
                            <td>
                                <div class="attendance-status-buttons">
                                    <button class="status-btn" data-member="6" data-status="present" onclick="setAttendance(6, 'present')">출석</button>
                                    <button class="status-btn active absent" data-member="6" data-status="absent" onclick="setAttendance(6, 'absent')">결석</button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="member-info">
                                    <div class="member-avatar">스</div>
                                    <div class="member-details">
                                        <div class="member-name">스프링초보</div>
                                        <div class="member-role">모임원</div>
                                    </div>
                                </div>
                            </td>
                            <td><span class="rate-badge rate-high">80%</span></td>
                            <td>
                                <div class="attendance-status-buttons">
                                    <button class="status-btn" data-member="7" data-status="present" onclick="setAttendance(7, 'present')">출석</button>
                                    <button class="status-btn active absent" data-member="7" data-status="absent" onclick="setAttendance(7, 'absent')">결석</button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-ghost" onclick="closeAttendanceModal()">취소</button>
                <button class="btn btn-primary" onclick="saveAttendance()">💾 저장하기</button>
            </div>
        </div>
    </div>
</body>
</html>
