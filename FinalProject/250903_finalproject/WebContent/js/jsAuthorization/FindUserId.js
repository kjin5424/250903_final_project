/**
 * 
 */
// 아이디 찾기 폼 유효성 검사
function validateLogin(event) {
	if (event) {
		event.preventDefault();
	}

	const userEmail = document.getElementById('userEmail').value.trim();
	const errorMsg = document.querySelector('.error-message');

	if (userEmail == "") {
		showError('아이디와 비밀번호를 모두 입력해주세요.');
		return false;
	}

	// 아이디 찾기 
	processFindUserEmail(userEmail);

	return false;
}

// 에러 메시지 표시
function showError(message) {
	const errorMsg = document.querySelector('.error-message');
	const errorText = document.querySelector('.error-text');
	
	errorText.textContent = '⚠️ ' + message;
	errorMsg.classList.add('show');
}

// 에러 메시지 제거
function closeErrorMessage() {
	const errorMsg = document.querySelector('.error-message');
	errorMsg.classList.remove('show');
}

// 아이디 찾기 처리
function processFindUserEmail(userEmail) {

	// 일반 사용자 아이디찾기
	if (userEmail === 'user123@gmail.com') {
		alert('이메일로 아이디 전송 완료!');
		window.location.href = 'UserLogin.jsp';
		return;
	}

	// 이메일 검증 실패
	showError('올바르지 않은 이메일입니다.');
}

// Enter 키 처리
document.getElementById('userEmail').addEventListener(
'keypress',
function(e) {
	if (e.key === 'Enter') {
		document.getElementById('FindUserIdForm').dispatchEvent(
				new Event('submit'));
	}
});

// 페이지 로드시 이메일 입력란에 포커스
window.addEventListener('load', function() {
	document.getElementById('userEmail').focus();
});