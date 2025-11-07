<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html> 
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 문의/답변 이력</title>
    <style>
        /* ================================================
           마이페이지 스타일
        ================================================ */
        :root {
            --max-width: 1200px;
            --spacing-xs: 4px;
            --spacing-sm: 8px;
            --spacing-md: 16px;
            --spacing-lg: 24px;
            --spacing-xl: 32px;
            --spacing-2xl: 48px;

            --radius-sm: 4px;
            --radius-md: 8px;
            --radius-lg: 16px;
            --radius-full: 9999px;

            --color-white: #fff;
            --color-base: #f9f9f9;
            --color-border-light: #e0e0e0;
            --color-primary: #4f46e5;
            --color-primary-dark: #3730a3;
            --color-primary-lighter: #c7d2fe;
            --color-accent: #f43f5e;
            --color-text-primary: #111827;
            --color-text-secondary: #6b7280;
            --color-text-tertiary: #9ca3af;

            --shadow-sm: 0 1px 3px rgba(0,0,0,0.1);
            --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
            --transition-base: 0.3s;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: var(--color-base);
            margin: 0;
            padding: var(--spacing-2xl) 0;
            color: var(--color-text-primary);
        }

        .container {
            max-width: var(--max-width);
            margin: 0 auto;
            padding: 0 var(--spacing-lg);
            display: grid;
            grid-template-columns: 1fr;
            gap: var(--spacing-xl);
        }

        .header {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: var(--spacing-xl);
            text-align: center;
        }

        .section {
            background: var(--color-white);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: var(--spacing-xl);
        }

        .section-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: var(--spacing-lg);
            color: var(--color-primary-dark);
            border-bottom: 2px solid var(--color-primary-lighter);
            padding-bottom: var(--spacing-sm);
        }

        .inquiry-info,
        .answer-list {
            display: flex;
            flex-direction: column;
            gap: var(--spacing-md);
        }

        .info-item {
            display: flex;
            gap: var(--spacing-md);
            font-size: 15px;
        }

        .info-label {
            font-weight: 600;
            width: 100px;
            color: var(--color-text-secondary);
        }

        .info-value,
        .inquiry-type,
        .answer-count {
            font-weight: 500;
            color: var(--color-text-primary);
        }

        .status-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: var(--radius-full);
            font-size: 12px;
            font-weight: 600;
            color: white;
        }

        .status-answered {
            background: var(--color-accent);
        }

        .inquiry-content {
            background: var(--color-base);
            padding: var(--spacing-md);
            border-radius: var(--radius-md);
            font-size: 15px;
            line-height: 1.6;
            white-space: pre-wrap;
        }

        /* 답변 리스트 */
        .answer-item {
            background: var(--color-base);
            border-radius: var(--radius-md);
            padding: var(--spacing-md);
            margin-bottom: var(--spacing-md);
        }

        .answer-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: var(--spacing-sm);
            font-size: 14px;
            font-weight: 600;
            color: var(--color-text-secondary);
        }

        .answer-content {
            font-size: 15px;
            line-height: 1.6;
            color: var(--color-text-primary);
            white-space: pre-wrap;
        }

        .btn-back {
            display: inline-block;
            margin-top: var(--spacing-md);
            padding: 10px 24px;
            background: var(--color-border-light);
            color: var(--color-text-primary);
            border-radius: var(--radius-md);
            font-weight: 600;
            text-decoration: none;
        }

        .btn-back:hover {
            background: var(--color-text-secondary);
            color: white;
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 var(--spacing-md);
            }

            .section-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="header">문의 내역</div>
    <div class="container">

        <!-- 회원 문의 이력 -->
        <div class="section">
            <div class="section-title">문의 내역</div>
            <div class="inquiry-info">
                <div class="info-item">
                    <span class="info-label">문의번호:</span>
                    <span class="info-value">${inquiry.inquiryCode}</span>
                </div>

               <div class="info-item">
                    <span class="info-label">접수 일자:</span>
                    <span class="info-value">
                        <fmt:formatDate value="${inquiry.createdDate}" pattern="yyyy-MM-dd" />
                    </span>
                </div>

                <div class="info-item">
                    <span class="info-label">답변 상태:</span>
                    <span class="status-badge status-answered">답변완료</span>
                </div>
            </div>

            <div class="form-group">
                <div class="form-label">문의 제목</div>
                <div class="inquiry-content">${inquiry.title}</div>
            </div>

            <div class="form-group">
                <div class="form-label">문의 내용</div>
                <div class="inquiry-content">${inquiry.content}</div>
            </div>
        </div>

        <!-- 관리자 답변 이력 -->
        <div class="section">
            <div class="section-title">답변 내역</div>

            <div class="answer-list">
                <c:forEach var="ans" items="${inquiry.answers}">
                    <div class="answer-item">
                        <div class="answer-header">
                            <span class="answer-author">관리자 (${ans.adminId})</span>
                           <span class="answer-date">
                                <fmt:formatDate value="${ans.answerDate}" pattern="yyyy-MM-dd" />
                            </span>
                        </div>
                        <div class="answer-content">${ans.answerContent}</div>
                    </div>
                </c:forEach>
            </div>
        </div>

       <a href="<%= cp %>/profilemodify.do?tab=inquiry" class="btn-back">목록으로</a>

    </div>
</body>
</html>
