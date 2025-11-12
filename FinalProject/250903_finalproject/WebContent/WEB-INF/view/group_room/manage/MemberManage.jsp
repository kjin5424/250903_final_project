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

.form-select {
	padding: 12px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
}

.empty-message {
	text-align: center;
	padding: 40px;
	color: #999;
	font-size: 16px;
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
}
</style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab"><span>로고 들어갈 자리</span></div>
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
                    onclick="location.href='managelist.do?groupApplyCode=${groupApplyCode}'">← 뒤로 가기</button>
            </div>
        </div>

        <div class="tab-menu">
            <div class="tab-item active" onclick="switchTab('members')">모임원 목록</div>
            <div class="tab-item" onclick="switchTab('transfer')">모임장 이양</div>
        </div>

        <div class="content-section">
            <!-- ✅ 기존 모임원 목록 탭 -->
            <div id="members-tab" class="tab-content active">
                <div class="member-list">
                    <c:set var="hasNonLeaderMembers" value="false" />
                    <c:forEach var="member" items="${memberList}">
                        <c:if test="${member.position ne '모임장'}">
                            <c:set var="hasNonLeaderMembers" value="true" />
                            <div class="member-item">
                                <div class="member-avatar">
                                    <c:choose>
                                        <c:when test="${not empty member.savePath}">
                                            <img src="${member.savePath}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
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
                                        <span>📧 ${member.email}</span>
                                        <span>📅 가입일: ${member.joinDate}</span>
                                    </div>
                                </div>

                                <div class="member-actions">
                                 
                                    <button class="btn-small btn-primary"
                                        onclick="changeRole('${member.joinCode}', '${member.nickName}')">권한 변경</button>

                                    <select id="quitReason_${member.joinCode}" class="form-select"
                                        style="width: auto; padding: 8px 12px; font-size: 13px;">
                                        <option value="">퇴출 사유 선택</option>
                                        <c:forEach var="reason" items="${quitReasonList}">
                                            <option value="${reason.quitReasonCode}">${reason.quitReason}</option>
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
            </div>

            <!-- ✅ 새로 추가된: 모임장 이양 탭 -->
            <div id="transfer-tab" class="tab-content">
                <div class="member-list">
                    <c:set var="hasTransferMembers" value="false" />
                    <c:forEach var="member" items="${memberList}">
                        <c:if test="${member.position ne '모임장'}">
                            <c:set var="hasTransferMembers" value="true" />
                            <div class="member-item">
                                <div class="member-avatar">
                                    <c:choose>
                                        <c:when test="${not empty member.savePath}">
                                            <img src="${member.savePath}" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                        </c:when>
                                        <c:otherwise>👤</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="member-info">
                                    <div class="member-name">
                                        ${member.nickName}
                                        <span class="member-role role-member">${member.position}</span>
                                    </div>
                                    <div class="member-stats">
                                        <span>📧 ${member.email}</span>
                                        <span>📅 가입일: ${member.joinDate}</span>
                                    </div>
                                </div>

                                <div class="member-actions">
                                    <button class="btn-small btn-primary"
                                        onclick="confirmTransfer('${member.joinCode}', '${member.nickName}')">이양하기</button>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <c:if test="${!hasTransferMembers}">
                        <div class="empty-message">⚠️ 이양 가능한 모임원이 없습니다.</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script>
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
        alert(memberName + '님의 권한 변경 기능 (개발 예정)');
    }

    function confirmKick(joinCode, userCode, memberName) {
        const selectId = 'quitReason_' + joinCode;
        const quitReason = document.getElementById(selectId).value;

        if (!quitReason) {
            alert('퇴출 사유를 선택해주세요.');
            return;
        }

        if (!confirm(memberName + '님을 퇴출하시겠습니까?')) {
            return;
        }

        fetch('kickmember_process.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            body:
                'joinCode=' + encodeURIComponent(joinCode) +
                '&userCode=' + encodeURIComponent(userCode) +
                '&groupApplyCode=' + encodeURIComponent('${groupApplyCode}') +
                '&quitReason=' + encodeURIComponent(quitReason)
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                alert(data.msg);
                location.reload();
            } else {
                alert('퇴출 실패: ' + (data.msg || '알 수 없는 오류'));
            }
        })
        .catch(err => {
            console.error(err);
            alert('퇴출 요청 중 오류 발생');
        });
    }

    // ✅ 새로 추가된 함수: 모임장 이양 처리
    function confirmTransfer(joinCode, memberName) {
        if (!confirm(memberName + '님에게 모임장 권한을 이양하시겠습니까?')) return;

        fetch('transferleader_process.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            body: 'joinCode=' + encodeURIComponent(joinCode) +
                  '&groupApplyCode=' + encodeURIComponent('${groupApplyCode}')
        })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'success') {
                alert(data.msg);
                location.reload();
            } else {
                alert('이양 실패: ' + (data.msg || '알 수 없는 오류'));
            }
        })
        .catch(err => {
            console.error(err);
            alert('이양 요청 중');
        });
    }
    </script>
</body>
</html>