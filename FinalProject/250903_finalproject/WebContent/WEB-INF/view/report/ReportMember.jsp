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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임원 신고</title>
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
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* 페이지 헤더 */
        .page-header {
            background: linear-gradient(135deg, #d32f2f 0%, #f44336 100%);
            color: white;
            padding: 40px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(211, 47, 47, 0.3);
        }
        .header-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
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
            color: #d32f2f;
        }
        .header-description {
            margin-top: 15px;
            font-size: 14px;
            opacity: 0.9;
            line-height: 1.6;
        }
        .group-name {
            font-size: 16px;
            opacity: 0.85;
            margin-top: 8px;
        }

        /* 신고 폼 */
        .report-form {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        .form-section {
            margin-bottom: 25px;
        }
        .form-label {
            display: block;
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }
        .form-label .required {
            color: #f44336;
            margin-left: 3px;
        }
        .form-description {
            font-size: 13px;
            color: #666;
            margin-bottom: 10px;
            line-height: 1.5;
        }

        /* 신고 대상 정보 */
        .target-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 2px solid #e0e0e0;
        }
        .member-profile {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 15px;
        }
        .member-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #8bc683 0%, #6ba562 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }
        .member-info {
            flex: 1;
        }
        .member-name {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        .member-role {
            display: inline-block;
            background: #e3f2fd;
            color: #1976d2;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .target-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .target-item:last-child {
            margin-bottom: 0;
        }
        .target-label {
            color: #666;
            font-weight: 600;
        }
        .target-value {
            color: #333;
        }

        /* 신고 유형 선택 */
        .report-type-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
        }
        .report-type-option {
            position: relative;
        }
        .report-type-option input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }
        .report-type-label {
            display: block;
            padding: 15px 20px;
            background: #f8f9fa;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
            font-weight: 600;
            font-size: 14px;
            color: #666;
        }
        .report-type-option input[type="radio"]:checked + .report-type-label {
            background: #ffebee;
            border-color: #f44336;
            color: #d32f2f;
        }
        .report-type-label:hover {
            border-color: #f44336;
        }

        /* 텍스트 입력 */
        textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            resize: vertical;
            transition: all 0.3s;
        }
        textarea:focus {
            outline: none;
            border-color: #f44336;
        }
        .char-count {
            text-align: right;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }

        /* 경고 박스 */
        .warning-box {
            background: #fff3e0;
            border: 2px solid #ffb74d;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
        }
        .warning-title {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            color: #f57c00;
            margin-bottom: 10px;
            font-size: 15px;
        }
        .warning-content {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
        }
        .warning-content ul {
            margin-left: 20px;
            margin-top: 8px;
        }
        .warning-content li {
            margin-bottom: 5px;
        }

        /* 정보 박스 */
        .info-box {
            background: #e3f2fd;
            border: 2px solid #90caf9;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 25px;
        }
        .info-content {
            font-size: 13px;
            color: #1565c0;
            line-height: 1.6;
        }

        /* 버튼 */
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .btn-submit {
            flex: 1;
            padding: 15px;
            background: #f44336;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-submit:hover {
            background: #d32f2f;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }
        .btn-cancel {
            flex: 1;
            padding: 15px;
            background: white;
            color: #666;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-cancel:hover {
            border-color: #999;
            color: #333;
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 25px 20px;
            }
            .page-title {
                font-size: 24px;
            }
            .report-form {
                padding: 20px;
            }
            .report-type-grid {
                grid-template-columns: 1fr;
            }
            .button-group {
                flex-direction: column;
            }
        }
    </style>
    <script>
        function updateCharCount() {
            const textarea = document.getElementById('reportContent');
            const charCount = document.getElementById('charCount');
            const currentLength = textarea.value.length;
            charCount.textContent = currentLength + ' / 1000';
            
            if (currentLength > 1000) {
                charCount.style.color = '#f44336';
            } else {
                charCount.style.color = '#999';
            }
        }

        function validateForm() {
        	console.log('validateForm 호출됨');
        	
        	const reportType = document.querySelector('input[name="reportMemberType"]:checked');
        	
         	console.log('선택된 신고유형:', reportType);
         	
        	const reportContent = document.getElementById('reportContent').value.trim();
        	
        	console.log('신고내용:', reportContent);

            if (!reportType) {
                alert('신고 유형을 선택해주세요.');
                return false;
            }

            if (!reportContent) {
                alert('신고 사유를 입력해주세요.');
                document.getElementById('reportContent').focus();
                return false;
            }

            if (reportContent.length < 5) {
                alert('신고 사유를 20자 이상 구체적으로 입력해주세요.');
                document.getElementById('reportContent').focus();
                return false;
            }

            if (reportContent.length > 1000) {
                alert('신고 사유는 1000자를 초과할 수 없습니다.');
                document.getElementById('reportContent').focus();
                return false;
            }

            if (confirm('이 모임원을 신고하시겠습니까?\n\n신고 내용은 모임장에게 전달되며, 허위 신고는 제재 대상이 될 수 있습니다.')) {
                return true;
            }
            return false;
        }

    	function cancelMember() {
    	    if(confirm('신고를 취소하시겠습니까?')) {
    	    	window.location.href = "<%= cp %>/reportmember.do";
    	    }
        }
    </script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab">
                <span>로고 들어갈 자리</span>
            </div>
        </div>
    </nav>

    <div class="container">
        <!-- 페이지 헤더 -->
        <div class="page-header">
            <div class="header-top">
                <div>
                    <div class="page-title">
                        <span>🚨</span>
                        <span>모임원 신고</span>
                    </div>
                    <div class="group-name">📚 알고리즘 정복 스터디</div>
                </div>
                <!-- <button class="btn-back" onclick="history.back()">← 뒤로 가기</button> -->
            </div>
            <div class="header-description">
                부적절한 행동을 하는 모임원을 신고할 수 있습니다.<br>
                신고 내용은 모임장이 검토하여 조치합니다.
            </div>
        </div>
        
        

        <!-- 신고 폼 -->
