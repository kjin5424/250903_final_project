<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 모임 게시글 목록</title>
    <style>
/* ================================================
    관리자 페이지 공통 스타일 적용형 (회원 상세용)
    ================================================ */
:root {
    --color-primary: #5cb85c; /* Green */
    --color-primary-dark: #3a8a3a;
    --color-primary-lighter: #f0fff0;
    --color-secondary: #007bff; /* Blue */
    --color-secondary-dark: #0056b3;
    --color-accent: #dc3545; /* Red for Danger/Delete */
    --color-accent-dark: #c82333;
    --color-text-primary: #333;
    --color-text-secondary: #6c757d;
    --color-border: #dee2e6;
    --color-border-light: #f8f9fa;
    --color-white: #fff;
    --radius-md: 8px;
    --radius-lg: 12px;
    --radius-full: 999px;
    --spacing-sm: 10px;
    --spacing-md: 16px;
    --spacing-lg: 24px;
    --spacing-xl: 40px;
    --transition-base: 0.2s ease;
    --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.08);
    --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* 기본 세팅 */
body {
    margin: 0;
    font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
    background-color: var(--color-border-light);
    padding: var(--spacing-lg);
    color: var(--color-text-primary);
    line-height: 1.6;
}

/* 페이지 헤더 */
.header {
    background-color: var(--color-white);
    padding: var(--spacing-lg);
    border-radius: var(--radius-lg);
    font-size: 28px;
    font-weight: 700;
    text-align: center;
    color: var(--color-text-primary);
    box-shadow: var(--shadow-sm);
    margin-bottom: var(--spacing-lg);
}

/* 컨테이너 (메인 카드) */
.container {
    background: var(--color-white);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
    padding: var(--spacing-lg);
    max-width: 1200px;
    margin: 0 auto;
}

/* ===============================
    정보 헤더 영역 (회원/모임 정보)
    =============================== */
.info-header {
    background-color: var(--color-primary-lighter);
    border: 1px solid var(--color-border);
    padding: var(--spacing-md) var(--spacing-lg);
    border-radius: var(--radius-md);
    margin-bottom: var(--spacing-lg);
    display: flex;
    flex-wrap: wrap;
    gap: var(--spacing-md);
    align-items: center;
    justify-content: space-between;
}

.info-header-left {
    display: flex;
    flex-wrap: wrap;
    gap: var(--spacing-lg);
}

.info-item {
    display: flex;
    align-items: center;
    font-size: 15px;
    padding: 4px 0;
}

.info-label {
    font-weight: 600;
    color: var(--color-text-secondary);
    margin-right: var(--spacing-sm);
}

.info-value {
    color: var(--color-text-primary);
    font-weight: 700;
}

/* ===============================
    액션 바 및 통계 (Delete Button 위치)
    =============================== */
.action-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: var(--spacing-md);
    padding: var(--spacing-sm) 0;
    border-bottom: 2px solid var(--color-border-light);
}

.result-count {
    font-size: 16px;
    font-weight: 500;
    color: var(--color-text-secondary);
}

.count-number {
    color: var(--color-secondary-dark); /* Highlight count number */
    font-weight: 800;
    font-size: 18px;
}

.select-info {
    font-size: 14px;
    color: var(--color-text-primary);
    font-weight: 600;
}

/* 삭제 버튼 스타일 */
.btn-delete-group {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
}

.button {
    padding: 10px 20px;
    border: none;
    border-radius: var(--radius-md);
    font-weight: 700;
    cursor: pointer;
    transition: all var(--transition-base);
    font-size: 14px;
    box-shadow: var(--shadow-sm);
}

/* ❌ 선택 삭제 버튼 */
.btn-delete-selected {
    background: var(--color-accent); /* Red */
    color: var(--color-white);
    padding: 10px 20px;
}

.btn-delete-selected:hover:not(:disabled) {
    background: var(--color-accent-dark);
    transform: translateY(-2px);
    box-shadow: 0 4px 6px rgba(220, 53, 69, 0.3);
}

