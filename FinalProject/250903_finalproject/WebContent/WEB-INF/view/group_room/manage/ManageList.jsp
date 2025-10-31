<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 관리</title>
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

        /* 헤더 */
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
        .role-badge {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
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

        /* 관리 메뉴 그리드 */
        .management-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }
        .management-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
            cursor: pointer;
            border: 2px solid transparent;
            position: relative;
        }
        .management-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            border-color: #8bc683;
        }
        .management-card.disabled {
            opacity: 0.5;
            cursor: not-allowed;
            pointer-events: none;
        }
        .card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #8bc683 0%, #6ba562 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(139, 198, 131, 0.3);
        }
        .card-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 10px;
        }
        .card-description {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
        }
        .permission-badge {
            display: inline-block;
            background: #e3f2fd;
            color: #1976d2;
            padding: 4px 8px;
            border-radius: 10px;
            font-size: 11px;
            font-weight: 600;
            margin-top: 8px;
        }

        /* 섹션 구분 */
        .section {
            margin-bottom: 40px;
        }
        .section-title {
            font-size: 24px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .section-divider {
            height: 3px;
            background: linear-gradient(90deg, #8bc683 0%, transparent 100%);
            margin-bottom: 20px;
        }

        /* 통계 카드 */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            text-align: center;
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

        /* 위험 영역 */
        .danger-zone {
            background: #fff5f5;
            border: 2px solid #ffebee;
            border-radius: 12px;
            padding: 30px;
            margin-top: 40px;
        }
        .danger-title {
            font-size: 20px;
            font-weight: bold;
            color: #d32f2f;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .danger-description {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        .btn-danger {
            background: #f44336;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-danger:hover {
            background: #d32f2f;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(244, 67, 54, 0.3);
        }

        @media (max-width: 768px) {
            .management-grid {
                grid-template-columns: 1fr;
            }
            .page-header {
                padding: 25px 20px;
            }
            .page-title {
                font-size: 24px;
            }
            .header-top {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
        }
    </style>
    <script>
        // 현재 사용자 권한 (서버에서 전달받아야 함)
        const userRole = 'leader'; // leader, subleader, helper

        function goToMemberManagement() {
            window.location.href = 'member_management.jsp';
        }

        function goToAttendanceManagement() {
            window.location.href = 'attendance_management.jsp';
        }

        function goToGroupEdit() {
            window.location.href = 'group_edit.jsp';
        }

        function goToApplicationManagement() {
            window.location.href = 'application_management.jsp';
        }

        function closeGroup() {
            if(confirm('정말 모임을 폐쇄하시겠습니까?\n모든 모임원이 탈퇴되며 복구할 수 없습니다.')) {
                const reason = prompt('폐쇄 사유를 입력해주세요:');
                if(reason && reason.trim()) {
                    alert('모임이 폐쇄되었습니다.');
                    window.location.href = 'group_list.jsp';
                }
            }
        }

        function goBack() {
            window.location.href = 'group_home.jsp';
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
                        <span>⚙️</span>
                        <span>모임 관리</span>
                        <span class="role-badge">모임장</span>
                    </div>
                    <div class="group-name">알고리즘 정복 스터디</div>
                </div>
                <button class="btn-back" onclick="location.href='home.do'">← 뒤로 가기</button>
            </div>
        </div>

        <!-- 모임 통계 -->
        <div class="section">
            <div class="section-title">📊 모임 현황</div>
            <div class="section-divider"></div>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-value">7/10</div>
                    <div class="stat-label">현재 모임원</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">3</div>
                    <div class="stat-label">대기 중인 신청</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">85%</div>
                    <div class="stat-label">평균 출석률</div>
                </div>
                <div class="stat-card">
                    <div class="stat-value">Lv.3</div>
                    <div class="stat-label">모임 레벨</div>
                </div>
            </div>
        </div>

        <!-- 모임원 관리 -->
        <div class="section">
            <div class="section-title">👥 모임원 관리</div>
            <div class="section-divider"></div>
            <div class="management-grid">
                <div class="management-card" onclick="location.href='membermanage.do'">
                    <div class="card-icon">👥</div>
                    <div class="card-title">모임원 및 권한 관리</div>
                    <div class="card-description">
                        모임원 목록 조회, 권한 부여(부모임장/도우미), 강제 퇴장 등을 관리합니다.
                    </div>
                    <span class="permission-badge">모임장 전용</span>
                </div>

                <div class="management-card" onclick="location.href='applicant.do'">
                    <div class="card-icon">📝</div>
                    <div class="card-title">가입 신청 관리</div>
                    <div class="card-description">
                        가입 신청자의 정보를 확인하고 승인/거절을 처리합니다.
                    </div>
                    <span class="permission-badge">모임장 이상</span>
                </div>

                <div class="management-card" onclick="location.href='attendance.do'">
                    <div class="card-icon">📋</div>
                    <div class="card-title">출석 관리</div>
                    <div class="card-description">
                        모임원의 출석/결석을 체크하고 출석률을 관리합니다.
                    </div>
                    <span class="permission-badge">부모임장 이상</span>
                </div>
            </div>
        </div>

        <!-- 모임 설정 -->
        <div class="section">
            <div class="section-title">⚙️ 모임 설정</div>
            <div class="section-divider"></div>
            <div class="management-grid">
                <div class="management-card" onclick="location.href='groupcreatemodify.do'">
                    <div class="card-icon">✏️</div>
                    <div class="card-title">모임 정보 수정</div>
                    <div class="card-description">
                        모임 이름, 설명, 규칙, 난이도 등 기본 정보를 수정합니다.
                    </div>
                    <span class="permission-badge">모임장 전용</span>
                </div>
            </div>
        </div>

        <!-- 위험 영역 -->
        <div class="danger-zone">
            <div class="danger-title">
                <span>⚠️</span>
                <span>위험 영역</span>
            </div>
            <div class="danger-description">
                아래 작업은 되돌릴 수 없습니다. 신중하게 결정해주세요.
            </div>
            <button class="btn-danger" onclick="closeGroup()">
                🗑️ 모임 폐쇄
            </button>
            <p style="font-size: 13px; color: #999; margin-top: 10px;">
                모임 폐쇄 시 모든 모임원이 탈퇴 처리되며, 게시글과 활동 내역은 삭제됩니다.
            </p>
        </div>
    </div>
</body>
</html>