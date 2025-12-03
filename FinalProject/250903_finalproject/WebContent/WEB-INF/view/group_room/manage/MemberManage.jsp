<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임원 관리</title>
    
    <!-- CSS Import -->
    <link rel="stylesheet" href="<%=cp%>/css_new/common_sample.css">
    <link rel="stylesheet" href="<%=cp%>/css_new/topmenubar_sample.css">
    <link rel="stylesheet" href="<%=cp%>/css_new/grouproommanage.css">
    
    <style>
        /* 컨테이너 */
        .container {
            max-width: var(--max-width);
            margin: 30px auto;
            padding: 0 var(--spacing-lg);
        }

        /* 탭 메뉴 */
        .tab-menu {
            display: flex;
            gap: 10px;
            margin-bottom: 0;
            border-bottom: 2px solid var(--color-border);
            background: var(--color-white);
            padding: 0 20px;
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
        }

        .tab-item {
            padding: 15px 25px;
            cursor: pointer;
            font-weight: 600;
            color: var(--color-text-secondary);
            border-bottom: 3px solid transparent;
            transition: all var(--transition-base);
            position: relative;
            bottom: -2px;
        }

        .tab-item:hover {
            color: var(--color-primary-dark);
        }

        .tab-item.active {
            color: var(--color-primary-dark);
            border-bottom-color: var(--color-primary-dark);
        }

        /* 콘텐츠 섹션 */
        .content-section {
            background: var(--color-white);
            border-radius: 0 0 var(--radius-lg) var(--radius-lg);
            padding: var(--spacing-xl);
            box-shadow: var(--shadow-sm);
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        /* 모임원 목록 */
        .member-list {
            display: grid;
            gap: var(--spacing-md);
        }

        .member-item {
            display: flex;
            align-items: center;
            padding: var(--spacing-lg);
            background: var(--color-base);
            border-radius: var(--radius-lg);
            border: 2px solid transparent;
            transition: all var(--transition-base);
        }

        .member-item:hover {
            border-color: var(--color-primary);
            background: var(--color-primary-lighter);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .member-avatar {
            width: 60px;
            height: 60px;
            border-radius: var(--radius-full);
            background: linear-gradient(135deg, var(--color-primary), var(--color-primary-dark));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-right: var(--spacing-lg);
            flex-shrink: 0;
            overflow: hidden;
        }

        .member-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .member-info {
            flex: 1;
        }

        .member-name {
            font-size: 18px;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: var(--spacing-xs);
            display: flex;
            align-items: center;
            gap: var(--spacing-sm);
        }

        .member-role {
            display: inline-flex;
            align-items: center;
            padding: 4px 12px;
            border-radius: var(--radius-full);
            font-size: 12px;
            font-weight: 600;
        }

        .role-subleader {
            background: var(--color-secondary-lighter);
            color: var(--color-secondary-dark);
        }

        .role-helper {
            background: var(--color-primary-lighter);
            color: var(--color-primary-dark);
        }

        .role-member {
            background: var(--color-border-light);
            color: var(--color-text-secondary);
        }

        .member-stats {
            display: flex;
            gap: var(--spacing-md);
            margin-top: var(--spacing-sm);
            font-size: 13px;
            color: var(--color-text-secondary);
            flex-wrap: wrap;
        }

        .member-actions {
            display: flex;
            gap: var(--spacing-sm);
            flex-wrap: wrap;
            align-items: center;
        }

        .action-group {
            display: flex;
            gap: var(--spacing-sm);
            align-items: center;
        }

        .form-select {
            width: 160px;
            padding: 10px 14px;
            border: 2px solid var(--color-border);
            border-radius: var(--radius-md);
            font-size: 13px;
            background: var(--color-white);
            cursor: pointer;
            transition: all var(--transition-fast);
        }

        .form-select:focus {
            outline: none;
            border-color: var(--color-primary);
        }

        /* 모임장 이양 카드 그리드 */
        .transfer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: var(--spacing-lg);
        }

        .transfer-card {
            background: var(--color-white);
            border: 2px solid var(--color-border);
            border-radius: var(--radius-lg);
            padding: var(--spacing-xl);
            text-align: center;
            transition: all var(--transition-base);
        }

        .transfer-card:hover {
            box-shadow: var(--shadow-md);
        }

        .transfer-avatar {
            width: 80px;
            height: 80px;
            border-radius: var(--radius-full);
            background: linear-gradient(135deg, var(--color-primary), var(--color-primary-dark));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin: 0 auto var(--spacing-md);
            overflow: hidden;
            font-weight: 700;
        }

        .transfer-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .transfer-name {
            font-size: 20px;
            font-weight: 700;
            color: var(--color-text-primary);
            margin-bottom: var(--spacing-sm);
        }

        .transfer-info {
            font-size: 14px;
            color: var(--color-text-secondary);
            margin-bottom: var(--spacing-md);
        }

        .transfer-btn {
            width: 100%;
            padding: 12px 24px;
            margin-top: var(--spacing-md);
        }

        .empty-message {
            text-align: center;
            padding: var(--spacing-2xl);
            color: var(--color-text-tertiary);
            font-size: 16px;
        }

        @media (max-width: 768px) {
            .member-item {
                flex-direction: column;
                text-align: center;
            }
            
            .member-avatar {
                margin: 0 0 var(--spacing-md) 0;
            }
            
            .member-actions {
                margin-top: var(--spacing-md);
                justify-content: center;
                width: 100%;
                flex-direction: column;
            }
            
            .action-group {
                width: 100%;
                flex-direction: column;
            }
            
            .form-select {
                width: 100%;
            }
            
            .transfer-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <!-- 상단바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />
    
    <!-- 사이드바 -->
    <c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />

    <div class="container">
        <!-- 페이지 헤더 -->
        <div class="page-header-custom">
            <div class="header-top">
                <div>
                    <div class="page-title-custom">
                        <span>👥</span>
                        <span>모임원 관리</span>
                        <span class="role-badge">모임장</span>
                    </div>
                    <div class="group-name">${groupDetail.groupTitle}</div>
                </div>
                <a href="managelist.do?groupApplyCode=${groupApplyCode}" class="btn-back-custom">
                    <span>←</span>
                    <span>관리 메뉴로</span>
                </a>
            </div>
        </div>

        <!-- 탭 메뉴 -->
        <div class="tab-menu">
            <div class="tab-item active" onclick="switchTab('members')">모임원 목록</div>
            <div class="tab-item" onclick="switchTab('transfer')">모임장 이양</div>
        </div>

        <!-- 콘텐츠 섹션 -->
        <div class="content-section">
            <!-- 모임원 목록 탭 -->
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
                                            <img src="${member.savePath}" alt="${member.nickName}">
                                        </c:when>
                                        <c:otherwise>${fn:substring(member.nickName, 0, 1)}</c:otherwise>
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
                                        <span>📅 ${member.joinDate}</span>
                                    </div>
                                </div>

                                <div class="member-actions">
                                    <div class="action-group">
                                        <select id="roleSelect_${member.joinCode}" class="form-select">
                                            <option value="부모임장" ${member.position eq '부모임장' ? 'selected' : ''}>부모임장</option>
                                            <option value="도우미" ${member.position eq '도우미' ? 'selected' : ''}>도우미</option>
                                            <option value="모임원" ${member.position eq '모임원' ? 'selected' : ''}>모임원</option>
                                        </select>
                                        <button class="btn btn-sm btn-primary"
                                            onclick="changeRole('${member.joinCode}', '${member.nickName}')">권한 변경</button>
                                    </div>

                                    <div class="action-group">
                                        <select id="quitReason_${member.joinCode}" class="form-select">
                                            <option value="">퇴출 사유 선택</option>
                                            <c:forEach var="reason" items="${quitReasonList}">
                                                <option value="${reason.quitReasonCode}">${reason.quitReason}</option>
                                            </c:forEach>
                                        </select>
                                        <button class="btn btn-sm btn-accent"
                                            onclick="confirmKick('${member.joinCode}', '${member.userCode}', '${member.nickName}')">퇴출</button>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>

                    <c:if test="${!hasNonLeaderMembers}">
                        <div class="empty-message">⚠️ 모임원이 없습니다.</div>
                    </c:if>
                </div>
            </div>

            <!-- 모임장 이양 탭 -->
            <div id="transfer-tab" class="tab-content">
                <div class="transfer-grid">
                    <c:set var="hasTransferMembers" value="false" />
                    <c:forEach var="member" items="${memberList}">
                        <c:if test="${member.position ne '모임장'}">
                            <c:set var="hasTransferMembers" value="true" />
                            <div class="transfer-card">
                                <div class="transfer-avatar">
                                    <c:choose>
                                        <c:when test="${not empty member.savePath}">
                                            <img src="${member.savePath}" alt="${member.nickName}">
                                        </c:when>
                                        <c:otherwise>${fn:substring(member.nickName, 0, 1)}</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="transfer-name">${member.nickName}</div>
                                <span class="member-role ${member.position eq '부모임장' ? 'role-subleader' : (member.position eq '도우미' ? 'role-helper' : 'role-member')}">
                                    ${member.position}
                                </span>
                                <div class="transfer-info">
                                    <div>📧 ${member.email}</div>
                                    <div>📅 ${member.joinDate}</div>
                                </div>
                                <button class="btn btn-primary transfer-btn" onclick="event.stopPropagation(); confirmTransfer('${member.joinCode}', '${member.nickName}')">모임장 이양</button>
                            </div>
                        </c:if>
                    </c:forEach>

                    <c:if test="${!hasTransferMembers}">
                        <div class="empty-message" style="grid-column: 1/-1;">⚠️ 이양 가능한 모임원이 없습니다.</div>
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

    function changeRole(joinCode, memberName) {
        const selectId = 'roleSelect_' + joinCode;
        const selectedRole = document.getElementById(selectId).value;
        
        if (!confirm(memberName + '님의 권한을 "' + selectedRole + '"로 변경하시겠습니까?')) {
            return;
        }
        
        // TODO: 서버로 권한 변경 요청 전송
        alert(memberName + '님의 권한이 "' + selectedRole + '"로 변경되었습니다. (개발 예정)');
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
            alert('이양 요청 중 오류 발생');
        });
    }
    </script>
</body>
</html>
