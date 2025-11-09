<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 가입 신청 완료</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .success-container {
            background: white;
            border-radius: 20px;
            padding: 60px 40px;
            max-width: 500px;
            width: 100%;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #8bc683 0%, #6ba562 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 50px;
            margin: 0 auto 30px;
            animation: scaleIn 0.5s ease-out 0.2s both;
            box-shadow: 0 4px 12px rgba(139, 198, 131, 0.3);
        }

        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }

        .success-title {
            font-size: 28px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 15px;
            animation: fadeIn 0.6s ease-out 0.4s both;
        }

        .success-message {
            font-size: 16px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 10px;
            animation: fadeIn 0.6s ease-out 0.5s both;
        }

        .group-name {
            font-size: 20px;
            font-weight: bold;
            color: #8bc683;
            margin: 20px 0;
            padding: 15px;
            background: #f0f8ef;
            border-radius: 12px;
            animation: fadeIn 0.6s ease-out 0.6s both;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .info-box {
            background: #fff8e1;
            border-left: 4px solid #ffc107;
            padding: 20px;
            border-radius: 8px;
            margin: 25px 0;
            text-align: left;
            animation: fadeIn 0.6s ease-out 0.7s both;
        }

        .info-box-title {
            font-size: 14px;
            font-weight: bold;
            color: #f57c00;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-box-content {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 35px;
            animation: fadeIn 0.6s ease-out 0.8s both;
        }

        .btn {
            flex: 1;
            padding: 15px 30px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #8bc683 0%, #6ba562 100%);
            color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .btn-secondary {
            background: white;
            color: #666;
            border: 2px solid #e0e0e0;
        }

        .btn-secondary:hover {
            background: #f5f5f5;
            border-color: #ccc;
        }

        .steps {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e0e0e0;
            animation: fadeIn 0.6s ease-out 0.9s both;
        }

        .steps-title {
            font-size: 14px;
            font-weight: bold;
            color: #666;
            margin-bottom: 15px;
        }

        .step-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
            text-align: left;
        }

        .step-number {
            width: 28px;
            height: 28px;
            background: #e8f5e9;
            color: #4caf50;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 13px;
            flex-shrink: 0;
        }

        .step-text {
            font-size: 14px;
            color: #666;
        }

        @media (max-width: 600px) {
            .success-container {
                padding: 40px 25px;
            }
            .success-title {
                font-size: 24px;
            }
            .button-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <!-- 성공/실패 아이콘 -->
        <c:choose>
            <c:when test="${success == true}">
                <div class="success-icon" style="background: linear-gradient(135deg, #8bc683 0%, #6ba562 100%);">✅</div>
                <h1 class="success-title">가입 신청 완료!</h1>
            </c:when>
            <c:otherwise>
                <div class="success-icon" style="background: linear-gradient(135deg, #f44336 0%, #d32f2f 100%);">❌</div>
                <h1 class="success-title" style="color: #d32f2f;">가입 신청 실패</h1>
            </c:otherwise>
        </c:choose>
        
        <!-- 메시지 출력 -->
        <p class="success-message">
            <c:choose>
                <c:when test="${not empty msg}">
                    ${msg}
                </c:when>
                <c:otherwise>
                    처리 결과를 확인할 수 없습니다.
                </c:otherwise>
            </c:choose>
        </p>
        
        <!-- 성공 시에만 안내 표시 -->
        <c:if test="${success == true}">
            <div class="info-box">
                <div class="info-box-title">
                    <span>⏰</span>
                    <span>다음 단계 안내</span>
                </div>
                <div class="info-box-content">
                    모임장의 승인 후 모임에 참여하실 수 있습니다.<br>
                    승인 결과는 알림으로 전송되며, 마이페이지에서 확인하실 수 있습니다.
                </div>
            </div>

            <div class="steps">
                <div class="steps-title">진행 단계</div>
                <div class="step-item">
                    <div class="step-number">1</div>
                    <div class="step-text">가입 신청 제출 완료 ✓</div>
                </div>
                <div class="step-item">
                    <div class="step-number">2</div>
                    <div class="step-text">모임장 검토 중...</div>
                </div>
                <div class="step-item">
                    <div class="step-number">3</div>
                    <div class="step-text">승인 시 모임 활동 시작</div>
                </div>
            </div>
        </c:if>

        <!-- 버튼 -->
        <div class="button-group">
            <button class="btn btn-primary" onclick="location.href='grouplist.do'">
                모임 리스트 보기
            </button>
            <button class="btn btn-secondary" onclick="location.href='mainpage.do'">
                메인으로
            </button>
        </div>
    </div>
    
    <!-- 디버깅용 콘솔 로그 -->
    <script>
        console.log('msg:', '${msg}');
        console.log('success:', '${success}');
    </script>
</body>
</html>