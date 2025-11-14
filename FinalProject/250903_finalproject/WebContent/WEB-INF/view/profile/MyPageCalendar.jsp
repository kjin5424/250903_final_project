<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    .calendar-container {
        background: var(--color-white);
        border-radius: var(--radius-lg);
        padding: var(--spacing-lg);
    }
    
    .calendar-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: var(--spacing-lg);
        padding-bottom: var(--spacing-md);
        border-bottom: 2px solid var(--color-primary-lighter);
    }
    
    .calendar-nav {
        display: flex;
        align-items: center;
        gap: var(--spacing-lg);
    }
    
    .calendar-nav button {
        background: var(--color-primary-lighter);
        border: none;
        border-radius: var(--radius-md);
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        font-size: 18px;
        transition: all var(--transition-base);
    }
    
    .calendar-nav button:hover {
        background: var(--color-primary);
        color: white;
    }
    
    .calendar-title {
        font-size: 20px;
        font-weight: 700;
        color: var(--color-text-primary);
    }
    
    .calendar-grid {
        display: grid;
        grid-template-columns: repeat(7, 1fr);
        gap: var(--spacing-xs);
    }
    
    .calendar-day-header {
        text-align: center;
        padding: var(--spacing-sm);
        font-size: 13px;
        font-weight: 600;
        color: var(--color-text-secondary);
    }
    
    .calendar-day-header.sunday {
        color: var(--color-accent);
    }
    
    .calendar-day-header.saturday {
        color: #2196F3;
    }
    
    .calendar-day {
        aspect-ratio: 1;
        padding: var(--spacing-xs);
        border: 1px solid var(--color-border-light);
        border-radius: var(--radius-md);
        display: flex;
        flex-direction: column;
        position: relative;
        transition: all var(--transition-base);
        cursor: pointer;
        background: var(--color-white);
    }
    
    .calendar-day:hover {
        border-color: var(--color-primary);
        box-shadow: var(--shadow-sm);
    }
    
    .calendar-day.today {
        background: var(--color-primary-lighter);
        border-color: var(--color-primary);
    }
    
    .calendar-day.other-month {
        background: var(--color-base);
        color: var(--color-text-tertiary);
    }
    
    .calendar-day-number {
        font-size: 14px;
        font-weight: 600;
        color: var(--color-text-primary);
        margin-bottom: var(--spacing-xs);
    }
    
    .calendar-day.sunday .calendar-day-number {
        color: var(--color-accent);
    }
    
    .calendar-day.saturday .calendar-day-number {
        color: #2196F3;
    }
    
    .calendar-events {
        display: flex;
        flex-direction: column;
        gap: 2px;
        flex: 1;
    }
    
    .calendar-event {
        font-size: 10px;
        padding: 2px 4px;
        border-radius: 3px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }
    
    .event-meeting {
        background: var(--color-primary-lighter);
        color: var(--color-primary-dark);
    }
    
    .event-challenge-daily {
        background: var(--color-secondary-lighter);
        color: var(--color-secondary-dark);
    }
    
    .event-challenge-monthly {
        background: #FFF3E0;
        color: #E65100;
    }
    
    /* 범례 */
    .calendar-legend {
        display: flex;
        gap: var(--spacing-lg);
        margin-top: var(--spacing-lg);
        padding-top: var(--spacing-lg);
        border-top: 1px solid var(--color-border-light);
    }
    
    .legend-item {
        display: flex;
        align-items: center;
        gap: var(--spacing-xs);
        font-size: 13px;
    }
    
    .legend-color {
        width: 16px;
        height: 16px;
        border-radius: 4px;
    }
    
    /* 이벤트 상세 모달 */
    .event-detail-modal {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.5);
        display: none;
        align-items: center;
        justify-content: center;
        z-index: 1000;
    }
    
    .event-detail-modal.show {
        display: flex;
    }
    
    .event-detail-content {
        background: var(--color-white);
        border-radius: var(--radius-lg);
        padding: var(--spacing-xl);
        max-width: 500px;
        width: 90%;
        max-height: 80vh;
        overflow-y: auto;
    }
    
    .event-detail-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: var(--spacing-lg);
    }
    
    .event-detail-close {
        background: none;
        border: none;
        font-size: 24px;
        cursor: pointer;
        color: var(--color-text-secondary);
    }
    
    .event-list {
        display: flex;
        flex-direction: column;
        gap: var(--spacing-md);
    }
    
    .event-item {
        padding: var(--spacing-md);
        border-radius: var(--radius-md);
        border: 2px solid var(--color-border-light);
    }
    
    .event-item-title {
        font-weight: 600;
        margin-bottom: var(--spacing-xs);
    }
    
    .event-item-group {
        font-size: 13px;
        color: var(--color-text-secondary);
    }
