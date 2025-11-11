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
    <title>공모자들 - 모임 레벨</title>
    <style>

        /* 현재 레벨 헤더 */
        .group-header {
            color: white;
            padding: 40px;
            text-align: center;
        }
        .current-level-title {
            font-size: 18px;
            opacity: 0.9;
            margin-bottom: 15px;
        }
        .current-level-display {
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .current-level-name {
            font-size: 24px;
            margin-bottom: 20px;
        }
        .level-progress-section {
            max-width: 600px;
            margin: 0 auto;
        }
        .progress-label {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }
        .progress-label > span{
            color: var(--color-primary-light)
        }
        .progress-bar {
            height: 20px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 15px;
        }
        .progress-fill {
            height: 100%;
            background: white;
            border-radius: 10px;
            transition: width 0.5s ease;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding-right: 10px;
            font-size: 12px;
            font-weight: 600;
            color: #2d5a29;
        }
        .next-level-info {
            font-size: 14px;
            opacity: 0.9;
        }

        /* 레벨 시스템 설명 */
        .level-info {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }
        .info-title {
            font-size: 22px;
            color: #2d5a29;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .info-description {
            color: #666;
            line-height: 1.8;
            text-align: center;
            margin-bottom: 30px;
        }

        /* 레벨 카드 리스트 */
        .level-list {
            display: grid;
            gap: 20px;
        }
        .level-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
            position: relative;
            border: 3px solid transparent;
        }
        .level-card.current {
            border-color: #4CAF50;
            box-shadow: 0 6px 20px rgba(76, 175, 80, 0.2);
        }
        .level-card.completed {
            opacity: 0.7;
        }
        .level-card.locked {
            opacity: 0.5;
        }
        .level-badge {
            position: absolute;
            top: -15px;
            right: 30px;
            background: #4CAF50;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
        }
        .level-badge.completed {
            background: #999;
        }
        .level-badge.locked {
            background: #e0e0e0;
            color: #999;
        }
        .level-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 20px;
        }
        .level-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #8bc683 0%, #4a8a42 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            font-weight: bold;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            flex-shrink: 0;
        }
        .level-info-text {
            flex: 1;
        }
        .level-number {
            font-size: 28px;
            font-weight: bold;
            color: #2d5a29;
            margin-bottom: 5px;
        }
        .level-capacity {
            font-size: 16px;
            color: #666;
        }
        
        .level-requirements {
            background: #f8faf8;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .requirements-title {
            font-size: 16px;
            font-weight: 600;
            color: #2d5a29;
            margin-bottom: 15px;
        }
        .requirement-item {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            font-size: 14px;
            color: #666;
        }
        .requirement-item:last-child {
            margin-bottom: 0;
        }
        .requirement-icon {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            flex-shrink: 0;
        }
        .icon-check {
            background: #4CAF50;
            color: white;
        }
        .icon-progress {
            background: #ff9800;
            color: white;
        }
        .icon-lock {
            background: #e0e0e0;
            color: #999;
        }
        .requirement-text {
            flex: 1;
        }
        .requirement-status {
            font-weight: 600;
            font-size: 13px;
        }
        .status-complete {
            color: #4CAF50;
        }
        .status-progress {
            color: #ff9800;
        }
        .status-locked {
            color: #999;
        }

        .level-benefits {
            background: #e8f5e9;
            padding: 20px;
            border-radius: 8px;
        }
        .benefits-title {
            font-size: 16px;
            font-weight: 600;
            color: #2d5a29;
            margin-bottom: 15px;
        }
        .benefit-item {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 10px;
            font-size: 14px;
            color: #333;
        }
        .benefit-item:last-child {
            margin-bottom: 0;
        }
        .benefit-icon {
            color: #4CAF50;
            font-weight: bold;
            flex-shrink: 0;
        }

        @media (max-width: 768px) {
            .current-level-header {
                padding: 30px 20px;
            }
            .current-level-display {
                font-size: 36px;
            }
            .current-level-name {
                font-size: 20px;
            }
            .level-card {
                padding: 20px;
            }
            .level-header {
                flex-direction: column;
                text-align: center;
            }
            .level-icon {
                width: 60px;
                height: 60px;
                font-size: 28px;
            }
        }
    </style>
    
    <!-- CSS 파일 임포트 -->
    <link rel="stylesheet" href="css_new/common_sample.css">
    <link rel="stylesheet" href="css_new/home_sample.css"> 
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>   
    
</head>
<body>
<!-- 상단바 -->
<c:import url="/WEB-INF/view/common/TopMenuBar.jsp" />

