/**
 * 
 */
// 로그인 폼 유효성 검사
function validateLogin(event)
{
	const userId = document.getElementById('userId').value.trim();
	const password = document.getElementById('password').value.trim();
	const errorMsg = document.querySelector('.error-message');

	if (userId == "" || password == "")
	{
		showError('아이디와 비밀번호를 모두 입력해주세요.');
		return false;
	}

	if (userId.length < 4)
	{
		showError('아이디는 4자 이상이어야 합니다.');
		return false;
	}

	if (password.length < 6)
	{
		showError('비밀번호는 6자 이상이어야 합니다.');
		return false;
	}

	return true;
}

// 에러 메시지 제거
function closeErrorMessage()
{
	const errorMsg = document.querySelector('.error-message');
	errorMsg.classList.remove('show');
}

// 페이지 로드시 아이디 입력란에 포커스
window.addEventListener('load', function()
{
	document.getElementById('userId').focus();
});