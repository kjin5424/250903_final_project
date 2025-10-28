<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 모임 히스토리</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; }
        .navbar { background: #a8d5a1; display: flex; align-items: center; padding: 0 20px; height: 48px; position: sticky; top: 0; z-index: 1000; box-shadow: 0 2px 4px rgba(0,0,0,0.1); gap: 4px; }
        .nav-left { display: flex; align-items: center; gap: 4px; flex: 1; }
        .logo-tab { background: #8bc683; color: white; padding: 0 20px; height: 36px; border-radius: 8px 8px 0 0; display: flex; align-items: center; gap: 8px; font-weight: bold; font-size: 16px; cursor: pointer; }
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .page-header { background: linear-gradient(135deg, #2d5a29 0%, #4a8a42 100%); color: white; padding: 40px; border-radius: 12px; margin-bottom: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .header-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .page-title { font-size: 32px; font-weight: bold; display: flex; align-items: center; gap: 12px; }
        .btn-back { background: rgba(255,255,255,0.2); color: white; border: 2px solid white; padding: 10px 20px; border-radius: 8px; font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.3s; text-decoration: none; }
        .btn-back:hover { background: white; color: #2d5a29; }
        .group-name { font-size: 18px; opacity: 0.9; }

        .tab-menu { display: flex; gap: 10px; margin-bottom: 30px; border-bottom: 2px solid #e0e0e0; background: white; padding: 0 20px; border-radius: 12px 12px 0 0; flex-wrap: wrap; }
        .tab-item { padding: 15px 25px; cursor: pointer; font-weight: 600; color: #666; border-bottom: 3px solid transparent; transition: all 0.3s; position: relative; bottom: -2px; }
        .tab-item:hover { color: #2d5a29; }
        .tab-item.active { color: #2d5a29; border-bottom-color: #2d5a29; }

        .content-section { background: white; border-radius: 0 0 12px 12px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        .tab-content { display: none; }
        .tab-content.active { display: block; }

        /* 타임라인 스타일 */
        .timeline { position: relative; padding: 20px 0; }
        .timeline:before { content: ''; position: absolute; left: 30px; top: 0; bottom: 0; width: 3px; background: linear-gradient(to bottom, #8bc683, #e0e0e0); }
        .timeline-item { position: relative; padding-left: 70px; margin-bottom: 30px; }
        .timeline-date { position: absolute; left: 0; top: 0; width: 60px; text-align: center; }
        .timeline-dot { width: 18px; height: 18px; background: #4CAF50; border-radius: 50%; border: 3px solid white; box-shadow: 0 0 0 3px #8bc683; margin: 0 auto 5px; }
        .timeline-date-text { font-size: 11px; color: #666; font-weight: 600; }
        .timeline-content { background: #f8faf8; padding: 20px; border-radius: 12px; border: 2px solid #e0e0e0; transition: all 0.3s; }
        .timeline-content:hover { border-color: #8bc683; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .timeline-title { font-size: 16px; font-weight: bold; color: #2d5a29; margin-bottom: 8px; display: flex; align-items: center; gap: 8px; }
        .timeline-category { display: inline-block; background: #e3f2fd; color: #1565c0; padding: 3px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
        .timeline-description { color: #666; font-size: 14px; line-height: 1.6; margin-top: 8px; }
        .timeline-meta { display: flex; gap: 15px; margin-top: 10px; font-size: 13px; color: #999; }

        /* 투표 히스토리 */
        .vote-result { display: flex; gap: 15px; margin-top: 12px; }
        .vote-option { flex: 1; padding: 10px; background: white; border-radius: 8px; text-align: center; }
        .vote-count { font-size: 20px; font-weight: bold; color: #2d5a29; }
        .vote-label { font-size: 12px; color: #666; }
        .vote-bar { height: 6px; background: #e0e0e0; border-radius: 3px; margin-top: 8px; overflow: hidden; }
        .vote-bar-fill { height: 100%; background: #4CAF50; border-radius: 3px; transition: width 0.3s; }

        /* 도전과제 히스토리 */
        .challenge-progress { margin-top: 12px; }
        .progress-bar { height: 30px; background: #e0e0e0; border-radius: 15px; overflow: hidden; position: relative; }
        .progress-fill { height: 100%; background: linear-gradient(90deg, #4CAF50, #8bc683); border-radius: 15px; transition: width 0.3s; display: flex; align-items: center; justify-content: center; }
        .progress-text { position: absolute; left: 50%; top: 50%; transform: translate(-50%, -50%); font-weight: bold; font-size: 13px; color: #333; }

        /* 출석 히스토리 */
        .attendance-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); gap: 10px; margin-top: 12px; }
        .attendance-item { padding: 10px; background: white; border-radius: 8px; text-align: center; border: 2px solid #e0e0e0; }
        .attendance-item.present { border-color: #4CAF50; background: #e8f5e9; }
        .attendance-item.absent { border-color: #f44336; background: #ffebee; }
        .attendance-name { font-weight: 600; font-size: 13px; margin-bottom: 5px; }
        .attendance-status { font-size: 11px; color: #666; }

        /* 통계 카드 */
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: #f8faf8; padding: 25px; border-radius: 12px; text-align: center; border: 2px solid #e0e0e0; }
        .stat-value { font-size: 32px; font-weight: bold; color: #2d5a29; margin-bottom: 8px; }
        .stat-label { font-size: 14px; color: #666; }

        /* 필터 */
        .filter-bar { display: flex; gap: 10px; margin-bottom: 25px; flex-wrap: wrap; }
        .filter-btn { padding: 10px 20px; border: 2px solid #e0e0e0; background: white; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 600; transition: all 0.3s; }
        .filter-btn:hover { border-color: #8bc683; }
        .filter-btn.active { background: #e8f5e9; border-color: #4CAF50; color: #2d5a29; }

        /* 레벨업 표시 */
        .level-up-badge { display: inline-block; background: linear-gradient(135deg, #ffd54f, #ffb300); color: #f57c00; padding: 5px 12px; border-radius: 15px; font-size: 12px; font-weight: bold; margin-left: 10px; animation: pulse 2s infinite; }
        @keyframes pulse { 0%, 100% { transform: scale(1); } 50% { transform: scale(1.05); } }

        /* 빈 상태 */
        .empty-state { text-align: center; padding: 60px 20px; color: #999; }
        .empty-icon { font-size: 60px; margin-bottom: 15px; }
        .empty-text { font-size: 16px; }

        @media (max-width: 768px) {
            .page-header { padding: 25px 20px; }
            .page-title { font-size: 24px; }
            .header-top { flex-direction: column; gap: 15px; align-items: flex-start; }
            .timeline:before { left: 20px; }
            .timeline-item { padding-left: 60px; }
            .vote-result { flex-direction: column; }
            .attendance-list { grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-left">
            <div class="logo-tab"><span>로고 들어갈 자리</span></div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <div class="header-top">
                <div>
                    <div class="page-title"><span>📜</span><span>모임 히스토리</span></div>
                    <div class="group-name">알고리즘 정복 스터디</div>
                </div>
                <button class="btn-back" onclick="history.back()">← 뒤로 가기</button>
            </div>
        </div>

        <div class="tab-menu">
            <div class="tab-item active" onclick="switchTab('all')">전체</div>
            <div class="tab-item" onclick="switchTab('vote')">투표</div>
            <div class="tab-item" onclick="switchTab('challenge')">도전과제</div>
            <div class="tab-item" onclick="switchTab('attendance')">출석</div>
            <div class="tab-item" onclick="switchTab('member')">모임</div>
            <div class="tab-item" onclick="switchTab('level')">레벨</div>
        </div>

        <div class="content-section">
            <!-- 전체 히스토리 -->
            <div id="all-tab" class="tab-content active">
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-value">45</div>
                        <div class="stat-label">총 활동 횟수</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">12</div>
                        <div class="stat-label">투표 진행</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">8</div>
                        <div class="stat-label">도전과제 완료</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">Lv.3</div>
                        <div class="stat-label">현재 레벨</div>
                    </div>
                </div>

                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.20</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🗳️</span>
                                <span>10월 4주차 모임 일정 투표 완료</span>
                                <span class="timeline-category">투표</span>
                            </div>
                            <div class="timeline-description">
                                10월 27일 오후 2시 스터디 카페 A지점에서 진행하기로 결정되었습니다.
                            </div>
                            <div class="vote-result">
                                <div class="vote-option">
                                    <div class="vote-count">5명</div>
                                    <div class="vote-label">참여</div>
                                    <div class="vote-bar"><div class="vote-bar-fill" style="width: 71%;"></div></div>
                                </div>
                                <div class="vote-option">
                                    <div class="vote-count">2명</div>
                                    <div class="vote-label">불참</div>
                                    <div class="vote-bar"><div class="vote-bar-fill" style="width: 29%;"></div></div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>👥 투표 인원: 7명</span>
                                <span>📊 참여율: 100%</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.18</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🏆</span>
                                <span>백준 실버 문제 풀기 도전과제 완료</span>
                                <span class="timeline-category">도전과제</span>
                            </div>
                            <div class="timeline-description">
                                7명 중 6명이 도전과제를 완료했습니다.
                            </div>
                            <div class="challenge-progress">
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: 86%;">
                                        <span style="color: white; font-weight: bold;">86%</span>
                                    </div>
                                    <div class="progress-text">6/7명 완료</div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>📅 기간: 2024.10.11 ~ 2024.10.18</span>
                                <span>⭐ 달성률: 86%</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.15</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>📋</span>
                                <span>10월 3주차 모임 출석</span>
                                <span class="timeline-category">출석</span>
                            </div>
                            <div class="timeline-description">
                                7명 중 6명이 출석했습니다.
                            </div>
                            <div class="attendance-list">
                                <div class="attendance-item present">
                                    <div class="attendance-name">김모임장</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">이부장</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">박도움</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">최스터디</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">정코딩</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">강알고</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item absent">
                                    <div class="attendance-name">윤개발</div>
                                    <div class="attendance-status">❌ 결석</div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>📍 장소: 스터디 카페 A지점</span>
                                <span>📊 출석률: 86%</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.10</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>👥</span>
                                <span>새로운 모임원 가입</span>
                                <span class="timeline-category">모임원</span>
                            </div>
                            <div class="timeline-description">
                                윤개발님이 모임에 참여했습니다. (7/10명)
                            </div>
                            <div class="timeline-meta">
                                <span>📧 윤dev@example.com</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.05</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🎉</span>
                                <span>모임 레벨 업!</span>
                                <span class="timeline-category">레벨</span>
                                <span class="level-up-badge">LEVEL UP!</span>
                            </div>
                            <div class="timeline-description">
                                축하합니다! 모임이 Lv.2에서 Lv.3으로 레벨업했습니다.<br>
                                • 모임 정원: 7명 → 10명<br>
                                • 부모임장 설정 가능<br>
                                • 개인 도전과제 해금
                            </div>
                            <div class="timeline-meta">
                                <span>🏆 달성 조건: 투표 성사 7회, 도전과제 2회 완료</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.09.28</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>👥</span>
                                <span>모임원 탈퇴</span>
                                <span class="timeline-category">모임원</span>
                            </div>
                            <div class="timeline-description">
                                홍길동님이 개인 사유로 모임을 탈퇴했습니다. (6/7명)
                            </div>
                            <div class="timeline-meta">
                                <span>📅 활동 기간: 2024.08.15 ~ 2024.09.28</span>
                                <span>📊 출석률: 75%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 투표 히스토리 -->
            <div id="vote-tab" class="tab-content">
                <div class="filter-bar">
                    <button class="filter-btn active" onclick="filterVote('all')">전체</button>
                    <button class="filter-btn" onclick="filterVote('completed')">완료된 투표</button>
                    <button class="filter-btn" onclick="filterVote('cancelled')">취소된 투표</button>
                </div>

                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.20</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🗳️</span>
                                <span>10월 4주차 모임 일정 투표</span>
                                <span class="timeline-category">완료</span>
                            </div>
                            <div class="timeline-description">
                                투표 결과: 10월 27일 오후 2시, 스터디 카페 A지점
                            </div>
                            <div class="vote-result">
                                <div class="vote-option">
                                    <div class="vote-count">5명</div>
                                    <div class="vote-label">참여</div>
                                    <div class="vote-bar"><div class="vote-bar-fill" style="width: 71%;"></div></div>
                                </div>
                                <div class="vote-option">
                                    <div class="vote-count">2명</div>
                                    <div class="vote-label">불참</div>
                                    <div class="vote-bar"><div class="vote-bar-fill" style="width: 29%;"></div></div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>📅 투표 기간: 2024.10.17 ~ 2024.10.20</span>
                                <span>👥 참여: 7/7명 (100%)</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.13</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🗳️</span>
                                <span>10월 3주차 모임 일정 투표</span>
                                <span class="timeline-category">완료</span>
                            </div>
                            <div class="timeline-description">
                                투표 결과: 10월 15일 오후 7시, 스터디 카페 B지점
                            </div>
                            <div class="vote-result">
                                <div class="vote-option">
                                    <div class="vote-count">6명</div>
                                    <div class="vote-label">참여</div>
                                    <div class="vote-bar"><div class="vote-bar-fill" style="width: 86%;"></div></div>
                                </div>
                                <div class="vote-option">
                                    <div class="vote-count">1명</div>
                                    <div class="vote-label">불참</div>
                                    <div class="vote-bar"><div class="vote-bar-fill" style="width: 14%;"></div></div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>📅 투표 기간: 2024.10.10 ~ 2024.10.13</span>
                                <span>👥 참여: 7/7명 (100%)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 도전과제 히스토리 -->
            <div id="challenge-tab" class="tab-content">
                <div class="filter-bar">
                    <button class="filter-btn active" onclick="filterChallenge('all')">전체</button>
                    <button class="filter-btn" onclick="filterChallenge('completed')">완료</button>
                    <button class="filter-btn" onclick="filterChallenge('ongoing')">진행중</button>
                </div>

                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.18</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🏆</span>
                                <span>백준 실버 문제 풀기</span>
                                <span class="timeline-category">완료</span>
                            </div>
                            <div class="timeline-description">
                                일주일 도전과제 - 매일 백준 실버 문제 1개씩 풀기
                            </div>
                            <div class="challenge-progress">
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: 86%;">
                                        <span style="color: white;">86%</span>
                                    </div>
                                    <div class="progress-text">6/7명 완료</div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>📅 기간: 2024.10.11 ~ 2024.10.18</span>
                                <span>👤 개설자: 김모임장</span>
                                <span>👥 참여: 7명</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.04</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🏆</span>
                                <span>자료구조 개념 정리하기</span>
                                <span class="timeline-category">완료</span>
                            </div>
                            <div class="timeline-description">
                                일주일 도전과제 - 스택, 큐, 덱, 트리 등 자료구조 개념 정리 및 공유
                            </div>
                            <div class="challenge-progress">
                                <div class="progress-bar">
                                    <div class="progress-fill" style="width: 100%;">
                                        <span style="color: white;">100%</span>
                                    </div>
                                    <div class="progress-text">7/7명 완료</div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>📅 기간: 2024.09.27 ~ 2024.10.04</span>
                                <span>👤 개설자: 김모임장</span>
                                <span>👥 참여: 7명</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 출석 히스토리 -->
            <div id="attendance-tab" class="tab-content">
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-value">12회</div>
                        <div class="stat-label">총 모임 횟수</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">85%</div>
                        <div class="stat-label">평균 출석률</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">6.8명</div>
                        <div class="stat-label">평균 참석 인원</div>
                    </div>
                </div>

                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.15</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>📋</span>
                                <span>10월 3주차 정기 모임</span>
                                <span class="timeline-category">출석</span>
                            </div>
                            <div class="attendance-list">
                                <div class="attendance-item present">
                                    <div class="attendance-name">김모임장</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">이부장</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">박도움</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">최스터디</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">정코딩</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item absent">
                                    <div class="attendance-name">강알고</div>
                                    <div class="attendance-status">❌ 결석</div>
                                </div>
                                <div class="attendance-item absent">
                                    <div class="attendance-name">윤개발</div>
                                    <div class="attendance-status">❌ 결석</div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>📍 장소: 스터디 카페 A지점</span>
                                <span>📊 출석률: 86% (6/7명)</span>
                                <span>⏰ 시간: 14:00 ~ 17:00</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.08</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>📋</span>
                                <span>10월 2주차 정기 모임</span>
                                <span class="timeline-category">출석</span>
                            </div>
                            <div class="attendance-list">
                                <div class="attendance-item present">
                                    <div class="attendance-name">김모임장</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">이부장</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">박도움</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">최스터디</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">정코딩</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">강알고</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                                <div class="attendance-item present">
                                    <div class="attendance-name">윤개발</div>
                                    <div class="attendance-status">✅ 출석</div>
                                </div>
                            </div>
                            <div class="timeline-meta">
                                <span>📍 장소: 온라인 (Zoom)</span>
                                <span>📊 출석률: 100% (7/7명)</span>
                                <span>⏰ 시간: 19:00 ~ 21:00</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 모임원 히스토리 -->
           <!-- 모임원 히스토리 -->
<div id="member-tab" class="tab-content">
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value">7명</div>
            <div class="stat-label">현재 모임원</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">3회</div>
            <div class="stat-label">권한 변경</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">5회</div>
            <div class="stat-label">모임 정보 수정</div>
        </div>
    </div>

    <div class="timeline">
        <div class="timeline-item">
            <div class="timeline-date">
                <div class="timeline-dot"></div>
                <div class="timeline-date-text">2024.10.12</div>
            </div>
            <div class="timeline-content">
                <div class="timeline-title">
                    <span>✏️</span>
                    <span>모임 정보 수정</span>
                    <span class="timeline-category">수정</span>
                </div>
                <div class="timeline-description">
                    <strong>김모임장</strong>님이 모임 정보를 수정했습니다.<br><br>
                    <strong>📝 변경 내역:</strong><br>
                    • 모임 시간: 토요일 14:00 → <strong>토요일 19:00</strong><br>
                    • 모임 장소: 스터디 카페 A지점 → <strong>온라인/오프라인 병행</strong><br>
                    • 모임 규칙 추가: 무단 결석 3회 시 자동 탈퇴
                </div>
                <div class="timeline-meta">
                    <span>👤 수정자: 김모임장</span>
                    <span>📅 수정일: 2024.10.12 15:30</span>
                </div>
            </div>
        </div>

        <div class="timeline-item">
            <div class="timeline-date">
                <div class="timeline-dot"></div>
                <div class="timeline-date-text">2024.09.25</div>
            </div>
            <div class="timeline-content">
                <div class="timeline-title">
                    <span>✏️</span>
                    <span>모임 정보 수정</span>
                    <span class="timeline-category">수정</span>
                </div>
                <div class="timeline-description">
                    <strong>김모임장</strong>님이 모임 정보를 수정했습니다.<br><br>
                    <strong>📝 변경 내역:</strong><br>
                    • 모임 설명 업데이트: 상세 학습 목표 추가<br>
                    • 난이도: 하 → <strong>중</strong><br>
                    • 모임 이미지 변경
                </div>
                <div class="timeline-meta">
                    <span>👤 수정자: 김모임장</span>
                    <span>📅 수정일: 2024.09.25 10:15</span>
                </div>
            </div>
        </div>

        <div class="timeline-item">
            <div class="timeline-date">
                <div class="timeline-dot"></div>
                <div class="timeline-date-text">2024.09.15</div>
            </div>
            <div class="timeline-content">
                <div class="timeline-title">
                    <span>⭐</span>
                    <span>권한 변경</span>
                    <span class="timeline-category">권한</span>
                </div>
                <div class="timeline-description">
                    <strong>이부장</strong>님이 부모임장으로 임명되었습니다.<br>
                    부모임장은 출석 관리, 가입 승인 권한을 갖습니다.
                </div>
                <div class="timeline-meta">
                    <span>👤 변경자: 김모임장</span>
                    <span>📅 변경일: 2024.09.15 14:20</span>
                </div>
            </div>
        </div>

        <div class="timeline-item">
            <div class="timeline-date">
                <div class="timeline-dot"></div>
                <div class="timeline-date-text">2024.08.20</div>
            </div>
            <div class="timeline-content">
                <div class="timeline-title">
                    <span>✏️</span>
                    <span>모임 정보 수정</span>
                    <span class="timeline-category">수정</span>
                </div>
                <div class="timeline-description">
                    <strong>김모임장</strong>님이 모임 정보를 수정했습니다.<br><br>
                    <strong>📝 변경 내역:</strong><br>
                    • 모임 이름: 알고리즘 스터디 → <strong>알고리즘 정복 스터디</strong><br>
                    • 가입 질문 추가: "자신의 알고리즘 수준과 목표를 작성해주세요."
                </div>
                <div class="timeline-meta">
                    <span>👤 수정자: 김모임장</span>
                    <span>📅 수정일: 2024.08.20 16:45</span>
                </div>
            </div>
        </div>

        <div class="timeline-item">
            <div class="timeline-date">
                <div class="timeline-dot"></div>
                <div class="timeline-date-text">2024.08.10</div>
            </div>
            <div class="timeline-content">
                <div class="timeline-title">
                    <span>⭐</span>
                    <span>권한 변경</span>
                    <span class="timeline-category">권한</span>
                </div>
                <div class="timeline-description">
                    <strong>박도움</strong>님이 도우미로 임명되었습니다.<br>
                    도우미는 출석 체크, 게시글 관리 권한을 갖습니다.
                </div>
                <div class="timeline-meta">
                    <span>👤 변경자: 김모임장</span>
                    <span>📅 변경일: 2024.08.10 11:30</span>
                </div>
            </div>
        </div>

        <div class="timeline-item">
            <div class="timeline-date">
                <div class="timeline-dot"></div>
                <div class="timeline-date-text">2024.08.05</div>
            </div>
            <div class="timeline-content">
                <div class="timeline-title">
                    <span>✏️</span>
                    <span>모임 정보 수정</span>
                    <span class="timeline-category">수정</span>
                </div>
                <div class="timeline-description">
                    <strong>김모임장</strong>님이 모임 정보를 수정했습니다.<br><br>
                    <strong>📝 변경 내역:</strong><br>
                    • 모임 공개 설정: 비공개 → <strong>공개</strong><br>
                    • 청소년 환영 모임 설정: OFF
                </div>
                <div class="timeline-meta">
                    <span>👤 수정자: 김모임장</span>
                    <span>📅 수정일: 2024.08.05 13:00</span>
                </div>
            </div>
        </div>
    </div>
</div>

            <!-- 레벨 히스토리 -->
            <div id="level-tab" class="tab-content">
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-value">Lv.3</div>
                        <div class="stat-label">현재 레벨</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">10명</div>
                        <div class="stat-label">최대 정원</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">2회</div>
                        <div class="stat-label">레벨업 횟수</div>
                    </div>
                </div>

                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.10.05</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🎉</span>
                                <span>Level 3 달성!</span>
                                <span class="level-up-badge">LEVEL UP!</span>
                            </div>
                            <div class="timeline-description">
                                축하합니다! 모임이 <strong>Lv.2</strong>에서 <strong>Lv.3</strong>으로 레벨업했습니다.<br><br>
                                <strong>🎁 해금된 기능:</strong><br>
                                • 모임 정원: 7명 → <strong>10명</strong><br>
                                • <strong>부모임장 설정</strong> 가능<br>
                                • <strong>개인 도전과제</strong> 해금 (모임원도 도전과제 개설 가능)<br><br>
                                <strong>📊 달성 조건:</strong><br>
                                • 투표 성사 누적 7회 ✅<br>
                                • 모임장 주최 도전과제 2회 완료 ✅
                            </div>
                            <div class="timeline-meta">
                                <span>📅 달성 일자: 2024.10.05</span>
                                <span>⏱️ 소요 시간: 레벨2 달성 후 38일</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.08.28</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🎉</span>
                                <span>Level 2 달성!</span>
                                <span class="level-up-badge">LEVEL UP!</span>
                            </div>
                            <div class="timeline-description">
                                축하합니다! 모임이 <strong>Lv.1</strong>에서 <strong>Lv.2</strong>로 레벨업했습니다.<br><br>
                                <strong>🎁 해금된 기능:</strong><br>
                                • 모임 정원: 5명 → <strong>7명</strong><br>
                                • 평균 연령대 표시 기능<br><br>
                                <strong>📊 달성 조건:</strong><br>
                                • 투표 성사 누적 2회 ✅<br>
                                • 최소 참가 의사 2명 이상 ✅
                            </div>
                            <div class="timeline-meta">
                                <span>📅 달성 일자: 2024.08.28</span>
                                <span>⏱️ 소요 시간: 모임 개설 후 25일</span>
                            </div>
                        </div>
                    </div>

                    <div class="timeline-item">
                        <div class="timeline-date">
                            <div class="timeline-dot"></div>
                            <div class="timeline-date-text">2024.08.03</div>
                        </div>
                        <div class="timeline-content">
                            <div class="timeline-title">
                                <span>🌱</span>
                                <span>모임 개설 (Level 1)</span>
                                <span class="timeline-category">시작</span>
                            </div>
                            <div class="timeline-description">
                                <strong>알고리즘 정복 스터디</strong> 모임이 개설되었습니다!<br><br>
                                <strong>초기 설정:</strong><br>
                                • 모임 정원: 5명<br>
                                • 카테고리: IT<br>
                                • 활동 방식: 온라인/오프라인 병행<br>
                                • 난이도: 중
                            </div>
                            <div class="timeline-meta">
                                <span>👤 모임장: 김모임장</span>
                                <span>📅 개설일: 2024.08.03</span>
                                <span>👥 초기 인원: 3명</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function switchTab(tabName) {
            // 모든 탭 비활성화
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-item').forEach(t => t.classList.remove('active'));
            
            // 선택한 탭 활성화
            document.getElementById(tabName + '-tab').classList.add('active');
            event.target.classList.add('active');
        }

        function filterVote(type) {
            // 필터 버튼 활성화 상태 변경
            event.target.parentElement.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // 실제로는 서버에서 필터링된 데이터를 가져와야 함
            console.log('투표 필터:', type);
        }

        function filterChallenge(type) {
            // 필터 버튼 활성화 상태 변경
            event.target.parentElement.querySelectorAll('.filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // 실제로는 서버에서 필터링된 데이터를 가져와야 함
            console.log('도전과제 필터:', type);
        }
    </script>
</body>
</html>