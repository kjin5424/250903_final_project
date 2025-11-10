<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 정보 수정</title>
    <style>
        /* CSS 코드는 변경하지 않고 그대로 유지합니다. */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        .navbar { background: #a8d5a1; display: flex; align-items: center; padding: 0 20px; height: 48px; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); gap: 4px; }
        .nav-left { display: flex; align-items: center; gap: 4px; flex: 1; }
        .nav-right { display: flex; align-items: center; margin-left: auto; }
        .logo-tab { background: #8bc683; color: white; padding: 0 20px; height: 36px; border-radius: 8px 8px 0 0; display: flex; align-items: center; gap: 8px; font-weight: bold; font-size: 16px; cursor: pointer; }
        .tab { background: #8bc683; color: white; border: none; padding: 0 24px; height: 36px; border-radius: 8px 8px 0 0; cursor: pointer; font-size: 14px; font-weight: 500; transition: all 0.2s ease; text-decoration: none; display: flex; align-items: center; }
        .tab.active { background: #f5f7fa; color: #2d5a29; height: 40px; }
        .login-btn { background: #2d5a29; color: white; border: none; padding: 8px 20px; border-radius: 6px; cursor: pointer; font-size: 14px; font-weight: 500; text-decoration: none; display: flex; align-items: center; gap: 6px; }
        .container { max-width: 900px; margin: 30px auto; padding: 0 20px; }
        .page-header { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08); margin-bottom: 20px; }
        .page-header h1 { color: #2d5a29; font-size: 28px; margin-bottom: 10px; }
        .page-header p { color: #666; font-size: 14px; }
        .warning-alert { background: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin-top: 15px; border-radius: 4px; }
        .warning-alert strong { color: #856404; }
        .warning-alert p { color: #856404; margin-top: 5px; }
        .form-container { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08); }
        .form-section { margin-bottom: 35px; padding-bottom: 35px; border-bottom: 2px solid #f0f0f0; }
        .form-section:last-of-type { border-bottom: none; }
        .section-title { font-size: 20px; color: #2d5a29; margin-bottom: 20px; font-weight: 600; display: flex; align-items: center; gap: 10px; }
        label { display: block; margin-top: 20px; margin-bottom: 8px; font-weight: 600; color: #333; font-size: 15px; }
        label.required::after { content: " *"; color: #f44336; }
        input[type=text], input[type=password], select, textarea, input[type=file] { width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 14px; transition: all 0.3s; font-family: inherit; }
        input[type=text]:focus, input[type=password]:focus, select:focus, textarea:focus { outline: none; border-color: #8bc683; box-shadow: 0 0 0 3px rgba(139, 198, 131, 0.1); }
        textarea { resize: vertical; min-height: 100px; }
        .tip { font-size: 13px; color: #999; margin-top: 6px; display: block; line-height: 1.5; }
        .tip.important { color: #f57c00; font-weight: 500; }
        .inline-group { display: flex; gap: 15px; align-items: center; flex-wrap: wrap; margin-top: 10px; }
        .inline-group input[type=radio], .inline-group input[type=checkbox] { width: auto; margin: 0; }
        .inline-group label { margin: 0; font-weight: normal; display: flex; align-items: center; gap: 5px; }
        .region-container { position: relative; }
        #regionList { border: 2px solid #e0e0e0; max-height: 150px; overflow-y: auto; display: none; padding: 0; margin: 0; list-style: none; position: absolute; background: white; width: 100%; z-index: 1000; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); margin-top: 5px; }
        #regionList li { padding: 12px 15px; cursor: pointer; transition: background 0.2s; }
        #regionList li:hover { background-color: #f0f8f0; }
        .image-preview-container { margin-top: 15px; }
        #currentImage, #preview { max-width: 250px; height: auto; border-radius: 10px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); display: block; margin-bottom: 10px; }
        #preview { display: none; }
        .image-label { font-size: 13px; color: #666; font-weight: 500; margin-bottom: 5px; }
        .remove-image-btn { padding: 8px 16px; background: #f44336; color: white; border: none; border-radius: 6px; cursor: pointer; font-size: 13px; transition: all 0.3s; }
        .remove-image-btn:hover { background: #d32f2f; }
        .password-section { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-top: 15px; display: none; }
        .action-buttons { display: flex; gap: 15px; margin-top: 40px; justify-content: center; }
        .btn { padding: 15px 40px; border: none; border-radius: 8px; font-size: 16px; font-weight: 600; cursor: pointer; transition: all 0.3s; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; }
        .btn-primary { background: #4CAF50; color: white; }
        .btn-primary:hover { background: #45a049; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3); }
        .btn-secondary { background: #e0e0e0; color: #666; }
        .btn-secondary:hover { background: #d0d0d0; }
        .btn-danger { background: #f44336; color: white; }
        .btn-danger:hover { background: #d32f2f; }
        .changed-indicator { display: inline-block; background: #ff9800; color: white; padding: 3px 8px; border-radius: 4px; font-size: 11px; font-weight: 600; margin-left: 8px; }
        @media (max-width: 768px) { .form-container { padding: 25px 20px; } .action-buttons { flex-direction: column; } .btn { width: 100%; justify-content: center; } }
    </style>
    <script>
        // 온라인/오프라인 선택 시 지역 입력 활성화/비활성화
        function toggleRegion() {
            // value 값은 DTO 필드명인 onOffType(1:온라인, 2:오프라인, 3:모두)의 선택에 따라 달라집니다.
            const onOffType = parseInt(document.querySelector('input[name="onOffType"]:checked')?.value || '1');
            const regionInput = document.getElementById("region");
            
            // 1: 온라인, 2: 오프라인, 3: 모두
            const isOffline = onOffType === 2 || onOffType === 3;

            regionInput.disabled = !isOffline;
            
            if(!isOffline) {
                // 온라인 전용인 경우 지역 정보 초기화 (선택사항)
                // regionInput.value = "";
            }
        }

        // 모임 공개/비공개 비밀번호 표시
        function togglePassword() {
            // privacy는 DTO의 password 필드 유무에 따라 판단하기 어려워, 임시로 privacy select box를 사용합니다.
            // 실제 구현에서는 password 필드가 null/empty인지로 판단해야 합니다.
            const privacySelect = document.getElementById("privacy");
            const passwordDiv = document.getElementById("passwordDiv");
            // passwordDiv.style.display = privacySelect.value === "private" ? "block" : "none";
            
            // DTO의 password 값으로 초기 상태 설정 (groupDetail.password가 null이 아니면 비공개로 가정)
            const currentPassword = document.getElementById("currentPasswordValue").value;
            const isPrivate = (privacySelect.value === "private") || (currentPassword && currentPassword.trim() !== "");
            passwordDiv.style.display = isPrivate ? "block" : "none";
        }

        // 동 자동완성 기능 (기존 로직 유지)
        const regions = ["홍대입구동","강남동","역삼동","삼성동","신촌동","연남동","청담동","을지로동"];
        function searchRegion() {
            const input = document.getElementById("region").value;
            const list = document.getElementById("regionList");
            list.innerHTML = '';
            if (!input) { list.style.display = 'none'; return; }
            const matches = regions.filter(r => r.includes(input));
            matches.forEach(r => {
                const li = document.createElement("li");
                li.textContent = r;
                li.onclick = () => {
                    document.getElementById("region").value = r;
                    list.style.display = 'none';
                    markAsChanged('region');
                };
                list.appendChild(li);
            });
            list.style.display = matches.length ? 'block' : 'none';
        }

        // 이미지 미리보기 함수 (기존 로직 유지)
        function previewImage(event) {
            const file = event.target.files[0];
            const preview = document.getElementById('preview');
            const currentImage = document.getElementById('currentImage');
            
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    if(currentImage) currentImage.style.display = 'none';
                }
                reader.readAsDataURL(file);
                markAsChanged('image');
            } else {
                preview.src = '#';
                preview.style.display = 'none';
                if(currentImage) currentImage.style.display = 'block';
            }
        }

        // 기존 이미지 삭제 (기존 로직 유지)
        function removeCurrentImage() {
            if(confirm('현재 이미지를 삭제하시겠습니까? (기본 이미지로 변경됩니다)')) {
                document.getElementById('currentImage').style.display = 'none';
                document.getElementById('removeImageFlag').value = 'true';
                markAsChanged('image');
            }
        }

        // 비밀번호 일치 검사 및 최종 확인
        function validatePassword() {
            const privacy = document.getElementById("privacy").value;
            
            // 비밀번호 검증 (비공개 모임이거나 비밀번호가 입력된 경우)
            if (privacy === "private") {
                const pw1 = document.getElementById("password").value;
                const pw2 = document.getElementById("passwordConfirm").value;

                // 새로운 비밀번호를 입력했지만 확인과 일치하지 않는 경우
                if (pw1 && (pw1 !== pw2)) {
                    alert("새 비밀번호가 확인과 일치하지 않습니다. 다시 입력해주세요.");
                    document.getElementById("password").value = "";
                    document.getElementById("passwordConfirm").value = "";
                    document.getElementById("password").focus();
                    return false;
                }
            }
            
            // 변경사항 확인
            if(hasChanges()) {
                return confirm('모임 정보를 수정하시겠습니까?\n모든 모임원에게 변경 알림이 발송됩니다.');
            } else {
                alert('변경된 내용이 없습니다.');
                return false;
            }
        }

        // 변경사항 추적 (기존 로직 유지)
        const changedFields = new Set();
        function markAsChanged(fieldId) { changedFields.add(fieldId); updateChangedIndicators(); }
        function hasChanges() { return changedFields.size > 0; }
        function updateChangedIndicators() { /* 변경사항 표시 로직 (선택사항) */ }
        function cancelEdit() { 
            if(hasChanges()) {
                if(confirm('변경사항이 저장되지 않습니다. 정말 취소하시겠습니까?')) { history.back(); }
            } else { history.back(); }
        }
        function setupChangeDetection() {
            const inputs = document.querySelectorAll('input, select, textarea');
            inputs.forEach(input => {
                input.addEventListener('change', function() {
                    markAsChanged(this.id || this.name);
                });
            });
        }

        window.onload = function() {
            // DTO 값을 기반으로 초기 상태 설정
            // 1. 모임 형태에 따른 지역 입력 활성화/비활성화
            // (주의: DTO의 onOffType 값에 따라 라디오 버튼의 checked 상태가 설정되어야 함)
            const initialOnOffType = document.querySelector('input[name="onOffType"]:checked')?.value;
            if (initialOnOffType) toggleRegion();
            
            // 2. 비밀번호 섹션 표시
            togglePassword();

            // 3. 변경 감지 설정
            setupChangeDetection();
        }
    </script>
</head>
<body>

    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab">
                <span>로고 들어갈 자리</span>
            </div>
            <a href="?page=notice" class="tab">공지사항</a>
            <a href="?page=groups" class="tab">모임구경</a>
            <a href="?page=creategroup" class="tab">모임 개설</a>
            <a href="?page=mygroups" class="tab active">내 모임</a>
        </div>
        <div class="nav-right">
            <a href="mypage.jsp" class="login-btn">
                <span>👤</span>
                <span>마이페이지</span>
            </a>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1>⚙️ 모임 정보 수정</h1>
            <p>모임 정보를 수정할 수 있습니다. 변경 시 모든 모임원에게 알림이 발송됩니다.</p>
            <div class="warning-alert">
                <strong>⚠️ 중요 안내</strong>
                <p>• 모임 정보 변경 시 모든 모임원에게 알림이 발송됩니다.</p>
                <p>• 악의적인 변경사항은 모임원들의 신고 대상이 될 수 있습니다.</p>
                <p>• 투표 미참여 탈퇴 기간 변경 시, 해당 조건으로 탈퇴되는 회원이 있을 경우 안내됩니다.</p>
            </div>
        </div>

        <form action="/groupeditcomplete.do" method="post" enctype="multipart/form-data" onsubmit="return validatePassword()">
            
            <input type="hidden" name="groupApplyCode" value="${groupDetail.groupApplyCode}">
            <input type="hidden" id="removeImageFlag" name="removeImageFlag" value="false">
            
            <input type="hidden" id="currentPasswordValue" value="${groupDetail.password}"> 
            
            <div class="form-container">
                <div class="form-section">
                    <h2 class="section-title">📋 기본 정보</h2>
                    
                    <label for="groupTitle" class="required">모임 이름</label>
                    <input type="text" id="groupTitle" name="groupTitle" value="${groupDetail.groupTitle}" placeholder="모임 이름을 입력하세요" required>
                    <span class="tip">모임 이름은 중복 가능하며, 간결하고 기억하기 쉽게 작성하세요.</span>

                    <label for="image">모임 이미지</label>
                    <div class="image-preview-container">
                        <div class="image-label">📷 현재 이미지</div>
                        <img id="currentImage" src="${groupDetail.savePath}" alt="현재 모임 이미지" 
                             onerror="this.onerror=null;this.src='https://via.placeholder.com/250';"
                             <c:if test="${empty groupDetail.savePath}">style="display:none;"</c:if>>
                        
                        <button type="button" class="remove-image-btn" onclick="removeCurrentImage()">🗑️ 이미지 삭제</button>
                        
                        <div style="margin-top: 20px;">
                            <div class="image-label">📁 새 이미지 업로드</div>
                            <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(event)">
                            <span class="tip">새 이미지를 업로드하면 기존 이미지가 교체됩니다.</span>
                            <img id="preview" src="#" alt="이미지 미리보기">
                        </div>
                    </div>

                    <label class="required">카테고리</label>
                    <div class="inline-group">
                        <label><input type="radio" name="topicType" value="1" <c:if test="${groupDetail.topicType == 1}">checked</c:if>> 독서</label>
                        <label><input type="radio" name="topicType" value="2" <c:if test="${groupDetail.topicType == 2}">checked</c:if>> 어학</label>
                        <label><input type="radio" name="topicType == 3" name="topicType" value="3" <c:if test="${groupDetail.topicType == 3}">checked</c:if>> IT</label>
                        <label><input type="radio" name="topicType" value="4" <c:if test="${groupDetail.topicType == 4}">checked</c:if>> 창업·취업</label>
                        <label><input type="radio" name="topicType" value="5" <c:if test="${groupDetail.topicType == 5}">checked</c:if>> 자격증</label>
                        <label><input type="radio" name="topicType" value="6" <c:if test="${groupDetail.topicType == 6}">checked</c:if>> 시험</label>
                        <label><input type="radio" name="topicType" value="7" <c:if test="${groupDetail.topicType == 7}">checked</c:if>> 취미</label>
                        <label><input type="radio" name="topicType" value="8" <c:if test="${groupDetail.topicType == 8}">checked</c:if>> 기타</label>
                    </div>

                    <label class="required">모임 형태</label>
                    <div class="inline-group">
                        <label><input type="radio" id="online" name="onOffType" value="1" onclick="toggleRegion()" <c:if test="${groupDetail.onOffType == 1 || groupDetail.onOffType == 3}">checked</c:if>> 온라인</label>
                        <label><input type="radio" id="offline" name="onOffType" value="2" onclick="toggleRegion()" <c:if test="${groupDetail.onOffType == 2 || groupDetail.onOffType == 3}">checked</c:if>> 오프라인</label>
                        <label><input type="radio" id="both" name="onOffType" value="3" onclick="toggleRegion()" <c:if test="${groupDetail.onOffType == 3}">checked</c:if>> 모두</label>
                    </div>

                    <label for="region">지역 (동 기준)</label>
                    <div class="region-container">
                        <input type="text" id="region" name="region" value="${groupDetail.region}" placeholder="예: 강남동" oninput="searchRegion()">
                        <ul id="regionList"></ul>
                    </div>
                    <span class="tip">오프라인 모임일 경우 활동 지역을 입력해주세요.</span>

                    <label for="groupContent" class="required">모임 내용/설명</label>
                    <textarea id="groupContent" name="groupContent" rows="5" placeholder="모임의 상세 내용과 목표, 활동 방식을 상세히 작성하세요." required>${groupDetail.groupContent}</textarea>
                    
                    <label for="days" class="required">요일 및 시간</label>
                    <input type="text" id="days" name="days" value="${groupDetail.days}" placeholder="예: 월/수/금 19:00~21:00" required>
                    <span class="tip">청소년이 포함된 모임은 종료 시간이 오후 10시를 넘을 수 없습니다.</span>
                </div>

                <div class="form-section">
                    <h2 class="section-title">👥 참여 제한</h2>
                    
                    <label for="youthFriendlyType">청소년 환영</label>
                    <select id="youthFriendlyType" name="youthFriendlyType">
                        <option value="1" <c:if test="${groupDetail.youthFriendlyType == 1}">selected</c:if>>예</option>
                        <option value="2" <c:if test="${groupDetail.youthFriendlyType == 2}">selected</c:if>>아니오</option>
                    </select>
                    <span class="tip">청소년 환영 모임은 종료 시간이 오후 10시 이후가 될 수 없습니다.</span>

                    <label for="member_limit">인원 수</label>
                    <input type="text" id="member_limit" name="member_limit" value="${groupDetail.currentMemberCount}명 / ${groupDetail.maxMemberCount}명" readonly>
                    <span class="tip important">💡 현재 레벨 ${groupDetail.level} - 최대 ${groupDetail.maxMemberCount}명까지 모집 가능합니다. 레벨업 시 인원 상한이 증가합니다.</span>

                    <label for="genderType">성별 제한</label>
                    <select id="genderType" name="genderType">
                        <option value="1" <c:if test="${groupDetail.genderType == 1}">selected</c:if>>제한 없음</option>
                        <option value="2" <c:if test="${groupDetail.genderType == 2}">selected</c:if>>동일 성별만</option>
                    </select>
                </div>

                <div class="form-section">
                    <h2 class="section-title">📝 추가 정보</h2>
                    
                    <label for="intro_required">한줄 자기소개서 필수 여부</label>
                    <select id="intro_required" name="intro_required">
                        <option value="yes" selected>예</option>
                        <option value="no">아니오</option>
                    </select>

                    <label for="question">가입 질문 작성</label>
                    <textarea id="question" name="question" rows="4" placeholder="가입 희망자에게 물어볼 질문을 작성하세요 (선택사항)">${groupDetail.question}</textarea>

                    <label for="rule">모임 내 주의사항/규칙</label>
                    <textarea id="rule" name="rule" rows="5" placeholder="모임 규칙이나 주의사항을 작성하세요 (선택사항)">${groupDetail.rule}</textarea>

                    <label for="kickOut">지정한 기간 이상 투표 미참가 시 탈퇴 설정</label>
                    <select id="kickOut" name="kickOut">
                        <option value="1" <c:if test="${groupDetail.kickOut == 1}">selected</c:if>>1주</option>
                        <option value="2" <c:if test="${groupDetail.kickOut == 2}">selected</c:if>>2주</option>
                        <option value="3" <c:if test="${groupDetail.kickOut == 3}">selected</c:if>>3주</option>
                        <option value="4" <c:if test="${groupDetail.kickOut == 4}">selected</c:if>>4주</option>
                    </select>
                    <span class="tip important">⚠️ 변경 시 해당 조건으로 탈퇴될 회원이 있을 경우 안내됩니다.</span>

                    <label for="privacy">모임 공개/비공개 설정</label>
                    <select id="privacy" name="privacy" onchange="togglePassword()">
                        <option value="public" <c:if test="${empty groupDetail.password}">selected</c:if>>공개</option>
                        <option value="private" <c:if test="${not empty groupDetail.password}">selected</c:if>>비공개</option>
                    </select>

                    <div id="passwordDiv" class="password-section">
                        <label for="password">비밀번호 설정</label>
                        <input type="password" id="password" name="password" placeholder="비밀번호 입력 (변경 시에만 입력)">
                        <span class="tip">비밀번호를 변경하지 않으려면 비워두세요.</span>
                        
                        <label for="passwordConfirm">비밀번호 확인</label>
                        <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호 다시 입력">
                    </div>

                    <label for="difficultyType">학습 난이도</label>
                    <select id="difficultyType" name="difficultyType">
                        <option value="1" <c:if test="${groupDetail.difficultyType == 1}">selected</c:if>>상</option>
                        <option value="2" <c:if test="${groupDetail.difficultyType == 2}">selected</c:if>>중</option>
                        <option value="3" <c:if test="${groupDetail.difficultyType == 3}">selected</c:if>>하</option>
                    </select>
                </div>

                <div class="action-buttons">
                    <button type="submit" class="btn btn-primary">✅ 수정 완료</button>
                    <button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
                    </div>
            </div>
        </form>
    </div>
</body>
</html>