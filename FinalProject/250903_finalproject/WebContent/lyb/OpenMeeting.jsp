
<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 모임 모집글 작성 화면 생성 -->
<%@ page language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>공모자들 - 모임 개설</title>

    <style>

        body {

            font-family: Arial, sans-serif;

            background-color: #f7f7f7;

            padding: 20px;

        }

        h1 {

            text-align: center;

            color: #333;

        }

        .container {

            width: 800px;

            margin: 0 auto;

            background: #fff;

            padding: 20px;

            border-radius: 10px;

            box-shadow: 0 0 10px rgba(0,0,0,0.1);

        }

        label {

            display: block;

            margin-top: 15px;

            font-weight: bold;

        }

        input[type=text], input[type=password], select, textarea, input[type=file] {

            width: 100%;

            padding: 8px;

            margin-top: 5px;

            border-radius: 5px;

            border: 1px solid #ccc;

        }

        textarea { resize: vertical; }

        .form-section { margin-top: 20px; border-top: 1px solid #ddd; padding-top: 20px; }

        .btn-submit {

            margin-top: 20px;

            padding: 10px 20px;

            background-color: #4CAF50;

            color: white;

            border: none;

            border-radius: 5px;

            cursor: pointer;

            font-size: 16px;

        }

        .btn-submit:hover { background-color: #45a049; }

        .inline-group {

            display: flex;

            gap: 10px;

            align-items: center;

            flex-wrap: wrap;

        }

        .tip { font-size: 12px; color: #666; margin-top: 3px; }

        #regionList {

            border: 1px solid #ccc;

            max-height: 120px;

            overflow-y: auto;

            display: none;

            padding-left: 0;

            margin-top: 0;

            list-style: none;

            position: absolute;

            background: white;

            width: calc(100% - 18px);

            z-index: 1000;

        }

        #regionList li {

            padding: 5px;

            cursor: pointer;

        }

        #regionList li:hover {

            background-color: #eee;

        }

        .region-container {

            position: relative;

        }

        /* 👇 이미지 미리보기 스타일 */

        #preview {

            display: none;

            width: 200px;

            height: auto;

            margin-top: 10px;

            border-radius: 10px;

            box-shadow: 0 0 8px rgba(0,0,0,0.2);

        }

    </style>



    <script>

        // 온라인/오프라인 선택 시 지역 입력 활성화/비활성화

        function toggleRegion() {

            var offline = document.getElementById("offline");

            var regionInput = document.getElementById("region");

            regionInput.disabled = !offline.checked;

            if(!offline.checked) {

                regionInput.value = "";

            }

        }



        // 모임 공개/비공개 비밀번호 표시

        function togglePassword() {

            var privacy = document.getElementById("privacy");

            var passwordDiv = document.getElementById("passwordDiv");

            passwordDiv.style.display = privacy.value === "private" ? "block" : "none";

        }



        // 동 자동완성 기능

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

                };

                list.appendChild(li);

            });

            list.style.display = matches.length ? 'block' : 'none';

        }



        // 👇 이미지 미리보기 함수

        function previewImage(event) {

            const file = event.target.files[0];

            const preview = document.getElementById('preview');

            if (file) {

                const reader = new FileReader();

                reader.onload = function(e) {

                    preview.src = e.target.result;

                    preview.style.display = 'block';

                }

                reader.readAsDataURL(file);

            } else {

                preview.src = '#';

                preview.style.display = 'none';

            }

        }



        // ✅ 비밀번호 일치 검사

        function validatePassword() {

            const privacy = document.getElementById("privacy").value;

            if (privacy === "private") {

                const pw1 = document.getElementById("password").value;

                const pw2 = document.getElementById("passwordConfirm").value;



                if (!pw1 || !pw2) {

                    alert("비밀번호를 모두 입력해주세요.");

                    return false;

                }

                if (pw1 !== pw2) {

                    alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");

                    document.getElementById("password").value = "";

                    document.getElementById("passwordConfirm").value = "";

                    document.getElementById("password").focus();

                    return false;

                }

            }

            return true;

        }



        window.onload = function() {

            toggleRegion();

            togglePassword();

        }

    </script>

</head>



<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_APP_KEY&libraries=services"></script>

<script>

var ps = new kakao.maps.services.Places();

function searchRegionAPI() {

    var keyword = document.getElementById("region").value;

    if(!keyword) return;

    ps.keywordSearch(keyword, function(data, status) {

        var list = document.getElementById("regionList");

        list.innerHTML = '';

        if(status === kakao.maps.services.Status.OK) {

            data.forEach(place => {

                var li = document.createElement("li");

                li.textContent = place.address_name;

                li.onclick = () => {

                    document.getElementById("region").value = place.address_name;

                    list.style.display = 'none';

                };

                list.appendChild(li);

            });

            list.style.display = data.length ? 'block' : 'none';

        }

    });

}

