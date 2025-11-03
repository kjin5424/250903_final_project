<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🚫 열람 불가 게시글</title>

    <style>
        /* 폰트, 기본 스타일 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { 
            font-family: 'Malgun Gothic', '맑은 고딕', 'Apple SD Gothic Neo', Roboto, 'Segoe UI', sans-serif; 
            background: #f0f2f5; /* 더 밝고 모던한 배경색 */
            min-height: 100vh; 
            color: #333; /* 기본 텍스트 색상 */
        }

        /* 네비게이션 바 */
        .navbar { 
            background: #4CAF50; /* Primary Green */
            display: flex; 
            align-items: center; 
            padding: 0 20px; 
            height: 55px; /* 높이 약간 증가 */
            position: sticky; 
            top: 0; 
            z-index: 1000; 
            box-shadow: 0 2px 8px rgba(0,0,0,0.1); 
        }
        .logo-tab { 
            background: #388E3C; /* Darker Green for Logo */
            color: #fff; 
            padding: 0 25px; 
            height: 40px; 
            border-radius: 8px; 
            display: flex; 
            align-items: center; 
            font-weight: bold; 
            cursor: default; /* 클릭 불가 표시 */
            font-size: 16px;
        }

        /* 메인 컨테이너 */
        .container { 
            max-width: 760px; /* 너비 약간 축소하여 집중도 향상 */
            margin: 40px auto; 
            padding: 0 20px; 
            display: flex; 
            flex-direction: column; 
            gap: 15px; /* 간격 축소 */
        }

        /* 주요 정보 박스 공통 스타일 */
        .post-container, .info-box, .suspension-warning { 
            background: #fff; 
            border-radius: 12px; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.08); /* 부드럽고 깊은 그림자 */
            padding: 25px; /* 패딩 약간 축소 */
            animation: fadeIn 0.5s ease-in-out; 
        }
        
        /* 블라인드 처리 알림 */
        .post-header { 
            text-align: center; 
            margin-bottom: 5px; 
            padding: 40px 25px; /* 상하 패딩 증가로 강조 */
        }
        .blind-icon { 
            font-size: 70px; 
            margin-bottom: 10px; 
            color: #FF7043; /* 경고를 위한 오렌지-레드 계열 */
        }
        .blind-title { 
            font-size: 26px; 
            font-weight: 800; 
            color: #D32F2F; /* 강렬한 레드 */
            margin-bottom: 10px; 
        }
        .blind-description { 
            font-size: 15px; 
            color: #666; 
            line-height: 1.6; 
            margin-bottom: 20px; 
        }
        .blind-reason { 
            display: inline-block; 
            padding: 6px 14px; 
            background: #FFEBEE; /* 옅은 붉은 배경 */
            border: 1px solid #D32F2F; 
            border-radius: 20px; /* 둥근 뱃지 모양 */
            font-weight: 700; 
            color: #D32F2F; 
            font-size: 14px;
        }

        /* 게시글 정보 박스 */
        .post-info-box { 
            padding: 25px;
        }
        .post-info-title { 
            font-weight: 700; 
            margin-bottom: 15px; 
            font-size: 18px;
            color: #4CAF50; /* Primary Green으로 강조 */
            border-bottom: 2px solid #E8F5E9; /* 옅은 구분선 */
            padding-bottom: 10px;
        }
        .post-info-item { 
            display: flex; 
            justify-content: space-between; 
            padding: 10px 0; 
            border-bottom: 1px dashed #eee; /* 점선으로 부드럽게 구분 */
            font-size: 15px;
        }
        .post-info-item:last-child {
            border-bottom: none;
        }
        .post-info-label { 
            font-weight: 600; 
            color: #555; 
        }
        .post-info-value { 
            color: #333; 
            font-weight: 500;
        }
        .highlight { 
            font-weight: 700; 
            color: #D32F2F; 
        }

        /* 신고 카테고리 뱃지 */
        .report-category-badge { 
            display: inline-block; 
            background: #FFE0B2; /* 부드러운 오렌지 배경 */
            color: #E65100; /* 다크 오렌지 텍스트 */
            border-radius: 4px; 
            padding: 3px 8px; 
            margin-right: 4px; 
            font-size: 13px; 
            font-weight: 600;
        }

        /* 활동 정지 경고/안내 */
        .suspension-warning { 
            border-left: 5px solid #FF9800; /* 오렌지색으로 경고/정지 표시 */
            padding-left: 20px; 
        }
        .suspension-icon { 
            font-size: 35px; 
            margin-bottom: 8px; 
            color: #FF9800;
        }
        .suspension-warning .suspension-icon.locked { /* isSuspended일 때 아이콘 색상 변경 */
            color: #D32F2F;
        }
        .suspension-title { 
            font-weight: 700; 
            font-size: 18px;
            color: #555;
            margin-bottom: 8px; 
        }
        .suspension-description { 
            font-size: 15px; 
            color: #666; 
            line-height: 1.5; 
            margin-bottom: 10px; 
        }
        .suspension-period { 
            font-weight: 700; 
            color: #D32F2F; 
            font-size: 16px;
        }

        /* 안내 메시지 */
        .info-box {
            background: #e8f5e9; /* 옅은 초록색 배경으로 부드러운 정보 느낌 */
        }
        .info-box-title { 
            font-weight: 700; 
            font-size: 18px;
            margin-bottom: 12px; 
            display: flex; 
            align-items: center; 
            gap: 8px; 
            color: #388E3C; /* 다크 그린 */
        }
        .info-box-content ul { 
            margin-left: 20px; 
            list-style-type: '👉 '; /* 커스텀 리스트 스타일 */
            color: #555; 
            font-size: 14px;
        }
        .info-box-content li { 
            margin-bottom: 8px; 
            padding-left: 5px;
        }

        /* 버튼 그룹 */
        .button-group { 
            display: flex; 
            justify-content: center; 
            gap: 15px; 
            margin-top: 30px; 
            flex-wrap: wrap; 
        }
        .btn { 
            padding: 14px 30px; /* 버튼 크기 키움 */
            border-radius: 8px; 
            font-weight: 700; 
            font-size: 16px; 
            cursor: pointer; 
            text-decoration: none; 
            text-align: center; 
            transition: all 0.3s ease; /* transition에 all 추가 */
            display: inline-block; 
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            border: none;
        }
        .btn-primary { 
            background: #4CAF50; /* Primary Green */
            color: #fff; 
        }
        .btn-primary:hover { 
            background: #388E3C; 
            transform: translateY(-3px); 
            box-shadow: 0 6px 10px rgba(0,0,0,0.15);
        }
        .btn-secondary { 
            background: #757575; /* Dark Gray */
            color: #fff; 
        }
        .btn-secondary:hover { 
            background: #616161; 
            transform: translateY(-3px); 
            box-shadow: 0 6px 10px rgba(0,0,0,0.15);
        }

        @media (max-width: 768px) { 
            .container { margin: 20px auto; }
            .post-container, .info-box, .suspension-warning { padding: 20px; }
            .button-group { flex-direction: column; gap: 10px; } 
            .btn { width: 100%; }
            .blind-icon { font-size: 60px; }
            .blind-title { font-size: 22px; }
        }

        @keyframes fadeIn { 
            from { opacity: 0; transform: translateY(15px); } 
            to { opacity: 1; transform: translateY(0); } 
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="logo-tab">게시판</div>
    </div>

    <div class="container">
        <div class="post-container post-header">
            <div class="blind-icon">🚫</div>
            <h1 class="blind-title">신고 처리로 인해 비공개 처리된 게시글입니다</h1>
            <p class="blind-description">
                이 게시글은 회원 신고 3회 이상 접수되어<br>
                관리자 확인 전까지 열람이 불가능합니다.
            </p>
            <div class="blind-reason">
                신고 사유: ${post.reportCategory != null ? post.reportCategory : '복합 사유'}
            </div>
        </div>

        <div class="post-container post-info-box">
            <h2 class="post-info-title">📋 게시글 정보</h2>
            <div class="post-info-item">
                <span class="post-info-label">게시글 제목</span>
                <span class="post-info-value highlight">${post.title}</span>
            </div>
            <div class="post-info-item">
                <span class="post-info-label">작성일자</span>
                <span class="post-info-value"><fmt:formatDate value="${post.createdDate}" pattern="yyyy년 MM월 dd일 HH:mm"/></span>
            </div>
            <div class="post-info-item">
                <span class="post-info-label">신고 카테고리</span>
                <span class="post-info-value">
                    <c:forEach items="${post.reportCategories}" var="category">
                        <span class="report-category-badge">${category}</span>
                    </c:forEach>
                    <c:if test="${empty post.reportCategories}">
                        <span class="report-category-badge">복합 사유</span>
                    </c:if>
                </span>
            </div>
        </div>

        <c:if test="${showSuspensionWarning}">
            <div class="post-container suspension-warning">
                <div class="suspension-icon">⚠️</div>
                <h3 class="suspension-title">활동 정지 경고</h3>
                <p class="suspension-description">
                    최근 1개월 이내 블라인드 처리된 게시글이 ${blindPostCount}개입니다.<br>
                    블라인드 게시글이 3개 이상이 되면 <strong>2주간 모든 모임에서 활동이 정지</strong>됩니다.
                </p>
                <div class="suspension-period">현재 ${blindPostCount}/3개 (${3 - blindPostCount}개 남음)</div>
            </div>
        </c:if>

        <c:if test="${isSuspended}">
            <div class="post-container suspension-warning">
                <div class="suspension-icon locked">🔒</div>
                <h3 class="suspension-title">활동 정지 처리 안내</h3>
                <p class="suspension-description">
                    최근 1개월 이내 블라인드 처리된 게시글이 3개 이상으로<br>
                    <strong>2주간 모든 모임에서 활동이 정지</strong>되었습니다.
                </p>
                <div class="suspension-period">
                    정지 기간: <fmt:formatDate value="${suspensionStartDate}" pattern="yyyy.MM.dd"/> ~ 
                    <fmt:formatDate value="${suspensionEndDate}" pattern="yyyy.MM.dd"/>
                </div>
            </div>
        </c:if>

        <div class="post-container info-box">
            <div class="info-box-title">ℹ️ 안내사항</div>
            <div class="info-box-content">
                <ul>
                    <li>신고가 접수된 게시글은 수정 및 삭제가 불가능합니다.</li>
                    <li>관리자 검토 후 신고가 기각될 경우 게시글이 다시 공개됩니다.</li>
                    <li>신고가 정당하다고 판단될 경우 게시글이 삭제되거나 모임에서 탈퇴 처리될 수 있습니다.</li>
                    <li>문의사항이 있으시면 고객센터로 연락 주시기 바랍니다.</li>
                </ul>
            </div>
        </div>

        <div class="button-group">
            <a href="userposts.do" class="btn btn-primary">게시글 목록</a>
            <a href="inquirylist_kmj.do" class="btn btn-secondary">관리자 문의목록</a>
        </div>
    </div>

    <script>
        // 뒤로가기 처리 (브라우저 히스토리 관리를 위해)
        window.addEventListener('popstate', function() {
            history.back();
        });
    </script>
</body>
</html>