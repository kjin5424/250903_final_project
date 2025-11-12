<%@ page contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>공모자들 - 모임 관리</title>
    
    <!-- CSS 파일 임포트 -->
    <link rel="stylesheet" href="css_new/common_sample.css">
    <link rel="stylesheet" href="css_new/home_sample.css">
    <link rel="stylesheet" href="css_new/manager_sample.css">
    <link rel="stylesheet" href="css_new/grouproommanage.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        // 현재 사용자 권한 (서버에서 전달받아야 함)
        const userRole = 'leader'; // leader, subleader, helper

        function closeGroup() {
            if(confirm('정말 모임을 폐쇄하시겠습니까?\n모든 모임원이 탈퇴되며 복구할 수 없습니다.')) {
                const reason = prompt('폐쇄 사유를 입력해주세요:');
                if(reason && reason.trim()) {
                    alert('모임이 폐쇄되었습니다.');
                    window.location.href = 'group_list.jsp';
                }
            }
        }
    </script>
</head>
<body>
    <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
    <!-- 사이드바 -->
	<c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />

    <!-- 관리 페이지 컨테이너 -->
    <div class="container">
        <!-- 페이지 헤더 -->
        <div class="page-header-custom">
            <div class="header-top">
                <div>
                    <div class="page-title-custom">
                        <span>⚙️</span>
                        <span>모임 관리</span>
                        <span class="role-badge">모임장</span>
                    </div>
                    <div class="group-name">${list.groupTitle }</div>
                </div>
                <a href="home.do" class="btn-back-custom">
                    <span>←</span>
                    <span>뒤로 가기</span>
                </a>
            </div>
        </div>

        <!-- 모임 통계 -->
        <div class="section">
            <div class="section-title">📊 모임 현황</div>
            <div class="section-divider"></div>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">${list.currentMemberCount }/${list.headCount }</div>
                    <div class="stat-label">현재 모임원</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">${list.totalActivity }</div>
                    <div class="stat-label">누적 활동</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">
                    	<fmt:formatNumber value="${list.totalAttendance}" type="number" maxFractionDigits="1" minFractionDigits="1" />%
                    </div>
                    <div class="stat-label">평균 출석률</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">Lv.${list.groupLevel }</div>
                    <div class="stat-label">모임 레벨</div>
                </div>
            </div>
        </div>

        <!-- 모임원 관리 -->
        <div class="section">
            <div class="section-title">👥 모임원 관리</div>
            <div class="section-divider"></div>
            <div class="management-grid">
                <div class="management-card" onclick="location.href='${pageContext.request.contextPath}/membermanage.do?groupApplyCode=${groupApplyCode}'">
                    <div class="card-icon">👥</div>
                    <div class="card-title">모임원 및 권한 관리</div>
                    <div class="card-description">
                        모임원 목록 조회, 권한 부여(부모임장/도우미), 강제 퇴장 등을 관리합니다.
                    </div>
                    <span class="permission-badge">모임장 전용</span>
                </div>

                <div class="management-card" onclick="location.href='applicant.do?groupApplyCode=${groupApplyCode}'">
                    <div class="card-icon">📝</div>
                    <div class="card-title">가입 신청 관리</div>
                    <div class="card-description">
                        가입 신청자의 정보를 확인하고 승인/거절을 처리합니다.
                    </div>
                    <span class="permission-badge">모임장 이상</span>
                </div>

                <div class="management-card" onclick="location.href='attendance.do?groupApplyCode=${groupApplyCode}'">
                    <div class="card-icon">📋</div>
                    <div class="card-title">출석 관리</div>
                    <div class="card-description">
                        모임원의 출석/결석을 체크하고 출석률을 관리합니다.
                    </div>
                    <span class="permission-badge">부모임장 이상</span>
                </div>
            </div>
        </div>

        <!-- 콘텐츠 관리 -->
        <div class="section">
            <div class="section-title">📢 콘텐츠 관리</div>
            <div class="section-divider"></div>
            <div class="management-grid">
                <div class="management-card" onclick="location.href='post2.do?groupApplyCode=${groupApplyCode}'">
                    <div class="card-icon">📄</div>
                    <div class="card-title">게시물/댓글 관리</div>
                    <div class="card-description">
                        부적절한 게시물과 댓글을 삭제하고 공지사항을 관리합니다.
                    </div>
                    <span class="permission-badge">부모임장 이상</span>
                </div>
            </div>
        </div>

        <!-- 모임 설정 -->
        <div class="section">
            <div class="section-title">⚙️ 모임 설정</div>
            <div class="section-divider"></div>
            <div class="management-grid">
                <div class="management-card" onclick="location.href='${pageContext.request.contextPath}/groupedit.do?groupApplyCode=${groupApplyCode}'">
                    <div class="card-icon">✏️</div>
                    <div class="card-title">모임 정보 수정</div>
                    <div class="card-description">
                        모임 이름, 설명, 규칙, 난이도 등 기본 정보를 수정합니다.
                    </div>
                    <span class="permission-badge">모임장 전용</span>
                </div>
            </div>
        </div>

        <!-- 위험 영역 -->
        <div class="danger-zone">
            <div class="danger-title">
                <span>⚠️</span>
                <span>위험 영역</span>
            </div>
            <div class="danger-description">
                아래 작업은 되돌릴 수 없습니다. 신중하게 결정해주세요.
            </div>
            <button class="btn-danger" onclick="closeGroup()">
                <span>🗑️</span>
                <span>모임 폐쇄</span>
            </button>
            <p class="danger-note">
                모임 폐쇄 시 모든 모임원이 탈퇴 처리되며, 게시글과 활동 내역은 삭제됩니다.
            </p>
        </div>
    </div>
</body>
</html>
