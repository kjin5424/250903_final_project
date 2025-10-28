<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 모임원 리스트 화면 생성 -->
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들 - 모임원 리스트</title>
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

    /* 제목 */
    h1.title { font-size:26px; color:#2d5a29; margin-bottom:20px; }

    /* 멤버 리스트 */
    .member-list { display:grid; grid-template-columns:repeat(auto-fill,minmax(220px,1fr)); gap:20px; }
    .member-card { background:white; border-radius:10px; padding:20px; text-align:center; transition:all 0.3s; box-shadow:0 2px 6px rgba(0,0,0,0.1); cursor:pointer; }
    .member-card:hover { background:#e8f5e9; transform:translateY(-3px); box-shadow:0 4px 12px rgba(0,0,0,0.15); }
    .member-avatar { width:70px; height:70px; border-radius:50%; background:#8bc683; color:white; display:flex; align-items:center; justify-content:center; font-size:26px; margin:0 auto 10px; }
    .member-name { font-size:16px; font-weight:bold; color:#333; margin-bottom:6px; }
    .member-role { font-size:12px; color:#999; background:#e0e0e0; padding:5px 10px; border-radius:12px; display:inline-block; margin-bottom:10px; }
    .member-intro { font-size:13px; color:#666; line-height:1.5; }

    /* 모달 */
    .modal-bg { display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); align-items:center; justify-content:center; z-index:2000; }
    .modal { background:white; padding:30px; border-radius:12px; max-width:500px; width:90%; position:relative; }
    .modal-close { position:absolute; top:10px; right:10px; cursor:pointer; font-size:18px; font-weight:bold; }
</style>

<script>
    function openModal(name, role, intro){
        document.getElementById('modal-name').textContent = name;
        document.getElementById('modal-role').textContent = role;
        document.getElementById('modal-intro').textContent = intro;
        document.getElementById('modal-bg').style.display = 'flex';
    }

    function closeModal(){
        document.getElementById('modal-bg').style.display = 'none';
    }
</script>

</head>
<body>

    <!-- 네비게이션 -->
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
        <a href="groupDetail.jsp" class="back-btn">← 모임 상세보기로</a>
        <h1 class="title">👥 알고리즘 정복 스터디 - 모임원 리스트</h1>

        <!-- 모임원 목록 -->
        <div class="member-list">
            <div class="member-card" onclick="openModal('코딩마스터','모임장','알고리즘과 코딩 교육 전문가입니다.')">
                <div class="member-avatar">코</div>
                <div class="member-name">코딩마스터</div>
                <div class="member-role">모임장</div>
                <div class="member-intro">알고리즘과 코딩 교육 전문가입니다.</div>
            </div>

            <div class="member-card" onclick="openModal('민수','일반','문제를 같이 풀며 성장하고 싶습니다.')">
                <div class="member-avatar">민</div>
                <div class="member-name">민수</div>
                <div class="member-role">모임원</div>
                <div class="member-intro">문제를 같이 풀며 성장하고 싶습니다.</div>
            </div>

            <div class="member-card" onclick="openModal('지연','일반','매주 성실하게 참여합니다.')">
                <div class="member-avatar">지</div>
                <div class="member-name">지연</div>
                <div class="member-role">모임원</div>
                <div class="member-intro">매주 성실하게 참여합니다.</div>
            </div>

            <div class="member-card" onclick="openModal('하준','일반','CS 공부에 관심이 많습니다.')">
                <div class="member-avatar">하</div>
                <div class="member-name">하준</div>
                <div class="member-role">모임원</div>
                <div class="member-intro">CS 공부에 자신이 있습니다.</div>
            </div>
        </div>
    </div>

    <!-- 모달 -->
    <div id="modal-bg" class="modal-bg" onclick="closeModal()">
        <div class="modal" onclick="event.stopPropagation();">
            <span class="modal-close" onclick="closeModal()">×</span>
            <h2 id="modal-name"></h2>
            <h4 id="modal-role" style="color:#666; margin:10px 0;"></h4>
            <p id="modal-intro"></p>
        </div>
    </div>

</body>
</html>