<!-- 사이드바 -->
<c:import url="/WEB-INF/view/common/GroupSideBar.jsp" />

    <div class="container">
        <!-- 현재 레벨 헤더 -->
        <div class="group-header">
            <div class="current-level-title">알고리즘 정복 스터디 현재 레벨</div>
            <div class="current-level-display">Level ${whatLevel }</div>
            <div class="current-level-name">🌟 성장하는 모임</div>
            <div class="level-progress-section">
                <div class="progress-label">
                    <span>다음 레벨까지</span>
                    <span>60%</span>
                </div>
                <div class="progress-bar">
                    <div class="progress-fill" style="width: 60%;">60%</div>
                </div>
                <div class="next-level-info">
                    Level ${whatLevel+1 }까지 투표 성사 8회, 도전과제 2회 남았습니다
                </div>
            </div>
        </div><!-- .current-level-header -->

        <!-- 레벨 시스템 설명 -->
        <div class="level-info">
            <h2 class="info-title">📊 모임 레벨 시스템</h2>
            <p class="info-description">
                모임의 활동량과 참여도에 따라 레벨이 상승합니다.<br>
                레벨이 올라갈수록 더 많은 모임원을 받을 수 있고, 다양한 기능이 해금됩니다.
            </p>
        </div>

        <!-- 레벨 카드 리스트 -->
        <div class="level-list">
            <!-- Level 1 -->
            <div class="level-card completed">
                <div class="level-badge completed">✓ 달성</div>
                <div class="level-header">
                    <div class="level-icon">1</div>
                    <div class="level-info-text">
                        <div class="level-number">Level 1 - 새싹 모임</div>
                        <div class="level-capacity">👥 최대 인원: 5명</div>
                    </div>
                </div>
                <div class="level-requirements">
                    <div class="requirements-title">✨ 달성 조건</div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-check">✓</div>
                        <div class="requirement-text">모임 개설</div>
                        <div class="requirement-status status-complete">완료</div>
                    </div>
                </div>
                <div class="level-benefits">
                    <div class="benefits-title">🎁 제공 혜택</div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>기본 모임 기능 사용</span>
                    </div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>게시판 이용</span>
                    </div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>투표 기능</span>
                    </div>
                </div>
            </div>

            <!-- Level 2 -->
            <div class="level-card completed">
                <div class="level-badge completed">✓ 달성</div>
                <div class="level-header">
                    <div class="level-icon">2</div>
                    <div class="level-info-text">
                        <div class="level-number">Level 2 - 활동 모임</div>
                        <div class="level-capacity">👥 최대 인원: 7명</div>
                    </div>
                </div>
                <div class="level-requirements">
                    <div class="requirements-title">✨ 달성 조건</div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-check">✓</div>
                        <div class="requirement-text">투표 성사 2회</div>
                        <div class="requirement-status status-complete">2/2회</div>
                    </div>
                </div>
                <div class="level-benefits">
                    <div class="benefits-title">🎁 제공 혜택</div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>모임원 상한수 7명으로 확대</span>
                    </div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>도전 과제 기능 해금 (모임장만)</span>
                    </div>
                </div>
            </div>

            <!-- Level 3 (현재) -->
            <div class="level-card current">
                <div class="level-badge">🔥 현재 레벨</div>
                <div class="level-header">
                    <div class="level-icon">3</div>
                    <div class="level-info-text">
                        <div class="level-number">Level 3 - 성장하는 모임</div>
                        <div class="level-capacity">👥 최대 인원: 10명</div>
                    </div>
                </div>
                <div class="level-requirements">
                    <div class="requirements-title">✨ 달성 조건</div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-check">✓</div>
                        <div class="requirement-text">모임장 주최 도전 과제 2회</div>
                        <div class="requirement-status status-complete">2/2회</div>
                    </div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-check">✓</div>
                        <div class="requirement-text">투표 성사 7회</div>
                        <div class="requirement-status status-complete">7/7회</div>
                    </div>
                </div>
                <div class="level-benefits">
                    <div class="benefits-title">🎁 제공 혜택</div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>모임원 상한수 10명으로 확대</span>
                    </div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>부모임장 설정 가능</span>
                    </div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>개인 도전 과제 작성 권한 해금 (모임장 → 모든 모임원)</span>
                    </div>
                </div>
            </div>

            <!-- Level 4 -->
            <div class="level-card">
                <div class="level-badge locked">🔒 잠김</div>
                <div class="level-header">
                    <div class="level-icon" style="background: linear-gradient(135deg, #e0e0e0 0%, #bdbdbd 100%);">4</div>
                    <div class="level-info-text">
                        <div class="level-number">Level 4 - 활발한 모임</div>
                        <div class="level-capacity">👥 최대 인원: 15명</div>
                    </div>
                </div>
                <div class="level-requirements">
                    <div class="requirements-title">✨ 달성 조건</div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-progress">⏳</div>
                        <div class="requirement-text">도전 과제 전체 누적 5회</div>
                        <div class="requirement-status status-progress">3/5회</div>
                    </div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-progress">⏳</div>
                        <div class="requirement-text">투표 성사 15회</div>
                        <div class="requirement-status status-progress">7/15회</div>
                    </div>
                </div>
                <div class="level-benefits">
                    <div class="benefits-title">🎁 제공 혜택</div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>모임원 상한수 15명으로 확대</span>
                    </div>
                </div>
            </div>

            <!-- Level 5 -->
            <div class="level-card locked">
                <div class="level-badge locked">🔒 잠김</div>
                <div class="level-header">
                    <div class="level-icon" style="background: linear-gradient(135deg, #e0e0e0 0%, #bdbdbd 100%);">5</div>
                    <div class="level-info-text">
                        <div class="level-number">Level 5 - 전문 모임</div>
                        <div class="level-capacity">👥 최대 인원: 20명</div>
                    </div>
                </div>
                <div class="level-requirements">
                    <div class="requirements-title">✨ 달성 조건</div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-lock">🔒</div>
                        <div class="requirement-text">투표 성사 50회</div>
                        <div class="requirement-status status-locked">0/50회</div>
                    </div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-lock">🔒</div>
                        <div class="requirement-text">모임장 누적 출석률 80%</div>
                        <div class="requirement-status status-locked">85%</div>
                    </div>
                    <div class="requirement-item">
                        <div class="requirement-icon icon-lock">🔒</div>
                        <div class="requirement-text">달성율 80% 이상 도전 과제 5개</div>
                        <div class="requirement-status status-locked">0/5개</div>
                    </div>
                </div>
                <div class="level-benefits">
                    <div class="benefits-title">🎁 제공 혜택</div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>모임원 상한수 20명으로 확대</span>
                    </div>
                    <div class="benefit-item">
                        <span class="benefit-icon">✓</span>
                        <span>도우미 2명 설정 가능</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>