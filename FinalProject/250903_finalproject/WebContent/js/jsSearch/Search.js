/**
 * 
 */
let selectedFilters = {
	category: []
	, region: []
    , type: []
    , status: []
};

// 필터 패널 토글
function toggleFilter() {
    const panel = $('#filterPanel');
    const toggleBtn = $('#filterToggle');

    panel.toggleClass('show');
    toggleBtn.toggleClass('active');
}

// 필터 업데이트
function updateFilters() {
    selectedFilters = { category: [], region: [], type: [], status: [] };

    $('.filter-panel input[type="checkbox"]:checked').each(function() {
        const category = $(this).data('category');
        const value = $(this).val();
        selectedFilters[category].push(value);
    });

    displaySelectedFilters();
    updateFilterCountBadge();
}

// 선택된 필터 태그 표시
function displaySelectedFilters() {
    const container = $('#selectedFilters');
    container.empty();

    const categoryLabels = {
    	category: '카테고리'
		, region: '지역'
        , type: '유형'
        , status: '상태'
    };

    $.each(selectedFilters, function(key, values) {
        $.each(values, function(_, value) {
            const tag = $(`
                <div class="filter-tag">
                    <span>${categoryLabels[key]}: ${value}</span>
                    <span class="remove-btn">×</span>
                </div>
            `);

            tag.find('.remove-btn').on('click', function() {
                removeFilter(key, value);
            });

            container.append(tag);
        });
    });
}

// 개별 필터 제거
function removeFilter(category, value) {
    $(`input[data-category="${category}"]`).each(function() {
        if ($(this).val() === value) {
            $(this).prop('checked', false);
        }
    });
    updateFilters();
}

// 필터 개수 배지 업데이트
function updateFilterCountBadge() {
    const totalCount = Object.values(selectedFilters).flat().length;
    const badge = $('#filterCountBadge');

    if (totalCount > 0) {
        badge.text(totalCount).show();
    } else {
        badge.hide();
    }
}

// 필터 초기화
function resetFilters() {
    $('.filter-panel input[type="checkbox"]').prop('checked', false);

    selectedFilters = { category: [], region: [], type: [],  status: [] };

    displaySelectedFilters();
    updateFilterCountBadge();
}

// 검색 실행
function performSearch() {
    const keyword = $('#searchBox').val().trim();

    if (!keyword
    	&& (selectedFilters.category.length == 0)
    	&& (selectedFilters.region.length == 0)
    	&& (selectedFilters.type.length == 0)
    	&& (selectedFilters.status.length == 0)) {
        alert('검색 내용이나 조건을 입력해주세요.');
        $('#searchBox').focus();
        return true;
    }
    
    return true;
}

// 엔터키 검색 + 초기 필터
$(document).ready(function() {
    $('#searchBox').on('keypress', function(e) {
        if (e.key === 'Enter') {
            performSearch();
        }
    });

    updateFilters();
});

// 외부 클릭 시 패널 닫기
$(document).on('click', function(e) {
    const panel = $('#filterPanel');
    const container = $('.search-section');
    const toggleBtn = $('#filterToggle');

    if (!$(e.target).closest(container).length && panel.hasClass('show')) {
        panel.removeClass('show');
        toggleBtn.removeClass('active');
    }
});
