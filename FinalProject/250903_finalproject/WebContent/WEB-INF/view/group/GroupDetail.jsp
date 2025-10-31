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
<title>공모자들 - 모임 히스토리</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: #f5f7fa;
}

.navbar {
	background: #a8d5a1;
	display: flex;
	align-items: center;
	padding: 0 20px;
	height: 48px;
	position: sticky;
	top: 0;
	z-index: 1000;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	gap: 4px;
}

.nav-left {
	display: flex;
	align-items: center;
	gap: 4px;
	flex: 1;
}

.logo-tab {
	background: #8bc683;
	color: white;
	padding: 0 20px;
	height: 36px;
	border-radius: 8px 8px 0 0;
	display: flex;
	align-items: center;
	gap: 8px;
	font-weight: bold;
	font-size: 16px;
	cursor: pointer;
}

.container {
	max-width: 1200px;
	margin: 30px auto;
	padding: 0 20px;
}

.page-header {
	background: linear-gradient(135deg, #2d5a29 0%, #4a8a42 100%);
	color: white;
	padding: 40px;
	border-radius: 12px;
	margin-bottom: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.page-title {
	font-size: 32px;
	font-weight: bold;
	display: flex;
	align-items: center;
	gap: 12px;
}

.btn-back {
	background: rgba(255, 255, 255, 0.2);
	color: white;
	border: 2px solid white;
	padding: 10px 20px;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
	text-decoration: none;
}

.btn-back:hover {
	background: white;
	color: #2d5a29;
}

.group-name {
	font-size: 18px;
	opacity: 0.9;
}

.tab-menu {
	display: flex;
	gap: 10px;
	margin-bottom: 30px;
	border-bottom: 2px solid #e0e0e0;
	background: white;
	padding: 0 20px;
	border-radius: 12px 12px 0 0;
	flex-wrap: wrap;
}

.tab-item {
	padding: 15px 25px;
	cursor: pointer;
	font-weight: 600;
	color: #666;
	border-bottom: 3px solid transparent;
	transition: all 0.3s;
	position: relative;
	bottom: -2px;
}

.tab-item:hover {
	color: #2d5a29;
}

.tab-item.active {
	color: #2d5a29;
	border-bottom-color: #2d5a29;
}

.content-section {
	background: white;
	border-radius: 0 0 12px 12px;
	padding: 30px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

/* 타임라인 스타일 */
.timeline {
	position: relative;
	padding: 20px 0;
}

.timeline:before {
	content: '';
	position: absolute;
	left: 30px;
	top: 0;
	bottom: 0;
	width: 3px;
	background: linear-gradient(to bottom, #8bc683, #e0e0e0);
}

.timeline-item {
	position: relative;
	padding-left: 70px;
	margin-bottom: 30px;
}

.timeline-date {
	position: absolute;
	left: 0;
	top: 0;
	width: 60px;
	text-align: center;
}

.timeline-dot {
	width: 18px;
	height: 18px;
	background: #4CAF50;
	border-radius: 50%;
	border: 3px solid white;
	box-shadow: 0 0 0 3px #8bc683;
	margin: 0 auto 5px;
}

.timeline-date-text {
	font-size: 11px;
	color: #666;
	font-weight: 600;
}

.timeline-content {
	background: #f8faf8;
	padding: 20px;
	border-radius: 12px;
	border: 2px solid #e0e0e0;
	transition: all 0.3s;
}

.timeline-content:hover {
	border-color: #8bc683;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.timeline-title {
	font-size: 16px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 8px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.timeline-category {
	display: inline-block;
	background: #e3f2fd;
	color: #1565c0;
	padding: 3px 10px;
	border-radius: 12px;
	font-size: 11px;
	font-weight: 600;
}

.timeline-description {
	color: #666;
	font-size: 14px;
	line-height: 1.6;
	margin-top: 8px;
}

.timeline-meta {
	display: flex;
	gap: 15px;
	margin-top: 10px;
	font-size: 13px;
	color: #999;
	flex-wrap: wrap;
}

/* 투표 히스토리 */
.vote-result {
	display: flex;
	gap: 15px;
	margin-top: 12px;
}

.vote-option {
	flex: 1;
	padding: 10px;
	background: white;
	border-radius: 8px;
	text-align: center;
}

.vote-count {
	font-size: 20px;
	font-weight: bold;
	color: #2d5a29;
}

.vote-label {
	font-size: 12px;
	color: #666;
}

.vote-bar {
	height: 6px;
	background: #e0e0e0;
	border-radius: 3px;
	margin-top: 8px;
	overflow: hidden;
}

.vote-bar-fill {
	height: 100%;
	background: #4CAF50;
	border-radius: 3px;
	transition: width 0.3s;
}

/* 도전과제 히스토리 */
.challenge-progress {
	margin-top: 12px;
}

.progress-bar {
	height: 30px;
	background: #e0e0e0;
	border-radius: 15px;
	overflow: hidden;
	position: relative;
}

.progress-fill {
	height: 100%;
	background: linear-gradient(90deg, #4CAF50, #8bc683);
	border-radius: 15px;
	transition: width 0.3s;
	display: flex;
	align-items: center;
	justify-content: center;
}

.progress-text {
	position: absolute;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
	font-weight: bold;
	font-size: 13px;
	color: #333;
}

/* 통계 카드 */
.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
}

.stat-card {
	background: #f8faf8;
	padding: 25px;
	border-radius: 12px;
	text-align: center;
	border: 2px solid #e0e0e0;
}

.stat-value {
	font-size: 32px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 8px;
}

.stat-label {
	font-size: 14px;
	color: #666;
}

/* 레벨업 표시 */
.level-up-badge {
	display: inline-block;
	background: linear-gradient(135deg, #ffd54f, #ffb300);
	color: #f57c00;
	padding: 5px 12px;
	border-radius: 15px;
	font-size: 12px;
	font-weight: bold;
	margin-left: 10px;
	animation: pulse 2s infinite;
}

@
keyframes pulse { 0%, 100% {
	transform: scale(1);
}

50%
{
transform


:

 

scale


(1
.05


);
}
}
@media ( max-width : 768px) {
	.page-header {
		padding: 25px 20px;
	}
	.page-title {
		font-size: 24px;
	}
	.header-top {
		flex-direction: column;
		gap: 15px;
		align-items: flex-start;
	}
	.timeline:before {
		left: 20px;
	}
	.timeline-item {
		padding-left: 60px;
	}
	.vote-result {
		flex-direction: column;
	}
}
</style>
</head>
<body>
	<!-- 임포트할 상단바 -->
	<nav class="navbar">
		<div class="nav-left">
			<div class="logo-tab">
				<span>로고 들어갈 자리</span>
			</div>
		</div>
	</nav>

	<div class="container">
		<div class="page-header">
			<div class="header-top">
				<div>
					<div class="page-title">
						<span>📜</span><span>나의 모임 기록</span>
					</div>
					<div class="group-name">알고리즘 정복 스터디</div>
				</div>
				<button class="btn-back" onclick="history.back()">← 뒤로 가기</button>
			</div>
		</div>

		<div class="tab-menu">
			<div class="tab-item active" onclick="switchTab('all')">전체</div>
			<div class="tab-item" onclick="switchTab('member')">게시글</div>
		</div>

		<div class="content-section">
			<!-- 전체 히스토리 -->
			<div id="all-tab" class="tab-content active">
				<div class="stats-grid">
					<div class="stat-card">
						<div class="stat-value">45</div>
						<div class="stat-label">총 활동 횟수</div>
					</div>
					<div class="stat-card">
						<div class="stat-value">8</div>
						<div class="stat-label">도전과제 완료</div>
					</div>
					<div class="stat-card">
						<div class="stat-value">도우미</div>
						<div class="stat-label">마지막 모임 권한</div>
					</div>
				</div>

				<div class="timeline">
					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.10.20</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🗳️</span> <span>10월 4주차 모임 일정 참석</span> <span
									class="timeline-category">활동</span>
							</div>
							<div class="timeline-description">
								<strong>결정 사항:</strong> 10월 27일 오후 2시, 스터디 카페 A지점
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.10.18</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🏆</span> <span>백준 실버 문제 풀기 도전과제 완료</span> <span
									class="timeline-category">도전과제</span>
							</div>
							<div class="timeline-description">7일 중 6일의 도전과제를 완료했습니다.
								(달성률 86%)</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.10.12</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🏆</span> <span>유빙 골드 문제 풀기 도전과제 완료</span> <span
									class="timeline-category">도전과제</span>
							</div>
							<div class="timeline-description">7일 중 6일의 도전과제를 완료했습니다.
								(달성률 86%)</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.10.10</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🗳️</span> <span>10월 2주차 모임 일정 참석</span> <span
									class="timeline-category">활동</span>
							</div>
							<div class="timeline-description">
								<strong>결정 사항:</strong> 10월 10일 오후 3시, 송도 스타벅스 A점
							</div>
						</div>
					</div>
					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.10.05</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🗳️</span> <span>10월 1주차 모임 일정 참석</span> <span
									class="timeline-category">활동</span>
							</div>
							<div class="timeline-description">
								<strong>결정 사항:</strong> 10월 05일 오후 5시, 송도 투썸플레이스 B점
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.09.25</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🗳️</span> <span>09월 4주차 모임 일정 참석</span> <span
									class="timeline-category">활동</span>
							</div>
							<div class="timeline-description">
								<strong>결정 사항:</strong> 09월 25일 오후 5시, 송도 투썸플레이스 B점
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.09.15</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>⭐</span> <span>권한 변경</span> <span
									class="timeline-category">권한</span>
							</div>
							<div class="timeline-description">스터디러버의 권한이 부모임장으로
								임명되었습니다.</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.09.05</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🏆</span> <span>자료구조 개념 정리하기 도전과제 완료</span> <span
									class="timeline-category">도전과제</span>
							</div>
							<div class="timeline-description">7일 모두 도전과제를 완료했습니다. (달성률
								100%)</div>
						</div>
					</div>
					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.28</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>⭐</span> <span>권한 변경</span> <span
									class="timeline-category">권한</span>
							</div>
							<div class="timeline-description">스터디러버의 권한이 도우미로
								임명되었습니다.</div>
						</div>
					</div>
					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.20</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🗳️</span> <span>08월 3주차 모임 일정 참석</span> <span
									class="timeline-category">활동</span>
							</div>
							<div class="timeline-description">
								<strong>결정 사항:</strong> 08월 20일 오후 5시, 송도 투썸플레이스 B점
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.10</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🗳️</span> <span>08월 2주차 모임 일정 참석</span> <span
									class="timeline-category">활동</span>
							</div>
							<div class="timeline-description">
								<strong>결정 사항:</strong> 08월 10일 오후 5시, 송도 투썸플레이스 B점
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.05</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>👥</span> <span>새로운 모임원 가입</span> <span
									class="timeline-category">모임원</span>
							</div>
							<div class="timeline-description">강알고, 정코딩님이 모임에 참여했습니다.</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 게시글 히스토리 -->
			<div id="member-tab" class="tab-content">
				<div class="timeline">
					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.10.12</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>✏️</span> <span>모임 정보 수정</span> <span
									class="timeline-category">수정</span>
							</div>
							<div class="timeline-description">
								• 모임 시간: 토요일 14:00 → 토요일 19:00<br> • 모임 장소: 스터디 카페 A지점 →
								온라인/오프라인 병행<br> • 모임 규칙 추가
							</div>
							<div class="timeline-meta">
								<span>👤 수정자: 김모임장</span>
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.10.10</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>👥</span> <span>새로운 모임원 가입</span> <span
									class="timeline-category">가입</span>
							</div>
							<div class="timeline-description">윤개발님이 모임에 참여했습니다.</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.09.25</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>✏️</span> <span>모임 정보 수정</span> <span
									class="timeline-category">수정</span>
							</div>
							<div class="timeline-description">
								• 모임 설명 업데이트<br> • 난이도: 하 → 중<br> • 모임 이미지 변경
							</div>
							<div class="timeline-meta">
								<span>👤 수정자: 김모임장</span>
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.09.15</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>⭐</span> <span>권한 변경</span> <span
									class="timeline-category">권한</span>
							</div>
							<div class="timeline-description">이부장님이 부모임장으로 임명되었습니다.</div>
							<div class="timeline-meta">
								<span>👤 변경자: 김모임장</span>
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.20</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>✏️</span> <span>모임 정보 수정</span> <span
									class="timeline-category">수정</span>
							</div>
							<div class="timeline-description">
								• 모임 이름: 알고리즘 스터디 → 알고리즘 정복 스터디<br> • 가입 질문 추가
							</div>
							<div class="timeline-meta">
								<span>👤 수정자: 김모임장</span>
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.10</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>⭐</span> <span>권한 변경</span> <span
									class="timeline-category">권한</span>
							</div>
							<div class="timeline-description">박도움님이 도우미로 임명되었습니다.</div>
							
						</div>
					</div>


					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.05</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>👥</span> <span>스터디러버님의 모임 시작!</span> <span
									class="timeline-category">가입</span>
							</div>
							<div class="timeline-description">스터디러버님이 모임에 참여했습니다.</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.05</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>✏️</span> <span>모임 정보 수정</span> <span
									class="timeline-category">수정</span>
							</div>
							<div class="timeline-description">
								• 모임 공개 설정: 비공개 → 공개<br> • 청소년 환영 모임 설정: OFF
							</div>
							<div class="timeline-meta">
								<span>👤 수정자: 김모임장</span>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- 게시물 이력 -->
			<div id="level-tab" class="tab-content">
				<div class="timeline">
					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.10.05</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🎉</span> <span>Level 3 달성!</span> <span
									class="level-up-badge">LEVEL UP!</span>
							</div>
							<div class="timeline-description">
								Lv.2 → Lv.3 레벨업<br> <br> <strong>해금된 기능:</strong><br>
								• 모임 정원: 7명 → 10명<br> • 부모임장 설정 가능<br> • 개인 도전과제 해금
								(모임원도 도전과제 개설 가능)
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.28</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🎉</span> <span>Level 2 달성!</span> <span
									class="level-up-badge">LEVEL UP!</span>
							</div>
							<div class="timeline-description">
								Lv.1 → Lv.2 레벨업<br> <br> <strong>해금된 기능:</strong><br>
								• 모임 정원: 5명 → 7명<br> • 평균 연령대 표시 기능
							</div>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-date">
							<div class="timeline-dot"></div>
							<div class="timeline-date-text">2024.08.03</div>
						</div>
						<div class="timeline-content">
							<div class="timeline-title">
								<span>🌱</span> <span>모임 개설</span> <span
									class="timeline-category">시작</span>
							</div>
							<div class="timeline-description">알고리즘 정복 스터디 모임이 개설되었습니다!
							</div>
						</div>
					</div>
				</div>
			</div>
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