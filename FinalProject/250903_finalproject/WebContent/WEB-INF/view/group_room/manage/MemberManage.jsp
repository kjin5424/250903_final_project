<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들 - 모임원 관리</title>
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
	max-width: 1400px;
	margin: 30px auto;
	padding: 0 20px;
}

.page-header {
	background: linear-gradient(135deg, #2d5a29 0%, #4a8a42 100%);
	color: white;
	padding: 40px;
	border-radius: 12px;
	margin-bottom: 30px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.header-top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
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
	color: #2d5a29;
}

.group-name {
	font-size: 18px;
	opacity: 0.9;
}

.tab-menu {
	display: flex;
	gap: 10px;
	margin-bottom: 30px;
	border-bottom: 2px solid #e0e0e0;
	background: white;
	padding: 0 20px;
	border-radius: 12px 12px 0 0;
}

.tab-item {
	padding: 15px 25px;
	cursor: pointer;
	font-weight: 600;
	color: #666;
	border-bottom: 3px solid transparent;
	transition: all 0.3s;
	position: relative;
	bottom: -2px;
}

.tab-item:hover {
	color: #2d5a29;
}

.tab-item.active {
	color: #2d5a29;
	border-bottom-color: #2d5a29;
}

.content-section {
	background: white;
	border-radius: 0 0 12px 12px;
	padding: 30px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 20px;
	margin-bottom: 30px;
}

.stat-card {
	background: #f8faf8;
	padding: 25px;
	border-radius: 12px;
	text-align: center;
	border: 2px solid #e0e0e0;
}

.stat-value {
	font-size: 32px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 8px;
}

.stat-label {
	font-size: 14px;
	color: #666;
}

.search-filter-bar {
	display: flex;
	gap: 15px;
	margin-bottom: 25px;
	flex-wrap: wrap;
}

.search-box {
	flex: 1;
	min-width: 250px;
	position: relative;
}

.search-input {
	width: 100%;
	padding: 12px 40px 12px 15px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
}

.search-input:focus {
	outline: none;
	border-color: #8bc683;
}

.search-icon {
	position: absolute;
	right: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: #999;
}

.filter-select {
	padding: 12px 15px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	cursor: pointer;
	background: white;
}

.filter-select:focus {
	outline: none;
	border-color: #8bc683;
}

.member-list {
	display: grid;
	gap: 15px;
}

.member-item {
	display: flex;
	align-items: center;
	padding: 20px;
	background: #f8faf8;
	border-radius: 12px;
	border: 2px solid transparent;
	transition: all 0.3s;
}

.member-item:hover {
	border-color: #8bc683;
	background: #f0f8f0;
}

.member-avatar {
	width: 60px;
	height: 60px;
	border-radius: 50%;
	background: #8bc683;
	color: white;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	margin-right: 20px;
	flex-shrink: 0;
}

.member-info {
	flex: 1;
}

.member-name {
	font-size: 18px;
	font-weight: bold;
	color: #333;
	margin-bottom: 5px;
}

.member-role {
	display: inline-block;
	padding: 4px 10px;
	border-radius: 12px;
	font-size: 12px;
	font-weight: 600;
	margin-right: 8px;
}

.role-leader {
	background: #ffd54f;
	color: #f57c00;
}

.role-subleader {
	background: #e3f2fd;
	color: #1565c0;
}

.role-helper {
	background: #f3e5f5;
	color: #7b1fa2;
}

.role-member {
	background: #e0e0e0;
	color: #666;
}

.member-stats {
	display: flex;
	gap: 15px;
	margin-top: 8px;
	font-size: 13px;
	color: #666;
	flex-wrap: wrap;
}

.member-actions {
	display: flex;
	gap: 8px;
	flex-wrap: wrap;
}

.btn-small {
	padding: 8px 15px;
	border: none;
	border-radius: 6px;
	font-size: 13px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
}

.btn-primary {
	background: #4CAF50;
	color: white;
}

.btn-primary:hover {
	background: #45a049;
}

.btn-secondary {
	background: #e0e0e0;
	color: #666;
}

.btn-secondary:hover {
	background: #d0d0d0;
}

.btn-danger {
	background: #f44336;
	color: white;
}

.btn-danger:hover {
	background: #d32f2f;
}

.empty-message {
	text-align: center;
	padding: 40px;
	color: #999;
	font-size: 16px;
}

.role-management-section {
	margin-bottom: 30px;
}

.section-title {
	font-size: 20px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 15px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.role-description {
	background: #e8f5e9;
	padding: 15px;
	border-radius: 8px;
	margin-bottom: 20px;
	font-size: 14px;
	color: #666;
	line-height: 1.6;
}

.transfer-section {
	background: #fff3e0;
	border: 2px solid #ffe0b2;
	border-radius: 12px;
	padding: 25px;
	margin-bottom: 20px;
}

.transfer-title {
	font-size: 18px;
	font-weight: bold;
	color: #e65100;
	margin-bottom: 10px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.transfer-description {
	color: #666;
	margin-bottom: 15px;
	line-height: 1.6;
}

.modal {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.5);
	z-index: 2000;
	align-items: center;
	justify-content: center;
}

.modal.active {
	display: flex;
}

.modal-content {
	background: white;
	border-radius: 12px;
	padding: 30px;
	max-width: 500px;
	width: 90%;
	max-height: 80vh;
	overflow-y: auto;
}

.modal-header {
	font-size: 22px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 20px;
}

.modal-body {
	margin-bottom: 20px;
}

.modal-footer {
	display: flex;
	gap: 10px;
	justify-content: flex-end;
}

.form-group {
	margin-bottom: 20px;
}

.form-label {
	display: block;
	font-weight: 600;
	margin-bottom: 8px;
	color: #333;
}

.form-select {
	width: 100%;
	padding: 12px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
}

.form-textarea {
	width: 100%;
	padding: 12px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	resize: vertical;
	min-height: 100px;
}

.btn-modal {
	padding: 10px 20px;
	border: none;
	border-radius: 6px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
}

.btn-modal-primary {
	background: #4CAF50;
	color: white;
}

.btn-modal-primary:hover {
	background: #45a049;
}

.btn-modal-cancel {
	background: #e0e0e0;
	color: #666;
}

.btn-modal-cancel:hover {
	background: #d0d0d0;
}

@media ( max-width : 768px) {
	.member-item {
		flex-direction: column;
		text-align: center;
	}
	.member-avatar {
		margin: 0 0 15px 0;
	}
	.member-actions {
		margin-top: 15px;
		justify-content: center;
	}
	.search-filter-bar {
		flex-direction: column;
	}
	.header-top {
		flex-direction: column;
		gap: 15px;
		align-items: flex-start;
	}
}
</style>
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
		<div class="page-header">
			<div class="header-top">
				<div>
					<div class="page-title">
						<span>👥</span><span>모임원 관리</span>
					</div>
					<div class="group-name">${groupDetail.groupTitle}</div>
				</div>
				<button class="btn-back"
					onclick="location.href='managelist.do?groupApplyCode=${groupApplyCode}'">←
					뒤로 가기</button>
			</div>
		</div>

		<div class="tab-menu">
			<div class="tab-item active" onclick="switchTab('members')">모임원
				목록</div>
			<div class="tab-item" onclick="switchTab('transfer')">모임장 이양</div>
		</div>

		<div class="content-section">
			<div id="members-tab" class="tab-content active">
				<c:set var="nonLeaderCount" value="0" />
				<c:forEach var="member" items="${memberList}">
					<c:if test="${member.position ne '모임장'}">
						<c:set var="nonLeaderCount" value="${nonLeaderCount + 1}" />
					</c:if>
				</c:forEach>



				<div class="member-list">
					<c:set var="hasNonLeaderMembers" value="false" />
					<c:forEach var="member" items="${memberList}">
						<c:if test="${member.position ne '모임장'}">
							<c:set var="hasNonLeaderMembers" value="true" />
							<div class="member-item">
								<div class="member-avatar">
									<c:choose>
										<c:when test="${not empty member.savePath}">
											<img src="${member.savePath}"
												style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
										</c:when>
										<c:otherwise>👤</c:otherwise>
									</c:choose>
								</div>
								<div class="member-info">
									<div class="member-name">
										${member.nickName}
										<c:choose>
											<c:when test="${member.position eq '부모임장'}">
												<span class="member-role role-subleader">⭐ 부모임장</span>
											</c:when>
											<c:when test="${member.position eq '도우미'}">
												<span class="member-role role-helper">🌟 도우미</span>
											</c:when>
											<c:otherwise>
												<span class="member-role role-member">모임원</span>
											</c:otherwise>
										</c:choose>
									</div>
									<div class="member-stats">
										<span>📧 ${member.email}</span> <span>📅 가입일:
											${member.joinDate}</span>
										<c:if test="${not empty member.totalActivity}">
											<span>🎯 활동:
												${member.attendanceActivity}/${member.totalActivity}</span>
										</c:if>
									</div>
									<c:if test="${not empty member.selfIntroduction}">
										<div style="margin-top: 8px; font-size: 13px; color: #666;">
											💬 ${member.selfIntroduction}</div>
									</c:if>
								</div>

								<div class="member-actions">
									<button class="btn-small btn-secondary"
										onclick="viewMemberDetail('${member.joinCode}')">상세보기</button>
									<button class="btn-small btn-primary"
										onclick="changeRole('${member.joinCode}', '${member.nickName}')">권한
										변경</button>

									<select id="quitReason_${member.joinCode}" class="form-select"
										style="width: auto; padding: 8px 12px; font-size: 13px;">
										<option value="">퇴출 사유 선택</option>
										<c:forEach var="reason" items="${quitReasonList}">
											<option value="${reason.quitReason}">${reason.quitReason}</option>
										</c:forEach>
									</select>

									<button class="btn-small btn-danger"
										onclick="confirmKick('${member.joinCode}', '${member.userCode}', '${member.nickName}')">퇴출</button>
								</div>
							</div>
						</c:if>
					</c:forEach>

					<c:if test="${!hasNonLeaderMembers}">
						<div class="empty-message">⚠️ 모임원이 없습니다.</div>
					</c:if>
				</div>

				<div id="roles-tab" class="tab-content">
					<div class="role-description">
						<strong>권한 설명</strong><br> <strong>👑 모임장:</strong> 모든 권한 보유,
						모임 폐쇄 및 권한 이양 가능<br> <strong>⭐ 부모임장:</strong> 모임원 관리, 출석 관리,
						가입 승인 가능<br> <strong>🌟 도우미:</strong> 출석 체크, 게시글 관리 가능<br>
						<strong>일반 모임원:</strong> 기본 활동 참여 권한만 보유
					</div>

					<c:set var="subleaderCount" value="0" />
					<c:forEach var="member" items="${memberList}">
						<c:if test="${member.position eq '부모임장'}">
							<c:set var="subleaderCount" value="${subleaderCount + 1}" />
						</c:if>
					</c:forEach>

					<div class="role-management-section">
						<div class="section-title">⭐ 부모임장 (${subleaderCount}명)</div>
						<div class="member-list">
							<c:forEach var="member" items="${memberList}">
								<c:if test="${member.position eq '부모임장'}">
									<div class="member-item">
										<div class="member-avatar">
											<c:choose>
												<c:when test="${not empty member.savePath}">
													<img src="${member.savePath}"
														style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
												</c:when>
												<c:otherwise>👤</c:otherwise>
											</c:choose>
										</div>
										<div class="member-info">
											<div class="member-name">${member.nickName}<span
													class="member-role role-subleader">⭐ 부모임장</span>
											</div>
											<div class="member-stats">
												<span>📧 ${member.email}</span> <span>📅 가입일:
													${member.joinDate}</span>
											</div>
										</div>
										<div class="member-actions">
											<button class="btn-small btn-danger"
												onclick="revokeRole('${member.joinCode}', '${member.nickName}', 'subleader')">권한
												해제</button>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<c:if test="${subleaderCount == 0}">
								<p style="color: #999; text-align: center; padding: 20px;">부모임장이
									없습니다.</p>
							</c:if>
						</div>
					</div>

					<c:set var="helperCount" value="0" />
					<c:forEach var="member" items="${memberList}">
						<c:if test="${member.position eq '도우미'}">
							<c:set var="helperCount" value="${helperCount + 1}" />
						</c:if>
					</c:forEach>

					<div class="role-management-section">
						<div class="section-title">🌟 도우미 (${helperCount}명)</div>
						<div class="member-list">
							<c:forEach var="member" items="${memberList}">
								<c:if test="${member.position eq '도우미'}">
									<div class="member-item">
										<div class="member-avatar">
											<c:choose>
												<c:when test="${not empty member.savePath}">
													<img src="${member.savePath}"
														style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
												</c:when>
												<c:otherwise>👤</c:otherwise>
											</c:choose>
										</div>
										<div class="member-info">
											<div class="member-name">${member.nickName}<span
													class="member-role role-helper">🌟 도우미</span>
											</div>
											<div class="member-stats">
												<span>📧 ${member.email}</span> <span>📅 가입일:
													${member.joinDate}</span>
											</div>
										</div>
										<div class="member-actions">
											<button class="btn-small btn-danger"
												onclick="revokeRole('${member.joinCode}', '${member.nickName}', 'helper')">권한
												해제</button>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<c:if test="${helperCount == 0}">
								<p style="color: #999; text-align: center; padding: 20px;">도우미가
									없습니다.</p>
							</c:if>
						</div>
					</div>

					<c:set var="regularMemberCount" value="0" />
					<c:forEach var="member" items="${memberList}">
						<c:if
							test="${member.position ne '모임장' && member.position ne '부모임장' && member.position ne '도우미'}">
							<c:set var="regularMemberCount" value="${regularMemberCount + 1}" />
						</c:if>
					</c:forEach>

					<div class="role-management-section">
						<div class="section-title">일반 모임원 (${regularMemberCount}명)</div>
						<p style="color: #666; margin-bottom: 15px;">권한을 부여하려면 모임원을
							선택하세요.</p>
						<div class="member-list">
							<c:forEach var="member" items="${memberList}">
								<c:if
									test="${member.position ne '모임장' && member.position ne '부모임장' && member.position ne '도우미'}">
									<div class="member-item">
										<div class="member-avatar">
											<c:choose>
												<c:when test="${not empty member.savePath}">
													<img src="${member.savePath}"
														style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
												</c:when>
												<c:otherwise>👤</c:otherwise>
											</c:choose>
										</div>
										<div class="member-info">
											<div class="member-name">${member.nickName}</div>
											<div class="member-stats">
												<span>📧 ${member.email}</span> <span>📅 가입일:
													${member.joinDate}</span>
											</div>
										</div>
										<div class="member-actions">
											<button class="btn-small btn-primary"
												onclick="grantRole('${member.joinCode}', '${member.nickName}')">권한
												부여</button>
										</div>
									</div>
								</c:if>
							</c:forEach>
							<c:if test="${regularMemberCount == 0}">
								<p style="color: #999; text-align: center; padding: 20px;">일반
									모임원이 없습니다.</p>
							</c:if>
						</div>
					</div>
				</div>

				<div id="transfer-tab" class="tab-content">
					<div class="transfer-section">
						<div class="transfer-title">
							<span>👑</span><span>모임장 권한 이양</span>
						</div>
						<div class="transfer-description">
							<strong>⚠️ 주의사항:</strong><br> • 모임장 권한을 다른 모임원에게 이양할 수 있습니다.<br>
							• 이양 후에는 되돌릴 수 없으며, 자동으로 일반 모임원이 됩니다.<br> • 새로운 모임장은 즉시 모든
							관리 권한을 갖게 됩니다.<br> • 다른 모임의 모임장은 이양 대상에서 제외됩니다.<br> •
							신중하게 결정해주세요.
						</div>
					</div>

					<div>
						<div class="section-title">이양 가능한 모임원</div>
						<div class="member-list">
							<c:set var="hasEligibleMembers" value="false" />
							<c:forEach var="member" items="${memberList}">
								<%-- 현재 모임의 모임장이 아니고, 다른 모임의 모임장이 아닌 경우만 표시 --%>
								<c:if test="${member.position ne '모임장'}">
									<%-- TODO: 다른 모임의 모임장 여부를 체크하는 로직 필요 (DB에서 확인) --%>
									<%-- 임시로 모든 모임원을 대상으로 표시 --%>
									<c:set var="hasEligibleMembers" value="true" />
									<div class="member-item">
										<div class="member-avatar">
											<c:choose>
												<c:when test="${not empty member.savePath}">
													<img src="${member.savePath}"
														style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
												</c:when>
												<c:otherwise>👤</c:otherwise>
											</c:choose>
										</div>
										<div class="member-info">
											<div class="member-name">
												${member.nickName}
												<c:choose>
													<c:when test="${member.position eq '부모임장'}">
														<span class="member-role role-subleader">⭐ 부모임장</span>
														<span
															style="color: #f57c00; font-size: 12px; font-weight: 600;">⭐
															추천</span>
													</c:when>
													<c:when test="${member.position eq '도우미'}">
														<span class="member-role role-helper">🌟 도우미</span>
													</c:when>
												</c:choose>
											</div>
											<div class="member-stats">
												<span>📧 ${member.email}</span> <span>📅 가입일:
													${member.joinDate}</span>
												<c:if test="${not empty member.totalActivity}">
													<span>🎯 활동:
														${member.attendanceActivity}/${member.totalActivity}</span>
												</c:if>
											</div>
										</div>
										<div class="member-actions">
											<button class="btn-small btn-primary"
												onclick="selectTransferTarget('${member.joinCode}', '${member.nickName}')">이양
												대상 선택</button>
										</div>
									</div>
								</c:if>
							</c:forEach>

							<c:if test="${!hasEligibleMembers}">
								<div class="empty-message">⚠️ 이양 가능한 모임원이 없습니다.</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="grantRoleModal" class="modal">
			<div class="modal-content">
				<div class="modal-header">권한 부여</div>
				<div class="modal-body">
					<p style="margin-bottom: 15px; color: #666;">
						<strong id="targetMemberName"></strong>님에게 부여할 권한을 선택하세요.
					</p>
					<div class="form-group">
						<label class="form-label">부여할 권한</label> <select id="roleSelect"
							class="form-select">
							<option value="">선택하세요</option>
							<option value="subleader">⭐ 부모임장</option>
							<option value="helper">🌟 도우미</option>
						</select>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn-modal btn-modal-cancel"
						onclick="closeModal('grantRoleModal')">취소</button>
					<button class="btn-modal btn-modal-primary"
						onclick="confirmGrantRole()">확인</button>
				</div>
			</div>
		</div>



		<div id="transferModal" class="modal">
			<div class="modal-content">
				<div class="modal-header">⚠️ 모임장 권한 이양</div>
				<div class="modal-body">
					<p style="margin-bottom: 15px; color: #666;">
						<strong id="transferTargetName"></strong>님에게 모임장 권한을 이양하시겠습니까?
					</p>
					<div
						style="background: #fff3e0; padding: 15px; border-radius: 8px; margin-bottom: 15px;">
						<strong style="color: #e65100;">⚠️ 주의:</strong><br>
						<ul
							style="margin-left: 20px; margin-top: 8px; color: #666; line-height: 1.6;">
							<li>이양 후에는 되돌릴 수 없습니다</li>
							<li>자동으로 일반 모임원이 됩니다</li>
							<li>모든 관리 권한을 잃게 됩니다</li>
						</ul>
					</div>
				</div>
				<div class="modal-footer">
					<button class="btn-modal btn-modal-cancel"
						onclick="closeModal('transferModal')">취소</button>
					<button class="btn-modal btn-modal-primary"
						style="background: #ff9800;" onclick="confirmTransfer()">이양하기</button>
				</div>
			</div>
		</div>

		<script>
        let currentMemberId = null;
        let currentMemberName = '';

        function switchTab(tabName) {
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));
            
            document.getElementById(tabName + '-tab').classList.add('active');
            event.target.classList.add('active');
        }

        function viewMemberDetail(joinCode) {
            alert('모임원 상세 정보 페이지로 이동합니다. (JoinCode: ' + joinCode + ')');
        }

        function changeRole(joinCode, memberName) {
            currentMemberId = joinCode;
            currentMemberName = memberName;
            document.getElementById('targetMemberName').textContent = memberName;
            openModal('grantRoleModal');
        }

        function grantRole(joinCode, memberName) {
            currentMemberId = joinCode;
            currentMemberName = memberName;
            document.getElementById('targetMemberName').textContent = memberName;
            openModal('grantRoleModal');
        }

        function revokeRole(joinCode, memberName, role) {
            const roleName = role === 'subleader' ? '부모임장' : '도우미';
            if (confirm(memberName + '님의 ' + roleName + ' 권한을 해제하시겠습니까?')) {
                alert('권한이 해제되었습니다.');
                location.reload();
            }
        }

        function confirmKick(joinCode, userCode, memberName) {
            // select에서 선택한 사유 가져오기
            const selectId = 'quitReason_' + joinCode;
            const quitReason = document.getElementById(selectId).value;
            
            // 사유 선택 체크
            if (!quitReason) {
                alert('퇴출 사유를 선택해주세요.');
                return;
            }
            
            // 확인
            if (!confirm(memberName + '님을 퇴출하시겠습니까?\n사유: ' + quitReason)) {
                return;
            }
            
			    fetch('kickmember_process.do', {
			    method: 'POST',
			    headers: {
			        'Content-Type': 'application/x-www-form-urlencoded'
			    },
			    body: 'joinCode=' + joinCode +
			          '&userCode=' + userCode +
			          '&groupApplyCode=' + '${groupApplyCode}' +
			          '&quitReason=' + quitReason
			})
			.then(response => response.json())
			.then(data => {
			    if(data.status === 'success') {
			        alert(data.msg);
			        location.reload();
			    } else {
			        alert('퇴출 처리 실패: ' + (data.msg || '알 수 없는 오류'));
			    }
			})
			.catch(error => {
			    alert('퇴출 요청 중 네트워크 또는 서버 오류 발생');
			    console.error(error);
			});
        }

        function confirmGrantRole() {
            const role = document.getElementById('roleSelect').value;
            
            if (!role) {
                alert('권한을 선택해주세요.');
                return;
            }

            const roleName = role === 'subleader' ? '부모임장' : '도우미';
            alert(currentMemberName + '님에게 ' + roleName + ' 권한이 부여되었습니다.');
            closeModal('grantRoleModal');
            location.reload();
        }

        function selectTransferTarget(joinCode, memberName) {
            currentMemberId = joinCode;
            currentMemberName = memberName;
            document.getElementById('transferTargetName').textContent = memberName;
            openModal('transferModal');
        }

        function confirmTransfer() {
            if (confirm('정말 ' + currentMemberName + '님에게 모임장 권한을 이양하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
                alert('모임장 권한이 이양되었습니다.\n일반 모임원으로 전환됩니다.');
                closeModal('transferModal');
                location.reload();
            }
        }

        function openModal(modalId) {
            document.getElementById(modalId).classList.add('active');
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }

        window.onclick = function(event) {
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('active');
            }
        }
    </script>
</body>
</html>