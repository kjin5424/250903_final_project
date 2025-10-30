/**
 * 
 */
$(document).ready(function() {
    $('#participantTitle').on('click', function() {
        const $table = $('#participantTable');
        $table.toggleClass('hidden');

        if ($table.hasClass('hidden')) {
            $(this).text('참가자 리스트 ▼(펼치기)');
            $table.css("display", "none");
        } else {
            $(this).text('참가자 리스트 ▲(접기)');
            $table.css("display", "block");
        }
    });
});