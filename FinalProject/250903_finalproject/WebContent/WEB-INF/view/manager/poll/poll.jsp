<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 통계 및 리스트</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', 'Malgun Gothic', sans-serif;
            background: linear-gradient(135deg, #c1fba4, #a589f5);
            color: #333;
            line-height: 1.6;
            min-height: 100vh;
            padding: 40px;
        }
        .inner-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            background: #f8f8f8;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }
        .section { margin-bottom: 40px; }
        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 24px;
            font-weight: 700;
        }
        .tab-menu {
            margin-bottom: 20px;
            gap: 10px;
            display: flex;
        }
        .tab-btn {
            padding: 10px 20px;
            border-radius: 6px;
            background: #e0e0e0;
            cursor: pointer;
            transition: 0.3s;
            border: none;
            font-size: 16px;
        }
        .tab-btn.active {
            background: #8b5cf6;
            color: #fff;
        }
        .tab-content { display: none; }
        .tab-content.active { display: block; }
        .stats-summary {
            display: flex;
            justify-content: space-around;
            background: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            border: 1px solid #ddd;
        }
        .stat-item {
            text-align: center;
            padding: 0 15px;
        }
        .stat-label {
            font-size: 14px;
            color: #666;
            margin-bottom: 5px;
        }
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #8b5cf6;
        }
        .filter-area {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
            padding: 15px;
            background: #eee;
            border-radius: 8px;
        }
        .filter-area label {
            font-weight: 600;
            margin-right: 5px;
        }
        .filter-area select, .filter-area input[type="text"] {
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .filter-area .checkbox-group {
            display: flex;
            align-items: center;
            gap: 5px;
        }
        .filter-area .checkbox-group input[type="checkbox"] {
            transform: scale(1.2);
        }
        .filter-area button {
            padding: 8px 15px;
            background: #8b5cf6;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: 0.2s;
        }
        .filter-area button:hover {
            background: #7c4dff;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }
        table th {
            background: #8b5cf6;
            color: #fff;
            font-weight: 600;
        }
        .table-cell-center { text-align: center; }
        .mb-md { margin-bottom: 20px; }
        h3 {
            font-size: 20px;
            margin-bottom: 15px;
            border-left: 4px solid #8b5cf6;
            padding-left: 10px;
        }
        /* 추가: 클릭 가능 요소 스타일 */
        .member-link {
            color: #8b5cf6;
            text-decoration: underline;
            cursor: pointer;
        }
        .member-link:hover {
            color: #7c4dff;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        $(document).ready(function() {
            // 탭 버튼 클릭 시
            $('.tab-btn').click(function() {
                const tabId = $(this).data('tab');
                $('.tab-btn').removeClass('active');
                $('.tab-content').removeClass('active');
                $(this).addClass('active');
                $('#' + tabId).addClass('active');
            });

            // 기본 탭 활성화 (첫 번째 탭)
            $('.tab-btn').first().click();
        });
        
        // 함수: 회원 상세 페이지 이동 (회원 ID가 필요하다고 가정)
        function goToUserDetail(memberId) {
            // 실제 구현 시 memberId를 파라미터로 넘겨서 상세 정보를 조회해야 합니다.
            // 예: ${cp}/user/UserDetail.jsp?id=' + memberId
            location.href = '${cp}/user/UserDetail.jsp?id=' + memberId;
        }
    </script>
</head>

<body>
    <div class="inner-wrapper">
        <div class="content">
            <section class="section">
                <div class="section-header">
                    <h2 class="section-title">📊 관리자 통계 및 회원 관리</h2>
                </div>

                <div class="tab-menu mb-md">
                    <button class="tab-btn" data-tab="tab-group">모임 탈퇴 관리</button>
                    <button class="tab-btn" data-tab="tab-app">어플리케이션 탈퇴 관리</button>
                    <button class="tab-btn" data-tab="tab-report">신고 통계 및 관리</button>
                </div>

                <div id="tab-group" class="tab-content">
                    <h3>👥 모임 탈퇴 통계 및 리스트</h3>
                    
                    <div class="stats-summary">
                        <div class="stat-item">
                            <div class="stat-label">총 모임 탈퇴 회원수</div>
                            <div class="stat-value">5</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">전체 회원수</div>
                            <div class="stat-value" style="color:#333;">1250</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">탈퇴율 (모임 기준)</div>
                            <div class="stat-value" style="color:#d9534f;">0.4%</div>
                        </div>
                    </div>

                    <div class="filter-area">
                        <label for="group-withdrawal-reason">탈퇴 사유:</label>
                        <select id="group-withdrawal-reason">
                            <option value="">전체 사유</option>
                            <option value="시간 부족">시간 부족</option>
                            <option value="개인 사정">개인 사정</option>
                            <option value="활동 불만">활동 불만</option>
                            <option value="모임 분위기">모임 분위기</option>
                            <option value="기타">기타</option>
                        </select>
                        <button type="button">검색</button>
                    </div>

                    <table class="table">
                        <thead>
                            <tr>
                                <th class="table-cell-center">No</th>
                                <th>회원명</th>
                                <th>모임명</th>
                                <th>탈퇴 사유</th>
                                <th>탈퇴일</th>
                            </tr>
                        </thead>
                        <tbody id="group-withdrawal-tbody">
                            <tr>
                                <td class="table-cell-center">1</td>
                                <td><a class="member-link" href="userdetail.do?memberId=m101">김철수</a></td>
                                 
                                <td>등산 동호회</td>
                                <td>시간 부족</td>
                                <td>2025-10-10 14:30</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">2</td>
                                <td><a class="member-link" href="userdetail.do?memberId=m102">이영희</a></td>
                                <td>스터디 모임</td>
                                <td>개인 사정</td>
                                <td>2025-10-14 09:20</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">3</td>
                                <td><a class="member-link" href="userdetail.do?memberId=m103">박민수</a></td>
                                <td>게임 커뮤니티</td>
                                <td>활동 불만</td>
                                <td>2025-10-21 17:40</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">4</td>
                                <td><a class="member-link" href="userdetail.do?memberId=m104">최수지</a></td>
                                <td>독서 모임</td>
                                <td>시간 부족</td>
                                <td>2025-10-25 11:15</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">5</td>
                                <td><a class="member-link" href="userdetail.do?memberId=m105">장동건</a></td>
                                <td>영화 감상</td>
                                <td>모임 분위기</td>
                                <td>2025-10-28 16:55</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="tab-app" class="tab-content">
                    <h3>📱 어플리케이션 탈퇴 통계 및 리스트</h3>
                    
                    <div class="stats-summary">
                        <div class="stat-item">
                            <div class="stat-label">총 어플리케이션 탈퇴 회원수</div>
                            <div class="stat-value">5</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">전체 회원수</div>
                            <div class="stat-value" style="color:#333;">1250</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">탈퇴율 (앱 기준)</div>
                            <div class="stat-value" style="color:#d9534f;">0.4%</div>
                        </div>
                    </div>

                    <div class="filter-area">
                        <label for="app-withdrawal-reason">탈퇴 사유:</label>
                        <select id="app-withdrawal-reason">
                            <option value="">전체 사유</option>
                            <option value="이용 불편">이용 불편</option>
                            <option value="잦은 오류">잦은 오류</option>
                            <option value="기능 부족">기능 부족</option>
                            <option value="개인 정보 문제">개인 정보 문제</option>
                            <option value="사용 빈도 감소">사용 빈도 감소</option>
                        </select>
                        <button type="button">검색</button>
                    </div>

                    <table class="table">
                        <thead>
                            <tr>
                                <th class="table-cell-center">No</th>
                                <th>회원명</th>
                                <th>이메일</th>
                                <th>탈퇴 사유</th>
                                <th>탈퇴일</th>
                            </tr>
                        </thead>
                        <tbody id="app-withdrawal-tbody">
                            <tr>
                                <td class="table-cell-center">1</td>
                                <td><a class="member-link" href="userdetail.do?memberId=a201">홍길동</a></td>
                                <td>hong@example.com</td>
                                <td>이용 불편</td>
                                <td>2025-10-01 11:10</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">2</td>
                                <td><a class="member-link" href="userdetail.do?memberId=a202">이수진</a></td>
                                <td>soo@example.com</td>
                                <td>잦은 오류</td>
                                <td>2025-10-11 13:45</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">3</td>
                                <td><a class="member-link" href="userdetail.do?memberId=a203">정우성</a></td>
                                <td>woo@example.com</td>
                                <td>기능 부족</td>
                                <td>2025-10-25 09:50</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">4</td>
                                <td><a class="member-link" href="userdetail.do?memberId=a204">김태희</a></td>
                                <td>th@example.com</td>
                                <td>개인 정보 문제</td>
                                <td>2025-10-26 10:00</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">5</td>
                                <td><a class="member-link" href="userdetail.do?memberId=a205">원빈</a></td>
                                <td>wb@example.com</td>
                                <td>사용 빈도 감소</td>
                                <td>2025-10-27 15:20</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="tab-report" class="tab-content">
                    <h3>🚨 신고 통계 및 리스트</h3>
                    
                    <div class="stats-summary">
                        <div class="stat-item">
                            <div class="stat-label">총 신고 건수</div>
                            <div class="stat-value">5</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">미처리 건수</div>
                            <div class="stat-value" style="color:#ffc107;">1</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-label">처리 완료 건수</div>
                            <div class="stat-value" style="color:#28a745;">4</div>
                        </div>
                    </div>

                    <div class="filter-area">
                        <label for="report-type">신고 구분:</label>
                        <select id="report-type">
                            <option value="">전체 구분</option>
                            <option value="회원">회원</option>
                            <option value="컨텐츠">컨텐츠</option>
                            <option value="모임">모임</option>
                        </select>

                        <label for="report-reason">신고 사유:</label>
                        <select id="report-reason">
                            <option value="">전체 사유</option>
                            <option value="욕설 포함">욕설 포함</option>
                            <option value="도배 행위">도배 행위</option>
                            <option value="불법 홍보">불법 홍보</option>
                            <option value="음란물">음란물</option>
                            <option value="개인 정보 침해">개인 정보 침해</option>
                        </select>

                        <div class="checkbox-group">
                            <label>신고자:</label>
                            <input type="checkbox" id="reporter-exclude-withdrawal" checked>
                            <label for="reporter-exclude-withdrawal">탈퇴회원 제외</label>
                        </div>
                        <div class="checkbox-group">
                            <label>피신고자:</label>
                            <input type="checkbox" id="reported-exclude-withdrawal" checked>
                            <label for="reported-exclude-withdrawal">탈퇴회원 제외</label>
                        </div>
                        
                        <button type="button">검색</button>
                    </div>

                    <table class="table">
                        <thead>
                            <tr>
                                <th class="table-cell-center">No</th>
                                <th>구분</th>
                                <th>사유</th>
                                <th>신고자</th>
                                <th>피신고자</th>
                                <th>날짜</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody id="report-tbody">
                            <tr>
                                <td class="table-cell-center">1</td>
                                <td>회원</td>
                                <td>욕설 포함</td>
                                
                                <td><a class="member-link" href="userdetail.do?memberId=r301">김하늘</a></td>
                                <td><span class="member-link" onclick="goToUserDetail('r302')">박하늘</span></td>
                                <td>2025-10-02 15:30</td>
                                <td>처리 완료</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">2</td>
                                <td>컨텐츠</td>
                                <td>도배 행위</td>
                                <td><span class="member-link" onclick="goToUserDetail('r303')">최민준</span></td>
                                <td><span class="member-link" onclick="goToUserDetail('r304')">윤아라</span></td>
                                <td>2025-10-05 12:20</td>
                                <td>처리 중</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">3</td>
                                <td>회원</td>
                                <td>불법 홍보</td>
                                <td><span class="member-link" onclick="goToUserDetail('r305')">박진수</span></td>
                                <td><span class="member-link" onclick="goToUserDetail('r306')">이해나</span></td>
                                <td>2025-10-07 19:00</td>
                                <td>삭제 완료</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">4</td>
                                <td>컨텐츠</td>
                                <td>음란물</td>
                                <td><span class="member-link" onclick="goToUserDetail('r307')">한지민</span></td>
                                <td><span class="member-link" onclick="goToUserDetail('r308')">김동현</span></td>
                                <td>2025-10-15 08:40</td>
                                <td>삭제 완료</td>
                            </tr>
                            <tr>
                                <td class="table-cell-center">5</td>
                                <td>모임</td>
                                <td>회원간이슈</td>
                                <td><span class="member-link" onclick="goToUserDetail('r309')">임수정</span></td>
                                <td><span class="member-link" onclick="goToUserDetail('r310')">강하늘</span></td>
                                <td>2025-10-22 14:10</td>
                                <td>처리 완료</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>
</body>
</html>