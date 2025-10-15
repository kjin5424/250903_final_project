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
    
    <!-- CSS 파일 로드 (순서 중요!) -->
    <link rel="stylesheet" href="<%=cp%>/css/variables.css">
    <link rel="stylesheet" href="<%=cp%>/css/common.css">
    <link rel="stylesheet" href="<%=cp%>/css/components.css">
</head>
<body>
    <!-- 상단바 (그라디언트 영역) -->
    <jsp:include page="/common/TopMenuBar.jsp" />
    
    <!-- Inner Wrapper (연회색 영역) -->
    <div class="inner-wrapper">
        <div class="content">
            
            <%
                // 현재 선택된 카테고리 (파라미터로 받기)
                String selectedCategory = request.getParameter("category");
                if (selectedCategory == null) selectedCategory = "all";
            %>
            
            <!-- 카테고리 필터 섹션 -->
            <div class="category-filter-section">
                <div class="category-tags">
                    <a href="?category=all" 
                       class="category-btn <%= "all".equals(selectedCategory) ? "active" : "" %>">
                        <span class="category-tag-icon">📚</span>
                        <span>전체</span>
                    </a>
                    <a href="?category=reading" 
                       class="category-btn <%= "reading".equals(selectedCategory) ? "active" : "" %>">
                        <span class="category-tag-icon">📖</span>
                        <span>독서</span>
                    </a>
                    <a href="?category=language" 
                       class="category-btn <%= "language".equals(selectedCategory) ? "active" : "" %>">
                        <span class="category-tag-icon">🌐</span>
                        <span>어학</span>
                    </a>
                    <a href="?category=it" 
                       class="category-btn <%= "it".equals(selectedCategory) ? "active" : "" %>">
                        <span class="category-tag-icon">💻</span>
                        <span>IT</span>
                    </a>
                    <a href="?category=startup" 
                       class="category-btn <%= "startup".equals(selectedCategory) ? "active" : "" %>">
                        <span class="category-tag-icon">🚀</span>
                        <span>창업·취업</span>
                    </a>
                    <a href="?category=license" 
                       class="category-btn <%= "license".equals(selectedCategory) ? "active" : "" %>">
                        <span class="category-tag-icon">📜</span>
                        <span>자격증</span>
                    </a>
                    <a href="?category=exam" 
                       class="category-btn <%= "exam".equals(selectedCategory) ? "active" : "" %>">
                        <span class="category-tag-icon">📝</span>
                        <span>시험</span>
                    </a>
                    <a href="?category=hobby" 
                       class="category-btn <%= "hobby".equals(selectedCategory) ? "active" : "" %>">
                        <span class="category-tag-icon">🎨</span>
                        <span>취미</span>
                    </a>
                </div>
            </div>
            
            <!-- 검색 섹션 (선택사항) -->
            <c:import url="/common/search.jsp"></c:import>
            
            <!-- IT 카테고리 섹션 -->
            <div class="section category-section">
                <div class="section-header">
                    <h2 class="section-title">💻 IT</h2>
                    <span class="section-count">8</span>
                </div>
                
                <!-- 모임 카드 컨테이너 -->
                <div class="meetings-container scroll-container">
                    <!-- 모임 카드 1 -->
                    <div class="meeting-card">
                        <div class="meeting-image">
                            💻
                            <span class="badge badge-recruiting badge-absolute">모집중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">알고리즘</span>
                                    <span class="tag">Python</span>
                                </div>
                                <button class="favorite-btn inactive">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 모임 카드 2 -->
                    <div class="meeting-card">
                        <div class="meeting-image">
                            📖
                            <span class="lock-icon">🔒</span>
                            <span class="badge badge-applying badge-absolute">참여신청중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">Java</span>
                                    <span class="tag">Spring</span>
                                </div>
                                <button class="favorite-btn active">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 모임 카드 3 -->
                    <div class="meeting-card">
                        <div class="meeting-image">
                            🎨
                            <span class="badge badge-closed badge-absolute">모집완료</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">React</span>
                                    <span class="tag">프론트엔드</span>
                                </div>
                                <button class="favorite-btn inactive">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 모임 카드 4 -->
                    <div class="meeting-card">
                        <div class="meeting-image">
                            🗄️
                            <span class="badge badge-recruiting badge-absolute">모집중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">Database</span>
                                    <span class="tag">SQL</span>
                                </div>
                                <button class="favorite-btn active">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 모임 카드 5 -->
                    <div class="meeting-card">
                        <div class="meeting-image">
                            🤖
                            <span class="badge badge-recruiting badge-absolute">모집중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">AI</span>
                                    <span class="tag">머신러닝</span>
                                </div>
                                <button class="favorite-btn inactive">♥</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 자격증 카테고리 섹션 -->
            <div class="section category-section">
                <div class="section-header">
                    <h2 class="section-title">📜 자격증</h2>
                    <span class="section-count">3</span>
                </div>
                
                <div class="meetings-container scroll-container">
                    <div class="meeting-card">
                        <div class="meeting-image">
                            💼
                            <span class="badge badge-recruiting badge-absolute">모집중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">자격증</span>
                                    <span class="tag">IT</span>
                                </div>
                                <button class="favorite-btn inactive">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="meeting-card">
                        <div class="meeting-image">
                            🌐
                            <span class="lock-icon">🔒</span>
                            <span class="badge badge-closed badge-absolute">모집완료</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">영어</span>
                                    <span class="tag">토익</span>
                                </div>
                                <button class="favorite-btn inactive">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="meeting-card">
                        <div class="meeting-image">
                            🏛️
                            <span class="badge badge-applying badge-absolute">참여신청중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">부동산</span>
                                    <span class="tag">자격증</span>
                                </div>
                                <button class="favorite-btn active">♥</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 취미/특기 카테고리 섹션 -->
            <div class="section category-section">
                <div class="section-header">
                    <h2 class="section-title">🎯 취미/특기</h2>
                    <span class="section-count">4</span>
                </div>
                
                <div class="meetings-container scroll-container">
                    <div class="meeting-card">
                        <div class="meeting-image">
                            📷
                            <span class="badge badge-recruiting badge-absolute">모집중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">사진</span>
                                    <span class="tag">출사</span>
                                </div>
                                <button class="favorite-btn inactive">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="meeting-card">
                        <div class="meeting-image">
                            🎸
                            <span class="badge badge-recruiting badge-absolute">모집중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">밴드</span>
                                    <span class="tag">음악</span>
                                </div>
                                <button class="favorite-btn active">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="meeting-card">
                        <div class="meeting-image">
                            ⚽
                            <span class="badge badge-recruiting badge-absolute">모집중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">풋살</span>
                                    <span class="tag">운동</span>
                                </div>
                                <button class="favorite-btn inactive">♥</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="meeting-card">
                        <div class="meeting-image">
                            🎨
                            <span class="badge badge-recruiting badge-absolute">모집중</span>
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
                            <div class="meeting-footer">
                                <div class="tags">
                                    <span class="tag">그림</span>
                                    <span class="tag">예술</span>
                                </div>
                                <button class="favorite-btn inactive">♥</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    
    <!-- 하단바 (그라디언트 영역) -->
    <jsp:include page="/common/UnderMenuBar.jsp" />
    
    <!-- JavaScript -->
    <script>
        // 즐겨찾기 버튼 토글
        document.querySelectorAll('.favorite-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                btn.classList.toggle('active');
                btn.classList.toggle('inactive');
            });
        });
        
        // 가로 스크롤 제어 (마우스 휠)
        document.querySelectorAll('.scroll-container').forEach(container => {
            container.addEventListener('wheel', (e) => {
                e.preventDefault();
                container.scrollLeft += e.deltaY;
            });
        });
    </script>
</body>
</html>