</script>



<body>

    <div class="container">

        <h1>공모자들 - 모임 개설</h1>



        <!-- ✅ 비밀번호 확인 검사를 위해 onsubmit 추가 -->

        <form action="#" method="post" enctype="multipart/form-data" onsubmit="return validatePassword()">

            <!-- 모임 기본 정보 -->

            <div class="form-section">

                <label for="title">모임 이름</label>

                <input type="text" id="title" name="title" placeholder="모임 이름을 입력하세요" >

                <div class="tip">모임 이름은 중복 가능하며, 간결하고 기억하기 쉽게 작성하세요.</div>



                <label for="image">모임 이미지 등록</label>

                <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(event)">

                <div class="tip">이미지가 없으면 기본 이미지가 사용됩니다.</div>

                <img id="preview" src="#" alt="이미지 미리보기">



                <label>카테고리</label>

                <div class="inline-group">

                    <input type="radio" id="category_reading" name="category" value="독서" checked>

                    <label for="category_reading">독서</label>

                    <input type="radio" id="category_language" name="category" value="어학">

                    <label for="category_language">어학</label>

                    <input type="radio" id="category_it" name="category" value="IT">

                    <label for="category_it">IT</label>

                    <input type="radio" id="category_startup" name="category" value="창업·취업">

                    <label for="category_startup">창업·취업</label>

                    <input type="radio" id="category_cert" name="category" value="자격증">

                    <label for="category_cert">자격증</label>

                    <input type="radio" id="category_exam" name="category" value="시험">

                    <label for="category_exam">시험</label>

                    <input type="radio" id="category_hobby" name="category" value="취미">

                    <label for="category_hobby">취미</label>

                    <input type="radio" id="category_etc" name="category" value="기타">

                    <label for="category_etc">기타</label>

                </div>



                <label>모임 형태</label>

                <div class="inline-group">

                    <input type="checkbox" id="online" name="meeting_type" value="온라인" checked onclick="toggleRegion()">

                    <label for="online">온라인</label>

                    <input type="checkbox" id="offline" name="meeting_type" value="오프라인" onclick="toggleRegion()">

                    <label for="offline">오프라인</label>

                </div>



                <label for="region">지역 (동 기준)</label>

                <div class="region-container">

                    <input type="text" id="region" name="region" placeholder="예: 강남동" oninput="searchRegion()">

                    <ul id="regionList"></ul>

                </div>



                <label for="days">요일 및 시간</label>

                <input type="text" id="days" name="days" placeholder="예: 월/수/금 19:00~21:00">

            </div>



            <!-- 참여 제한 -->

            <div class="form-section">

                <label>청소년 환영</label>

                <select name="teen_welcome">

                    <option value="yes">예</option>

                    <option value="no" selected>아니오</option>

                </select>



                <label>인원 수</label>

                <input type="text" name="member_limit" value="5" readonly>



                <label>성별 제한</label>

                <select name="gender_limit">

                    <option value="none" selected>제한 없음</option>

                    <option value="male">동일 성별만</option>

                </select>

            </div>



            <!-- 추가 정보 -->

            <div class="form-section">

                <label>한줄 자기소개서 필수 여부</label>

                <select name="intro_required">

                    <option value="yes" selected>예</option>

                    <option value="no">아니오</option>

                </select>



                <label>가입 질문 작성</label>

                <textarea name="join_question" rows="3"></textarea>



                <label>모임 내 주의사항/규칙</label>

                <textarea name="rules" rows="3"></textarea>



                <label>지정한 기간 이상 투표 미참가 시 탈퇴 설정</label>

                <select name="vote_absence">

                    <option value="1">1주</option>

                    <option value="2">2주</option>

                    <option value="3">3주</option>

                    <option value="4" selected>4주</option>

                </select>



                <label>모임 공개/비공개 설정</label>

                <select id="privacy" name="privacy" onchange="togglePassword()">

                    <option value="public" selected>공개</option>

                    <option value="private">비공개</option>

                </select>



                <div id="passwordDiv" style="display:none; margin-top:5px;">

                    <label for="password">비밀번호 설정</label>

                    <input type="password" id="password" name="password" placeholder="비밀번호 입력">

                    <!-- ✅ 비밀번호 재입력 추가 -->

                    <label for="passwordConfirm">비밀번호 확인</label>

                    <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호 다시 입력">

                </div>



                <label>학습 난이도</label>

                <select name="difficulty">

                    <option value="상">상</option>

                    <option value="중" selected>중</option>

                    <option value="하">하</option>

                </select>

            </div>



            <button type="submit" class="btn-submit">모임 개설</button>

        </form>

    </div>

</body>

</html>