</style>

<div class="content-section">
    <div class=page-header>
        <h1 class="page-title">📅 내 일정</h1>
	    <p class="page-description">참여 중인 모임의 일정을 한눈에 확인하세요</p>
    </div>

    <div class="calendar-container">
        <div class="calendar-header">
            <div class="calendar-nav">
                <button onclick="changeMonth(-1)">◀</button>
                <span class="calendar-title" id="calendarTitle">2025년 1월</span>
                <button onclick="changeMonth(1)">▶</button>
            </div>
            <button class="btn btn-primary btn-sm" onclick="goToToday()">오늘</button>
        </div>

        <div class="calendar-grid">
            <!-- 요일 헤더 -->
            <div class="calendar-day-header sunday">일</div>
            <div class="calendar-day-header">월</div>
            <div class="calendar-day-header">화</div>
            <div class="calendar-day-header">수</div>
            <div class="calendar-day-header">목</div>
            <div class="calendar-day-header">금</div>
            <div class="calendar-day-header saturday">토</div>
            
            <!-- 날짜 그리드 (JavaScript로 동적 생성) -->
            <div id="calendarDays"></div>
        </div>

        <div class="calendar-legend">
            <div class="legend-item">
                <div class="legend-color event-meeting"></div>
                <span>모임 일정</span>
            </div>
            <div class="legend-item">
                <div class="legend-color event-challenge-daily"></div>
                <span>일간 도전과제</span>
            </div>
            <div class="legend-item">
                <div class="legend-color event-challenge-monthly"></div>
                <span>월간 도전과제</span>
            </div>
        </div>
    </div>
</div>

<!-- 이벤트 상세 모달 -->
<div class="event-detail-modal" id="eventModal">
    <div class="event-detail-content">
        <div class="event-detail-header">
            <h3 id="modalDate">2025년 1월 15일</h3>
            <button class="event-detail-close" onclick="closeEventModal()">×</button>
        </div>
        <div class="event-list" id="modalEventList">
            <!-- 이벤트 목록 동적 생성 -->
        </div>
    </div>
</div>

