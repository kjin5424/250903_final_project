<%@ page contentType="text/html; charset=UTF-8" %>
<!-- 활동 출석 관리 화면 생성 -->
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공모자들 - 활동 출석 관리</title>
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
    .container { max-width:1000px; margin:40px auto; background:white; padding:40px; border-radius:12px; box-shadow:0 4px 10px rgba(0,0,0,0.1); }
    h1.title { font-size:26px; color:#2d5a29; margin-bottom:20px; text-align:center; }
    p.desc { text-align:center; color:#666; font-size:14px; margin-bottom:30px; }

    /* 출석표 */
    table { width:100%; border-collapse:collapse; margin-top:20px; }
    th, td { padding:14px 10px; text-align:center; border-bottom:1px solid #eee; font-size:14px; }
    th { background:#e8f5e9; color:#2d5a29; font-weight:600; }
    tr:hover { background:#f9fdf9; }
    .name-cell { font-weight:bold; color:#333; display:flex; align-items:center; justify-content:center; gap:6px; }

    /* 체크박스 */
    input[type="checkbox"] {
        width:18px; height:18px;
        accent-color:#8bc683;
        cursor:not-allowed; /* 클릭 불가 표시 */
    }

    /* 비활성화 input */
    input[disabled], textarea[disabled] {
        background:#f3f3f3;
        color:#555;
        cursor:not-allowed;
        border:1px solid #ddd;
    }

    /* 읽기전용 날짜 */
    input[readonly] {
        background:#f3f3f3;
        color:#222;
        border:1px solid #ccc;
        padding:6px 10px;
        border-radius:6px;
        cursor:default;
    }

    /* 뒤로가기 */
    .back-link { display:inline-block; margin-top:20px; color:#666; text-decoration:none; font-size:14px; }
    .back-link:hover { color:#2d5a29; text-decoration:underline; }

    /* 날짜 선택 */
    .date-select { display:flex; justify-content:flex-end; align-items:center; gap:10px; margin-bottom:10px; }
</style>
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

    <!-- 출석 관리 본문 -->
    <div class="container">
        <h1 class="title">📅 활동 출석 관리</h1>
        <p class="desc">출석 현황을 확인하세요. 수정은 관리자만 가능합니다 🔒</p>

        <div class="date-select">
            <label for="date">출석일:</label>
            <input type="date" id="date" name="date" value="2025-10-14" readonly>
        </div>

        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>이름</th>
                    <th>역할</th>
                    <th>출석</th>
                    <th>지각</th>
                    <th>결석</th>
                    <th>메모</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td class="name-cell">👑 코딩마스터</td>
                    <td>모임장</td>
                    <td><input type="checkbox" checked disabled></td>
                    <td><input type="checkbox" disabled></td>
                    <td><input type="checkbox" disabled></td>
                    <td><input type="text" value="정상 출석" disabled style="width:90%;"></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td class="name-cell">🧑‍💻 민수</td>
                    <td>모임원</td>
                    <td><input type="checkbox" checked disabled></td>
                    <td><input type="checkbox" disabled></td>
                    <td><input type="checkbox" disabled></td>
                    <td><input type="text" value="활발히 참여" disabled style="width:90%;"></td>
                </tr>
                <tr>
                    <td>3</td>
                    <td class="name-cell">👩‍💻 지연</td>
                    <td>모임원</td>
                    <td><input type="checkbox" disabled></td>
                    <td><input type="checkbox" checked disabled></td>
                    <td><input type="checkbox" disabled></td>
                    <td><input type="text" value="지각 (교통 문제)" disabled style="width:90%;"></td>
                </tr>
                <tr>
                    <td>4</td>
                    <td class="name-cell">👨‍💻 하준</td>
                    <td>모임원</td>
                    <td><input type="checkbox" disabled></td>
                    <td><input type="checkbox" disabled></td>
                    <td><input type="checkbox" checked disabled></td>
                    <td><input type="text" value="개인 사정으로 결석" disabled style="width:90%;"></td>
                </tr>
            </tbody>
        </table>

        <div style="text-align:center;">
            <a href="groupDetail.jsp" class="back-link">← 모임 상세보기로 돌아가기</a>
        </div>
    </div>

</body>
</html>
