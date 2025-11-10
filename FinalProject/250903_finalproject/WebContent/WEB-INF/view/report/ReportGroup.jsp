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
<title>공모자들 - 모임 신고</title>
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

/* 신고 대상 모임 정보 */
.target-info {
	background: #f8f9fa;
	padding: 20px;
	border-radius: 8px;
	border: 2px solid #e0e0e0;
}

.group-header-section {
	display: flex;
	align-items: center;
	gap: 15px;
	margin-bottom: 15px;
	padding-bottom: 15px;
	border-bottom: 1px solid #e0e0e0;
}

.group-image {
	width: 80px;
	height: 80px;
	border-radius: 12px;
	background: linear-gradient(135deg, #8bc683 0%, #6ba562 100%);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 40px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.group-info {
	flex: 1;
}

.group-name {
	font-size: 20px;
	font-weight: 600;
	color: #333;
	margin-bottom: 8px;
}

.group-meta {
	display: flex;
	gap: 10px;
	flex-wrap: wrap;
}

.meta-badge {
	display: inline-block;
	background: #e3f2fd;
	color: #1976d2;
	padding: 4px 10px;
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
	.group-header-section {
		flex-direction: column;
		align-items: flex-start;
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
		const reportType = document
				.querySelector('input[name="reportType"]:checked');
		e

		if (!reportType) {
			alert('신고 유형을 선택해주세요.');
			return false;
		}

		if (confirm('이 모임을 신고하시겠습니까?\n\n신고 내용은 관리자가 검토하며, 허위 신고는 제재 대상이 될 수 있습니다.')) {
			return true;
		}
		return false;
	}

	function cancelGroup() {
	    if(confirm('신고를 취소하시겠습니까?')) {
	    	window.location.href = "<%= cp %>/reportgroup.do";
	    }
	}
</script>
</head>
<body>

	<!-- 상단바 -->
	<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

	<div class="container">
		<!-- 페이지 헤더 -->
		<div class="page-header">
			<div class="header-top">
				<div class="page-title">
					<span>🚨</span> <span>모임 신고</span>
				</div>
				<!-- <button class="btn-back" onclick="history.back()">← 뒤로 가기</button> -->
			</div>
			<div class="header-description">
				부적절하거나 규정을 위반하는 모임을 신고할 수 있습니다.<br> 신고 내용은 관리자가 검토하여 조치합니다.
			</div>
		</div>

		<!-- 신고 폼 -->
<!-- 		 <form class="report-form" method="post" action="reportgroup.do" onsubmit="return validateForm()"> -->

		<form class="report-form" onsubmit="return validateForm()" method="post">

	<!-- 		<form id="report-form" action="reportgroup.do" method="post" onsubmit="return validateForm()"> -->
	
				<!-- 로그인 없이 임의 사용자 고정 -->
			<input type="hidden" name="userCode" value="UC00000033">
			
			<!-- 신고 대상 모임 (예: 그룹신청코드) -->
			<input type="hidden" name="groupApplyCode" value="12">

			<!-- 정보 박스 -->
			<div class="info-box">
				<div class="info-content">💡 모임 신고는 플랫폼 관리자가 검토합니다. 심각한 위반 사항이
					확인되면 모임 폐쇄, 모임장 제재 등의 조치가 이루어질 수 있습니다.</div>
			</div>

			<!-- 경고 -->
			<div class="warning-box">
				<div class="warning-title">
					<span>⚠️</span> <span>신고 전 확인해주세요</span>
				</div>
				<div class="warning-content">
					<ul>
						<li>허위 신고 또는 악의적인 신고는 귀하의 계정이 제재될 수 있습니다.</li>
						<li>모임 내부 갈등이나 의견 차이는 모임장과 먼저 대화로 해결을 권장합니다.</li>
						<li>신고는 심각한 규정 위반이나 불법 행위에 대해서만 사용해주세요.</li>
						<li>신고 내용은 관리자만 확인하며, 신고자 정보는 보호됩니다.</li>
					</ul>
				</div>
			</div>

			<!-- 신고 대상 모임 정보 -->
			<div class="form-section">
				<label class="form-label">신고 대상 모임</label>
				<div class="target-info">
					<div class="group-header-section">
						<div class="group-image">📚</div>
						<div class="group-info">
							<div class="group-name">알고리즘 정복 스터디</div>
							<div class="group-meta">
								<span class="meta-badge">IT</span> <span class="meta-badge">Lv.3</span>
								<span class="meta-badge">온라인/오프라인</span>
							</div>
						</div>
					</div>
					<div class="target-item">
						<span class="target-label">모임장:</span> <span class="target-value">모임장넘버원</span>
					</div>
					<div class="target-item">
						<span class="target-label">개설일:</span> <span class="target-value">2025.11.12</span>
					</div>
					<div class="target-item">
						<span class="target-label">현재 인원:</span> <span
							class="target-value">7/10명</span>
					</div>
					<div class="target-item">
						<span class="target-label">모임 활동:</span> <span
							class="target-value">총 45회</span>
					</div>
				</div>
			</div>

			<!-- 신고 유형 선택 -->
			<div class="form-section">
				<label class="form-label"> 신고 유형 <span class="required">*</span>
				</label>
				<div class="form-description">해당하는 신고 유형을 선택해주세요.</div>
				<div class="report-type-grid">
					<div class="report-type-option">
						<input type="radio" id="type1" name="reportGroupType" value="1">
						<label class="report-type-label" for="type1">음란성 모임</label>
					</div>
					<div class="report-type-option">
						<input type="radio" id="type2" name="reportGroupType" value="2">
						<label class="report-type-label" for="type2">광고성 모임</label>
					</div>
					<div class="report-type-option">
						<input type="radio" id="type3" name="reportGroupType" value="3">
						<label class="report-type-label" for="type3">불법/유해 모임</label>
					</div>

				</div>

				<!-- 버튼 -->
				<div class="button-group">
					<button type="button" class="btn-cancel" onclick="cancelGroup()">취소</button> 
					<!-- <button type="submit" class="btn-submit" onclick="location.href='reportafter.do'">신고 제출</button> -->
					<button type="submit" class="btn-submit">신고 제출</button>
				</div>
			</div>
		</form>
	</div>
</body>
</html>