.btn-delete-selected:disabled {
    background: #ccc;
    color: #999;
    cursor: not-allowed;
    transform: none;
    box-shadow: none;
    opacity: 0.8;
}

/* ===============================
    테이블 스타일
    =============================== */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: var(--spacing-sm);
    font-size: 14px;
    border: 1px solid var(--color-border);
    border-radius: var(--radius-md);
    overflow: hidden; /* Ensure rounded corners clip content */
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
    border-bottom: 2px solid var(--color-primary);
}

tbody tr:hover {
    background: #f1f1f1;
}

/* 제목 셀 스타일 (왼쪽 정렬) */
.title-cell {
    text-align: left;
}

.title-link {
    color: var(--color-secondary);
    text-decoration: none;
    font-weight: 600;
    transition: color var(--transition-base);
}

.title-link:hover {
    color: var(--color-secondary-dark);
    text-decoration: underline;
}

/* 체크박스 셀 너비 조정 */
.checkbox-cell {
    width: 40px;
}

/* ===============================
    커스텀 모달 (Custom Confirm)
    =============================== */
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: none; /* Default hidden */
    justify-content: center;
    align-items: center;
    z-index: 1000;
}

.modal-content {
    background: var(--color-white);
    padding: var(--spacing-lg);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
    max-width: 400px;
    width: 90%;
    text-align: center;
}

.modal-content h3 {
    color: var(--color-accent-dark);
    margin-top: 0;
}

.modal-actions {
    margin-top: var(--spacing-lg);
    display: flex;
    justify-content: center;
    gap: var(--spacing-md);
}

.btn-confirm {
    background-color: var(--color-accent);
    color: var(--color-white);
}

.btn-cancel {
    background-color: var(--color-border);
    color: var(--color-text-primary);
}

