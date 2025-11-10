<%@ page contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" %>
<% 
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 가입 신청</title>
    
    <!-- CSS 파일 임포트 -->
    <link rel="stylesheet" href="css_new/common_sample.css">
    <link rel="stylesheet" href="css_new/topmenubar_sample.css">
    <link rel="stylesheet" href="css_new/home_sample.css">
    <link rel="stylesheet" href="css_new/manager_sample.css">
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <style>
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f5f7fa; }

        /* 네비게이션 바 */
        .navbar { background:#a8d5a1; display:flex; align-items:center; padding:0 20px; height:48px; position:sticky; top:0; z-index:1000; box-shadow:0 2px 4px rgba(0,0,0,0.1); gap:4px; }
        .nav-left { display:flex; align-items:center; gap:4px; flex:1; }
        .nav-right { display:flex; align-items:center; margin-left:auto; }
        .logo-tab { background:#8bc683; color:white; padding:0 20px; height:36px; border-radius:8px 8px 0 0; display:flex; align-items:center; gap:8px; font-weight:bold; font-size:16px; cursor:pointer; }
        .tab { background:#8bc683; color:white; border:none; padding:0 24px; height:36px; border-radius:8px 8px 0 0; cursor:pointer; font-size:14px; font-weight:500; transition:all 0.2s ease; text-decoration:none; display:flex; align-items:center; }
        .tab.active { background:#f5f7fa; color:#2d5a29; height:40px; }
        .profile-btn { background:#2d5a29; color:white; border:none; padding:8px 20px; border-radius:6px; cursor:pointer; font-size:14px; font-weight:500; text-decoration:none; display:flex; align-items:center; gap:6px; }

        /* 컨테이너 */	
        .container { max-width:800px; margin:40px auto; padding:0 20px; }
        .page-header { text-align:center; margin-bottom:40px; }
        .page-title { font-size:32px; font-weight:bold; color:#2d5a29; margin-bottom:10px; }
        .page-subtitle { font-size:16px; color:#666; }

        /* 모임 정보 카드 */
        .group-info-card { background:white; border-radius:12px; padding:30px; box-shadow:0 2px 8px rgba(0,0,0,0.08); margin-bottom:30px; }
        .group-header { display:flex; align-items:center; gap:20px; padding-bottom:20px; border-bottom:2px solid #f0f0f0; margin-bottom:20px; }
        .group-image { width:100px; height:100px; border-radius:12px; background:#e0e0e0; flex-shrink:0; }
        .group-title { font-size:24px; font-weight:bold; color:#333; margin-bottom:8px; }
        .group-meta { display:flex; gap:15px; flex-wrap:wrap; font-size:14px; color:#666; }
        .group-meta-item { display:flex; align-items:center; gap:5px; }

        /* 안내 박스 */
        .info-box { background:#e3f2fd; border-left:4px solid #2196f3; padding:20px; border-radius:8px; margin-bottom:30px; }
        .info-box-title { font-weight:600; color:#1565c0; margin-bottom:10px; display:flex; align-items:center; gap:8px; }
        .info-box-content { color:#1565c0; line-height:1.6; font-size:14px; }
        .info-box-content ul { margin-top:10px; padding-left:20px; }
        .info-box-content li { margin-bottom:5px; }

        /* 가입 가능 횟수 */
        .limit-notice { background:#fff3e0; border-left:4px solid #ff9800; padding:20px; border-radius:8px; margin-bottom:30px; }
        .limit-notice-title { font-weight:600; color:#f57c00; margin-bottom:10px; display:flex; align-items:center; gap:8px; }
        .limit-notice-content { color:#f57c00; font-size:14px; line-height:1.6; }
        .limit-bar { background:#ffe0b2; height:10px; border-radius:5px; overflow:hidden; margin-top:10px; }
        .limit-fill { height:100%; background:#ff9800; transition:width 0.3s; }
        .limit-text { font-size:12px; color:#f57c00; margin-top:5px; }

        /* 신청서 작성 */
        .application-form { background:white; border-radius:12px; padding:40px; box-shadow:0 2px 8px rgba(0,0,0,0.08); }
        .section { margin-bottom:35px; padding-bottom:35px; border-bottom:2px solid #f0f0f0; }
        .section:last-of-type { border-bottom:none; }
        .section-title { font-size:20px; color:#2d5a29; font-weight:bold; margin-bottom:20px; display:flex; align-items:center; gap:10px; }
        .form-group { margin-bottom:25px; }
        .form-label { display:block; font-size:15px; font-weight:600; color:#333; margin-bottom:10px; }
        .required { color:#f44336; margin-left:4px; }
        .form-input { width:100%; padding:14px 16px; border:2px solid #e0e0e0; border-radius:8px; font-size:14px; transition:all 0.3s; font-family:inherit; }
        .form-input:focus { outline:none; border-color:#8bc683; box-shadow:0 0 0 3px rgba(139,198,131,0.1); }
        .form-textarea { min-height:120px; resize:vertical; }
        .form-help { font-size:13px; color:#999; margin-top:8px; }
        .char-count { text-align:right; font-size:12px; color:#999; margin-top:5px; }
        .question-item { background:#f8faf8; padding:20px; border-radius:8px; border-left:4px solid #8bc683; margin-bottom:20px; }
        .question-text { font-weight:600; color:#2d5a29; margin-bottom:12px; line-height:1.5; }

        /* 버튼 */
        .button-group { display:flex; gap:15px; margin-top:40px; }
        .btn { flex:1; padding:16px 32px; border:none; border-radius:10px; font-size:16px; font-weight:600; cursor:pointer; transition:all 0.3s; text-decoration:none; text-align:center; }
        .btn-primary { background:#4CAF50; color:white; }
        .btn-primary:hover { background:#45a049; transform:translateY(-2px); box-shadow:0 4px 12px rgba(76,175,80,0.3); }
        .btn-secondary { background:#e0e0e0; color:#666; }
        .btn-secondary:hover { background:#d0d0d0; }

        @media (max-width:768px) {
            .container { padding:20px 15px; }
            .application-form { padding:25px 20px; }
            .group-header { flex-direction:column; text-align:center; }
            .button-group { flex-direction:column; }
        }
    </style>
    <script>
        function updateCharCount(textareaId, countId, maxLength) {
            const textarea = document.getElementById(textareaId);
            const count = document.getElementById(countId);
            const currentLength = textarea.value.length;
            count.textContent = `${currentLength} / ${maxLength}자`;
            count.style.color = currentLength > maxLength ? '#f44336' : '#999';
        }

        function submitApplication() {
            // 1. 유효성 검사
            const intro = document.getElementById('selfIntro').value.trim();
            if (!intro) {
                alert('한줄 자기소개는 필수 항목입니다.');
                document.getElementById('selfIntro').focus();
                return;
            }
            
            const questions = document.querySelectorAll('.question-answer');
            for (let q of questions) {
                if (!q.value.trim()) {
                    alert('모든 질문에 답변해주세요.');
                    q.focus();
                    return;
                }
            }

            const agree = document.getElementById('agreeRules').checked;
            if (!agree) {
                alert('모임 규칙에 동의해야 합니다.');
                return;
            }

            if (confirm('이 모임에 가입 신청하시겠습니까?')) {
                // 2. Form 생성
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'applicationcomplete.do';
                
                // userCode
                const userCodeInput = document.createElement('input');
                userCodeInput.type = 'hidden';
                userCodeInput.name = 'userCode';
                userCodeInput.value = document.getElementById('userCodeInput').value;
                form.appendChild(userCodeInput);
                console.log('✅ userCode:', userCodeInput.value);
                
                // groupJoinCode (✅ Controller에서 이 이름으로 받음)
                const groupJoinCodeInput = document.createElement('input');
                groupJoinCodeInput.type = 'hidden';
                groupJoinCodeInput.name = 'groupJoinCode';
                groupJoinCodeInput.value = document.getElementById('groupJoinCodeInput').value;
                form.appendChild(groupJoinCodeInput);
                console.log('✅ groupJoinCode:', groupJoinCodeInput.value);
                
                // introduce
                const introduceInput = document.createElement('input');
                introduceInput.type = 'hidden';
                introduceInput.name = 'introduce';
                introduceInput.value = intro;
                form.appendChild(introduceInput);
                console.log('✅ introduce:', intro);
                
                // answer
                const allAnswers = Array.from(questions)
                    .map(q => q.value.trim())
                    .join('|||');
                
                const answerInput = document.createElement('input');
                answerInput.type = 'hidden';
                answerInput.name = 'answer';
                answerInput.value = allAnswers;
                form.appendChild(answerInput);
                console.log('✅ answer:', allAnswers);
                
                // Form 제출
                document.body.appendChild(form);
                form.submit();
            }
        }

        function cancelApplication() {
            if (confirm('가입 신청을 취소하시겠습니까?')) {
                window.history.back();
            }
        }
    </script>
</head>
<body>
    <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">📝 모임 가입 신청</h1>
            <p class="page-subtitle">아래 정보를 작성하여 모임에 가입 신청하세요</p>
        </div>

        <!-- 모임 정보 -->
        <div class="group-info-card">
            <div class="group-header">
                <img src="https://via.placeholder.com/100" alt="모임 이미지" class="group-image">
                <div>
                    <h2 class="group-title">${groupDetail.groupTitle }</h2>
                    <div class="group-meta">
                        <div class="group-meta-item"><span>👥</span><span>${groupDetail.currentMemberCount}/${groupDetail.maxCount}</span></div>
                        <div class="group-meta-item"><span>📍</span><span>${groupDetail.region}</span></div>
                        <div class="group-meta-item"><span>⏰</span><span>${groupDetail.frequency}</span></div>
                        <div class="group-meta-item"><span>🎯</span><span>난이도: ${groupDetail.difficulty}</span></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 안내 박스 -->
        <div class="info-box">
            <div class="info-box-title"><span>ℹ️</span><span>가입 신청 안내</span></div>
            <div class="info-box-content">
                <ul>
                    <li>가입 신청 후 모임장의 승인을 기다려주세요.</li>
                    <li>승인이 완료되면 알림으로 안내해드립니다.</li>
                    <li>신청서 작성 내용은 모임장에게만 공개됩니다.</li>
                    <li>신청을 취소하려면 마이페이지에서 취소할 수 있습니다.</li>
                </ul>
            </div>
        </div>

        <!-- 가입 가능 횟수 -->
        <div class="limit-notice">
            <div class="limit-notice-title"><span>⚠️</span><span>가입 가능 횟수</span></div>
            <div class="limit-notice-content">
                현재 2개 모임에 참여 중입니다. 최대 3개까지 가입할 수 있습니다.
                <div class="limit-bar"><div class="limit-fill" style="width:66.6%;"></div></div>
                <div class="limit-text">남은 가입 가능 횟수: </div>
            </div>
        </div>

        <!-- 신청서 작성 -->
        <div class="application-form">
            <!-- 한줄 자기소개 -->
            <div class="section">
                <h3 class="section-title"><span>✍️</span><span>한줄 자기소개</span></h3>
                <div class="form-group">
                    <label class="form-label">자기소개<span class="required">*</span></label>
                    <textarea 
                        id="selfIntro"
                        class="form-input form-textarea"
                        placeholder="간단한 자기소개를 작성해주세요 (50자 이내)"
                        maxlength="50"
                        oninput="updateCharCount('selfIntro','introCount',50)"
                        name = "introduce"
                    ></textarea>
                    <div class="char-count" id="introCount">0 / 50자</div>
                    <p class="form-help">모임원들에게 보여지는 한줄 소개입니다.</p>
                </div>
            </div>

            <!-- 가입 질문 -->
<c:if test="${not empty groupQuestionRule.question}">
    <div class="section">
        <h3 class="section-title"><span>❓</span><span>가입 질문</span></h3>
        <p class="form-help" style="margin-bottom:20px;">모임장이 설정한 질문에 답변해주세요. 답변은 모임장에게만 공개됩니다.</p>
        <div class="question-item">
            <div class="question-text">${groupQuestionRule.question}</div>
            <textarea class="form-input form-textarea question-answer" 
                      name="answer" 
                      placeholder="답변을 입력해주세요" 
                      style="min-height:80px;"></textarea>
        </div>
    </div>
</c:if>

            <!-- 모임 규칙 확인 -->
            <div class="section">
                <h3 class="section-title"><span>📜</span><span>모임 규칙</span></h3>
                <div style="background:#f8faf8; padding:20px; border-radius:8px; line-height:1.8; color:#666;">
                    <p><strong style="color:#333;">다음 규칙을 확인하고 동의해주세요:</strong></p><br>
                    	${groupQuestionRule.rule }
                    <label style="display:flex; align-items:center; gap:10px; cursor:pointer;">
                        <input type="checkbox" id="agreeRules" style="width:18px; height:18px;">
                        <span style="color:#333; font-weight:600;">위 규칙을 확인했으며 이를 준수하겠습니다.</span>
                    </label>
                </div>
            </div>
            
            <div class="application-form">
            <input type="hidden" id="userCodeInput" name="userCode" value="${userCode}">
            <input type="hidden" id="groupJoinCodeInput" name="groupApplyCode" value="${groupApplyCode}">
            <div class="section">
                </div>

            <!-- 버튼 -->
            <div class="button-group">
                <button type="button" class="btn btn-primary" onclick="submitApplication()">✅ 가입 신청하기</button>
                <button type="button" class="btn btn-secondary" onclick="cancelApplication()">취소</button>
            </div>
        </div>
    </div>
</body>
</html>
















