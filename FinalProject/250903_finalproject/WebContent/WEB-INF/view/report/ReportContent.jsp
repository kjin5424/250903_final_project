<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath(); 
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들 - 신고하기</title>
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

.report-type-option input[type="radio"]:checked+.report-type-label {
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

@media ( max-width : 768px) {
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
function validateForm() {
    const reportType = document.querySelector('input[name="reportContentType"]:checked');
    if(!reportType) {
        alert('신고 유형을 선택해주세요.');
        return false;
    }
    return confirm('신고를 제출하시겠습니까?\n허위 신고는 제재 대상이 될 수 있습니다.');
}

function cancelReport() {
    if(confirm('신고를 취소하시겠습니까?')) {
    	window.location.href = "<%= cp %>/reportcontent.do";
    }
}
</script>
</head>
<body>

	<!-- 상단바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

<div class="container">
    <div class="page-header">
        <div class="header-top">
            <div class="page-title"><span>🚨</span> <span>컨텐츠 신고</span></div>
        </div>
        <div class="header-description">
            부적절한 게시글이나 사용자를 신고할 수 있습니다.<br> 신고 내용은 관리자가 검토하여 조치합니다.
        </div>
    </div>

    <!--     <form class="report-form" onsubmit="return validateForm()" method="post" action="reportcontent.do"> -->      
<form method="post" action="<%= cp %>/reportcontent.do" name="reportForm" onsubmit="return validateForm()"> 
    <input type="hidden" name="postCode" value="195"> 
    <input type="hidden" name="joinCode" value="270">
          
		
        <div class="warning-box">
            <div class="warning-title"><span>⚠️</span> 신고 전 확인해주세요</div>
            <div class="warning-content">
                <ul>
                    <li>허위 신고 또는 악의적인 신고는 제재 대상이 될 수 있습니다.</li>
                    <li>신고 내용은 관리자만 확인하며, 신고자 정보는 보호됩니다.</li>
                    <li>신고 처리 결과는 알림을 통해 안내됩니다.</li>
                    <li>긴급한 문제는 고객센터로 문의해주세요.</li>
                </ul>
            </div>
        </div>

        <!-- 신고 대상 정보 -->
        <div class="form-section">
            <label class="form-label">신고 대상 정보</label>
            <div class="target-info">
                <div class="target-item"><span class="target-label">대상 유형:</span> <span class="target-value">게시글</span></div>
                <div class="target-item"><span class="target-label">작성자:</span> <span class="target-value">알고리즘초보</span></div>
                <div class="target-item"><span class="target-label">제목:</span> <span class="target-value">DB 문제 접근 방법 질문드립니다</span></div>
                <div class="target-item"><span class="target-label">작성일:</span> <span class="target-value">2025.11.09 14:30</span></div>
            </div>
        </div>

        <!-- 신고 유형 선택 -->
        <div class="form-section">
            <label class="form-label">신고 유형 <span class="required">*</span></label>
            <div class="form-description">해당하는 신고 유형을 선택해주세요.</div>
            <div class="report-type-grid">
                <div class="report-type-option">
                    <input type="radio" id="type1" name="reportContentType" value="1">
                    <label class="report-type-label" for="type1">음란성/선정적 내용</label>
                </div>
                <div class="report-type-option">
                    <input type="radio" id="type2" name="reportContentType" value="2">
                    <label class="report-type-label" for="type2">폭력/유해한 내용</label>
                </div>
                <div class="report-type-option">
                    <input type="radio" id="type3" name="reportContentType" value="3">
                    <label class="report-type-label" for="type3">광고/홍보/스팸</label>
                </div>
                <div class="report-type-option">
                    <input type="radio" id="type4" name="reportContentType" value="4">
                    <label class="report-type-label" for="type4">거짓정보/허위사실 유포</label>
                </div>
                <div class="report-type-option">
                    <input type="radio" id="type5" name="reportContentType" value="5">
                    <label class="report-type-label" for="type5">타인 비방/명예 훼손</label>
                </div>
                <div class="report-type-option">
                    <input type="radio" id="type6" name="reportContentType" value="6">
                    <label class="report-type-label" for="type6">저작권 침해</label>
                </div>
                <div class="report-type-option">
                    <input type="radio" id="type7" name="reportContentType" value="7">
                    <label class="report-type-label" for="type7">개인정보 노출</label>
                </div>
                <div class="report-type-option">
                    <input type="radio" id="type8" name="reportContentType" value="8">
                    <label class="report-type-label" for="type8">부적절한 닉네임/프로필 사진</label>
                </div>
            </div>
        </div>



        <div class="button-group">
            <button type="button" class="btn-cancel" onclick="cancelReport()">취소</button>
            <button type="submit" class="btn-submit">신고 제출</button>
        </div>
    </form>
</div>
</body>
</html>