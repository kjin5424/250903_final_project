<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>열람 불가 게시글</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/variables.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/components.css">
    
    <style>
        :root {
            --primary: #C8D456;
            --secondary: #C4BFF5;
            --accent: #E25668;
            --text-primary: #1A1A1A;
            --text-secondary: #666666;
            --white: #FFFFFF;
            --off-white: #F8F9FA;
            --gray-light: #E0E0E0;
            --warning-bg: #FFF3E0;
            --warning-border: #FF9800;<div class="button-group">
            --error-bg: #FFEBEE;
            --error-border: #E25668;
            --shadow-md: 0 4px 8px rgba(0,0,0,0.12);
            --radius-lg: 12px;
            --radius-md: 8px;
            --padding-lg: 16px;
            --padding-xl: 24px;
            --padding-xxl: 32px;
            --margin-md: 12px;
            --margin-lg: 16px;
            --margin-xl: 24px;
            --font-size-sm: 14px;
            --font-size-base: 16px;
            --font-size-lg: 18px;
            --font-size-h3: 24px;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Malgun Gothic', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background-color: var(--off-white);
            color: var(--text-primary);
            line-height: 1.6;
            padding: var(--padding-xl);
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        /* 블라인드 처리 알림 박스 */
        .blind-notice {
            background: var(--error-bg);
            border: 2px solid var(--error-border);
            border-radius: var(--radius-lg);
            padding: var(--padding-xxl);
            margin-bottom: var(--margin-xl);
            box-shadow: var(--shadow-md);
            text-align: center;
        }
        
        .blind-icon {
            font-size: 64px;
            margin-bottom: var(--margin-lg);
            opacity: 0.8;
        }
        
        .blind-title {
            font-size: var(--font-size-h3);
            font-weight: 700;
            color: var(--accent);
            margin-bottom: var(--margin-md);
        }
        
        .blind-description {
            font-size: var(--font-size-base);
            color: var(--text-secondary);
            line-height: 1.8;
            margin-bottom: var(--margin-lg);
        }
        
        .blind-reason {
            display: inline-block;
            background: var(--white);
            border: 2px solid var(--error-border);
            border-radius: var(--radius-md);
            padding: var(--padding-lg);
            font-size: var(--font-size-lg);
            font-weight: 600;
            color: var(--accent);
            margin-top: var(--margin-md);
        }
        
        /* 게시글 정보 박스 */
        .post-info-box {
            background: var(--white);
            border-radius: var(--radius-lg);
            padding: var(--padding-xl);
            margin-bottom: var(--margin-xl);
            box-shadow: var(--shadow-md);
        }
        
        .post-info-title {
            font-size: var(--font-size-lg);
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: var(--margin-lg);
            padding-bottom: var(--padding-lg);
            border-bottom: 2px solid var(--gray-light);
        }
        
        .post-info-item {
            display: flex;
            padding: var(--padding-lg);
            background: var(--off-white);
            border-radius: var(--radius-md);
            margin-bottom: var(--margin-md);
        }
        
        .post-info-item:last-child {
            margin-bottom: 0;
        }
        
        .post-info-label {
            min-width: 120px;
            font-size: var(--font-size-base);
            font-weight: 600;
            color: var(--text-secondary);
        }
        
        .post-info-value {
            flex: 1;
            font-size: var(--font-size-base);
            color: var(--text-primary);
            font-weight: 500;
        }
        
        .post-info-value.highlight {
            color: var(--accent);
            font-weight: 700;
        }
        
        /* 신고 카테고리 뱃지 */
        .report-category-badge {
            display: inline-block;
            padding: 6px 16px;
            background: var(--error-bg);
            border: 1px solid var(--error-border);
            border-radius: 20px;
            font-size: var(--font-size-sm);
            font-weight: 600;
            color: var(--accent);
            margin-right: 8px;
        }
        
        /* 안내 메시지 박스 */
        .info-box {
            background: var(--warning-bg);
            border-left: 4px solid var(--warning-border);
            border-radius: var(--radius-md);
            padding: var(--padding-lg);
            margin-bottom: var(--margin-xl);
        }
        
        .info-box-title {
            font-size: var(--font-size-base);
            font-weight: 700;
            color: #F57C00;
            margin-bottom: var(--margin-md);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .info-box-content {
            font-size: var(--font-size-sm);
            color: var(--text-secondary);
            line-height: 1.8;
        }
        
        .info-box-content ul {
            margin-left: 20px;
            margin-top: 8px;
        }
        
        .info-box-content li {
            margin-bottom: 6px;
        }
        
        /* 버튼 그룹 */
        .button-group {
            display: flex;
            gap: 12px;
            justify-content: center;
            margin-top: var(--margin-xl);
        }
        
        .btn {
            padding: 12px 32px;
            border: none;
            border-radius: var(--radius-md);
            font-size: var(--font-size-base);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-primary {
            background: var(--secondary);
            color: var(--white);
        }
        
        .btn-primary:hover {
            background: #A8A3E0;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(196, 191, 245, 0.4);
        }
        
        .btn-secondary {
            background: var(--gray-light);
            color: var(--text-primary);
        }
        
        .btn-secondary:hover {
            background: #BDBDBD;
        }
        
        /* 활동 정지 경고 (추가 경고가 필요한 경우) */
        .suspension-warning {
            background: linear-gradient(135deg, #FFEBEE 0%, #FFCDD2 100%);
            border: 2px solid var(--accent);
            border-radius: var(--radius-lg);
            padding: var(--padding-xl);
            margin-bottom: var(--margin-xl);
            text-align: center;
        }
        
        .suspension-icon {
            font-size: 48px;
            margin-bottom: var(--margin-md);
        }
        
        .suspension-title {
            font-size: var(--font-size-lg);
            font-weight: 700;
            color: var(--accent);
            margin-bottom: var(--margin-md);
        }
        
        .suspension-description {
            font-size: var(--font-size-base);
            color: var(--text-secondary);
            line-height: 1.8;
        }
        
        .suspension-period {
            display: inline-block;
            background: var(--white);
            padding: 8px 20px;
            border-radius: var(--radius-md);
            font-weight: 700;
            color: var(--accent);
            margin-top: var(--margin-md);
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            body {
                padding: var(--padding-lg);
            }
            
            .blind-icon {
                font-size: 48px;
            }
            
            .blind-title {
                font-size: 20px;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
            
            .post-info-item {
                flex-direction: column;
            }
            
            .post-info-label {
                margin-bottom: 6px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 블라인드 처리 알림 -->
        <div class="blind-notice">
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
        
        <!-- 게시글 정보 -->
        <div class="post-info-box">
            <h2 class="post-info-title">📋 게시글 정보</h2>
            
            <div class="post-info-item">
                <span class="post-info-label">게시글 제목</span>
                <span class="post-info-value highlight">${post.title}</span>
            </div>
            
            <div class="post-info-item">
                <span class="post-info-label">작성일자</span>
                <span class="post-info-value">
                    <fmt:formatDate value="${post.createdDate}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                </span>
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
        
        <!-- 활동 정지 경고 (조건부 표시) -->
        <c:if test="${showSuspensionWarning}">
            <div class="suspension-warning">
                <div class="suspension-icon">⚠️</div>
                <h3 class="suspension-title">활동 정지 경고</h3>
                <p class="suspension-description">
                    최근 1개월 이내 블라인드 처리된 게시글이 ${blindPostCount}개입니다.<br>
                    블라인드 게시글이 3개 이상이 되면<br>
                    <strong>2주간 모든 모임에서 활동이 정지</strong>됩니다.
                </p>
                <div class="suspension-period">
                    현재 ${blindPostCount}/3개 (${3 - blindPostCount}개 남음)
                </div>
            </div>
        </c:if>
        
        <!-- 활동 정지 안내 (이미 정지된 경우) -->
        <c:if test="${isSuspended}">
            <div class="suspension-warning">
                <div class="suspension-icon">🔒</div>
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
            
            <!-- 블라인드 처리된 게시글 목록 -->
            <div class="post-info-box">
                <h2 class="post-info-title">🚫 블라인드 처리된 게시글 목록</h2>
                <c:forEach items="${blindPosts}" var="blindPost" varStatus="status">
                    <div class="post-info-item">
                        <span class="post-info-label">${status.index + 1}번째 게시글</span>
                        <span class="post-info-value">
                            ${blindPost.title}
                            (<fmt:formatDate value="${blindPost.createdDate}" pattern="yyyy.MM.dd"/>)
                        </span>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <!-- 안내 메시지 -->
        <div class="info-box">
            <div class="info-box-title">
                <span>ℹ️</span>
                <span>안내사항</span>
            </div>
            <div class="info-box-content">
                <ul>
                    <li>신고가 접수된 게시글은 수정 및 삭제가 불가능합니다.</li>
                    <li>관리자 검토 후 신고가 기각될 경우 게시글이 다시 공개됩니다.</li>
                    <li>신고가 정당하다고 판단될 경우 게시글이 삭제되거나 모임에서 탈퇴 처리될 수 있습니다.</li>
                    <li>문의사항이 있으시면 고객센터로 연락 주시기 바랍니다.</li>
                </ul>
            </div>
        </div>
        
        <!-- 버튼 그룹 -->
        <div class="button-group">
            <a href="userposts.do" class="btn btn-primary">
                게시판으로 돌아가기
            </a>
            <a href="${pageContext.request.contextPath}/support/contact" class="btn btn-secondary">
                고객센터 문의
            </a>
        </div>
    </div>
    
    <script>
        // 뒤로가기 처리
        window.addEventListener('popstate', function(event) {
            history.back();
        });
    </script>
</body>
</html>