<script>
    let currentYear = 2025;
    let currentMonth = 0; // 0 = 1월
    
    // 샘플 이벤트 데이터 (실제로는 서버에서 가져와야 함)
    const events = {
        '2025-01-15': [
            { type: 'meeting', title: '주간 독서 모임', group: '책 읽는 모임' },
            { type: 'challenge-daily', title: '하루 10페이지 읽기', group: '책 읽는 모임' }
        ],
        '2025-01-20': [
            { type: 'meeting', title: '코딩 스터디', group: '파이썬 초보 모임' }
        ],
        '2025-01-25': [
            { type: 'challenge-monthly', title: '월간 챌린지 완료', group: '운동하는 모임' }
        ]
    };
    
    function renderCalendar() {
        const firstDay = new Date(currentYear, currentMonth, 1);
        const lastDay = new Date(currentYear, currentMonth + 1, 0);
        const prevLastDay = new Date(currentYear, currentMonth, 0);
        
        const firstDayOfWeek = firstDay.getDay();
        const lastDate = lastDay.getDate();
        const prevLastDate = prevLastDay.getDate();
        
        // 제목 업데이트
        document.getElementById('calendarTitle').textContent = 
            currentYear + '년 ' + (currentMonth + 1) + '월';
        
        let calendarHTML = '';
        
        // 이전 달 날짜
        for (let i = firstDayOfWeek - 1; i >= 0; i--) {
            calendarHTML += createDayCell(prevLastDate - i, true, false);
        }
        
        // 현재 달 날짜
        const today = new Date();
        for (let date = 1; date <= lastDate; date++) {
            const isToday = (currentYear === today.getFullYear() && 
                           currentMonth === today.getMonth() && 
                           date === today.getDate());
            const dayOfWeek = new Date(currentYear, currentMonth, date).getDay();
            calendarHTML += createDayCell(date, false, isToday, dayOfWeek);
        }
        
        // 다음 달 날짜
        const remainingCells = 42 - (firstDayOfWeek + lastDate);
        for (let date = 1; date <= remainingCells; date++) {
            calendarHTML += createDayCell(date, true, false);
        }
        
        document.getElementById('calendarDays').innerHTML = calendarHTML;
    }
    
    function createDayCell(date, isOtherMonth, isToday, dayOfWeek = -1) {
        const dateStr = currentYear + '-' + 
                       String(currentMonth + 1).padStart(2, '0') + '-' + 
                       String(date).padStart(2, '0');
        
        const dayEvents = events[dateStr] || [];
        
        let classes = 'calendar-day';
        if (isOtherMonth) classes += ' other-month';
        if (isToday) classes += ' today';
        if (dayOfWeek === 0) classes += ' sunday';
        if (dayOfWeek === 6) classes += ' saturday';
        
        let eventsHTML = '';
        dayEvents.forEach(event => {
            eventsHTML += `<div class="calendar-event event-${event.type}">${event.title}</div>`;
        });
        
        return `
            <div class="${classes}" onclick="showEventDetail('${dateStr}')">
                <div class="calendar-day-number">${date}</div>
                <div class="calendar-events">${eventsHTML}</div>
            </div>
        `;
    }
    
    function changeMonth(delta) {
        currentMonth += delta;
        if (currentMonth < 0) {
            currentMonth = 11;
            currentYear--;
        } else if (currentMonth > 11) {
            currentMonth = 0;
            currentYear++;
        }
        renderCalendar();
    }
    
    function goToToday() {
        const today = new Date();
        currentYear = today.getFullYear();
        currentMonth = today.getMonth();
        renderCalendar();
    }
    
    function showEventDetail(dateStr) {
        const dayEvents = events[dateStr];
        if (!dayEvents || dayEvents.length === 0) return;
        
        const date = new Date(dateStr);
        const dateText = date.getFullYear() + '년 ' + 
                        (date.getMonth() + 1) + '월 ' + 
                        date.getDate() + '일';
        
        document.getElementById('modalDate').textContent = dateText;
        
        let eventListHTML = '';
        dayEvents.forEach(event => {
            let typeText = '';
            let typeClass = '';
            if (event.type === 'meeting') {
                typeText = '모임 일정';
                typeClass = 'event-meeting';
            } else if (event.type === 'challenge-daily') {
                typeText = '일간 도전과제';
                typeClass = 'event-challenge-daily';
            } else if (event.type === 'challenge-monthly') {
                typeText = '월간 도전과제';
                typeClass = 'event-challenge-monthly';
            }
            
            eventListHTML += `
                <div class="event-item ${typeClass}">
                    <div style="font-size: 11px; color: var(--color-text-tertiary); margin-bottom: 4px;">
                        ${typeText}
                    </div>
                    <div class="event-item-title">${event.title}</div>
                    <div class="event-item-group">📚 ${event.group}</div>
                </div>
            `;
        });
        
        document.getElementById('modalEventList').innerHTML = eventListHTML;
        document.getElementById('eventModal').classList.add('show');
    }
    
    function closeEventModal() {
        document.getElementById('eventModal').classList.remove('show');
    }
    
    // 모달 외부 클릭 시 닫기
    document.getElementById('eventModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeEventModal();
        }
    });
    
    // 초기 렌더링
    renderCalendar();
</script>
