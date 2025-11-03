<%@ page contentType="text/html; charset=UTF-8" %>

<!-- 모임원 과 게시물은 아직 안 한 미완성본 -->
<!-- 모임 모집글 화면 생성 -->
<%@ page language="java" %>

<!DOCTYPE html>

<html lang="ko">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>공모자들 - 모임 상세보기</title>

    <style>

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }



        /* 네비게이션 */

        .navbar { background: #a8d5a1; display: flex; align-items: center; padding: 0 20px; height: 48px; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 4px rgba(0,0,0,0.1); gap:4px;}

        .nav-left { display:flex; align-items:center; gap:4px; flex:1; }

        .nav-right { display:flex; align-items:center; margin-left:auto; }

        .logo-tab { background:#8bc683; color:white; padding:0 20px; height:36px; border-radius:8px 8px 0 0; display:flex; align-items:center; gap:8px; font-weight:bold; font-size:16px; cursor:pointer; }

        .tab { background:#8bc683; color:white; border:none; padding:0 24px; height:36px; border-radius:8px 8px 0 0; cursor:pointer; font-size:14px; font-weight:500; text-decoration:none; display:flex; align-items:center; }

        .tab.active { background:#f5f7fa; color:#2d5a29; height:40px; }

        .login-btn { background:#2d5a29; color:white; border:none; padding:8px 20px; border-radius:6px; cursor:pointer; font-size:14px; font-weight:500; text-decoration:none; display:flex; align-items:center; gap:6px; }



        /* 컨테이너 */

        .container { max-width:1200px; margin:30px auto; padding:0 20px; }

        .back-btn { display:inline-flex; align-items:center; gap:8px; padding:10px 20px; background:white; border:1px solid #ddd; border-radius:8px; color:#666; text-decoration:none; margin-bottom:20px; transition: all 0.2s;}

        .back-btn:hover { background:#f5f7fa; border-color:#8bc683; color:#2d5a29; }



        /* 모임 헤더 */

        .group-header { background:white; border-radius:12px; padding:30px; box-shadow:0 2px 8px rgba(0,0,0,0.08); margin-bottom:20px; display:flex; gap:30px; }

        .group-image { width:200px; height:200px; border-radius:12px; object-fit:cover; background:#e0e0e0; flex-shrink:0; }

        .group-info { flex:1; }

        .group-title-row { display:flex; align-items:center; gap:15px; margin-bottom:15px; }

        .group-title { font-size:28px; color:#2d5a29; font-weight:bold; }

        .badge { padding:6px 12px; border-radius:20px; font-size:12px; font-weight:600; background:#e3f2fd; color:#1565c0; }

        .badge.category { background:#f3e5f5; color:#7b1fa2; }

        .badge.status { background:#e8f5e9; color:#2e7d32; }

        .group-meta { display:flex; flex-wrap:wrap; gap:20px; margin-bottom:20px; color:#666; font-size:14px; }

        .meta-item { display:flex; align-items:center; gap:6px; }

        .meta-item strong { color:#333; }

        .group-stats { display:flex; gap:30px; padding:20px 0; border-top:1px solid #e0e0e0; border-bottom:1px solid #e0e0e0; margin:20px 0; }

        .stat-item { text-align:center; }

        .stat-value { font-size:24px; font-weight:bold; color:#2d5a29; }

        .stat-label { font-size:12px; color:#999; margin-top:5px; }

        .action-buttons { display:flex; gap:10px; margin-top:20px; }

        .btn { padding:12px 30px; border:none; border-radius:8px; font-size:15px; font-weight:600; cursor:pointer; transition:all 0.3s; text-decoration:none; display:inline-flex; align-items:center; gap:8px; }

        .btn-primary { background:#4CAF50; color:white; }

        .btn-primary:hover { background:#45a049; transform:translateY(-2px); box-shadow:0 4px 12px rgba(76,175,80,0.3); }

        .btn-outline { background:white; color:#2d5a29; border:2px solid #2d5a29; }

        .btn-outline:hover { background:#2d5a29; color:white; }

        .btn-favorite { background:white; color:#ff6b6b; border:2px solid #ff6b6b; }

        .btn-favorite:hover { background:#ff6b6b; color:white; }



        /* 탭 */

        .detail-tabs { background:white; border-radius:12px; padding:0; box-shadow:0 2px 8px rgba(0,0,0,0.08); margin-bottom:20px; overflow:hidden; }

        .tab-buttons { display:flex; border-bottom:2px solid #e0e0e0; }

        .tab-button { flex:1; padding:18px; background:white; border:none; color:#666; font-size:15px; font-weight:600; cursor:pointer; transition:all 0.3s; border-bottom:3px solid transparent; }

        .tab-button:hover { background:#f5f7fa; }

        .tab-button.active { color:#2d5a29; border-bottom-color:#2d5a29; }

        .tab-content { padding:30px; display:none; }



        /* 모임 소개 */

        .intro-section h3 { color:#2d5a29; margin-bottom:15px; font-size:18px; }

        .intro-section p { color:#666; line-height:1.8; white-space:pre-wrap; }

        .info-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(250px,1fr)); gap:15px; margin-top:20px; }

        .info-box { background:#f8faf8; padding:15px; border-radius:8px; border-left:4px solid #8bc683; }

        .info-box-title { font-size:13px; color:#999; margin-bottom:8px; }

        .info-box-value { font-size:15px; color:#333; font-weight:600; }



        /* 멤버 리스트 */

        .member-list { display:grid; grid-template-columns:repeat(auto-fill,minmax(200px,1fr)); gap:15px; }

        .member-card { background:#f8faf8; padding:20px; border-radius:8px; text-align:center; transition:all 0.3s; cursor:pointer; }

        .member-card:hover { background:#e8f5e9; transform:translateY(-2px); box-shadow:0 4px 12px rgba(0,0,0,0.1); }

        .member-avatar { width:60px; height:60px; border-radius:50%; background:#8bc683; color:white; display:flex; align-items:center; justify-content:center; font-size:24px; margin:0 auto 10px; }

        .member-name { font-weight:600; color:#333; margin-bottom:5px; }

        .member-role { font-size:12px; color:#999; background:#e0e0e0; padding:4px 8px; border-radius:12px; display:inline-block; }

        .member-intro { font-size:13px; color:#666; margin-top:10px; line-height:1.4; }



        /* 게시글 */

        .post-preview { background:#f8faf8; padding:15px; border-radius:8px; margin-bottom:10px; cursor:pointer; transition:all 0.3s; border-left:4px solid #8bc683; }

        .post-preview:hover { background:#e8f5e9; transform:translateX(5px); }

        .post-tag { display:inline-block; padding:4px 8px; background:#2d5a29; color:white; font-size:11px; border-radius:4px; margin-right:8px; }

        .post-title { font-size:15px; color:#333; font-weight:600; margin:8px 0; }

        .post-meta { font-size:12px; color:#999; }

        .empty-message { text-align:center; padding:40px; color:#999; }



        /* 모달 */

        .modal-bg { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); align-items:center; justify-content:center; z-index:2000; }

        .modal { background:white; padding:30px; border-radius:12px; max-width:500px; width:90%; position:relative; }

        .modal-close { position:absolute; top:10px; right:10px; cursor:pointer; font-size:18px; font-weight:bold; }



        @media (max-width:768px) {

            .group-header { flex-direction:column; }

            .group-image { width:100%; height:250px; }

            .group-stats { flex-wrap:wrap; gap:15px; }

            .action-buttons { flex-direction:column; }

            .btn { width:100%; justify-content:center; }

        }

    </style>

    <script>

        function switchTab(tabName){

            const buttons = document.querySelectorAll('.tab-button');

            const contents = document.querySelectorAll('.tab-content');



            buttons.forEach(btn=>btn.classList.remove('active'));

            contents.forEach(content=>content.style.display='none');



            document.querySelector(`[onclick*="${tabName}"]`).classList.add('active');

            document.getElementById(tabName).style.display='block';

        }



        function toggleFavorite(){

            const btn = document.querySelector('.btn-favorite');

            if(btn.textContent.includes('즐겨찾기')){

                btn.innerHTML='⭐ 즐겨찾기 해제';

                alert('즐겨찾기에 추가되었습니다!');

            } else {

                btn.innerHTML='☆ 즐겨찾기';

                alert('즐겨찾기에서 제거되었습니다!');

            }

        }



        function joinGroup(){

            if(confirm('이 모임에 가입 신청하시겠습니까?')){

                alert('가입 신청이 완료되었습니다!\n모임장의 승인을 기다려주세요.');

            }

        }



        function openModal(title, subtitle, content){

            document.getElementById('modal-title').textContent=title;

            document.getElementById('modal-subtitle').textContent=subtitle;

            document.getElementById('modal-content').textContent=content;

            document.getElementById('modal-bg').style.display='flex';

        }



        function closeModal(){

            document.getElementById('modal-bg').style.display='none';

        }



        window.onload=function(){

            // 처음 모임 소개 탭 보이기

            document.getElementById('intro').style.display='block';

            document.querySelector('.tab-button').classList.add('active');



            // 게시글 클릭 이벤트 (이벤트 위임)

            document.getElementById('posts').addEventListener('click', function(e){

                const post = e.target.closest('.post-preview');

                if(!post) return;

                const title = post.querySelector('.post-title').textContent;

                const meta = post.querySelector('.post-meta').textContent;

                const content = '게시글 상세 내용을 여기에 표시합니다.';

                openModal(title, meta, content);

            });



            // 멤버 클릭 이벤트 (이벤트 위임)

            document.getElementById('members').addEventListener('click', function(e){

                const member = e.target.closest('.member-card');

                if(!member) return;

                const name = member.querySelector('.member-name').textContent;

                const role = member.querySelector('.member-role').textContent;

                const intro = member.querySelector('.member-intro').textContent;

                openModal(name, role, intro);

            });

        }

    </script>

</head>

<body>

    <nav class="navbar">

        <div class="nav-left">

            <div class="logo-tab"><span>로고</span></div>

            <a href="?page=notice" class="tab">공지사항</a>

            <a href="?page=groups" class="tab active">모임구경</a>

            <a href="?page=creategroup" class="tab">모임 개설</a>

            <a href="?page=mygroups" class="tab">내 모임</a>

        </div>

        <div class="nav-right">

            <a href="login.jsp" class="login-btn">🔐 로그인</a>

        </div>

    </nav>



    <div class="container">

        <a href="?page=groups" class="back-btn">← 모임 목록으로</a>
		
		 


        <!-- 모임 헤더 -->

        <div class="group-header">

            <img src="https://via.placeholder.com/200" alt="모임 이미지" class="group-image">

            <div class="group-info">

                <div class="group-title-row">

                    <h1 class="group-title">알고리즘 정복 스터디</h1>

                    <span class="badge category">IT</span>

                    <span class="badge status">모집중</span>

                    <span class="badge">Lv.3</span>

                </div>

                <div class="group-meta">

                    <div class="meta-item"><span>👤</span><strong>모임장:</strong> 코딩마스터</div>

                    <div class="meta-item"><span>📅</span><strong>개설일:</strong> 2024-09-15</div>

                    <div class="meta-item"><span>📍</span><strong>지역:</strong> 강남동</div>

                    <div class="meta-item"><span>⏰</span><strong>활동시간:</strong> 월/수/금 19:00~21:00</div>

                </div>

                <div class="group-stats">

                    <div class="stat-item"><div class="stat-value">7/10</div><div class="stat-label">모임원</div></div>

                    <div class="stat-item"><div class="stat-value">85%</div><div class="stat-label">평균 출석률</div></div>

                    <div class="stat-item"><div class="stat-value">12회</div><div class="stat-label">누적 활동</div></div>

                    <div class="stat-item"><div class="stat-value">중</div><div class="stat-label">학습 난이도</div></div>

                </div>

                <div class="action-buttons">

                    <button class="btn btn-primary" onclick="joinGroup()">✅ 가입 신청하기</button>

                    <button class="btn btn-favorite" onclick="toggleFavorite()">☆ 즐겨찾기</button>
                    
                    <!-- 모임 홈으로 이동 버튼 추가 -->
    				<button class="btn btn-outline" onclick="home()">🏠 모임 홈으로 이동</button>

                </div>

            </div>

        </div>



        <!-- 탭 네비게이션 -->

        <div class="detail-tabs">

            <div class="tab-buttons">

                <button class="tab-button active" onclick="switchTab('intro')">📝 모임 소개</button>

               

            </div>



            <div id="intro" class="tab-content">

                <div class="intro-section">

                    <h3>모임 소개</h3>

                    <p>이 스터디는 알고리즘 문제를 단계별로 정복하기 위q한 모임입니다.

주 3회 온라인으로 진행하며, 서로 코드 리뷰와 문제 풀이를 함께 합니다.</p>

                    <div class="info-grid">

                        <div class="info-box"><div class="info-box-title">참여 가능 인원</div><div class="info-box-value">10명</div></div>

                        <div class="info-box"><div class="info-box-title">난이도</div><div class="info-box-value">중급</div></div>

                        <div class="info-box"><div class="info-box-title">활동 방식</div><div class="info-box-value">온라인</div></div>

                        <div class="info-box"><div class="info-box-title">기간</div><div class="info-box-value">3개월</div></div>

                    </div>
                    
                      <h3 style="margin-top:30px;">모임원 한 줄 소개</h3>
       			 <div class="member-preview" style="display:flex; gap:15px; flex-wrap:wrap; margin-top:10px;">
            	<div class="member-card" style="flex:0 0 120px; padding:10px; text-align:center;">
                <div class="member-avatar" style="width:50px; height:50px; font-size:18px;">코</div>
                <div class="member-name" style="font-size:14px; font-weight:600;">코딩마스터</div>
                <div class="member-intro" style="font-size:12px; color:#666;">알고리즘과 코딩 교육 전문가</div>
           		 </div>
            	<div class="member-card" style="flex:0 0 120px; padding:10px; text-align:center;">
                <div class="member-avatar" style="width:50px; height:50px; font-size:18px;">민</div>
                <div class="member-name" style="font-size:14px; font-weight:600;">민수</div>
                <div class="member-intro" style="font-size:12px; color:#666;">문제를 같이 풀며 성장</div>
            	</div>
           		 <div class="member-card" style="flex:0 0 120px; padding:10px; text-align:center;">
                <div class="member-avatar" style="width:50px; height:50px; font-size:18px;">지</div>
                <div class="member-name" style="font-size:14px; font-weight:600;">지연</div>
                <div class="member-intro" style="font-size:12px; color:#666;">매주 성실하게 참여</div>
           		 </div>
        </div>

                </div>

            </div>



            <div id="members" class="tab-content">

                <div class="member-list">

                    <div class="member-card"><div class="member-avatar">코</div><div class="member-name">코딩마스터</div><div class="member-role">모임장</div><div class="member-intro">알고리즘과 코딩 교육 전문가입니다.</div></div>

                    <div class="member-card"><div class="member-avatar">민</div><div class="member-name">민수</div><div class="member-role">일반</div><div class="member-intro">문제를 같이 풀며 성장하고 싶습니다.</div></div>

                    <div class="member-card"><div class="member-avatar">지</div><div class="member-name">지연</div><div class="member-role">일반</div><div class="member-intro">매주 성실하게 참여합니다.</div></div>

                    <!-- 나머지 멤버 카드 추가 가능 -->

                </div>

            </div>



            <div id="posts" class="tab-content">

                <div class="post-preview">

                    <span class="post-tag">공지</span>

                    <div class="post-title">다음 주 문제 풀이 자료 공유</div>

                    <div class="post-meta">2025-10-01 | 코딩마스터</div>

                </div>

                <div class="post-preview">

                    <span class="post-tag">일반</span>

                    <div class="post-title">오늘 풀이 질문</div>

                    <div class="post-meta">2025-10-05 | 민수</div>

                </div>

                <div class="empty-message">추가 게시글이 없습니다.</div>

            </div>

        </div>
        

    </div>



    <!-- 모달 -->

    <div id="modal-bg" class="modal-bg" onclick="closeModal()">

        <div class="modal" onclick="event.stopPropagation();">

            <span class="modal-close" onclick="closeModal()">×</span>

            <h2 id="modal-title"></h2>

            <h4 id="modal-subtitle" style="color:#666; margin:10px 0;"></h4>

            <p id="modal-content"></p>

        </div>

    </div>

</body>

</html>