.btn-confirm:hover { background-color: var(--color-accent-dark); }
.btn-cancel:hover { background-color: #d8d8d8; }

/* 빈 상태 스타일 */
.empty-state {
    text-align: center;
    padding: 60px 20px;
    border: 1px dashed var(--color-border);
    border-radius: var(--radius-md);
    margin-top: var(--spacing-md);
    color: var(--color-text-secondary);
}

.empty-state-icon {
    font-size: 40px;
    margin-bottom: var(--spacing-md);
}


/* 반응형 */
@media (max-width: 768px) {
    body {
        padding: var(--spacing-md);
    }
    
    .info-header {
        flex-direction: column;
        align-items: flex-start;
        gap: var(--spacing-sm);
    }

    .info-header-left {
        flex-direction: column;
        gap: var(--spacing-sm);
    }

    .action-bar {
        flex-direction: column;
        align-items: stretch;
        gap: var(--spacing-sm);
    }
    
    .btn-delete-selected {
        width: 100%;
        margin-top: var(--spacing-sm);
    }
    
    table, thead, tbody, th, td, tr { 
        display: block; 
    }
    
    thead tr { 
        position: absolute;
        top: -9999px;
        left: -9999px;
    }
    
    tr { 
        border: 1px solid var(--color-border);
        margin-bottom: var(--spacing-sm);
        border-radius: var(--radius-md);
    }
    
    td { 
        border: none;
        position: relative;
        padding-left: 50%; 
        text-align: right;
    }
    
    td:before { 
        position: absolute;
        top: 0;
        left: 6px;
        width: 45%; 
        padding-right: 10px; 
        white-space: nowrap;
        text-align: left;
        font-weight: 700;
        color: var(--color-primary-dark);
    }
    
    /* 각 셀에 라벨 추가 (Mobile 전용) */
    td:nth-of-type(2):before { content: "번호"; }
    td:nth-of-type(3):before { content: "게시판 이름"; }
    td:nth-of-type(4):before { content: "제목"; }
    td:nth-of-type(5):before { content: "작성일자"; }
    
    /* 체크박스 셀은 그대로 유지 */
    td:first-child {
        text-align: left;
        padding-left: 10px;
        display: flex;
        justify-content: flex-start;
        align-items: center;
        min-height: 40px;
    }
    
    td:first-child:before { content: "선택"; width: auto; position: static; margin-right: 10px; }
}
    </style>
</head>
<body>
    <!-- 커스텀 삭제 확인 모달 UI -->
    <div id="customConfirmModal" class="modal-overlay">
        <div class="modal-content">
            <h3>⚠️ 게시글 삭제 확인</h3>
            <p id="modalMessage"></p>
            <div class="modal-actions">
                <button class="button btn-cancel" onclick="closeModal()">취소</button>
                <button class="button btn-confirm" id="modalConfirmBtn">삭제</button>
            </div>
        </div>
    </div>
    
    <div class="header">회원 모임 게시글 목록 관리</div>
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

        <!-- 액션 바: 결과 수, 선택 정보, 삭제 버튼 -->
        <div class="action-bar">
            <div class="result-count">
                총 <span class="count-number" id="totalCount">5</span>개의 게시글
            </div>
            
            <div class="btn-delete-group">
                <div class="select-info">
                    <span id="selectedCount" style="color: var(--color-accent); font-size: 16px;">0</span>개 선택됨
                </div>
                <!-- 삭제 버튼 위치 조정 -->
                <button id="deleteBtn" class="button btn-delete-selected" onclick="confirmDeleteSelected()" disabled>
                    ❌ 선택 삭제
                </button>
            </div>
        </div>

        <!-- 작성글 테이블 -->
        <table id="postTable">
            <thead>
                <tr>
                    <th class="checkbox-cell">
                        <input type="checkbox" id="selectAll" onchange="toggleSelectAll()">
                    </th>
                    <th>번호</th>
                    <th>게시판 이름</th>
                    <th>제목</th>
                    <th>작성일자</th>
                </tr>
            </thead>
            <tbody id="postTableBody">
                <tr data-post-id="1">
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="1" onchange="updateSelectCount()">
                    </td>
                    <td>5</td>
                    <td>자유게시판</td>
                    <td class="title-cell">
                       <a href="blind.do?id=1" class="title-link">Java 스터디 2주차 후기 공유합니다</a>
                    </td>
                    <td>2024-02-05</td>
                </tr>
                <tr data-post-id="2">
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="2" onchange="updateSelectCount()">
                    </td>
                    <td>4</td>
                    <td>질문게시판</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">Optional 사용법 질문드립니다</a>
                    </td>
                    <td>2024-02-10</td>
                </tr>
                <tr data-post-id="3">
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="3" onchange="updateSelectCount()">
                    </td>
                    <td>3</td>
                    <td>자료실</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">Spring Boot 입문 자료 공유</a>
                    </td>
                    <td>2024-03-15</td>
                </tr>
                <tr data-post-id="4">
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="4" onchange="updateSelectCount()">
                    </td>
                    <td>2</td>
                    <td>자유게시판</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">이번주 스터디 일정 변경 공지</a>
                    </td>
                    <td>2024-04-20</td>
                </tr>
                <tr data-post-id="5">
                    <td class="checkbox-cell">
                        <input type="checkbox" class="post-checkbox" value="5" onchange="updateSelectCount()">
                    </td>
                    <td>1</td>
                    <td>질문게시판</td>
                    <td class="title-cell">
                        <a href="#" class="title-link">Stream API 성능 최적화 방법 궁금합니다</a>
                    </td>
                    <td>2024-05-12</td>
                </tr>
            </tbody>
        </table>

        <!-- 게시글이 없을 경우의 대체 콘텐츠 (주석 처리 해제 후 사용) -->
        <div id="emptyState" class="empty-state" style="display: none;">
             <div class="empty-state-icon">📝</div>
             <p>작성한 게시글이 없습니다.</p>
        </div>
    </div>

    <script>
        // 전역 변수: 삭제 확인 후 실행할 함수 (Promise 대신 단순 콜백 사용)
        let deleteConfirmedCallback = null;

        document.addEventListener('DOMContentLoaded', function() {
            // 초기 로딩 시 선택 개수 업데이트 및 상태 확인
            updateSelectCount();
        });

        // 1. 모달 열기 함수 (confirm() 대체)
        function openModal(message, onConfirm) {
            document.getElementById('modalMessage').textContent = message;
            document.getElementById('customConfirmModal').style.display = 'flex';
            
            // 기존 이벤트 리스너 제거 및 새 리스너 할당
            const confirmBtn = document.getElementById('modalConfirmBtn');
            if (confirmBtn._eventListener) {
                confirmBtn.removeEventListener('click', confirmBtn._eventListener);
            }

            confirmBtn._eventListener = function() {
                closeModal();
                onConfirm();
            };
            confirmBtn.addEventListener('click', confirmBtn._eventListener);
        }

        // 2. 모달 닫기 함수
        function closeModal() {
            document.getElementById('customConfirmModal').style.display = 'none';
        }

        // 3. 삭제 확인 트리거
        function confirmDeleteSelected() {
            var count = document.querySelectorAll('.post-checkbox:checked').length;
            if (count === 0) {
                // 이미 버튼이 disabled 상태이므로 이 코드는 실행되지 않음
                console.log('삭제할 게시글을 선택해주세요.');
                return;
            }

            const message = count + '개의 게시글을 정말로 삭제하시겠습니까? 삭제된 데이터는 복구할 수 없습니다.';
            
            // openModal을 통해 실제 삭제 로직을 콜백으로 전달
            openModal(message, deleteSelected);
        }

        // 4. 전체 선택/해제
        function toggleSelectAll() {
            var selectAll = document.getElementById('selectAll');
            var checkboxes = document.querySelectorAll('.post-checkbox');
            
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = selectAll.checked;
            });
            
            updateSelectCount();
        }

        // 5. 선택 개수 업데이트 및 버튼 상태 관리
        function updateSelectCount() {
            var checkboxes = document.querySelectorAll('.post-checkbox');
            var checkedCheckboxes = document.querySelectorAll('.post-checkbox:checked');
            var count = checkedCheckboxes.length;
            var totalCount = checkboxes.length;
            
            document.getElementById('selectedCount').textContent = count;
            
            // 삭제 버튼 활성화/비활성화
            var deleteBtn = document.getElementById('deleteBtn');
            if (deleteBtn) {
                deleteBtn.disabled = count === 0;
            }
            
            // 전체 선택 체크박스 상태 업데이트 (전체 선택/해제)
            var selectAll = document.getElementById('selectAll');
            if (totalCount === 0) {
                 selectAll.checked = false;
                 selectAll.disabled = true; // 게시글이 없으면 체크박스 비활성화
            } else {
                 selectAll.disabled = false;
                 selectAll.checked = count === totalCount;
            }
        }

        // 6. 선택 삭제 실행 로직
        function deleteSelected() {
            var checkboxes = document.querySelectorAll('.post-checkbox:checked');
            var postIds = [];
            
            checkboxes.forEach(function(checkbox) {
                postIds.push(checkbox.value);
            });
            
            // 실제로는 여기에 서버 통신 (AJAX 등) 로직이 들어갑니다.
            console.log('--- [서버 전송] 삭제할 게시글 ID:', postIds);
            
            // 삭제된 행 제거 (임시로 화면에서 제거)
            checkboxes.forEach(function(checkbox) {
                checkbox.closest('tr').remove();
            });
            
            // 상태 업데이트 및 결과 수 반영
            updateSelectCount();
            
            // 결과 수 업데이트
            var remainingCount = document.querySelectorAll('.post-checkbox').length;
            document.getElementById('totalCount').textContent = remainingCount;
            
            // 게시글이 없으면 빈 상태 표시
            if(remainingCount === 0) {
                document.getElementById('emptyState').style.display = 'block';
                document.getElementById('postTable').style.display = 'none';
            }
            
            console.log('선택한 게시글이 화면에서 삭제되었습니다.');
            
            // 삭제 성공 메시지 표시 (선택사항)
            // alert('선택한 게시글이 삭제되었습니다. (경고창 대신 토스트 알림 사용 권장)');
        }
    </script>
</body>
</html>
