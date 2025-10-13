<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	request.setAttribute("cp", cp); 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 목록 - 공모자들</title>
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

/* 컨텐츠 영역 */
.content {
	padding: 40px 30px;
	max-width: 1400px;
	margin: 0 auto;
}

/* 카테고리 섹션 */
.category-section {
	margin-bottom: 40px;
}

.category-header {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 20px;
}

.category-title {
	font-size: 24px;
	font-weight: bold;
	color: #2d5a29;
}

.category-count {
	background: #a8d5a1;
	color: white;
	padding: 4px 12px;
	border-radius: 20px;
	font-size: 14px;
	font-weight: 500;
}

/* 모임 카드 컨테이너 */
.meetings-container {
	display: flex;
	gap: 20px;
	overflow-x: auto;
	padding-bottom: 10px;
	scroll-behavior: smooth;
}

.meetings-container::-webkit-scrollbar {
	height: 8px;
}

.meetings-container::-webkit-scrollbar-track {
	background: #e0e0e0;
	border-radius: 4px;
}

.meetings-container::-webkit-scrollbar-thumb {
	background: #a8d5a1;
	border-radius: 4px;
}

.meetings-container::-webkit-scrollbar-thumb:hover {
	background: #8bc683;
}

/* 카테고리 필터 섹션 */
.category-filter-section {
	background: white;
	padding: 30px;
	margin: 20px 20px;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.filter-title {
	font-size: 18px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 20px;
	display: flex;
	align-items: center;
	gap: 8px;
}

.category-tags {
	display: flex;
	flex-wrap: wrap;
	gap: 12px;
}

.category-tag {
	padding: 10px 20px;
	background: #f8faf9;
	border: 2px solid #e8f5e6;
	border-radius: 25px;
	font-size: 15px;
	font-weight: 500;
	color: #666;
	cursor: pointer;
	transition: all 0.3s ease;
	display: flex;
	align-items: center;
	gap: 6px;
	text-decoration: none;
}

.category-tag:hover {
	background: #e8f5e6;
	border-color: #a8d5a1;
	color: #2d5a29;
	transform: translateY(-2px);
	box-shadow: 0 2px 8px rgba(168, 213, 161, 0.3);
}

.category-tag.active {
	background: #2d5a29;
	border-color: #2d5a29;
	color: white;
	font-weight: 600;
}

.category-tag-icon {
	font-size: 18px;
}

/* 컨텐츠 영역 */
.content {
	padding: 40px 30px;
	max-width: 1400px;
	margin: 0 auto;
}

/* 카테고리 섹션 */
.category-section {
	margin-bottom: 40px;
}

.category-header {
	display: flex;
	align-items: center;
	gap: 12px;
	margin-bottom: 20px;
}

.category-title {
	font-size: 24px;
	font-weight: bold;
	color: #2d5a29;
}

.category-count {
	background: #a8d5a1;
	color: white;
	padding: 4px 12px;
	border-radius: 20px;
	font-size: 14px;
	font-weight: 500;
}

/* 모임 카드 */
.meeting-card {
	background: white;
	border-radius: 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
	min-width: 280px;
	max-width: 280px;
	cursor: pointer;
	transition: all 0.3s ease;
	overflow: hidden;
}

.meeting-card:hover {
	transform: translateY(-4px);
	box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
}

.meeting-image {
	width: 100%;
	height: 160px;
	background: linear-gradient(135deg, #a8d5a1, #8bc683);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 48px;
	position: relative;
}

.meeting-status {
	position: absolute;
	top: 10px;
	right: 10px;
	background: rgba(255, 255, 255, 0.95);
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: 600;
	color: #2d5a29;
}

.meeting-info {
	padding: 20px;
}

.meeting-title {
	font-size: 18px;
	font-weight: bold;
	color: #333;
	margin-bottom: 8px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.meeting-description {
	font-size: 14px;
	color: #666;
	margin-bottom: 12px;
	line-height: 1.5;
	height: 42px;
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
}

.meeting-meta {
	display: flex;
	flex-direction: column;
	gap: 8px;
	border-top: 1px solid #f0f0f0;
	padding-top: 12px;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 13px;
	color: #666;
}

.meta-icon {
	font-size: 16px;
}

.meeting-tags {
	display: flex;
	flex-wrap: wrap;
	gap: 6px;
	margin-top: 10px;
}

.tag {
	background: #f0f7ee;
	color: #2d5a29;
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: 500;
}

/* 빈 상태 */
.empty-state {
	text-align: center;
	padding: 60px 20px;
	color: #999;
}

.empty-state-icon {
	font-size: 64px;
	margin-bottom: 16px;
}

/* 반응형 */
@media (max-width: 768px) {
	.content {
		padding: 20px 15px;
	}
	
	.category-title {
		font-size: 20px;
	}
	
	.meeting-card {
		min-width: 240px;
		max-width: 240px;
	}
	
	.category-title {
		font-size: 20px;
	}
	
	.category-filter-section {
		margin: 15px;
		padding: 20px;
	}
	
	.category-tags {
		gap: 8px;
	}
	
	.category-tag {
		padding: 8px 16px;
		font-size: 14px;
	}
}
</style>
</head>
<body>
	<!-- 여기에 상단바 import -->
	<div id="topMenu">
		<%-- <c:import url="${cp }/menubar/UserMenuBar.jsp"></c:import> --%>
		<jsp:include page="../menubar/TopMenuBar.jsp" />
	</div>
	

	<div class="content">
	
	<!-- 카테고리 필터 섹션 -->
	<%
		// 현재 선택된 카테고리 (파라미터로 받기)
		String selectedCategory = request.getParameter("category");
		if (selectedCategory == null) selectedCategory = "all";
	%>
	
	<div class="category-filter-section">
		<div class="filter-title">
			<span>🏷️</span>
			<span>카테고리</span>
		</div>
		<div class="category-tags">
			<a href="?category=all" class="category-tag <%= "all".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">📚</span>
				<span>전체</span>
			</a>
			<a href="?category=reading" class="category-tag <%= "reading".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">📖</span>
				<span>독서</span>
			</a>
			<a href="?category=language" class="category-tag <%= "language".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">🌐</span>
				<span>어학</span>
			</a>
			<a href="?category=it" class="category-tag <%= "it".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">💻</span>
				<span>IT</span>
			</a>
			<a href="?category=startup" class="category-tag <%= "startup".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">🚀</span>
				<span>창업·취업</span>
			</a>
			<a href="?category=license" class="category-tag <%= "license".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">📜</span>
				<span>자격증</span>
			</a>
			<a href="?category=exam" class="category-tag <%= "exam".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">✏️</span>
				<span>시험</span>
			</a>
			<a href="?category=hobby" class="category-tag <%= "hobby".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">🎨</span>
				<span>취미</span>
			</a>
			<a href="?category=etc" class="category-tag <%= "etc".equals(selectedCategory) ? "active" : "" %>">
				<span class="category-tag-icon">📌</span>
				<span>기타</span>
			</a>
		</div>
	</div>
	
		<!-- 스터디 모임 -->
		<div class="category-section">
			<div class="category-header">
				<h2 class="category-title">📚 IT</h2>
				<span class="category-count">8</span>
			</div>
			<div class="meetings-container">
				<div class="meeting-card">
					<div class="meeting-image">
						💻
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">알고리즘 정복 스터디</h3>
						<p class="meeting-description">매주 3문제씩 풀고 코드 리뷰하는 알고리즘 스터디입니다.</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>8/10명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 월, 수 19:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">알고리즘</span>
							<span class="tag">Python</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						📖
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">Java Spring 마스터</h3>
						<p class="meeting-description">Spring Boot로 실전 프로젝트를 만들어보는 스터디</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>5/8명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 토 14:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>강남역 스터디카페</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">Java</span>
							<span class="tag">Spring</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						🎨
						<span class="meeting-status">진행중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">React 실전 프로젝트</h3>
						<p class="meeting-description">React로 실제 서비스를 만들어보는 프로젝트형 스터디</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>6/6명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 수 20:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">React</span>
							<span class="tag">프론트엔드</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						🗄️
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">데이터베이스 심화</h3>
						<p class="meeting-description">MySQL, PostgreSQL 성능 최적화 스터디</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>3/6명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 목 19:30</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">Database</span>
							<span class="tag">SQL</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						🤖
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">AI/ML 입문반</h3>
						<p class="meeting-description">파이썬으로 시작하는 머신러닝 기초 스터디</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>7/10명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 화, 목 20:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">AI</span>
							<span class="tag">머신러닝</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 프로젝트 -->
		<div class="category-section">
			<div class="category-header">
				<h2 class="category-title">🚀 언어</h2>
				<span class="category-count">5</span>
			</div>
			<div class="meetings-container">
				<div class="meeting-card">
					<div class="meeting-image">
						🏪
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">중고거래 플랫폼</h3>
						<p class="meeting-description">지역 기반 중고거래 웹 서비스 개발 프로젝트</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>4/6명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 금 19:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">풀스택</span>
							<span class="tag">3개월</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						📱
						<span class="meeting-status">진행중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">운동 메이트 앱</h3>
						<p class="meeting-description">운동 파트너를 찾아주는 모바일 앱 개발</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>5/5명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 토, 일 10:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>선릉역 코워킹</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">React Native</span>
							<span class="tag">앱개발</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						🎮
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">인디 게임 개발</h3>
						<p class="meeting-description">Unity로 만드는 2D 퍼즐 어드벤처 게임</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>3/5명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 목 20:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">Unity</span>
							<span class="tag">게임</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						📊
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">데이터 분석 대시보드</h3>
						<p class="meeting-description">공공데이터를 활용한 시각화 대시보드 제작</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>2/4명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 화 19:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">Python</span>
							<span class="tag">데이터분석</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 취미/특기 -->
		<div class="category-section">
			<div class="category-header">
				<h2 class="category-title">🎯 취미/특기</h2>
				<span class="category-count">6</span>
			</div>
			<div class="meetings-container">
				<div class="meeting-card">
					<div class="meeting-image">
						📷
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">사진 촬영 동아리</h3>
						<p class="meeting-description">주말마다 출사하며 사진 실력을 향상시키는 모임</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>12/15명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 토 09:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>서울 각지</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">사진</span>
							<span class="tag">출사</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						🎸
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">밴드 멤버 모집</h3>
						<p class="meeting-description">록 밴드 키보디스트, 베이시스트 모집합니다</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>3/5명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 수 19:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>홍대 연습실</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">밴드</span>
							<span class="tag">음악</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						⚽
						<span class="meeting-status">진행중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">주말 풋살 클럽</h3>
						<p class="meeting-description">매주 일요일 아침 풋살하는 친목 클럽</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>16/20명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 일 08:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>잠실 체육관</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">풋살</span>
							<span class="tag">운동</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						🎨
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">취미 드로잉 클래스</h3>
						<p class="meeting-description">인물화, 풍경화 등 함께 그리는 드로잉 모임</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>6/10명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 토 15:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>신촌 아트센터</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">그림</span>
							<span class="tag">예술</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 자격증 -->
		<div class="category-section">
			<div class="category-header">
				<h2 class="category-title">📜 자격증</h2>
				<span class="category-count">4</span>
			</div>
			<div class="meetings-container">
				<div class="meeting-card">
					<div class="meeting-image">
						💼
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">정보처리기사 준비반</h3>
						<p class="meeting-description">2025년 상반기 정보처리기사 시험 대비 스터디</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>9/12명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 월, 목 20:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">자격증</span>
							<span class="tag">IT</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						🏛️
						<span class="meeting-status">모집중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">공인중개사 스터디</h3>
						<p class="meeting-description">32회 공인중개사 시험 합격을 위한 그룹 스터디</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>5/8명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매주 화, 금 19:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>종로 스터디카페</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">부동산</span>
							<span class="tag">자격증</span>
						</div>
					</div>
				</div>
				
				<div class="meeting-card">
					<div class="meeting-image">
						🌐
						<span class="meeting-status">진행중</span>
					</div>
					<div class="meeting-info">
						<h3 class="meeting-title">토익 900+ 달성</h3>
						<p class="meeting-description">3개월 안에 토익 900점 이상 목표 스터디</p>
						<div class="meeting-meta">
							<div class="meta-item">
								<span class="meta-icon">👥</span>
								<span>6/6명</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📅</span>
								<span>매일 06:00</span>
							</div>
							<div class="meta-item">
								<span class="meta-icon">📍</span>
								<span>온라인</span>
							</div>
						</div>
						<div class="meeting-tags">
							<span class="tag">영어</span>
							<span class="tag">토익</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 여기에 하단바 import -->
	<jsp:include page="../menubar/UnderMenuBar.jsp"></jsp:include>
		
</body>
</html>