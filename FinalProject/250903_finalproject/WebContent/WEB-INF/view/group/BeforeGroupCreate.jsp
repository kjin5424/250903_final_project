<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<!DOCTYPE html>

<html lang="ko">


<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>공모자들 - 모임 개설 안내</title>

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

        .nav-right {

            display: flex;

            align-items: center;

            margin-left: auto;

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

            transition: all 0.2s ease;

        }

        .logo-tab:hover {

            background: #7ab872;

        }

        .tab {

            background: #8bc683;

            color: white;

            border: none;

            padding: 0 24px;

            height: 36px;

            border-radius: 8px 8px 0 0;

            cursor: pointer;

            font-size: 14px;

            font-weight: 500;

            transition: all 0.2s ease;

            text-decoration: none;

            display: flex;

            align-items: center;

        }

        .tab:hover:not(.active) {

            background: #7ab872;

        }

        .tab.active {

            background: #f5f7fa;

            color: #2d5a29;

            height: 40px;

        }

        .login-btn {

            background: #2d5a29;

            color: white;

            border: none;

            padding: 8px 20px;

            border-radius: 6px;

            cursor: pointer;

            font-size: 14px;

            font-weight: 500;

            transition: all 0.2s ease;

            text-decoration: none;

            display: flex;

            align-items: center;

            gap: 6px;

        }

        .login-btn:hover {

            background: #1f4019;

        }

        

        /* 메인 컨텐츠 */

        .container {

            max-width: 900px;

            margin: 40px auto;

            padding: 0 20px;

        }

        .intro-header {

            background: linear-gradient(135deg, #2d5a29 0%, #4a8a42 100%);

            color: white;

            padding: 40px;

            border-radius: 12px 12px 0 0;

            text-align: center;

        }

        .intro-header h1 {

            font-size: 32px;

            margin-bottom: 10px;

        }

        .intro-header p {

            font-size: 16px;

            opacity: 0.9;

        }

        

        .intro-content {

            background: white;

            padding: 40px;

            border-radius: 0 0 12px 12px;

            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);

        }

        

        .info-section {

            margin-bottom: 40px;

        }

        .info-section h2 {

            color: #2d5a29;

            font-size: 22px;

            margin-bottom: 20px;

            padding-bottom: 10px;

            border-bottom: 2px solid #a8d5a1;

        }

        

        .info-grid {

            display: grid;

            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));

            gap: 20px;

            margin-bottom: 30px;

        }

        .info-card {

            background: #f8faf8;

            padding: 20px;

            border-radius: 8px;

            border-left: 4px solid #8bc683;

        }

        .info-card h3 {

            color: #2d5a29;

            font-size: 16px;

            margin-bottom: 10px;

            display: flex;

            align-items: center;

            gap: 8px;

        }

        .info-card p {

            color: #666;

            font-size: 14px;

            line-height: 1.6;

        }

        

        .requirements-list {

            background: #fff8e1;

            padding: 20px;

            border-radius: 8px;

            border: 1px solid #ffd54f;

            margin-bottom: 20px;

        }

        .requirements-list h3 {

            color: #f57c00;

            margin-bottom: 15px;

            display: flex;

            align-items: center;

            gap: 8px;

        }

        .requirements-list ul {

            list-style: none;

            padding-left: 0;

        }

        .requirements-list li {

            padding: 8px 0;

            padding-left: 24px;

            position: relative;

            color: #666;

        }

        .requirements-list li::before {

            content: "✓";

            position: absolute;

            left: 0;

            color: #4CAF50;

            font-weight: bold;

        }

        

        .warning-box {

            background: #ffebee;

            padding: 20px;

            border-radius: 8px;

            border: 1px solid #ef5350;

            margin-bottom: 20px;

        }

        .warning-box h3 {

            color: #c62828;

            margin-bottom: 10px;

            display: flex;

            align-items: center;

            gap: 8px;

        }

        .warning-box p {

            color: #666;

            line-height: 1.6;

            margin: 5px 0;

        }

        

        .level-info {

            background: #e3f2fd;

            padding: 20px;

            border-radius: 8px;

            margin-bottom: 20px;

        }

        .level-info h3 {

            color: #1565c0;

            margin-bottom: 15px;

        }

        .level-table {

            width: 100%;

            border-collapse: collapse;

            font-size: 14px;

        }

        .level-table th {

            background: #90caf9;

            color: #1565c0;

            padding: 12px;

            text-align: left;

            font-weight: 600;

        }

        .level-table td {

            padding: 12px;

            border-bottom: 1px solid #e0e0e0;

            color: #666;

        }

        .level-table tr:last-child td {

            border-bottom: none;

        }

        

        .action-buttons {

            display: flex;

            gap: 15px;

            margin-top: 30px;

            justify-content: center;

        }

        .btn {

            padding: 15px 40px;

            border: none;

            border-radius: 8px;

            font-size: 16px;

            font-weight: 600;

            cursor: pointer;

            transition: all 0.3s ease;

            text-decoration: none;

            display: inline-block;

        }

        .btn-primary {

            background: #4CAF50;

            color: white;

        }

        .btn-primary:hover {

            background: #45a049;

            transform: translateY(-2px);

            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);

        }

        .btn-secondary {

            background: #e0e0e0;

            color: #666;

        }

        .btn-secondary:hover {

            background: #d0d0d0;

        }

        

        @media (max-width: 768px) {

            .intro-header {

                padding: 30px 20px;

            }

            .intro-header h1 {

                font-size: 24px;

            }

            .intro-content {

                padding: 30px 20px;

            }

            .info-grid {

                grid-template-columns: 1fr;

            }

            .action-buttons {

                flex-direction: column;

            }

            .btn {

                width: 100%;

            }

        }

    </style>

