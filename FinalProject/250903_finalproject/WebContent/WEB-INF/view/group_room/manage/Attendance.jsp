<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 출석 관리</title>
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
            max-width: 1600px;
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
            margin-top: 10px;
        }

        /* 필터 및 액션 바 */
        .action-bar {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        .filter-group {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .filter-label {
            font-weight: 600;
            color: #333;
            font-size: 14px;
        }
        .filter-select {
            padding: 8px 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .filter-select:focus {
            outline: none;
            border-color: #8bc683;
        }
        .btn-save {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-save:hover {
            background: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }
        .btn-save:disabled {
            background: #e0e0e0;
            color: #999;
            cursor: not-allowed;
            transform: none;
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
        .stat-icon {
            font-size: 32px;
            margin-bottom: 10px;
        }
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 5px;
        }
        .stat-label {
            font-size: 14px;
            color: #666;
        }

        /* 출석 테이블 */
        .attendance-section {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        .section-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .attendance-table {
            width: 100%;
            border-collapse: collapse;
        }
        .attendance-table thead {
            background: #f8faf8;
        }
        .attendance-table th {
            padding: 15px 10px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #e0e0e0;
            font-size: 14px;
        }
        .attendance-table th:first-child {
            padding-left: 20px;
        }
        .attendance-table td {
            padding: 15px 10px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }
        .attendance-table td:first-child {
            padding-left: 20px;
        }
        .attendance-table tbody tr {
            transition: background 0.3s;
        }
        .attendance-table tbody tr:hover {
            background: #f8faf8;
        }
        .member-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .member-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #8bc683;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 16px;
        }
        .member-name {
            font-weight: 600;
            color: #333;
        }
        .member-role {
            font-size: 12px;
            color: #999;
        }
        .attendance-status {
            display: flex;
            gap: 8px;
        }
        .status-btn {
            padding: 6px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            background: white;
            color: #666;
        }
        .status-btn:hover {
            border-color: #8bc683;
        }
        .status-btn.active.present {
            background: #4CAF50;
            color: white;
            border-color: #4CAF50;
        }
        .status-btn.active.absent {
            background: #f44336;
            color: white;
            border-color: #f44336;
        }
        .status-btn.active.late {
            background: #ff9800;
            color: white;
            border-color: #ff9800;
        }
        .rate-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
        }
        .rate-high {
            background: #e8f5e9;
            color: #2e7d32;
        }
        .rate-medium {
            background: #fff3e0;
            color: #e65100;
        }
        .rate-low {
            background: #ffebee;
            color: #c62828;
        }
        .memo-input {
            width: 100%;
            padding: 6px 10px;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            font-size: 13px;
        }
        .memo-input:focus {
            outline: none;
            border-color: #8bc683;
        }

        /* 이력 테이블 */
        .history-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .history-table th,
        .history-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }
        .history-table th {
            background: #f8faf8;
            font-weight: 600;
            color: #333;
        }
        .history-date {
            font-weight: 600;
            color: #333;
        }
        .history-type {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 600;
        }
        .type-regular {
            background: #e3f2fd;
            color: #1976d2;
        }
        .type-irregular {
            background: #f3e5f5;
            color: #7b1fa2;
        }

        /* 빈 상태 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        .empty-state-icon {
            font-size: 60px;
            margin-bottom: 15px;
        }
        .empty-state-text {
            font-size: 16px;
        }

        /* 알림 메시지 */
        .alert-info {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
            color: #1565c0;
        }

        @media (max-width: 768px) {
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
            .attendance-table {
                font-size: 12px;
            }
            .attendance-table th,
            .attendance-table td {
                padding: 10px 5px;
            }
            .status-btn {
                padding: 4px 10px;
                font-size: 11px;
            }
        }
    </style>
    <script>
        // 출석 데이터 (서버에서 전달받아야 함)
        const attendanceData = {};
        let hasChanges = false;

        function setAttendance(memberId, status) {
            if (!attendanceData[memberId]) {
                attendanceData[memberId] = {};
            }
            attendanceData[memberId].status = status;
            
            // 버튼 활성화 상태 변경
            const buttons = document.querySelectorAll(`[data-member="${memberId}"]`);
            buttons.forEach(btn => {
                btn.classList.remove('active', 'present', 'absent', 'late');
                if (btn.getAttribute('data-status') === status) {
                    btn.classList.add('active', status);
                }
            });
            
            hasChanges = true;
            document.getElementById('saveBtn').disabled = false;
        }

        function setMemo(memberId, memo) {
            if (!attendanceData[memberId]) {
                attendanceData[memberId] = {};
            }
            attendanceData[memberId].memo = memo;
            hasChanges = true;
            document.getElementById('saveBtn').disabled = false;
        }

        function saveAttendance() {
            if (!hasChanges) {
                alert('변경된 내용이 없습니다.');
                return;
            }

            const meetingDate = document.getElementById('meetingSelect').value;
            if (!meetingDate) {
                alert('모임 일정을 선택해주세요.');
                return;
            }

            // 서버로 전송
            console.log('저장할 데이터:', {
                meetingDate: meetingDate,
                attendance: attendanceData
            });

            alert('출석이 저장되었습니다.');
            hasChanges = false;
            document.getElementById('saveBtn').disabled = true;
        }

        function filterByStatus() {
            const status = document.getElementById('statusFilter').value;
            const rows = document.querySelectorAll('.attendance-table tbody tr');
            
            rows.forEach(row => {
                if (status === 'all') {
                    row.style.display = '';
                } else {
                    const activeBtn = row.querySelector(`.status-btn.active.${status}`);
                    row.style.display = activeBtn ? '' : 'none';
                }
            });
        }

        function loadMeetingAttendance() {
            const meetingId = document.getElementById('meetingSelect').value;
            if (!meetingId) return;
            
            // 서버에서 해당 모임의 출석 데이터를 불러옴
            alert('모임 일정의 출석 데이터를 불러옵니다.');
            // 실제로는 AJAX로 데이터를 불러와서 표시
        }

        function goBack() {
            if (hasChanges) {
                if (confirm('저장하지 않은 변경사항이 있습니다. 정말 나가시겠습니까?')) {
                    window.location.href = 'group_management.jsp';
                }
            } else {
                window.location.href = 'group_management.jsp';
            }
        }

        function viewHistory(memberId) {
            window.location.href = 'member_attendance_history.jsp?memberId=' + memberId;
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
                        <span>📋</span>
                        <span>출석 관리</span>
                    </div>
                    <div class="group-name">알고리즘 정복 스터디</div>
                </div>
                <button class="btn-back" onclick="goBack()">← 관리 메뉴로</button>
            </div>
        </div>

        <!-- 알림 -->
        <div class="alert-info">
            ℹ️ 출석 변경은 해당 모임의 종료 시간까지만 가능합니다. 모임원의 출석/결석 상태를 체크하고 저장해주세요.
        </div>

        <!-- 통계 -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">👥</div>
                <div class="stat-value">7명</div>
                <div class="stat-label">전체 모임원</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-value">85%</div>
                <div class="stat-label">평균 출석률</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-value">12회</div>
                <div class="stat-label">누적 모임 횟수</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🎯</div>
                <div class="stat-value">6명</div>
                <div class="stat-label">평균 참석 인원</div>
            </div>
        </div>

        <!-- 필터 및 액션 -->
        <div class="action-bar">
            <div style="display: flex; gap: 20px; flex-wrap: wrap;">
                <div class="filter-group">
                    <span class="filter-label">모임 일정:</span>
                    <select id="meetingSelect" class="filter-select" onchange="loadMeetingAttendance()">
                        <option value="">선택하세요</option>
                        <option value="2024-10-17">2024-10-17 (목) 19:00 - 정기 모임</option>
                        <option value="2024-10-10">2024-10-10 (목) 19:00 - 정기 모임</option>
                        <option value="2024-10-03">2024-10-03 (목) 19:00 - 정기 모임</option>
                    </select>
                </div>
                <div class="filter-group">
                    <span class="filter-label">출석 상태:</span>
                    <select id="statusFilter" class="filter-select" onchange="filterByStatus()">
                        <option value="all">전체</option>
                        <option value="present">출석</option>
                        <option value="absent">결석</option>
                        
                    </select>
                </div>
            </div>
            <button id="saveBtn" class="btn-save" onclick="saveAttendance()" disabled>💾 저장하기</button>
        </div>

        <!-- 출석 체크 -->
        <div class="attendance-section">
            <div class="section-title">
                <span>출석 체크</span>
                <span style="font-size: 14px; color: #666; font-weight: normal;">
                    출석 상태를 선택하고 필요시 메모를 남겨주세요
                </span>
            </div>

            <table class="attendance-table">
                <thead>
                    <tr>
                        <th>모임원</th>
                        <th>출석 상태</th>
                        <th>누적 출석률</th>
                        <th>메모</th>
                        <th>이력</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="member-info">
                                <div class="member-avatar">코</div>
                                <div>
                                    <div class="member-name">코딩마스터</div>
                                    <div class="member-role">모임장</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="attendance-status">
                                <button class="status-btn" data-member="1" data-status="present" onclick="setAttendance(1, 'present')">출석</button>
                                
                                <button class="status-btn" data-member="1" data-status="absent" onclick="setAttendance(1, 'absent')">결석</button>
                            </div>
                        </td>
                        <td><span class="rate-badge rate-high">92%</span></td>
                        <td><input type="text" class="memo-input" placeholder="메모 입력..." onchange="setMemo(1, this.value)"></td>
                        <td><button class="status-btn" onclick="viewHistory(1)">보기</button></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="member-info">
                                <div class="member-avatar">개</div>
                                <div>
                                    <div class="member-name">개발자지망생</div>
                                    <div class="member-role">모임원</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="attendance-status">
                                <button class="status-btn" data-member="2" data-status="present" onclick="setAttendance(2, 'present')">출석</button>
                                
                                <button class="status-btn" data-member="2" data-status="absent" onclick="setAttendance(2, 'absent')">결석</button>
                            </div>
                        </td>
                        <td><span class="rate-badge rate-high">88%</span></td>
                        <td><input type="text" class="memo-input" placeholder="메모 입력..." onchange="setMemo(2, this.value)"></td>
                        <td><button class="status-btn" onclick="viewHistory(2)">보기</button></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="member-info">
                                <div class="member-avatar">알</div>
                                <div>
                                    <div class="member-name">알고리즘초보</div>
                                    <div class="member-role">모임원</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="attendance-status">
                                <button class="status-btn" data-member="3" data-status="present" onclick="setAttendance(3, 'present')">출석</button>
                               
                                <button class="status-btn" data-member="3" data-status="absent" onclick="setAttendance(3, 'absent')">결석</button>
                            </div>
                        </td>
                        <td><span class="rate-badge rate-medium">75%</span></td>
                        <td><input type="text" class="memo-input" placeholder="메모 입력..." onchange="setMemo(3, this.value)"></td>
                        <td><button class="status-btn" onclick="viewHistory(3)">보기</button></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="member-info">
                                <div class="member-avatar">자</div>
                                <div>
                                    <div class="member-name">자바마스터</div>
                                    <div class="member-role">모임원</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="attendance-status">
                                <button class="status-btn" data-member="4" data-status="present" onclick="setAttendance(4, 'present')">출석</button>
                               
                                <button class="status-btn" data-member="4" data-status="absent" onclick="setAttendance(4, 'absent')">결석</button>
                            </div>
                        </td>
                        <td><span class="rate-badge rate-high">90%</span></td>
                        <td><input type="text" class="memo-input" placeholder="메모 입력..." onchange="setMemo(4, this.value)"></td>
                        <td><button class="status-btn" onclick="viewHistory(4)">보기</button></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="member-info">
                                <div class="member-avatar">파</div>
                                <div>
                                    <div class="member-name">파이썬러버</div>
                                    <div class="member-role">모임원</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="attendance-status">
                                <button class="status-btn" data-member="5" data-status="present" onclick="setAttendance(5, 'present')">출석</button>
                              
                                <button class="status-btn" data-member="5" data-status="absent" onclick="setAttendance(5, 'absent')">결석</button>
                            </div>
                        </td>
                        <td><span class="rate-badge rate-high">83%</span></td>
                        <td><input type="text" class="memo-input" placeholder="메모 입력..." onchange="setMemo(5, this.value)"></td>
                        <td><button class="status-btn" onclick="viewHistory(5)">보기</button></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="member-info">
                                <div class="member-avatar">웹</div>
                                <div>
                                    <div class="member-name">웹개발자</div>
                                    <div class="member-role">모임원</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="attendance-status">
                                <button class="status-btn" data-member="6" data-status="present" onclick="setAttendance(6, 'present')">출석</button>
                               
                                <button class="status-btn" data-member="6" data-status="absent" onclick="setAttendance(6, 'absent')">결석</button>
                            </div>
                        </td>
                        <td><span class="rate-badge rate-low">65%</span></td>
                        <td><input type="text" class="memo-input" placeholder="메모 입력..." onchange="setMemo(6, this.value)"></td>
                        <td><button class="status-btn" onclick="viewHistory(6)">보기</button></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="member-info">
                                <div class="member-avatar">스</div>
                                <div>
                                    <div class="member-name">스프링초보</div>
                                    <div class="member-role">모임원</div>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="attendance-status">
                                <button class="status-btn" data-member="7" data-status="present" onclick="setAttendance(7, 'present')">출석</button>
                                
                                <button class="status-btn" data-member="7" data-status="absent" onclick="setAttendance(7, 'absent')">결석</button>
                            </div>
                        </td>
                        <td><span class="rate-badge rate-high">80%</span></td>
                        <td><input type="text" class="memo-input" placeholder="메모 입력..." onchange="setMemo(7, this.value)"></td>
                        <td><button class="status-btn" onclick="viewHistory(7)">보기</button></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>