<%-- <form class="report-form" method="post" action="<%= cp %>/reportmember.do" onsubmit="return validateForm()"> --%>

<form class="report-form" method="POST" action="<%=cp%>/reportmember.do" onsubmit="return validateForm()">
        
       <%--  <form method="post" action="<%= cp %>/reportmember.do" name="reportForm" onsubmit="return validateForm()">  --%>
        
        
            <!-- 정보 박스 -->
            <div class="info-box">
                <div class="info-content">
                    💡 모임원 신고는 모임장에게 전달됩니다. 모임장이 검토 후 경고, 권한 조정, 강제 퇴장 등의 조치를 취할 수 있습니다.
                </div>
            </div>

            <!-- 경고 -->
            <div class="warning-box">
                <div class="warning-title">
                    <span>⚠️</span>
                    <span>신고 전 확인해주세요</span>
                </div>
                <div class="warning-content">
                    <ul>
                        <li>허위 신고 또는 악의적인 신고는 제재 대상이 될 수 있습니다.</li>
                        <li>신고 내용은 모임장에게만 공개되며, 신고자 정보는 보호됩니다.</li>
                        <li>가능한 구체적인 증거와 함께 신고 사유를 작성해주세요.</li>
                        <li>단순 의견 차이나 감정적 갈등은 대화로 해결을 권장합니다.</li>
                    </ul>
                </div>
            </div>

            <!-- 신고 대상 정보 -->
            <div class="form-section">
                <label class="form-label">신고 대상 모임원</label>
                <div class="target-info">
                    <div class="member-profile">
                        <div class="member-avatar">👤</div>
                        <div class="member-info">
                            <div class="member-name">알고리즘초보</div>
                            <span class="member-role">일반 모임원</span>
                        </div>
                    </div>
                    <div class="target-item">
                        <span class="target-label">가입일:</span>
                        <span class="target-value">2025-11-09</span>
                    </div>
                    <div class="target-item">
                        <span class="target-label">출석률:</span>
                        <span class="target-value">85% (11/13회)</span>
                    </div>
                    <div class="target-item">
                        <span class="target-label">작성 게시글:</span>
                        <span class="target-value">23개</span>
                    </div>
                </div>
            </div>

            <!-- 신고 유형 선택 -->
            <div class="form-section">
                <label class="form-label">
                    신고 유형 <span class="required">*</span>
                </label>
                <div class="form-description">
                    해당하는 신고 유형을 선택해주세요.
                </div>
                <div class="report-type-grid">
                    <div class="report-type-option">
                       <!--  <input type="radio" id="type1" name="reportType" value="abuse"> -->
                       <input type="radio" id="type1" name="reportMemberType" value="1">
                        <label class="report-type-label" for="type1">폭력적 언어/행위(따돌림 포함)</label>
                    </div>
                    <div class="report-type-option">
                        <!-- <input type="radio" id="type2" name="reportType" value="harassment"> -->
                        <input type="radio" id="type2" name="reportMemberType" value="2">
                        <label class="report-type-label" for="type2">성희롱/불쾌한 언행</label>
                    </div>
                    <div class="report-type-option">
                   <!--      <input type="radio" id="type3" name="reportType" value="spam"> -->
                        <input type="radio" id="type3" name="reportMemberType" value="3">
                        <label class="report-type-label" for="type3">도용/사칭</label>
                    </div>
                    <div class="report-type-option">
                       <!--  <input type="radio" id="type4" name="reportType" value="inappropriate"> -->
                         <input type="radio" id="type4" name="reportMemberType" value="4">
                        <label class="report-type-label" for="type4">불법활동 및 강요(마약/도박)</label>
                    </div>
                    <div class="report-type-option">
                      <!--   <input type="radio" id="type5" name="reportType" value="violation"> -->
                        <input type="radio" id="type5" name="reportMemberType" value="5">
                        <label class="report-type-label" for="type5">금전적/비금전적 사기 행위</label>
                    </div>
                    <div class="report-type-option">
                        <!-- <input type="radio" id="type6" name="reportType" value="absence"> -->
                         <input type="radio" id="type6" name="reportMemberType" value="6">
                        <label class="report-type-label" for="type6">모임원 의견을 무시한 모임운영</label>
                    </div>
              
                    <div class="report-type-option">
                       <!--  <input type="radio" id="type8" name="reportType" value="etc"> -->
                        <input type="radio" id="type8" name="reportMemberType" value="8">
                        <label class="report-type-label" for="type8">기타</label>
                    </div>
                </div>
            </div>

            <!-- 신고 사유 입력 -->
            <div class="form-section">
                <label class="form-label" for="reportContent">
                    신고 사유 <span class="required">*</span>
                </label>
                <div class="form-description">
                    신고 사유를 구체적으로 작성해주세요. 가능하면 날짜, 상황, 증거 등을 포함해주세요. (최소 5자, 최대 1000자)
                </div>
                <textarea id="reportContent" name="content"
                    rows="10" 
                    placeholder="신고 사유를 상세히 작성해주세요.&#10;&#10;예시:&#10;- 언제: 2025년 11월 09일 모임 중&#10;- 어떤 상황: 다른 모임원에게 지속적으로 욕설을 사용&#10;- 구체적 내용: '○○○' 등의 욕설을 반복적으로 사용하며 다른 모임원을 비하함&#10;- 증거: 해당 게시글/댓글 링크 또는 스크린샷&#10;&#10;※ 가능한 객관적 사실을 중심으로 작성해주세요."
                    oninput="updateCharCount()"
                    maxlength="1000"></textarea>
                <div class="char-count" id="charCount">0 / 1000</div>
            </div>

            <!-- 버튼 -->
            <div class="button-group">
            	<input type="hidden" name="reporterCode" value="249">
				<input type="hidden" name="reporteeCode" value="250">
         
                <button type="button" class="btn-cancel" onclick="cancelMember()">취소</button>
        				<button type="submit" class="btn-submit">신고 제출</button> 

            </div>
        </form>
    </div>
</body>
</html>