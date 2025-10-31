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
    <title>소명 신청서 제출</title>
    <style>
        /* 기존 관리자 페이지 CSS를 재활용하여 일관성을 유지합니다. */
        body {
            margin: 0;
            font-family: 'Inter', 'Malgun Gothic', sans-serif;
            background-color: #F8F9FA; /* 배경색을 약간 회색으로 변경 */
            padding: 30px 20px;
        }

        .header {
            background-color: #FFFFFF;
            padding: 20px;
            border-radius: 15px;
            font-size: 28px; /* 폰트 크기 확대 */
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05); /* 그림자 강화 */
            color: #333;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 20px;
            max-width: 1000px; /* 너비 조정 */
            margin: 0 auto;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        /* 섹션 공통 */
        .section {
            margin-bottom: 30px;
            padding: 20px;
            border-radius: 12px; /* 모서리 조정 */
            background-color: #F5F7FA; /* 연한 배경색 */
            border: 1px solid #EAEAEA;
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #BFFCC6; /* 연두색 강조 */
            color: #333;
        }

        /* 정보 그리드 */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2열로 단순화 */
            gap: 15px;
            margin-bottom: 15px;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 5px 0;
        }

        .info-label {
            font-weight: bold;
            min-width: 140px; /* 레이블 너비 확보 */
            color: #555;
            flex-shrink: 0;
        }

        .info-value {
            color: #111;
            word-break: break-all;
        }
        
        /* 버튼 */
        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }

        .button {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            transition: background-color 0.2s, transform 0.1s;
        }

        .btn-submit {
            background-color: #BFFCC6; /* 연두색 강조 */
            color: #333;
            box-shadow: 0 3px #A8EBB0;
        }

        .btn-submit:hover {
            background-color: #A8EBB0;
            transform: translateY(1px);
            box-shadow: 0 2px #95D79B;
        }

        .btn-back {
            background-color: #FFFFFF;
            border: 1px solid #ccc;
            color: #333;
            box-shadow: 0 3px #E0E0E0;
        }

        .btn-back:hover {
            background-color: #F5F5F5;
            transform: translateY(1px);
            box-shadow: 0 2px #CCC;
        }

        /* 텍스트 영역 */
        textarea {
            width: 100%;
            padding: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            font-family: inherit;
            resize: vertical;
            min-height: 250px; /* 높이 증가 */
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        textarea:focus {
            outline: none;
            border-color: #BFFCC6;
            box-shadow: 0 0 5px rgba(191, 252, 198, 0.5);
        }

        /* 처리 정보 박스 (경고/안내용으로 활용) */
        .process-info-box {
            background-color: #FFF9E6;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #FFA726;
            margin-top: 10px;
            color: #664900;
            line-height: 1.6;
        }

        .process-info-box strong {
            color: #E65100;
        }

        /* 파일 첨부 영역 */
        .file-upload-area {
            margin-top: 20px;
            padding: 15px;
            background-color: #FDFDFD;
            border: 1px dashed #BFFCC6;
            border-radius: 8px;
        }

        .file-upload-area input[type="file"] {
            display: block;
            margin-top: 10px;
        }

        /* 뱃지 */
        .badge {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }
        
        .type-content { background-color: #E1F5FE; color: #1565C0; }
        .status-blind { background-color: #FFCDD2; color: #C62828; }
        
        @media (max-width: 768px) {
            .info-grid {
                grid-template-columns: 1fr; /* 모바일에서 1열로 변경 */
            }
        }
    </style>
</head>
<body>
    <div class="header">소명 신청서</div>
    <div class="container">
        
        <!-- 현재 조치 및 안내 -->
        <div class="section">
            <div class="section-title">현재 처리 현황 및 유의사항</div>
            <div class="process-info-box">
                <strong>[안내]</strong> 회원님의 게시글 #1234는 다수 신고 접수(3건)로 인해 자동 블라인드 처리되었습니다. <br>
                블라인드 처리일: 2024-10-03 14:25:00 <br>
                소명신청 가능하며, 소명신청 반려에 대한 소명신청은 불가능합니다. 신중하게 작성해 주시기 바랍니다.
            </div>
        </div>

        <!-- 원 신고 정보 -->
        <div class="section">
            <div class="section-title">신고 및 제재 대상 정보</div>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">제재 대상:</span>
                    <span class="info-value"><a href="#" class="link-text">게시글 #1234 (제목: 스터디에 유용한 플랫폼 공유!)</a></span>
                </div>
                <div class="info-item">
                    <span class="info-label">신고 카테고리:</span>
                    <span class="info-value">광고/홍보/스팸</span>
                </div>
                <div class="info-item">
                    <span class="info-label">신고 구분:</span>
                    <span class="badge type-content">컨텐츠</span>
                </div>
                <div class="info-item">
                    <span class="info-label">현재 상태:</span>
                    <span class="badge status-blind">블라인드 처리됨</span>
                </div>
                <div class="info-item">
                    <span class="info-label">신고 접수 횟수:</span>
                    <span class="info-value">3건</span>
                </div>
                <div class="info-item">
                    <span class="info-label">신고 내용 요약:</span>
                    <span class="info-value">특정 플랫폼 홍보, 광고성 글로 오인</span>
                </div>
            </div>
        </div>

        <!-- 소명 신청서 작성 -->
        <div class="section">
            <div class="section-title">소명 내용 작성</div>
            <form id="appealForm" onsubmit="return submitAppeal(event)">
                <label for="appealContent" style="display: block; font-weight: bold; margin-bottom: 8px; color: #333;">
                    소명 내용 (구체적인 해명 및 증빙 자료 설명)
                </label>
                <textarea id="appealContent" name="appealContent" placeholder="
회원님의 콘텐츠가 규정을 위반하지 않았음을 증명하는 구체적인 내용을 작성해 주세요. 
&#10;
&#10;예시: 
&#10;1. 해당 게시글의 작성 목적은 (금전적 대가 없는) 순수한 정보 공유였습니다.
&#10;2. 어떤 부분이 오해의 소지가 있었는지 설명하고, 해당 행위를 하지 않았음을 증명할 수 있는 근거를 제시해 주세요.
&#10;3. 오해를 줄이기 위한 앞으로의 계획을 간략히 언급해 주세요.
" required></textarea>

                <div class="file-upload-area">
                    <label for="appealFile" style="font-weight: bold; color: #333;">증빙 자료 첨부 (선택)</label>
                    <input type="file" id="appealFile" name="appealFile" accept="image/*, .pdf, .zip">
                    <div style="font-size: 12px; color: #777; margin-top: 5px;">
                        스크린샷, 관련 문서 등 소명에 도움이 될 수 있는 자료를 첨부해 주세요. (최대 10MB)
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit" class="button btn-submit">소명 신청 제출</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // NOTE: In a real application, the data would be fetched from the server.
        // The original code used alert(), so we use a custom modal or simple function for compliance.
        // We will use a simple function to handle submission (instead of using alert or confirm)

        function showMessageModal(title, message) {
             const modal = document.createElement('div');
             modal.style.cssText = 
                position: fixed; top: 0; left: 0; width: 100%; height: 100%;
                background: rgba(0,0,0,0.6); display: flex; justify-content: center;
                align-items: center; z-index: 1000;
             `;
             const content = document.createElement('div');
             content.style.cssText = `
                background: white; padding: 30px; border-radius: 12px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3); max-width: 400px;
                text-align: center;
             `;
             const titleEl = document.createElement('h3');
             titleEl.innerText = title;
             titleEl.style.cssText = 'color: #333; margin-bottom: 15px;';
             
             const messageEl = document.createElement('p');
             messageEl.innerText = message;
             messageEl.style.cssText = 'color: #555; margin-bottom: 25px; line-height: 1.5;';

             const closeButton = document.createElement('button');
             closeButton.innerText = '확인';
             closeButton.style.cssText = `
                padding: 10px 20px; border: none; border-radius: 6px; 
                background-color: #BFFCC6; font-weight: bold; cursor: pointer;
                transition: background-color 0.2s;
             `;
             closeButton.onclick = () => {
                 document.body.removeChild(modal);
                 // Simulate navigation after successful submission
                 if (title === "소명 신청 완료") {
                    // In a real app, redirect to a confirmation page or user's main page
                    // window.location.href = 'userAppealHistory.jsp'; 
                    console.log("Redirecting to appeal history...");
                 }
             };

             content.appendChild(titleEl);
             content.appendChild(messageEl);
             content.appendChild(closeButton);
             modal.appendChild(content);
             document.body.appendChild(modal);
        }

        function submitAppeal(event) {
            event.preventDefault(); // 기본 폼 제출 방지

            const content = document.getElementById('appealContent').value.trim();
            const file = document.getElementById('appealFile').files[0];
            
            if (content.length < 50) {
                showMessageModal('오류', '소명 내용은 최소 50자 이상 작성해 주셔야 합니다.');
                return false;
            }

            // 실제 서버 전송 로직 (fetch API 등)은 여기에 들어갑니다.
            console.log("--- 소명 신청 데이터 ---");
            console.log("소명 내용:", content.substring(0, 100) + (content.length > 100 ? '...' : ''));
            console.log("첨부 파일:", file ? file.name : '없음');
            console.log("서버로 데이터 전송 중...");

            // 성공 시 메시지 표시
            showMessageModal(
                '소명 신청 완료', 
                '소명 신청이 성공적으로 제출되었습니다. 관리자 검토 후 결과는 알림으로 안내될 예정입니다.'
            );

            return true;
        }
    </script>
</body>
</html>
