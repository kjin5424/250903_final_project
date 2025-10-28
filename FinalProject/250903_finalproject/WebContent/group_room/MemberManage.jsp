<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임원 관리</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        .navbar { background: #a8d5a1; display: flex; align-items: center; padding: 0 20px; height: 48px; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 4px rgba(0,0,0,0.1); gap: 4px; }
        .nav-left { display: flex; align-items: center; gap: 4px; flex: 1; }
        .logo-tab { background: #8bc683; color: white; padding: 0 20px; height: 36px; border-radius: 8px 8px 0 0; display: flex; align-items: center; gap: 8px; font-weight: bold; font-size: 16px; cursor: pointer; }
        .container { max-width: 1400px; margin: 30px auto; padding: 0 20px; }
        .page-header { background: linear-gradient(135deg, #2d5a29 0%, #4a8a42 100%); color: white; padding: 40px; border-radius: 12px; margin-bottom: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .header-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .page-title { font-size: 32px; font-weight: bold; display: flex; align-items: center; gap: 12px; }
        .btn-back { background: rgba(255,255,255,0.2); color: white; border: 2px solid white; padding: 10px 20px; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.3s; text-decoration: none; }
        .btn-back:hover { background: white; color: #2d5a29; }
        .group-name { font-size: 18px; opacity: 0.9; }
        .tab-menu { display: flex; gap: 10px; margin-bottom: 30px; border-bottom: 2px solid #e0e0e0; background: white; padding: 0 20px; border-radius: 12px 12px 0 0; }
        .tab-item { padding: 15px 25px; cursor: pointer; font-weight: 600; color: #666; border-bottom: 3px solid transparent; transition: all 0.3s; position: relative; bottom: -2px; }
        .tab-item:hover { color: #2d5a29; }
        .tab-item.active { color: #2d5a29; border-bottom-color: #2d5a29; }
        .content-section { background: white; border-radius: 0 0 12px 12px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: #f8faf8; padding: 25px; border-radius: 12px; text-align: center; border: 2px solid #e0e0e0; }
        .stat-value { font-size: 32px; font-weight: bold; color: #2d5a29; margin-bottom: 8px; }
        .stat-label { font-size: 14px; color: #666; }
        .search-filter-bar { display: flex; gap: 15px; margin-bottom: 25px; flex-wrap: wrap; }
        .search-box { flex: 1; min-width: 250px; position: relative; }
        .search-input { width: 100%; padding: 12px 40px 12px 15px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; }
        .search-input:focus { outline: none; border-color: #8bc683; }
        .search-icon { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); color: #999; }
        .filter-select { padding: 12px 15px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; cursor: pointer; background: white; }
        .filter-select:focus { outline: none; border-color: #8bc683; }
        .member-list { display: grid; gap: 15px; }
        .member-item { display: flex; align-items: center; padding: 20px; background: #f8faf8; border-radius: 12px; border: 2px solid transparent; transition: all 0.3s; }
        .member-item:hover { border-color: #8bc683; background: #f0f8f0; }
        .member-avatar { width: 60px; height: 60px; border-radius: 50%; background: #8bc683; color: white; display: flex; align-items: center; justify-content: center; font-size: 24px; margin-right: 20px; flex-shrink: 0; }
        .member-info { flex: 1; }
        .member-name { font-size: 18px; font-weight: bold; color: #333; margin-bottom: 5px; }
        .member-role { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 12px; font-weight: 600; margin-right: 8px; }
        .role-leader { background: #ffd54f; color: #f57c00; }
        .role-subleader { background: #e3f2fd; color: #1565c0; }
        .role-helper { background: #f3e5f5; color: #7b1fa2; }
        .role-member { background: #e0e0e0; color: #666; }
        .member-stats { display: flex; gap: 15px; margin-top: 8px; font-size: 13px; color: #666; flex-wrap: wrap; }
        .member-actions { display: flex; gap: 8px; flex-wrap: wrap; }
        .btn-small { padding: 8px 15px; border: none; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; transition: all 0.3s; }
        .btn-primary { background: #4CAF50; color: white; }
        .btn-primary:hover { background: #45a049; }
        .btn-secondary { background: #e0e0e0; color: #666; }
        .btn-secondary:hover { background: #d0d0d0; }
        .btn-danger { background: #f44336; color: white; }
        .btn-danger:hover { background: #d32f2f; }
        .role-management-section { margin-bottom: 30px; }
        .section-title { font-size: 20px; font-weight: bold; color: #2d5a29; margin-bottom: 15px; display: flex; align-items: center; gap: 10px; }
        .role-description { background: #e8f5e9; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; color: #666; line-height: 1.6; }
        .transfer-section { background: #fff3e0; border: 2px solid #ffe0b2; border-radius: 12px; padding: 25px; margin-top: 30px; }
        .transfer-title { font-size: 18px; font-weight: bold; color: #e65100; margin-bottom: 10px; display: flex; align-items: center; gap: 10px; }
        .transfer-description { color: #666; margin-bottom: 15px; line-height: 1.6; }
        .btn-transfer { background: #ff9800; color: white; border: none; padding: 12px 24px; border-radius: 8px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.3s; }
        .btn-transfer:hover { background: #f57c00; }
        .modal { display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); z-index: 2000; align-items: center; justify-content: center; }
        .modal.active { display: flex; }
        .modal-content { background: white; border-radius: 12px; padding: 30px; max-width: 500px; width: 90%; max-height: 80vh; overflow-y: auto; }
        .modal-header { font-size: 22px; font-weight: bold; color: #2d5a29; margin-bottom: 20px; }
        .modal-body { margin-bottom: 20px; }
        .modal-footer { display: flex; gap: 10px; justify-content: flex-end; }
        .form-group { margin-bottom: 20px; }
        .form-label { display: block; font-weight: 600; margin-bottom: 8px; color: #333; }
        .form-select { width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; }
        .form-textarea { width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; resize: vertical; min-height: 100px; }
        .btn-modal { padding: 10px 20px; border: none; border-radius: 6px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.3s; }
        .btn-modal-primary { background: #4CAF50; color: white; }
        .btn-modal-primary:hover { background: #45a049; }
        .btn-modal-cancel { background: #e0e0e0; color: #666; }
        .btn-modal-cancel:hover { background: #d0d0d0; }
        @media (max-width: 768px) {
            .member-item { flex-direction: column; text-align: center; }
            .member-avatar { margin: 0 0 15px 0; }
            .member-actions { margin-top: 15px; justify-content: center; }
            .search-filter-bar { flex-direction: column; }
            .header-top { flex-direction: column; gap: 15px; align-items: flex-start; }
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
                    <div class="page-title"><span>👥</span><span>모임원 관리</span></div>
                    <div class="group-name">알고리즘 정복 스터디</div>
                </div>
                <button class="btn-back" onclick="history.back()">← 뒤로 가기</button>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script type="text/javascript">
        
        	$(".btn-back").click(function() {
				alert("모임 리스트 화면으로 이동합니다.");
			});
        
        </script>

        <div class="tab-menu">
            <div class="tab-item active" onclick="switchTab('members')">모임원 목록</div>
            <div class="tab-item" onclick="switchTab('roles')">권한 관리</div>
            <div class="tab-item" onclick="switchTab('transfer')">모임장 이양</div>
        </div>

        <div class="content-section">
            <div id="members-tab" class="tab-content active">
                <div class="stats-grid">
                    <div class="stat-card"><div class="stat-value">7</div><div class="stat-label">전체 모임원</div></div>
                    <div class="stat-card"><div class="stat-value">85%</div><div class="stat-label">평균 출석률</div></div>
                    <div class="stat-card"><div class="stat-value">10</div><div class="stat-label">정원</div></div>
                </div>

                <div class="search-filter-bar">
                    <div class="search-box">
                        <input type="text" class="search-input" placeholder="모임원 이름 또는 이메일 검색">
                        <span class="search-icon">🔍</span>
                    </div>
                    <select class="filter-select">
                        <option value="all">전체</option>
                        <option value="leader">모임장</option>
                        <option value="subleader">부모임장</option>
                        <option value="helper">도우미</option>
                        <option value="member">일반 모임원</option>
                    </select>
                    <select class="filter-select">
                        <option value="all">모든 출석률</option>
                        <option value="high">80% 이상</option>
                        <option value="medium">50-80%</option>
                        <option value="low">50% 미만</option>
                    </select>
                </div>

                <div class="member-list">
                    <div class="member-item">
                        <div class="member-avatar">👤</div>
                        <div class="member-info">
                            <div class="member-name">김모임장<span class="member-role role-leader">👑 모임장</span></div>
                            <div class="member-stats">
                                <span>📧 leader@example.com</span>
                                <span>📊 출석률 95%</span>
                                <span>📅 가입일 2024-01-15</span>
                            </div>
                        </div>
                        <div class="member-actions">
                            <button class="btn-small btn-secondary" onclick="viewMemberDetail(1)">상세보기</button>
                        </div>
                    </div>

                    <div class="member-item">
                        <div class="member-avatar">👤</div>
                        <div class="member-info">
                            <div class="member-name">이부장<span class="member-role role-subleader">⭐ 부모임장</span></div>
                            <div class="member-stats">
                                <span>📧 subleader@example.com</span>
                                <span>📊 출석률 88%</span>
                                <span>📅 가입일 2024-02-10</span>
                            </div>
                        </div>
                        <div class="member-actions">
                            <button class="btn-small btn-secondary" onclick="viewMemberDetail(2)">상세보기</button>
                            <button class="btn-small btn-primary" onclick="changeRole(2)">권한 변경</button>
                            <button class="btn-small btn-danger" onclick="kickMember(2)">퇴출</button>
                        </div>
                    </div>

                    <div class="member-item">
                        <div class="member-avatar">👤</div>
                        <div class="member-info">
                            <div class="member-name">박도움<span class="member-role role-helper">🌟 도우미</span></div>
                            <div class="member-stats">
                                <span>📧 helper@example.com</span>
                                <span>📊 출석률 92%</span>
                                <span>📅 가입일 2024-03-05</span>
                            </div>
                        </div>
                        <div class="member-actions">
                            <button class="btn-small btn-secondary" onclick="viewMemberDetail(3)">상세보기</button>
                            <button class="btn-small btn-primary" onclick="changeRole(3)">권한 변경</button>
                            <button class="btn-small btn-danger" onclick="kickMember(3)">퇴출</button>
                        </div>
                    </div>

                    <div class="member-item">
                        <div class="member-avatar">👤</div>
                        <div class="member-info">
                            <div class="member-name">최스터디<span class="member-role role-member">모임원</span></div>
                            <div class="member-stats">
                                <span>📧 member1@example.com</span>
                                <span>📊 출석률 78%</span>
                                <span>📅 가입일 2024-04-20</span>
                            </div>
                        </div>
                        <div class="member-actions">
                            <button class="btn-small btn-secondary" onclick="viewMemberDetail(4)">상세보기</button>
                            <button class="btn-small btn-primary" onclick="changeRole(4)">권한 변경</button>
                            <button class="btn-small btn-danger" onclick="kickMember(4)">퇴출</button>
                        </div>
                    </div>

                    <div class="member-item">
                        <div class="member-avatar">👤</div>
                        <div class="member-info">
                            <div class="member-name">정코딩<span class="member-role role-member">모임원</span></div>
                            <div class="member-stats">
                                <span>📧 member2@example.com</span>
                                <span>📊 출석률 82%</span>
                                <span>📅 가입일 2024-05-15</span>
                            </div>
                        </div>
                        <div class="member-actions">
                            <button class="btn-small btn-secondary" onclick="viewMemberDetail(5)">상세보기</button>
                            <button class="btn-small btn-primary" onclick="changeRole(5)">권한 변경</button>
                            <button class="btn-small btn-danger" onclick="kickMember(5)">퇴출</button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="roles-tab" class="tab-content">
                <div class="role-description">
                    <strong>권한 설명</strong><br>
                    <strong>👑 모임장:</strong> 모든 권한 보유, 모임 폐쇄 및 권한 이양 가능<br>
                    <strong>⭐ 부모임장:</strong> 모임원 관리, 출석 관리, 가입 승인 가능<br>
                    <strong>🌟 도우미:</strong> 출석 체크, 게시글 관리 가능<br>
                    <strong>일반 모임원:</strong> 기본 활동 참여 권한만 보유
                </div>

                <div class="role-management-section">
                    <div class="section-title">⭐ 부모임장 (1명)</div>
                    <div class="member-list">
                        <div class="member-item">
                            <div class="member-avatar">👤</div>
                            <div class="member-info">
                                <div class="member-name">이부장<span class="member-role role-subleader">⭐ 부모임장</span></div>
                                <div class="member-stats">
                                    <span>📧 subleader@example.com</span>
                                    <span>📊 출석률 88%</span>
                                </div>
                            </div>
                            <div class="member-actions">
                                <button class="btn-small btn-danger" onclick="revokeRole(2, 'subleader')">권한 해제</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="role-management-section">
                    <div class="section-title">🌟 도우미 (1명)</div>
                    <div class="member-list">
                        <div class="member-item">
                            <div class="member-avatar">👤</div>
                            <div class="member-info">
                                <div class="member-name">박도움<span class="member-role role-helper">🌟 도우미</span></div>
                                <div class="member-stats">
                                    <span>📧 helper@example.com</span>
                                    <span>📊 출석률 92%</span>
                                </div>
                            </div>
                            <div class="member-actions">
                                <button class="btn-small btn-danger" onclick="revokeRole(3, 'helper')">권한 해제</button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="role-management-section">
                    <div class="section-title">일반 모임원 (2명)</div>
                    <p style="color:#666;margin-bottom:15px;">권한을 부여하려면 모임원을 선택하세요.</p>
                    <div class="member-list">
                        <div class="member-item">
                            <div class="member-avatar">👤</div>
                            <div class="member-info">
                                <div class="member-name">최스터디</div>
                                <div class="member-stats">
                                    <span>📧 member1@example.com</span>
                                    <span>📊 출석률 78%</span>
                                </div>
                            </div>
                            <div class="member-actions">
                                <button class="btn-small btn-primary" onclick="grantRole(4, '최스터디')">권한 부여</button>
                            </div>
                        </div>
                        <div class="member-item">
                            <div class="member-avatar">👤</div>
                            <div class="member-info">
                                <div class="member-name">정코딩</div>
                                <div class="member-stats">
                                    <span>📧 member2@example.com</span>
                                    <span>📊 출석률 82%</span>
                                </div>
                            </div>
                            <div class="member-actions">
                                <button class="btn-small btn-primary" onclick="grantRole(5, '정코딩')">권한 부여</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="transfer-tab" class="tab-content">
                <div class="transfer-section">
                    <div class="transfer-title"><span>👑</span><span>모임장 권한 이양</span></div>
                    <div class="transfer-description">
                        <strong>⚠️ 주의사항:</strong><br>
                        • 모임장 권한을 다른 모임원에게 이양할 수 있습니다.<br>
                        • 이양 후에는 되돌릴 수 없으며, 자동으로 일반 모임원이 됩니다.<br>
                        • 새로운 모임장은 즉시 모든 관리 권한을 갖게 됩니다.<br>
                        • 신중하게 결정해주세요.
                    </div>
                </div>

                <div style="margin-top:30px;">
                    <div class="section-title">이양 가능한 모임원</div>
                    <div class="member-list">
                        <div class="member-item">
                            <div class="member-avatar">👤</div>
                            <div class="member-info">
                                <div class="member-name">이부장<span class="member-role role-subleader">⭐ 부모임장</span></div>
                                <div class="member-stats">
                                    <span>📧 subleader@example.com</span>
                                    <span>📊 출석률 88%</span>
                                    <span>⭐ 추천</span>
                                </div>
                            </div>
                            <div class="member-actions">
                                <button class="btn-small btn-primary" onclick="selectTransferTarget(2, '이부장')">이양 대상 선택</button>
                            </div>
                        </div>

                        <div class="member-item">
                            <div class="member-avatar">👤</div>
                            <div class="member-info">
                                <div class="member-name">박도움<span class="member-role role-helper">🌟 도우미</span></div>
                                <div class="member-stats">
                                    <span>📧 helper@example.com</span>
                                    <span>📊 출석률 92%</span>
                                </div>
                            </div>
                            <div class="member-actions">
                                <button class="btn-small btn-primary" onclick="selectTransferTarget(3, '박도움')">이양 대상 선택</button>
                            </div>
                        </div>

                        <div class="member-item">
                            <div class="member-avatar">👤</div>
                            <div class="member-info">
                                <div class="member-name">최스터디</div>
                                <div class="member-stats">
                                    <span>📧 member1@example.com</span>
                                    <span>📊 출석률 78%</span>
                                </div>
                            </div>
                            <div class="member-actions">
                                <button class="btn-small btn-primary" onclick="selectTransferTarget(4, '최스터디')">이양 대상 선택</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 권한 부여 모달 -->
    <div id="grantRoleModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">권한 부여</div>
            <div class="modal-body">
                <p style="margin-bottom:15px;color:#666;"><strong id="targetMemberName"></strong>님에게 부여할 권한을 선택하세요.</p>
                <div class="form-group">
                    <label class="form-label">부여할 권한</label>
                    <select id="roleSelect" class="form-select">
                        <option value="">선택하세요</option>
                        <option value="subleader">⭐ 부모임장</option>
                        <option value="helper">🌟 도우미</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn-modal btn-modal-cancel" onclick="closeModal('grantRoleModal')">취소</button>
                <button class="btn-modal btn-modal-primary" onclick="confirmGrantRole()">확인</button>
            </div>
        </div>
    </div>

    <!-- 모임원 퇴출 모달 -->
    <div id="kickMemberModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">모임원 퇴출</div>
            <div class="modal-body">
                <p style="margin-bottom:15px;color:#666;">퇴출 사유를 작성해주세요. 신고 사유에 해당할 경우 신고까지 연계할 수 있습니다.</p>
                <div class="form-group">
                    <label class="form-label">퇴출 사유</label>
                    <textarea id="kickReason" class="form-textarea" placeholder="퇴출 사유를 입력하세요"></textarea>
                </div>
                <div class="form-group">
                    <label style="display:flex;align-items:center;gap:8px;cursor:pointer;">
                        <input type="checkbox" id="reportCheck">
                        <span>신고 처리로 연계하기</span>
                    </label>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn-modal btn-modal-cancel" onclick="closeModal('kickMemberModal')">취소</button>
                <button class="btn-modal btn-modal-primary" style="background:#f44336;" onclick="confirmKickMember()">퇴출</button>
            </div>
        </div>
    </div>

    <!-- 모임장 이양 모달 -->
    <div id="transferModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">⚠️ 모임장 권한 이양</div>
            <div class="modal-body">
                <p style="margin-bottom:15px;color:#666;"><strong id="transferTargetName"></strong>님에게 모임장 권한을 이양하시겠습니까?</p>
                <div style="background:#fff3e0;padding:15px;border-radius:8px;margin-bottom:15px;">
                    <strong style="color:#e65100;">⚠️ 주의:</strong><br>
                    <ul style="margin-left:20px;margin-top:8px;color:#666;line-height:1.6;">
                        <li>이양 후에는 되돌릴 수 없습니다</li>
                        <li>자동으로 일반 모임원이 됩니다</li>
                        <li>모든 관리 권한을 잃게 됩니다</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn-modal btn-modal-cancel" onclick="closeModal('transferModal')">취소</button>
                <button class="btn-modal btn-modal-primary" style="background:#ff9800;" onclick="confirmTransfer()">이양하기</button>
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

        function viewMemberDetail(memberId) {
            alert('모임원 상세 정보 페이지로 이동합니다. (ID: ' + memberId + ')');
            // window.location.href = 'member_detail.jsp?id=' + memberId;
        }

        function changeRole(memberId) {
            alert('권한 변경 기능 (ID: ' + memberId + ')');
        }

        function kickMember(memberId) {
            currentMemberId = memberId;
            openModal('kickMemberModal');
        }

        function confirmKickMember() {
            const reason = document.getElementById('kickReason').value.trim();
            const reportCheck = document.getElementById('reportCheck').checked;
            
            if (!reason) {
                alert('퇴출 사유를 입력해주세요.');
                return;
            }

            if (confirm('정말 이 모임원을 퇴출하시겠습니까?')) {
                alert('모임원이 퇴출되었습니다.' + (reportCheck ? '\n신고 처리가 연계되었습니다.' : ''));
                closeModal('kickMemberModal');
                document.getElementById('kickReason').value = '';
                document.getElementById('reportCheck').checked = false;
            }
        }

        function grantRole(memberId, memberName) {
            currentMemberId = memberId;
            currentMemberName = memberName;
            document.getElementById('targetMemberName').textContent = memberName;
            openModal('grantRoleModal');
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
            document.getElementById('roleSelect').value = '';
        }

        function revokeRole(memberId, role) {
            const roleName = role === 'subleader' ? '부모임장' : '도우미';
            if (confirm(roleName + ' 권한을 해제하시겠습니까?')) {
                alert('권한이 해제되었습니다.');
            }
        }

        function selectTransferTarget(memberId, memberName) {
            currentMemberId = memberId;
            currentMemberName = memberName;
            document.getElementById('transferTargetName').textContent = memberName;
            openModal('transferModal');
        }

        function confirmTransfer() {
            if (confirm('정말 ' + currentMemberName + '님에게 모임장 권한을 이양하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) {
                alert('모임장 권한이 이양되었습니다.\n일반 모임원으로 전환됩니다.');
                closeModal('transferModal');
                // 실제로는 서버 처리 후 메인 페이지로 이동
                // window.location.href = 'group_home.jsp';
            }
        }

        function openModal(modalId) {
            document.getElementById(modalId).classList.add('active');
        }

        function closeModal(modalId) {
            document.getElementById(modalId).classList.remove('active');
        }

        // 모달 외부 클릭 시 닫기
        window.onclick = function(event) {
            if (event.target.classList.contains('modal')) {
                event.target.classList.remove('active');
            }
        }
    </script>
</body>
</html>