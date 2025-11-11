<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>알림</title>
    <style>
        :root {
            --color-primary: #4f46e5;
            --color-primary-dark: #3730a3;
            --color-secondary: #f59e0b;
            --color-base: #f9fafb;
            --color-white: #ffffff;
            --color-text-primary: #111827;
            --color-text-secondary: #6b7280;
            --radius-lg: 12px;
            --spacing-md: 12px;
            --spacing-lg: 20px;
            --spacing-xl: 32px;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: var(--color-base);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .message-container {
            background-color: var(--color-white);
            padding: var(--spacing-xl);
            border-radius: var(--radius-lg);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 400px;
            width: 90%;
        }

        .message-container p {
            font-size: 16px;
            color: var(--color-text-primary);
            margin-bottom: var(--spacing-lg);
            line-height: 1.6;
        }

        .message-container a {
            display: inline-block;
            padding: 10px 20px;
            background-color: var(--color-primary);
            color: var(--color-white);
            font-weight: 700;
            border-radius: var(--radius-lg);
            text-decoration: none;
            transition: background-color 0.2s ease;
        }

        .message-container a:hover {
            background-color: var(--color-primary-dark);
        }
    </style>

    <c:if test="${not empty url}">
        <script>
            setTimeout(function() {
                location.href = '${url}'; 	
            }, 2000);
        </script>
    </c:if>
</head>
<body>
    <div class="message-container">
        <p>${msg}</p>
        <c:if test="${not empty url}">
            <a href="${url}">확인</a>
        </c:if>
    </div>
</body>
</html>
