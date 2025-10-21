<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 모임 게시글 목록</title>
    <style>
/* ================================================
   관리자 페이지 공통 스타일 적용형 (회원 상세용)
   ================================================ */

:root {
    --color-primary: #BFFCC6;
    --color-primary-dark: #2E7D32;
    --color-primary-lighter: #E9FBEF;
    --color-secondary: #E6D6FF;
    --color-secondary-dark: #6B4FB6;
    --color-secondary-lighter: #F4EFFF;
    --color-accent: #FFB3BA;
    --color-accent-dark: #E65100;
    --color-text-primary: #333;
    --color-text-secondary: #666;
    --color-border: #ddd;
    --color-border-light: #eee;
    --color-white: #fff;
    --radius-md: 8px;
    --radius-lg: 16px;
    --radius-full: 999px;
    --spacing-xs: 4px;
    --spacing-sm: 8px;
    --spacing-md: 12px;
    --spacing-lg: 20px;
    --spacing-xl: 32px;
    --transition-base: 0.2s ease;
    --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 8px rgba(0, 0, 0, 0.08);
}

/* 기본 세팅 */
body {
    margin: 0;
    font-family: "Segoe UI", Arial, sans-serif;
    background-color: var(--color-secondary-lighter);
    padding: var(--spacing-xl) var(--spacing-lg);
    color: var(--color-text-primary);
}

/* 페이지 헤더 */
.header {
    padding: var(--spacing-lg);
    border-radius: var(--radius-lg);
    font-size: 28px;
    font-weight: 800;
    text-align: center;
    color: var(--color-text-primary);
    box-shadow: var(--shadow-md);
    margin-bottom: var(--spacing-xl);
}

/* 컨테이너 */
.container {
    background: var(--color-white);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-sm);
    padding: var(--spacing-xl);
    max-width: 1400px;
    margin: 0 auto;
}

/* ===============================
   회원 기본 정보 영역
   =============================== */
.member-info {
    background: var(--color-primary-lighter);
    padding: var(--spacing-lg);
    border-radius: var(--radius-lg);
    margin-bottom: var(--spacing-xl);
    box-shadow: var(--shadow-sm);
}

.member-info-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: var(--spacing-md);
}

.profile-section {
    grid-column: 1 / -1;
    display: flex;
    align-items: center;
    gap: var(--spacing-lg);
    background: var(--color-white);
    padding: var(--spacing-md);
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-sm);
}

.profile-img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: var(--color-secondary);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 32px;
}

.info-item {
    display: flex;
    align-items: center;
    font-size: 15px;
}

.info-label {
    font-weight: 700;
    color: var(--color-text-secondary);
    margin-right: var(--spacing-sm);
    min-width: 100px;
}

/* ===============================
   탭 메뉴
   =============================== */
.tab-menu {
    display: flex;
    gap: var(--spacing-sm);
    border-bottom: 2px solid var(--color-secondary);
    margin-bottom: var(--spacing-md);
}

.tab-button {
    padding: 12px 20px;
    font-weight: 700;
    background: transparent;
    border: none;
    border-bottom: 3px solid transparent;
    cursor: pointer;
    transition: all var(--transition-base);
}

.tab-button:hover {
    background: var(--color-secondary-lighter);
}

.tab-button.active {
    border-bottom-color: var(--color-primary);
    background: var(--color-secondary-lighter);
    color: var(--color-primary-dark);
}

/* 탭 내용 */
.tab-content {
    display: none;
    animation: fadeIn 0.2s ease;
}

.tab-content.active {
    display: block;
}

/* ===============================
   테이블 공통
   =============================== */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: var(--spacing-md);
    font-size: 14px;
}

th, td {
    padding: var(--spacing-md);
    text-align: center;
    border-bottom: 1px solid var(--color-border-light);
}

th {
    background: var(--color-primary-lighter);
    font-weight: 700;
    color: var(--color-primary-dark);
}

tbody tr:hover {
    background: var(--color-secondary-lighter);
    cursor: pointer;
}

/* ===============================
   상태 배지
   =============================== */
.status-badge {
    display: inline-block;
    padding: 6px 12px;
    border-radius: var(--radius-full);
    font-size: 12px;
    font-weight: 700;
}

.status-pending {
    background: #fff3e0;
    color: #f57c00;
}

.status-completed {
    background: var(--color-primary-lighter);
    color: var(--color-primary-dark);
}

.status-rejected {
    background: #ffebee;
    color: #c62828;
}

/* ===============================
   버튼 영역
   =============================== */
.action-buttons {
    display: flex;
    justify-content: center;
    gap: var(--spacing-md);
    margin-top: var(--spacing-lg);
}

.button {
    padding: 10px 24px;
    border: none;
    border-radius: var(--radius-md);
    font-weight: 700;
    cursor: pointer;
    transition: all var(--transition-base);
    font-size: 14px;
}

.btn-suspend {
    background: var(--color-accent);
    color: white;
}

.btn-withdraw {
    background: #FFDFBA;
    color: #444;
}

.btn-back {
    background: var(--color-primary);
    color: #222;
}

.button:hover {
    transform: translateY(-1px);
    box-shadow: var(--shadow-sm);
    opacity: 0.9;
}

/* 링크 스타일 */
.link-text {
    color: var(--color-secondary-dark);
    text-decoration: none;
}

.link-text:hover {
    text-decoration: underline;
}

/* 애니메이션 */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

/* 반응형 */
@media (max-width: 1024px) {
    .member-info-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .member-info-grid {
        grid-template-columns: 1fr;
    }

    .tab-menu {
        flex-wrap: wrap;
    }

    .action-buttons {
        flex-direction: column;
    }

    .button {
        width: 100%;
    }
}

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

.result-count {
    margin-bottom: 15px;
    font-size: 14px;
    color: #666;
}

.count-number {
    color: #1976D2;
    font-weight: bold;
}

.select-info {
    font-size: 14px;
    color: #666;
}
    </style>
</head>
<body>
    <div class="header">회원 모임 게시글 목록</div>
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