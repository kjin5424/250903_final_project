<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 모임 작성글 목록</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #E9D9FF;
            padding: 40px 30px;
        }

        .header {
            background-color: #BFFCC6;
            padding: 20px;
            border-radius: 15px;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .container {
            background-color: #fff;
            padding: 25px;
            border-radius: 20px;
            max-width: 1400px;
            margin: 0 auto;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        /* 정보 헤더 */
        .info-header {
            background-color: #F5F5F5;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .info-header-left {
            display: flex;
            gap: 30px;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-label {
            font-weight: bold;
            color: #666;
        }

        .info-value {
            color: #333;
            font-weight: 600;
        }

        /* 액션 바 */
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .select-info {
            font-size: 14px;
            color: #666;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .button {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
        }

        .btn-delete {
            background-color: #FFB3BA;
            color: #333;
        }

        .btn-back {
            background-color: #BFFCC6;
            color: #333;
        }

        .button:hover {
            opacity: 0.8;
        }

        .button:disabled {
            background-color: #ddd;
            cursor: not-allowed;
            opacity: 0.6;
        }

        /* 테이블 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #BFFCC6;
            font-weight: bold;
            color: #333;
        }

        tbody tr:nth-child(odd) {
            background-color: #E6D6FF;
        }

        tbody tr:nth-child(even) {
            background-color: #F0E8FF;
        }

        tbody tr:hover {
            background-color: #D5C5EE;
        }

        /* 체크박스 */
        .checkbox-cell {
            width: 50px;
        }

        input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        /* 제목 열 */
        .title-cell {
            text-align: left;
            max-width: 400px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .title-link {
            color: #333;
            text-decoration: none;
        }

        .title-link:hover {
            color: #1976D2;
            text-decoration: underline;
        }

        /* 결과 카운트 */
        .result-count {
            margin-bottom: 15px;
            font-size: 14px;
            color: #666;
        }

        .count-number {
            color: #1976D2;
            font-weight: bold;
        }

        /* 빈 상태 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="header">회원 모임 작성글 목록</div>
    <div class="container">
        <!-- 정보 헤더 -->
        <div class="info-header">
            <div class="info-header-left">
                <div class="info-item">
                    <span class="info-label">회원:</span>
                    <span class="info-value">홍길동 (user001)</span>
                </div>
                <div class="info-item">
                    <span class="info-label">모임:</span>
                    <span class="info-value">Java 스터디</span>
                </div>
                <div class="info-item">
                    <span class="info-label">활동기간:</span>
                    <span class="info-value">2024-01-20 ~ 현재</span>
                </div>
            </div>
        </div>

        <!-- 결과 수 -->
        <div class="result-count">
            총 <span class="count-number">5</span>개의 게시글
        </div>

        <!-- 액션 바 -->
        <div class="action-bar">
            <div class="select-info">
                <span id="selectedCount">0</span>개 선택됨
            </div>
            <div class="action-buttons">
                <button class="button btn-delete" id="deleteBtn" onclick="deleteSelected()" disabled>선택 삭제</button>
                <button class="button btn-back" onclick="history.back()">이전으로</button>
            </div>
        </div>

        <!-- 작성글 테이블 -->
        <table>
            <thead>
                <tr>
                    <th class="checkbox-cell">
                        <input type="checkbox" id="selectAll" onchange="toggleSelectAll()">
                    </th>
                    <th>번호</th>
                    <th>게시판 이름</th>
                    <th>제목</th>
                    <th>작성일자</th>
                    <th>조회수</th>
                    <th>댓글수</th>
                </tr>
            </thead>
            <tbody id="postTableBody">
                <tr>
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="1" onchange="updateSelectCount()">
                    </td>
                    <td>5</td>
                    <td>자유게시판</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">Java 스터디 2주차 후기 공유합니다</a>
                    </td>
                    <td>2024-02-05</td>
                    <td>156</td>
                    <td>12</td>
                </tr>
                <tr>
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="2" onchange="updateSelectCount()">
                    </td>
                    <td>4</td>
                    <td>질문게시판</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">Optional 사용법 질문드립니다</a>
                    </td>
                    <td>2024-02-10</td>
                    <td>89</td>
                    <td>8</td>
                </tr>
                <tr>
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="3" onchange="updateSelectCount()">
                    </td>
                    <td>3</td>
                    <td>자료실</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">Spring Boot 입문 자료 공유</a>
                    </td>
                    <td>2024-03-15</td>
                    <td>234</td>
                    <td>25</td>
                </tr>
                <tr>
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="4" onchange="updateSelectCount()">
                    </td>
                    <td>2</td>
                    <td>자유게시판</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">이번주 스터디 일정 변경 공지</a>
                    </td>
                    <td>2024-04-20</td>
                    <td>178</td>
                    <td>15</td>
                </tr>
                <tr>
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="5" onchange="updateSelectCount()">
                    </td>
                    <td>1</td>
                    <td>질문게시판</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">Stream API 성능 최적화 방법 궁금합니다</a>
                    </td>
                    <td>2024-05-12</td>
                    <td>145</td>
                    <td>18</td>
                </tr>
            </tbody>
        </table>

        <!-- 빈 상태 (게시글이 없을 때) -->
        <!-- <div class="empty-state">
            <div class="empty-state-icon">📝</div>
            <p>작성한 게시글이 없습니다.</p>
        </div> -->
    </div>

    <script>
        // 전체 선택/해제
        function toggleSelectAll() {
            var selectAll = document.getElementById('selectAll');
            var checkboxes = document.querySelectorAll('.post-checkbox');
            
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = selectAll.checked;
            });
            
            updateSelectCount();
        }

        // 선택 개수 업데이트
        function updateSelectCount() {
            var checkboxes = document.querySelectorAll('.post-checkbox:checked');
            var count = checkboxes.length;
            var totalCheckboxes = document.querySelectorAll('.post-checkbox').length;
            
            document.getElementById('selectedCount').textContent = count;
            
            // 삭제 버튼 활성화/비활성화
            var deleteBtn = document.getElementById('deleteBtn');
            deleteBtn.disabled = count === 0;
            
            // 전체 선택 체크박스 상태 업데이트
            var selectAll = document.getElementById('selectAll');
            selectAll.checked = count === totalCheckboxes && count > 0;
        }

        // 선택 삭제
        function deleteSelected() {
            var checkboxes = document.querySelectorAll('.post-checkbox:checked');
            var count = checkboxes.length;
            
            if(count === 0) {
                alert('삭제할 게시글을 선택해주세요.');
                return;
            }
            
            if(confirm(count + '개의 게시글을 삭제하시겠습니까?')) {
                var postIds = [];
                checkboxes.forEach(function(checkbox) {
                    postIds.push(checkbox.value);
                });
                
                // 실제로는 서버에 삭제 요청을 보내야 합니다
                console.log('삭제할 게시글 ID:', postIds);
                
                alert('선택한 게시글이 삭제되었습니다.');
                
                // 삭제된 행 제거 (실제로는 페이지 새로고침)
                checkboxes.forEach(function(checkbox) {
                    checkbox.closest('tr').remove();
                });
                
                updateSelectCount();
                
                // 결과 수 업데이트
                var remainingCount = document.querySelectorAll('.post-checkbox').length;
                document.querySelector('.count-number').textContent = remainingCount;
                
                // 게시글이 없으면 빈 상태 표시
                if(remainingCount === 0) {
                    document.getElementById('postTableBody').innerHTML = 
                        '<tr><td colspan="7" style="padding: 60px; text-align: center; color: #999;">작성한 게시글이 없습니다.</td></tr>';
                }
            }
        }
    </script>
</body>
</html>