<%@ page contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
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
    <title>공모자들 - 모임 관리</title>
    
    <!-- CSS 파일 임포트 -->
    <link rel="stylesheet" href="css_new/common_sample.css">
    <link rel="stylesheet" href="css_new/topmenubar_sample.css">
    <link rel="stylesheet" href="css_new/home_sample.css">
    <link rel="stylesheet" href="css_new/manager_sample.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
        
        /* 통계 그리드 - 원본과 동일하게 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        
        /* 관리 카드 그리드 스타일 */
        .management-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        
        .management-card {
            background: var(--color-white);
            border-radius: var(--radius-lg);
            padding: 30px;
            box-shadow: var(--shadow-sm);
            transition: all var(--transition-base);
            cursor: pointer;
            border: 2px solid transparent;
        }
        
        .management-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
            border-color: var(--color-primary);
        }
        
        .card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--color-primary), var(--color-primary-dark));
            border-radius: var(--radius-full);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 20px;
            box-shadow: var(--shadow-md);
        }
        
        .card-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: 10px;
        }
        
        .card-description {
            font-size: 14px;
            color: var(--color-text-secondary);
            line-height: 1.6;
            margin-bottom: 8px;
        }
        
        .permission-badge {
            display: inline-block;
            background: var(--color-primary-lighter);
            color: var(--color-primary-dark);
            padding: 4px 10px;
            border-radius: var(--radius-full);
            font-size: 11px;
            font-weight: 700;
        }
        
        /* 섹션 스타일 */
        .section {
            margin-bottom: 40px;
        }
        
        .section-title {
            font-size: 24px;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-divider {
            height: 3px;
            background: linear-gradient(90deg, var(--color-primary), transparent);
            margin-bottom: 20px;
        }
        
        /* 위험 영역 */
        .danger-zone {
            background: #FFF5F5;
            border: 2px solid #FFEBEE;
            border-radius: var(--radius-lg);
            padding: 30px;
            margin-top: 40px;
        }
        
        .danger-title {
            font-size: 20px;
            font-weight: 700;
            color: #D32F2F;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .danger-description {
            color: var(--color-text-secondary);
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .btn-danger {
            background: #F44336;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: var(--radius-md);
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-danger:hover {
            background: #D32F2F;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }
        
        .danger-note {
            font-size: 13px;
            color: var(--color-text-tertiary);
            margin-top: 10px;
        }
        
        /* 페이지 헤더는 group-header 스타일 활용 */
        .page-header-custom {
            background: linear-gradient(135deg, var(--color-primary-deep), var(--color-primary-darker));
            color: white;
            padding: 40px;
            border-radius: var(--radius-lg);
            margin-bottom: 30px;
            box-shadow: var(--shadow-lg);
        }
        
        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .page-title-custom {
            font-size: 32px;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .role-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 15px;
            border-radius: var(--radius-full);
            font-size: 14px;
            font-weight: 600;
        }
        
        .group-name {
            font-size: 18px;
            opacity: 0.9;
        }
        
        .btn-back-custom {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid white;
            padding: 10px 20px;
            border-radius: var(--radius-md);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition-base);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-back-custom:hover {
            background: white;
            color: var(--color-primary-dark);
        }
        
        @media (max-width: 768px) {
            .management-grid {
                grid-template-columns: 1fr;
            }
            
            .page-header-custom {
                padding: 25px 20px;
            }
            
            .page-title-custom {
                font-size: 24px;
            }
            
            .header-top {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
        }
    </style>
    
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
                    <div class="group-name">알고리즘 정복 스터디</div>
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
                    <div class="stat-value">7/10</div>
                    <div class="stat-label">현재 모임원</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">12</div>
                    <div class="stat-label">누적 활동</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">85%</div>
                    <div class="stat-label">평균 출석률</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">Lv.3</div>
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