</head>

<body>

  <!-- 상단 메뉴바 -->
    <c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />



    <div class="container">

        <div class="intro-header">

            <h1>✨ 모임을 개설해보세요!</h1>

            <p>함께 공부하고 성장할 멤버들을 모집해보세요</p>

        </div>

        

        <div class="intro-content">

            <div class="info-section">

                <h2>📋 모임 개설 전 확인사항</h2>

                

                <div class="requirements-list">

                    <h3>⚡ 개설 조건</h3>

                    <ul>

                        <li>회원당 최대 1개의 모임만 개설할 수 있습니다</li>

                        <li>개설 후 7일 이내에 최소 3명 이상이 모여야 합니다</li>

                        <li>최소 인원이 모이지 않으면 자동으로 삭제됩니다</li>

                    </ul>

                </div>



                <div class="warning-box">

                    <h3>⚠️ 중요 안내사항</h3>

                    <p><strong>개설 24시간 전</strong> 모임장에게 안내 메일이 발송됩니다.</p>

                    <p>최소 인원 미달 시 해당 내용도 함께 안내됩니다.</p>

                    <p>개설 후에도 모임 정보 수정이 가능하며, 변경 시 모든 모임원에게 알림이 발송됩니다.</p>

                </div>

            </div>



            <div class="info-section">

                <h2>📝 필수 입력 항목</h2>

                <div class="info-grid">

                    <div class="info-card">

                        <h3>🏷️ 기본 정보</h3>

                        <p>모임 이름, 이미지, 카테고리를 설정합니다. 모임 이름은 중복 가능합니다.</p>

                    </div>

                    <div class="info-card">

                        <h3>📍 모임 형태</h3>

                        <p>온라인/오프라인 선택 및 지역, 요일, 시간을 설정합니다.</p>

                    </div>

                    <div class="info-card">

                        <h3>👥 참여 제한</h3>

                        <p>청소년 환영 여부, 인원 수(5명 고정), 성별 제한을 설정합니다.</p>

                    </div>

                    <div class="info-card">

                        <h3>🔒 추가 설정</h3>

                        <p>가입 질문, 모임 규칙, 공개/비공개, 학습 난이도를 설정합니다.</p>

                    </div>

                </div>

            </div>



            <div class="info-section">

                <h2>🎯 모임 레벨 시스템</h2>

                <div class="level-info">

                    <h3>레벨별 혜택 안내</h3>

                    <table class="level-table">

                        <thead>

                            <tr>

                                <th>레벨</th>

                                <th>달성 조건</th>

                                <th>혜택</th>

                            </tr>

                        </thead>

                        <tbody>

                            <tr>

                                <td><strong>Lv.1</strong></td>

                                <td>개설 직후</td>

                                <td>최대 5명</td>

                            </tr>

                            <tr>

                                <td><strong>Lv.2</strong></td>

                                <td>투표 성사 2회</td>

                                <td>최대 7명</td>

                            </tr>

                            <tr>

                                <td><strong>Lv.3</strong></td>

                                <td>도전과제 2회 + 투표 7회</td>

                                <td>최대 10명, 부모임장 설정, 개인 도전과제</td>

                            </tr>

                            <tr>

                                <td><strong>Lv.4</strong></td>

                                <td>도전과제 5회 + 투표 15회</td>

                                <td>최대 15명</td>

                            </tr>

                            <tr>

                                <td><strong>Lv.5</strong></td>

                                <td>투표 50회 + 출석률 80% + 우수 도전과제 5개</td>

                                <td>최대 20명, 도우미 2명 설정</td>

                            </tr>

                        </tbody>

                    </table>

                </div>

            </div>



            <div class="info-section">

                <h2>💡 작성 팁</h2>

                <div class="info-grid">

                    <div class="info-card">

                        <h3>✍️ 모임 이름</h3>

                        <p>간결하고 기억하기 쉽게 작성하세요. 모임의 목적이 잘 드러나면 좋습니다.</p>

                    </div>

                    <div class="info-card">

                        <h3>📸 모임 이미지</h3>

                        <p>등록하지 않으면 기본 이미지가 사용됩니다. 모임 분위기를 잘 나타내는 이미지를 선택하세요.</p>

                    </div>

                    <div class="info-card">

                        <h3>❓ 가입 질문</h3>

                        <p>모임에 적합한 인원을 선별하기 위한 질문을 작성할 수 있습니다.</p>

                    </div>

                    <div class="info-card">

                        <h3>📜 모임 규칙</h3>

                        <p>원활한 모임 운영을 위한 주의사항이나 규칙을 미리 안내하세요.</p>

                    </div>

                </div>

            </div>



            <div class="action-buttons">

<!--                 <a href="group_create_form.jsp" class="btn btn-primary" onclick="location.href='groupcreate.do'">모임 개설하기</a>

                <a href="?page=groups" class="btn btn-secondary" onclick="location.href='start.do'">다른 모임 둘러보기</a> -->
                
                <button class="btn btn-primary" onclick="location.href='groupcreate.do'">모임 개설하기</button>
                <button class="btn btn-secondary" onclick="location.href='start.do'">다른 모임 둘러보기</button>

            </div>

        </div>

    </div>

</body>

</html>















































