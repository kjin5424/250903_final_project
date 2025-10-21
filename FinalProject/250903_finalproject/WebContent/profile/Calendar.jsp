<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공모자들 - 캘린더 일정표</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .calendar-day {
            min-height: 100px;
        }
        .schedule-item {
            font-size: 0.75rem;
            cursor: pointer;
            transition: all 0.2s;
        }
        .schedule-item:hover {
            transform: translateX(2px);
        }
        .progress-bar {
            height: 4px;	
            background-color: #e5e7eb;
            border-radius: 9999px;
            overflow: hidden;
        }
        .progress-fill {
            height: 100%;
            transition: width 0.3s;
        }
        .today-label {
            font-size: 0.65rem;
            font-weight: bold;
            color: white;
            background-color: #3b82f6;
            padding: 1px 4px;
            border-radius: 9999px;
            margin-left: 4px;
        }
    </style>
</head>
<body class="bg-gray-50">
    <div class="min-h-screen p-4">
        <div class="max-w-7xl mx-auto">
            <!-- 헤더 -->
            <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                <div class="flex items-center justify-between mb-6">
                    <h1 class="text-2xl font-bold text-gray-800 flex items-center gap-2">
                        <svg class="w-7 h-7 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                        일정 캘린더
                    </h1>
                </div>

                <!-- 모임 선택 필터 -->
                <div class="flex gap-2 flex-wrap">
                    <button onclick="filterGroup('all')" 
                            id="filter-all" 
                            data-color="bg-gray-500"
                            class="filter-btn px-4 py-2 rounded-full text-sm font-medium transition-all bg-gray-500 text-white">
                        전체 모임
                    </button>
                    <button onclick="filterGroup('group1')" 
                            id="filter-group1" 
                            data-color="bg-blue-500"
                            class="filter-btn px-4 py-2 rounded-full text-sm font-medium transition-all bg-gray-100 text-gray-600 hover:bg-gray-200">
                        IT 스터디
                    </button>
                    <button onclick="filterGroup('group2')" 
                            id="filter-group2" 
                            data-color="bg-green-500"
                            class="filter-btn px-4 py-2 rounded-full text-sm font-medium transition-all bg-gray-100 text-gray-600 hover:bg-gray-200">
                        영어회화 모임
                    </button>
                    <button onclick="filterGroup('group3')" 
                            id="filter-group3" 
                            data-color="bg-purple-500"
                            class="filter-btn px-4 py-2 rounded-full text-sm font-medium transition-all bg-gray-100 text-gray-600 hover:bg-gray-200">
                        독서 토론방
                    </button>
                </div>
            </div>

            <!-- 캘린더 -->
            <div class="bg-white rounded-lg shadow-sm p-6">
            
                <!-- 월 네비게이션 -->
                <div class="flex items-center justify-between mb-6">
                    <button onclick="changeMonth(-1)" class="p-2 hover:bg-gray-100 rounded-lg transition-colors">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                        </svg>
                    </button>
                    <h2 id="current-month" class="text-xl font-bold text-gray-800"></h2>
                    <button onclick="changeMonth(1)" class="p-2 hover:bg-gray-100 rounded-lg transition-colors">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                        </svg>
                    </button>
                </div>

                <!-- 요일 헤더 -->
                <div class="grid grid-cols-7 gap-2 mb-2">
                    <div class="text-center font-semibold py-2 text-red-600">일</div>
                    <div class="text-center font-semibold py-2 text-gray-700">월</div>
                    <div class="text-center font-semibold py-2 text-gray-700">화</div>
                    <div class="text-center font-semibold py-2 text-gray-700">수</div>
                    <div class="text-center font-semibold py-2 text-gray-700">목</div>
                    <div class="text-center font-semibold py-2 text-gray-700">금</div>
                    <div class="text-center font-semibold py-2 text-blue-600">토</div>
                </div>

                <!-- 날짜 그리드 -->
                <div id="calendar-grid" class="grid grid-cols-7 gap-2"></div>
            </div>

            <!-- 범례 -->
            <div class="bg-white rounded-lg shadow-sm p-6 mt-6">
                <h3 class="font-semibold text-gray-800 mb-4">일정 안내</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="flex items-center gap-2">
                        <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                        </svg>
                        <span class="text-sm text-gray-700">성사된 모임 일정</span>
                    </div>
                    <div class="flex items-center gap-2">
                        <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        <span class="text-sm text-gray-700">참여중인 도전 과제</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 일정 상세 모달 -->
    <div id="schedule-modal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" onclick="closeModal(event)">
        <div class="bg-white rounded-lg shadow-xl p-6 max-w-md w-full mx-4" onclick="event.stopPropagation()">
            <div class="flex justify-between items-start mb-4">
                <h3 id="modal-title" class="text-xl font-bold text-gray-800"></h3>
                <button onclick="closeModal()" class="text-gray-400 hover:text-gray-600">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                    </svg>
                </button>
            </div>
            <div id="modal-content" class="space-y-3"></div>
        </div>
    </div>

    <script>
        const schedules = [
            {
                id: 1, groupId: 'group1', groupName: 'IT 스터디', type: 'meeting',
                date: new Date(2025, 9, 5), title: '정기 모임', time: '19:00 - 21:00',
                location: '강남구 역삼동', mode: 'offline', participants: 5, color: 'bg-blue-500'
            },
            {
                id: 2, groupId: 'group2', groupName: '영어회화 모임', type: 'meeting',
                date: new Date(2025, 9, 12), title: '정기 모임', time: '18:00 - 20:00',
                location: 'Zoom', mode: 'online', participants: 7, color: 'bg-green-500'
            },
            {
                id: 3, groupId: 'group1', groupName: 'IT 스터디', type: 'challenge',
                date: new Date(2025, 9, 1), endDate: new Date(2025, 9, 7),
                title: '일주일 코딩 챌린지', description: '매일 1시간 코딩하기',
                progress: 85, color: 'bg-blue-500'
            },
            {
                id: 4, groupId: 'group3', groupName: '독서 토론방', type: 'meeting',
                date: new Date(2025, 9, 19), title: '정기 모임', time: '14:00 - 16:00',
                location: '서초구 서초동', mode: 'offline', participants: 4, color: 'bg-purple-500'
            },
            {
                id: 5, groupId: 'group2', groupName: '영어회화 모임', type: 'challenge',
                date: new Date(2025, 9, 10), endDate: new Date(2025, 10, 10),
                title: '한달 영어 말하기', description: '매일 30분 영어로 대화하기',
                progress: 60, color: 'bg-green-500'
            },
            {
                id: 6, groupId: 'group1', groupName: 'IT 스터디', type: 'meeting',
                date: new Date(2025, 9, 26), title: '비정기 모임', time: '15:00 - 18:00',
                location: 'Google Meet', mode: 'online', participants: 6, color: 'bg-blue-500'
            }
        ];

        let currentDate = new Date();
        let selectedGroup = 'all';

        function getDaysInMonth(date) {
            const year = date.getFullYear();
            const month = date.getMonth();
            const firstDay = new Date(year, month, 1);
            const lastDay = new Date(year, month + 1, 0);
            const daysInMonth = lastDay.getDate();
            const startingDayOfWeek = firstDay.getDay();
            return { daysInMonth, startingDayOfWeek, year, month };
        }

        function getSchedulesForDate(date) {
            return schedules.filter(schedule => {
                if (selectedGroup !== 'all' && schedule.groupId !== selectedGroup) return false;
                if (schedule.type === 'meeting') {
                    return schedule.date.toDateString() === date.toDateString();
                } else if (schedule.type === 'challenge') {
                    return date >= schedule.date && date <= schedule.endDate;
                }
                return false;
            });
        }

        function renderCalendar() {
            const { daysInMonth, startingDayOfWeek, year, month } = getDaysInMonth(currentDate);
            const grid = document.getElementById('calendar-grid');
            const monthDisplay = document.getElementById('current-month');
            monthDisplay.textContent = year + '년 ' + (month + 1) + '월';
            grid.innerHTML = '';

            for (let i = 0; i < startingDayOfWeek; i++) {
                const emptyDiv = document.createElement('div');
                emptyDiv.className = 'aspect-square';
                grid.appendChild(emptyDiv);
            }

            for (let day = 1; day <= daysInMonth; day++) {
                const date = new Date(year, month, day);
                const daySchedules = getSchedulesForDate(date);
                const isToday = date.toDateString() === new Date().toDateString();
                const dayOfWeek = date.getDay();

                const dayDiv = document.createElement('div');
                dayDiv.className = 'border rounded-lg p-2 calendar-day ' + 
                    (isToday ? 'bg-blue-100 border-blue-500 shadow-md' : 'bg-white border-gray-200');

                const dayNumber = document.createElement('div');
                dayNumber.className = 'text-sm font-semibold mb-1 ' + 
                    (isToday ? 'text-blue-700 flex items-center' : 
                     dayOfWeek === 0 ? 'text-red-600' : 
                     dayOfWeek === 6 ? 'text-blue-600' : 'text-gray-700');
                dayNumber.textContent = day;
                if (isToday) {
                    const todayLabel = document.createElement('span');
                    todayLabel.textContent = '오늘';
                    todayLabel.className = 'today-label';
                    dayNumber.appendChild(todayLabel);
                }
                dayDiv.appendChild(dayNumber);

                const scheduleContainer = document.createElement('div');
                scheduleContainer.className = 'space-y-1';

                daySchedules.forEach(schedule => {
                    const scheduleDiv = document.createElement('div');
                    scheduleDiv.className = 'schedule-item p-1 rounded bg-opacity-10 border-l-2 ' + 
                        schedule.color + ' border-' + schedule.color.split('-')[1] + '-500';
                    scheduleDiv.onclick = () => showScheduleDetail(schedule);

                    const titleRow = document.createElement('div');
                    titleRow.className = 'flex items-center gap-1';
                    const icon = schedule.type === 'meeting' ? 
                        '<svg class="w-3 h-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/></svg>' :
                        '<svg class="w-3 h-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>';
                    titleRow.innerHTML = icon + '<span class="truncate font-medium">' + schedule.title + '</span>';
                    scheduleDiv.appendChild(titleRow);

                    if (schedule.type === 'meeting' && schedule.time) {
                        const timeRow = document.createElement('div');
                        timeRow.className = 'flex items-center gap-1 mt-1 text-gray-600';
                        timeRow.innerHTML = '<svg class="w-3 h-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg><span class="truncate text-xs">' + schedule.time + '</span>';
                        scheduleDiv.appendChild(timeRow);
                    }

                    if (schedule.type === 'challenge' && schedule.progress) {
                        const progressDiv = document.createElement('div');
                        progressDiv.className = 'mt-1 progress-bar';
                        progressDiv.innerHTML = '<div class="progress-fill ' + schedule.color + '" style="width: ' + schedule.progress + '%"></div>';
                        scheduleDiv.appendChild(progressDiv);
                    }

                    scheduleContainer.appendChild(scheduleDiv);
                });

                dayDiv.appendChild(scheduleContainer);
                grid.appendChild(dayDiv);
            }
        }

        function changeMonth(offset) {
            currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + offset, 1);
            renderCalendar();
        }

        function filterGroup(groupId) {
            selectedGroup = groupId;
            document.querySelectorAll('.filter-btn').forEach(btn => {
                btn.className = 'filter-btn px-4 py-2 rounded-full text-sm font-medium transition-all bg-gray-100 text-gray-600 hover:bg-gray-200';
            });
            const activeBtn = document.getElementById('filter-' + groupId);
            if (activeBtn) {
                const colorClass = activeBtn.getAttribute('data-color') || 'bg-blue-500';
                activeBtn.className = 'filter-btn px-4 py-2 rounded-full text-sm font-medium transition-all ' + colorClass + ' text-white';
            }
            renderCalendar();
        }

        function showScheduleDetail(schedule) {
            const modal = document.getElementById('schedule-modal');
            const title = document.getElementById('modal-title');
            const content = document.getElementById('modal-content');
            title.textContent = schedule.title;
            let html = '<div class="text-sm text-gray-600 mb-2">' + schedule.groupName + '</div>';
            if (schedule.type === 'meeting') {
                html += '<div class="flex items-center gap-2 mb-2"><svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg><span>' + schedule.time + '</span></div>';
                html += '<div class="flex items-center gap-2 mb-2"><svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg><span>' + schedule.location + ' (' + (schedule.mode === 'online' ? '온라인' : '오프라인') + ')</span></div>';
                html += '<div class="flex items-center gap-2"><svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/></svg><span>참가 인원: ' + schedule.participants + '명</span></div>';
            } else {
                const startDate = schedule.date.toLocaleDateString('ko-KR');
                const endDate = schedule.endDate.toLocaleDateString('ko-KR');
                html += '<div class="mb-2"><strong>기간:</strong> ' + startDate + ' ~ ' + endDate + '</div>';
                html += '<div class="mb-2"><strong>설명:</strong> ' + schedule.description + '</div>';
                html += '<div class="mb-2"><strong>달성률:</strong> ' + schedule.progress + '%</div>';
                html += '<div class="progress-bar"><div class="progress-fill ' + schedule.color + '" style="width: ' + schedule.progress + '%"></div></div>';
            }
            content.innerHTML = html;
            modal.classList.remove('hidden');
        }

        function closeModal(event) {
            if (!event || event.target.id === 'schedule-modal') {
                document.getElementById('schedule-modal').classList.add('hidden');
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            renderCalendar();
        });
        function showScheduleDetail(schedule) {
            const modal = document.getElementById('schedule-modal');
            const title = document.getElementById('modal-title');
            const content = document.getElementById('modal-content');
            title.textContent = schedule.title;
            let html = '<div class="text-sm text-gray-600 mb-2">' + schedule.groupName + '</div>';

            if (schedule.type === 'meeting') {
                html += '<div class="flex items-center gap-2 mb-2"><svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/></svg><span>' + schedule.time + '</span></div>';
                html += '<div class="flex items-center gap-2 mb-2"><svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/></svg><span>' + schedule.location + ' (' + (schedule.mode === 'online' ? '온라인' : '오프라인') + ')</span></div>';
                html += '<div class="flex items-center gap-2 mb-2"><svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/></svg><span>참가 인원: ' + schedule.participants + '명</span></div>';

                // ✅ [추가됨] 모임 홈 이동 버튼
                html += `
                    <div class="mt-4 flex justify-end">
                        <button onclick="goToGroupHome('${schedule.groupId}')"
                            class="bg-blue-500 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors">
                            모임 홈으로 이동
                        </button>
                    </div>`;
            } 
            else if (schedule.type === 'challenge') {
                const startDate = schedule.date.toLocaleDateString('ko-KR');
                const endDate = schedule.endDate.toLocaleDateString('ko-KR');
                html += '<div class="mb-2"><strong>기간:</strong> ' + startDate + ' ~ ' + endDate + '</div>';
                html += '<div class="mb-2"><strong>설명:</strong> ' + schedule.description + '</div>';
                html += '<div class="mb-2"><strong>달성률:</strong> ' + schedule.progress + '%</div>';
                html += '<div class="progress-bar"><div class="progress-fill ' + schedule.color + '" style="width: ' + schedule.progress + '%"></div></div>';

                // ✅ [추가됨] 도전 과제 하러 가기 버튼
                html += `
                    <div class="mt-4 flex justify-end">
                        <button onclick="goToChallenge('${schedule.id}')"
                            class="bg-green-500 text-white px-4 py-2 rounded-md text-sm font-medium hover:bg-green-600 transition-colors">
                            도전 과제 하러 가기
                        </button>
                    </div>`;
            }

            content.innerHTML = html;
            modal.classList.remove('hidden');
        }
        
        function goToGroupHome(groupId) {
            // 실제 구현 시: window.location.href = `/groupHome.jsp?groupId=${groupId}`;
            alert(groupId + " 모임 홈으로 이동합니다!");
        }

        function goToChallenge(challengeId) {
            // 실제 구현 시: window.location.href = `/challengeView.jsp?id=${challengeId}`;
            alert("도전 과제 페이지로 이동합니다! (ID: " + challengeId + ")");
        }


    </script>
</body>
</html>
