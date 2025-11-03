<%@ page contentType="text/html; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 소명 신청 관리</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #FFFFFF; 
            padding: 40px 30px;
        }

        .header {
            background-color: #FFFFFF; 
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

        /* 섹션 공통 */
        .section {
            margin-bottom: 30px;
            padding: 20px;
            border-radius: 10px;
            background-color: #F5F5F5;
        }

        .section-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #BFFCC6; /* 연두로 통일 */
            color: #333;
        }

        /* 정보 그리드 */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-bottom: 15px;
        }

        .info-item {
            display: flex;
            align-items: center;
        }

        .info-label {
            font-weight: bold;
            min-width: 120px;
            color: #666;
        }

        .info-value {
            color: #333;
        }

        /* 링크 */
        .link-text {
            color: #1976D2;
            text-decoration: none;
            font-weight: 500;
        }

        .link-text:hover {
            text-decoration: underline;
        }

        /* 내용 박스 */
        .content-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #E0E0E0;
            line-height: 1.6;
            min-height: 100px;
        }

        /* 처리 정보 박스 */
        .process-info-box {
            background-color: #FFF9E6;
            padding: 15px;
            border-radius: 8px;
            border-left: 4px solid #FFA726;
            margin-top: 10px;
        }

        .process-info-box strong {
            color: #E65100;
        }

        /* 소명 판단 */
        .decision-area {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            border: 2px solid #BFFCC6;
        }

        .option-group {
            margin-bottom: 20px;
        }

        .option-title {
            font-weight: bold;
            margin-bottom: 10px;
            color: #333;
        }

        .radio-group {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .radio-item {
            display: flex;
            align-items: center;
            padding: 10px;
            border: 2px solid #E0E0E0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .radio-item:hover {
            background-color: #F5F5F5;
        }

        .radio-item input[type="radio"] {
            width: 18px;
            height: 18px;
            margin-right: 10px;
            cursor: pointer;
        }

        .radio-item label {
            cursor: pointer;
            flex: 1;
        }

        .radio-desc {
            font-size: 13px;
            color: #666;
            margin-top: 3px;
        }

        /* 텍스트 영역 */
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
            font-family: Arial, sans-serif;
            resize: vertical;
            min-height: 100px;
            box-sizing: border-box;
        }

        textarea:focus {
            outline: none;
            border-color: #BFFCC6;
        }

        /* 버튼 */
        .button-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }

        .button {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
        }

        .btn-approve {
            background-color: #BFFCC6;
            color: #333;
        }

        .btn-approve:hover {
            background-color: #A8EBB0;
        }

        .btn-reject {
            background-color: #FFB3BA;
            color: #333;
        }

        .btn-reject:hover {
            opacity: 0.8;
        }

        .btn-back {
            background-color: #FFFFFF; /* 연보라 제거 -> 흰색 */
            border: 1px solid #ccc;
            color: #333;
        }

        .btn-back:hover {
            background-color: #F5F5F5;
        }

        /* 뱃지 */
        .report-type {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .type-member {
            background-color: #E3F2FD;
            color: #1565C0;
        }

        .type-content {
            background-color: #E1F5FE; /* 연보라 제거 -> 연한 블루 */
            color: #1565C0;
        }

        .type-meeting {
            background-color: #FFF3E0;
            color: #E65100;
        }

        .status-badge {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .status-appeal {
            background-color: #FFF9C4;
            color: #F57F17;
        }

        /* 타임라인 */
        .timeline {
            position: relative;
            padding-left: 40px;
        }

        .timeline-item {
            position: relative;
            padding: 15px 0;
            border-left: 2px solid #BFFCC6;
            padding-left: 25px;
            margin-bottom: 15px;
        }

        .timeline-item:before {
            content: '';
            position: absolute;
            left: -7px;
            top: 20px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background-color: #BFFCC6;
            border: 2px solid #fff;
        }

        .timeline-date {
            font-size: 12px;
            color: #999;
            margin-bottom: 5px;
        }

        .timeline-title {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        .timeline-desc {
            font-size: 14px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="header">소명 신청 관리</div>
    <div class="container">
        <!-- 소명 신청 정보 -->
        <div class="section">
            <div class="section-title">소명 신청 정보</div>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">소명번호:</span>
                    <span class="info-value">APL005</span>
                </div>
                <div class="info-item">
                    <span class="info-label">신청자:</span>
                    <a href="memberDetail.jsp?id=user022" class="link-text">user022 (박지성)</a>
                </div>
                <div class="info-item">
                    <span class="info-label">신청 일자:</span>
                    <span class="info-value">2024-10-03 18:45:30</span>
                </div>
                <div class="info-item">
                    <span class="info-label">소명 상태:</span>
                    <span class="status-badge status-appeal">승인대기</span>
                </div>
            </div>

            <div class="option-group">
                <div class="option-title">소명 내용</div>
                <div class="content-box">
                    안녕하세요. 광고/홍보/스팸으로 신고받아 블라인드 처리된 게시글에 대해 소명하고자 합니다.<br><br>

                    해당 게시글은 광고나 홍보 목적이 아닌, 모임 활동과 관련된 정보 공유 글이었습니다.<br>
                    저희 스터디 모임에서 사용하기 좋은 무료 학습 플랫폼을 소개하는 내용이었고, 
                    어떠한 금전적 대가나 홍보 목적이 없었습니다.<br><br>

                    첨부한 스크린샷을 보시면 알 수 있듯이, 단순히 모임원들과 유익한 정보를 나누기 위한 
                    순수한 의도였습니다. 제목에 플랫폼 이름이 들어가 있어서 오해가 발생한 것 같습니다.<br><br>

                    앞으로는 제목을 더욱 신중하게 작성하도록 하겠습니다. 
                    블라인드 해제를 부탁드립니다.<br><br>

                    감사합니다.
                </div>
            </div>
        </div>

        <!-- 원 신고 정보 -->
        <div class="section">
            <div class="section-title">원 신고 정보</div>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">신고번호:</span>
                    <a href="reportDetail.jsp?id=RPT011" class="link-text">RPT011</a>
                </div>
                <div class="info-item">
                    <span class="info-label">신고 구분:</span>
                    <span class="report-type type-content">컨텐츠</span>
                </div>
                <div class="info-item">
                    <span class="info-label">신고 카테고리:</span>
                    <span class="info-value">광고/홍보/스팸</span>
                </div>
                <div class="info-item">
                    <span class="info-label">신고 일자:</span>
                    <span class="info-value">2024-10-03 14:20:15</span>
                </div>
                <div class="info-item">
                    <span class="info-label">신고 접수 횟수:</span>
                    <span class="info-value">3건</span>
                </div>
                <div class="info-item">
                    <span class="info-label">피신고 대상:</span>
                    <a href="#" class="link-text">게시글 #1234</a>
                </div>
            </div>

            <div class="option-group">
                <div class="option-title">신고 내용 요약</div>
                <div class="content-box">
                    [접수자 1] 특정 플랫폼을 계속 홍보하는 것 같습니다.<br>
                    [접수자 2] 제목과 내용이 광고성 글로 보입니다.<br>
                    [접수자 3] 링크를 클릭하라고 유도하는 스팸 같습니다.
                </div>
            </div>

            <div class="process-info-box">
                <strong>현재 처리 상태:</strong><br>
                - 신고 3회 접수로 자동 블라인드 처리됨 (2024-10-03 14:25:00)<br>
                - 컨텐츠 수정/삭제 불가 상태<br>
                - 피신고자에게 블라인드 처리 안내 발송됨
            </div>
        </div>

        <!-- 처리 이력 -->
        <div class="section">
            <div class="section-title">처리 이력 타임라인</div>
            
            <div class="timeline">
                <div class="timeline-item">
                    <div class="timeline-date">2024-10-03 14:20:15</div>
                    <div class="timeline-title">신고 1차 접수</div>
                    <div class="timeline-desc">user011이 게시글 #1234를 신고 (광고/홍보/스팸)</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-date">2024-10-03 14:21:30</div>
                    <div class="timeline-title">신고 2차 접수</div>
                    <div class="timeline-desc">user013이 게시글 #1234를 신고 (광고/홍보/스팸)</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-date">2024-10-03 14:23:45</div>
                    <div class="timeline-title">신고 3차 접수</div>
                    <div class="timeline-desc">user017이 게시글 #1234를 신고 (광고/홍보/스팸)</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-date">2024-10-03 14:25:00</div>
                    <div class="timeline-title">자동 블라인드 처리</div>
                    <div class="timeline-desc">신고 3회 기준 도달로 게시글 블라인드 처리</div>
                </div>
                <div class="timeline-item">
                    <div class="timeline-date">2024-10-03 18:45:30</div>
                    <div class="timeline-title">소명 신청 접수</div>
                    <div class="timeline-desc">user022가 소명 신청함</div>
                </div>
            </div>
        </div>

        <!-- 관리자 판단 -->
        <div class="section">
            <div class="section-title">관리자 판단 및 처리</div>
            
            <div class="decision-area">
                <div class="option-group">
                    <div class="option-title">소명 처리 결정</div>
                    <div class="radio-group">
                        <div class="radio-item">
                            <input type="radio" id="approve" name="decision" value="approve">
                            <label for="approve">
                                <div><strong>소명 승인</strong></div>
                                <div class="radio-desc">블라인드 처리를 해제하고 게시글을 복구합니다. (컨텐츠 신고의 경우) / 탈퇴 사유를 "개인 사유"로 변경합니다. (회원 신고의 경우)</div>
                            </label>
                        </div>
                        <div class="radio-item">
                            <input type="radio" id="reject" name="decision" value="reject">
                            <label for="reject">
                                <div><strong>소명 반려</strong></div>
                                <div class="radio-desc">소명을 인정하지 않고 기존 처리를 유지합니다. 추가 소명 신청은 불가능합니다.</div>
                            </label>
                        </div>
                    </div>
                </div>

                <div class="option-group">
                    <div class="option-title">처리 의견 (필수)</div>
                    <textarea id="adminComment" placeholder="관리자 판단 사유를 입력하세요.&#10;&#10;※ 신청자에게 전달될 내용입니다.&#10;&#10;예시 (승인):&#10;확인 결과 해당 게시글은 모임 활동과 관련된 정보 공유 목적으로 판단되어 블라인드를 해제합니다.&#10;다만, 앞으로는 제목 작성 시 오해의 소지가 없도록 주의해 주시기 바랍니다.&#10;&#10;예시 (반려):&#10;해당 게시글은 특정 플랫폼의 이름과 링크를 반복적으로 노출하고 있어 홍보성 게시글로 판단됩니다.&#10;따라서 소명을 인정하기 어려우며, 블라인드 처리를 유지합니다."></textarea>
                </div>

                <div class="option-group" id="approveOptions" style="display: none;">
                    <div class="option-title">승인 시 추가 처리 (선택)</div>
                    <div style="padding: 10px; background-color: #F5F5F5; border-radius: 8px;">
                        <label style="display: flex; align-items: center; cursor: pointer;">
                            <input type="checkbox" id="removeBlindHistory" style="width: 18px; height: 18px; margin-right: 8px;">
                            <span>블라인드 처리 이력 삭제 (활동 정지 판단 기준에서 제외)</span>
                        </label>
                    </div>
                </div>

                <div class="button-group">
                    <button class="button btn-approve" onclick="processAppeal('approve')">소명 승인</button>
                    <button class="button btn-reject" onclick="processAppeal('reject')">소명 반려</button>
                <button class="button btn-back" onclick="location.href='reportlist_kmj.do'">목록으로</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('input[name="decision"]').forEach(function(radio) {
            radio.addEventListener('change', function() {
                var approveOptions = document.getElementById('approveOptions');
                if(this.value === 'approve') {
                    approveOptions.style.display = 'block';
                } else {
                    approveOptions.style.display = 'none';
                }
            });
        });

        function processAppeal(action) {
            var decision = document.querySelector('input[name="decision"]:checked');
            var adminComment = document.getElementById('adminComment').value.trim();
            
            if(!decision) {
                alert('처리 결정을 선택해주세요.');
                return;
            }
            
            if(adminComment === '') {
                alert('처리 의견을 입력해주세요.');
                return;
            }
            
            var decisionText = decision.value === 'approve' ? '승인' : '반려';
            var message = '소명을 ' + decisionText + ' 처리하시겠습니까?\n\n';
            
            if(decision.value === 'approve') {
                message += '- 블라인드 처리 해제 및 게시글 복구\n';
                var removeHistory = document.getElementById('removeBlindHistory').checked;
                if(removeHistory) {
                    message += '- 블라인드 처리 이력 삭제\n';
                }
            } else {
                message += '- 기존 처리 유지 (블라인드 상태 유지)\n';
                message += '- 추가 소명 신청 불가\n';
            }
            
            message += '\n신청자에게 처리 결과가 전송됩니다.';
            
            if(confirm(message)) {
                console.log('소명 처리:', {
                    decision: decision.value,
                    adminComment: adminComment,
                    removeBlindHistory: decision.value === 'approve' ? document.getElementById('removeBlindHistory').checked : false
                });
                
                alert('소명 처리가 완료되었습니다.\n신청자에게 알림이 전송됩니다.');
                location.href = 'reportlist_kmj.do';
            }
        }
    </script>
</body>
</html>
