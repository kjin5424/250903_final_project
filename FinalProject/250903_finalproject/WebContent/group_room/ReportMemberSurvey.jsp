<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%  request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath(); %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 회원 신고 설문</title>
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
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }

        /* 경고 헤더 */
        .warning-header {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: white;
            padding: 30px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
            text-align: center;
        }
        .warning-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
        .warning-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .warning-subtitle {
            font-size: 16px;
            opacity: 0.95;
        }

        /* 메인 카드 */
        .survey-card {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 25px;
        }

        .section {
            margin-bottom: 35px;
        }
        .section:last-child {
            margin-bottom: 0;
        }

        .section-title {
            font-size: 18px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-divider {
            height: 2px;
            background: linear-gradient(90deg, #8bc683 0%, transparent 100%);
            margin-bottom: 20px;
        }

        /* 신고 정보 박스 */
        .report-info-box {
            background: #fff3e0;
            border: 2px solid #ffe0b2;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 25px;
        }
        .report-info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 15px;
        }
        .report-info-row:last-child {
            margin-bottom: 0;
        }
        .report-label {
            font-weight: 600;
            color: #666;
        }
        .report-value {
            color: #333;
            font-weight: 500;
        }
        .report-category {
            display: inline-block;
            background: #ff6b6b;
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
        }

        /* 안내 박스 */
        .info-box {
            background: #e3f2fd;
            border-left: 4px solid #2196f3;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
        }
        .info-title {
            font-weight: bold;
            color: #1565c0;
            margin-bottom: 10px;
            font-size: 16px;
        }
        .info-content {
            color: #555;
            line-height: 1.7;
            font-size: 14px;
        }
        .info-list {
            margin-top: 10px;
            padding-left: 20px;
        }
        .info-list li {
            margin-bottom: 6px;
            color: #555;
        }

        /* 투표 영역 */
        .vote-section {
            background: #f8faf8;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 30px;
            margin-bottom: 25px;
        }
        .vote-question {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 25px;
            text-align: center;
        }
        .vote-options {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .vote-option {
            flex: 1;
            max-width: 200px;
        }
        .vote-radio {
            display: none;
        }
        .vote-label {
            display: block;
            padding: 20px;
            background: white;
            border: 3px solid #e0e0e0;
            border-radius: 12px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 600;
            font-size: 16px;
        }
        .vote-label:hover {
            border-color: #8bc683;
            background: #f0f8f0;
        }
        .vote-radio:checked + .vote-label {
            border-color: #4CAF50;
            background: #e8f5e9;
            color: #2d5a29;
        }
        .vote-icon {
            font-size: 32px;
            margin-bottom: 10px;
        }

        /* 상세 내용 입력 영역 */
        .detail-section {
            display: none;
            margin-top: 25px;
            padding: 20px;
            background: #f0f8f0;
            border-radius: 10px;
            border: 2px solid #8bc683;
        }
        .detail-section.active {
            display: block;
        }
        .detail-title {
            font-size: 16px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 15px;
        }
        .detail-textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            resize: vertical;
            min-height: 120px;
            transition: all 0.3s;
        }
        .detail-textarea:focus {
            outline: none;
            border-color: #8bc683;
            box-shadow: 0 0 0 3px rgba(139, 198, 131, 0.1);
        }
        .detail-textarea::placeholder {
            color: #999;
        }
        .char-count {
            text-align: right;
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }
        .detail-note {
            font-size: 13px;
            color: #666;
            margin-top: 10px;
            line-height: 1.5;
        }

        /* 통계 정보 */
        .stats-box {
            background: #f0f4f8;
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
            text-align: center;
        }
        .stats-row {
            display: flex;
            justify-content: space-around;
            gap: 20px;
        }
        .stat-item {
            flex: 1;
        }
        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 5px;
        }
        .stat-label {
            font-size: 13px;
            color: #666;
        }

        /* 버튼 */
        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        .btn {
            padding: 15px 40px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-submit {
            background: #4CAF50;
            color: white;
        }
        .btn-submit:hover:not(:disabled) {
            background: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }
        .btn-submit:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        .btn-cancel {
            background: #e0e0e0;
            color: #666;
        }
        .btn-cancel:hover {
            background: #d0d0d0;
        }

        /* 경고 메시지 */
        .warning-message {
            background: #fff3e0;
            border: 2px solid #ffb74d;
            border-radius: 10px;
            padding: 20px;
            margin-top: 25px;
        }
        .warning-message-title {
            font-weight: bold;
            color: #e65100;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .warning-message-content {
            color: #666;
            line-height: 1.6;
            font-size: 14px;
        }

        /* 결과 화면 */
        .result-screen {
            display: none;
            text-align: center;
        }
        .result-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }
        .result-title {
            font-size: 24px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 15px;
        }
        .result-message {
            color: #666;
            line-height: 1.8;
            margin-bottom: 30px;
        }

        @media (max-width: 768px) {
            .survey-card {
                padding: 25px 20px;
            }
            .vote-options {
                flex-direction: column;
            }
            .vote-option {
                max-width: 100%;
            }
            .button-group {
                flex-direction: column;
            }
            .btn {
                width: 100%;
            }
            .stats-row {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
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
        <div class="warning-header">
            <div class="warning-icon">⚠️</div>
            <div class="warning-title">회원 신고 설문</div>
            <div class="warning-subtitle">모임 내 신고 건에 대한 의견을 수렴합니다</div>
        </div>

        <!-- 설문 화면 -->
        <div id="surveyScreen">
            <div class="survey-card">
                <div class="section">
                    <div class="section-title">📋 신고 정보</div>
                    <div class="section-divider"></div>
                    <div class="report-info-box">
                        <div class="report-info-row">
                            <span class="report-label">신고 일자:</span>
                            <span class="report-value">2024-10-20 14:30</span>
                        </div>
                        <div class="report-info-row">
                            <span class="report-label">피신고자:</span>
                            <span class="report-value">김문제 (닉네임 비공개)</span>
                        </div>
                        <div class="report-info-row">
                            <span class="report-label">신고 사유:</span>
                            <span class="report-category">악의적 활동(욕설/비방/모욕/괴롭힘)</span>
                        </div>
                    </div>
                </div>

                <div class="section">
                    <div class="info-box">
                        <div class="info-title">📢 설문 안내</div>
                        <div class="info-content">
                            모임 내에서 회원 신고가 접수되었습니다. 공정한 처리를 위해 모임원 여러분의 의견을 수렴합니다.
                            <ul class="info-list">
                                <li><strong>설문 참여는 익명으로 진행</strong>됩니다. 신고자와 투표 결과는 공개되지 않습니다.</li>
                                <li>모임 인원 <strong>10명 이하:</strong> 3명 이상 동의 시 피신고자는 모임에서 탈퇴됩니다.</li>
                                <li>모임 인원 <strong>10명 초과:</strong> 전체 인원의 30% 이상 동의 시 피신고자는 모임에서 탈퇴됩니다.</li>
                                <li>신중하게 판단하여 투표해주시기 바랍니다.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="section">
                    <div class="vote-section">
                        <div class="vote-question">
                            해당 회원의 모임 탈퇴에 동의하시나요?
                        </div>
                        <div class="vote-options">
                            <div class="vote-option">
                                <input type="radio" name="vote" id="agree" value="agree" class="vote-radio">
                                <label for="agree" class="vote-label">
                                    <div class="vote-icon">✅</div>
                                    <div>동의합니다</div>
                                </label>
                            </div>
                            <div class="vote-option">
                                <input type="radio" name="vote" id="disagree" value="disagree" class="vote-radio">
                                <label for="disagree" class="vote-label">
                                    <div class="vote-icon">❌</div>
                                    <div>동의하지 않습니다</div>
                                </label>
                            </div>
                        </div>

                        <!-- 상세 내용 입력 영역 - 동의 -->
                        <div id="agreeDetail" class="detail-section">
                            <div class="detail-title">📝 동의 사유를 작성해주세요</div>
                            <textarea id="agreeTextarea" class="detail-textarea" placeholder="탈퇴 동의 사유를 구체적으로 작성해주세요. (선택사항, 최대 500자)" maxlength="500"></textarea>
                            <div class="char-count"><span id="agreeCount">0</span> / 500자</div>
                            <div class="detail-note">
                                ℹ️ 작성하신 내용은 신고 처리에 참고자료로 활용됩니다. 구체적인 사례나 목격한 상황을 작성해주시면 더욱 공정한 판단에 도움이 됩니다.
                            </div>
                        </div>

                        <!-- 상세 내용 입력 영역 - 비동의 -->
                        <div id="disagreeDetail" class="detail-section">
                            <div class="detail-title">📝 비동의 사유를 작성해주세요</div>
                            <textarea id="disagreeTextarea" class="detail-textarea" placeholder="탈퇴 비동의 사유를 구체적으로 작성해주세요. (선택사항, 최대 500자)" maxlength="500"></textarea>
                            <div class="char-count"><span id="disagreeCount">0</span> / 500자</div>
                            <div class="detail-note">
                                ℹ️ 작성하신 내용은 신고 처리에 참고자료로 활용됩니다. 신고 내용이 사실과 다르거나 오해의 소지가 있다고 판단되는 이유를 작성해주세요.
                            </div>
                        </div>

                        <div class="stats-box">
                            <div class="stats-row">
                                <div class="stat-item">
                                    <div class="stat-value">7</div>
                                    <div class="stat-label">전체 모임원</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">3</div>
                                    <div class="stat-label">필요 동의 인원</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">4</div>
                                    <div class="stat-label">현재 참여 인원</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="warning-message">
                    <div class="warning-message-title">
                        <span>⚠️</span>
                        <span>주의사항</span>
                    </div>
                    <div class="warning-message-content">
                        • 투표는 <strong>1회만 가능</strong>하며, 제출 후 수정할 수 없습니다.<br>
                        • 피신고자가 탈퇴 처리될 경우, 탈퇴 사유는 <strong>'회원 신고'</strong>로 기록됩니다.<br>
                        • 피신고자는 탈퇴 후 <strong>소명 신청</strong>을 할 수 있습니다.<br>
                        • 허위 또는 악의적인 투표는 제재 대상이 될 수 있습니다.
                    </div>
                </div>

                <div class="button-group">
                    <button class="btn btn-cancel" onclick="goBack()">취소</button>
                    <button class="btn btn-submit" id="submitBtn" onclick="submitVote()" disabled>투표 제출</button>
                </div>
            </div>
        </div>

        <!-- 결과 화면 -->
        <div id="resultScreen" class="result-screen">
            <div class="survey-card">
                <div class="result-icon">✅</div>
                <div class="result-title">투표가 완료되었습니다</div>
                <div class="result-message">
                    의견 주셔서 감사합니다.<br>
                    설문 결과는 익명으로 처리되며, 일정 기준 이상 동의 시<br>
                    피신고자에게 처리 결과가 안내됩니다.
                </div>
                <div class="button-group">
                    <button class="btn btn-submit" onclick="goToGroupHome()">모임 홈으로</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        // 투표 선택 시 상세 내용 영역 표시 및 제출 버튼 활성화
        document.querySelectorAll('input[name="vote"]').forEach(radio => {
            radio.addEventListener('change', function() {
                // 모든 상세 내용 영역 숨기기
                document.getElementById('agreeDetail').classList.remove('active');
                document.getElementById('disagreeDetail').classList.remove('active');
                
                // 선택한 옵션에 따라 해당 영역 표시
                if (this.value === 'agree') {
                    document.getElementById('agreeDetail').classList.add('active');
                } else if (this.value === 'disagree') {
                    document.getElementById('disagreeDetail').classList.add('active');
                }
                
                // 제출 버튼 활성화
                document.getElementById('submitBtn').disabled = false;
            });
        });

        // 글자 수 카운터
        document.getElementById('agreeTextarea').addEventListener('input', function() {
            document.getElementById('agreeCount').textContent = this.value.length;
        });

        document.getElementById('disagreeTextarea').addEventListener('input', function() {
            document.getElementById('disagreeCount').textContent = this.value.length;
        });

        function submitVote() {
            const selectedVote = document.querySelector('input[name="vote"]:checked');
            
            if (!selectedVote) {
                alert('투표 항목을 선택해주세요.');
                return;
            }

            // 선택한 상세 내용 가져오기
            let detailContent = '';
            if (selectedVote.value === 'agree') {
                detailContent = document.getElementById('agreeTextarea').value.trim();
            } else {
                detailContent = document.getElementById('disagreeTextarea').value.trim();
            }

            if (confirm('투표를 제출하시겠습니까?\n제출 후에는 수정할 수 없습니다.')) {
                // 실제로는 서버에 투표 결과 및 상세 내용 전송
                const voteData = {
                    vote: selectedVote.value,
                    detail: detailContent
                };
                console.log('투표 결과:', voteData);

                // 화면 전환
                document.getElementById('surveyScreen').style.display = 'none';
                document.getElementById('resultScreen').style.display = 'block';
            }
        }

        function goBack() {
            if (confirm('설문 참여를 취소하시겠습니까?')) {
                history.back();
            }
        }

        function goToGroupHome() {
            window.location.href = 'group_home.jsp';
        }
    </script>
</body>
</html>