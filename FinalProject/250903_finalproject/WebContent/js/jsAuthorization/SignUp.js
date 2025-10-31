/**
 * 
 */
// 중복 확인 상태 추적
let userIdChecked = false;
let nicknameChecked = false;
// 모든 필수 요소 검증
let passwordChecked = false;
let emailChecked = false;
let frontSsnChecked = false;
let backSsnChecked = false;
let addressChecked = false;
// 중복 확인 값 임시 저장.(→ 변경 추적용)
let tempUserId = "";
let tempUserNickname = "";

$(function()
{
	// 아이디 중복 확인
	$("#check-id").click(function()
	{
		var inputId = $("#userId").val().trim();
		var param =
		{
			uid : inputId
		};
		$.ajax(
		{
			type : "GET",
			url : "validateuniqueid.do",
			data : param,
			success : function(arg) // 입력된 아이디의 갯수
			{
				tempUserId = inputId;
				var validIdText = $("#validIdCheck");
				validIdText.css("display", "inline");
				// arg는 해당 id로 검색한 레코드 수
				if (Number.parseInt(arg) == 0) // 중복이 아닌 경우
				{
					validIdText.removeClass("error");
					validIdText.addClass("success");
					validIdText.text("사용 가능한 아이디입니다.");
					userIdChecked = true;
				} else
				// 중복인 경우
				{
					validIdText.removeClass("success");
					validIdText.addClass("error");
					validIdText.text("이미 사용 중인 아이디입니다.");
					userIdChecked = false;
				}
				checkFormValid();
			},
			beforeSend : function()
			{
				if (!inputId) // 공백 검사
					return false;

				const idPattern = /^[a-zA-Z0-9]{4,20}$/;
				if (!idPattern.test(inputId)) // 아이디 형식 검사
				{
					$("#userIdHelp").addClass("error");
					$("#userIdHelp").text("아이디는 4-20자의 영문, 숫자만 사용 가능합니다.");
					return false;
				}

				return true;
			},
			error : function(e)
			{
				alert(e.responseText);
			}
		});
		
	});

	// 아이디 칸 키 입력
	$("#userId").keyup(function(event)
	{
		// 아이디 입력값 변경 시
		if ($("#userId").val() != tempUserId)
		{
			$("#userIdHelp").removeClass("error");
			$("#userIdHelp").text("영문, 숫자 조합 4-20자");
			$("#validIdCheck").css("display", "none");
			userIdChecked = false;
		}

		// 엔터 입력
		if (event.keyCode == 13)
		{
			$("#check-id").click();
		}
		checkFormValid();
	});

	// 닉네임 중복 확인
	$("#check-nickname").click(
	function()
	{
		var inputNickname = $("#nickname").val().trim();
		var param =
		{
			nickname : inputNickname
		};
		$.ajax(
		{
			type : "GET",
			url : "validateuniquenickname.do",
			data : param,
			success : function(arg)
			{
				tempUserNickname = inputNickname;
				var validNicknameText = $("#validNicknameCheck");
				validNicknameText.css("display", "inline");
				if (Number.parseInt(arg) == 0)
				{
					validNicknameText.removeClass("error");
					validNicknameText.addClass("success");
					validNicknameText.text("사용 가능한 닉네임입니다.");
					nicknameChecked = true;
				} else
				{
					validNicknameText.removeClass("success");
					validNicknameText.addClass("error");
					validNicknameText.text("이미 사용중인 닉네임입니다.");
					nicknameChecked = false;
				}
				checkFormValid();
			},
			beforeSend : function()
			{
				if (!inputNickname) // 공백 검사
					return false;

				const nicknamePattern = /^[가-힣a-zA-Z0-9]{2,12}$/;
				if (!nicknamePattern.test(inputNickname)) // 유효성 검사
				{
					$("#nicknameHelp").addClass("error");
					$("#nicknameHelp").text(
							" 닉네임은 2-12자의 한글, 영문, 숫자만 사용 가능합니다.");
					return false;
				}

				return true;
			},
			error : function(e)
			{
				alert(e.responseText);
			}
		});
	});

	// 닉네임 칸 키 입력
	$("#nickname").keyup(function(event)
	{
		// 닉네임 입력값 변경 시
		if ($("#nickname").val() != tempUserNickname)
		{
			$("#nicknameHelp").removeClass("error");
			$("#nicknameHelp").text("2-12자의 한글, 영문, 숫자");
			$("#validNicknameCheck").css("display", "none");
			nicknameChecked = false;
		}

		// 엔터키 입력시
		if (event.keyCode == 13)
		{
			$("#check-nickname").click();
		}
		checkFormValid();
	});

	// 비밀번호 칸 키 입력(강도표기 & 유효성검사)
	$("#password").keyup(function()
	{
		$("#password-help").text("영문, 숫자, 특수문자(~,!,@,#,$) 조합 8-20자");
		const inputPw = $(this).val();
		const fill = $("#strengthFill");
		const idStr = $("#strengthText");

		if (inputPw.length === 0)
		{
			$("#passwordStrength").css("display", "none");
			return;
		}

		$("#passwordStrength").css("display", "block");

		const validPattern = /^[a-zA-Z0-9~!@#$]*$/;
		if (!validPattern.test(inputPw))
		{
			$("#passwordStrength").css("display", "none");
			$("#password-help").text('영문, 숫자, 특수문자(~,!,@,#,$)만 사용 가능합니다.');
			return;
		}

		var strength = 0;
		if (inputPw.length >= 8)
			strength++;
		if (/[a-zA-Z]/.test(inputPw))
			strength++;
		if (/[0-9]/.test(inputPw))
			strength++;
		if (/[~!@#$]/.test(inputPw))
			strength++;

		idStr.css("display", "inline");
		fill.removeClass("week medium strong");
		if (strength <= 2)
		{
			fill.addClass('weak');
			idStr.text('약함');
		} else if (strength === 3)
		{
			fill.addClass('medium');
			idStr.text('보통');
		} else
		{
			fill.addClass('strong');
			idStr.text('강함');
		}
		
	});
	
	
	// 비밀번호 확인
	$("#passwordConfirm").keyup(function checkPw()
	{
		const password = $("#password").val();
		const checkPw = $(this).val();
		const help = document.getElementById('passwordConfirmHelp');
		
		if (checkPw.length === 0)
		{
			help.textContent = '';
			this.classList.remove('error', 'success');
			return;
		}

		if (password === checkPw)
		{
			help.textContent = '비밀번호가 일치합니다.';
			help.className = 'form-help success';
			this.classList.remove('error');
			this.classList.add('success');
			passwordChecked = true;
		} else
		{
			help.textContent = '비밀번호가 일치하지않습니다.';
			help.className = 'form-help error';
			this.classList.remove('success');
			this.classList.add('error');
			passwordChecked = false;
		}
		
		checkFormValid();
	});
	
	
	// 이메일 유효성 및 중복 검사
	$("#email").blur(function() 
	{
		const inputEmail = this.value.trim();
		const help = $("#emailHelp");

		var param = {email: inputEmail}
		$.ajax(
		{
			type: "GET"
			, url: "validateuniqueemail.do"
			, data: param
			, success: function(arg)
			{
				if (Number.parseInt(arg) == 0)
				{
					help.removeClass("error");
					help.addClass("success");
					help.text("사용 가능한 이메일입니다.");
					emailChecked = true;
				}
				else
				{
					if (confirm("먼저 등록된 이메일이 있습니다.\n" +
							"찾아보시겠습니까?"))
					{
						$(location).prop("href", "findidpage.do");
					}
					help.removeClass("success");
					help.addClass("error");
					help.text("이미 존재하는 이메일입니다.");
					emailChecked = false;
				}
				checkFormValid();
			}
			, beforeSend: function()
			{
				const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
				if(!emailPattern.test(inputEmail) || !inputEmail)
				{
					help.text('올바른 이메일 형식이 아닙니다.');
					help.removeClass("success");
					help.addClass("error");
					return false;
				}
				return true;
			}
			, error: function(e)
			{
				alert(e.responseText);
			}
		});
	});
	
	
	// 주민등록번호 앞자리 유효성 검사
	$("#ssnFront").blur(function()
	{
		const ssnFront = $(this).val().trim();
		const help = document.getElementById('ssnHelp');
		const ssnPattern = /^[0-9]{6}$/;
		
		if (!ssnPattern.test(ssnFront))
		{
			help.textContent = '주민등록번호를 정확히 입력해주세요.';
			help.className = 'form-help error';
			frontSsnChecked = false;
			return;
		}
		
		help.textContent = '주민등록번호는 안전하게 암호화되어 저장됩니다.';
		help.className = 'form-help';
		frontSsnChecked = true;
		checkFormValid();
	});
	
	
	// 주민등록번호 뒷자리 유효성 검사
	$("#ssnBack").blur(function()
	{
		const ssnBack = $(this).val().trim();
		const help = $("#ssnHelp");
		const ssnPattern = /^[0-9]{7}$/;

		if (!ssnPattern.test(ssnBack))
		{
			help.textContent = '주민등록번호를 정확히 입력해주세요.';
			help.className = 'form-help error';
			backSsnChecked = false;
			return;
		}
		
		// 서버로 중복 확인 요청 (자바에서 구현 예정)
		// TODO: 주민등록번호 중복 확인 API 호출
		// 만약 중복이면 아이디 찾기 페이지로 이동 여부 물어보기
		// 중복검사 패스
		
		help.textContent = '주민등록번호는 안전하게 암호화되어 저장됩니다.';
		help.className = 'form-help';
		backSsnChecked = true;
		checkFormValid();
	});
	
	$("#check-addr").click(function()
	{
		new daum.Postcode({
	        oncomplete: function(data) {
	          // 도로명 주소
	          var roadAddr = data.roadAddress;
	          // 우편번호
	          var zonecode = data.zonecode;

	          $("#zipCode").val(zonecode);
	          $("#address").val(roadAddr);
	        }
		}).open();
		addressChecked = true;
	});

});


//랜덤 닉네임 생성
function generateRandomNickname()
{
	const adjectives = [ '행복한', '즐거운', '신나는', '활기찬', '밝은', '재밌는', '멋진' ];
	const nouns = [ '토끼', '고양이', '강아지', '판다', '코알라', '펭귄', '여우' ];
	const numbers = Math.floor(Math.random() * 100);

	const randomNickname = adjectives[Math.floor(Math.random()
			* adjectives.length)]
			+ nouns[Math.floor(Math.random() * nouns.length)] + numbers;

	document.getElementById('nickname').value = randomNickname;
	nicknameChecked = false;
	document.getElementById('nickname').classList.remove('success', 'error');
	$("#nicknameHelp").css("color", "#666");
	document.getElementById('nicknameHelp').textContent = '중복 확인을 해주세요.';
	document.getElementById('nicknameHelp').className = 'form-help';
}


// 약관 전체 동의
function toggleAllTerms(checkbox) {
	const checkboxes = ['agreeService', 'agreePrivacy', 'agreeMarketing'];
	checkboxes.forEach(id => {
		document.getElementById(id).checked = checkbox.checked;
	});
	checkFormValid();
}

// 약관 개별 체크시 전체 동의 업데이트
function updateAgreeAll() {
	const service = document.getElementById('agreeService').checked;
	const privacy = document.getElementById('agreePrivacy').checked;
	const marketing = document.getElementById('agreeMarketing').checked;
	
	document.getElementById('agreeAll').checked = service && privacy && marketing;
	checkFormValid();
}

// 약관 보기
function showTerms(type) {
	const title = type === 'service' ? '이용약관' : '개인정보 처리방침';
	alert(title + ' 내용을 보여줄 팝업 (구현 예정)');
}

// 폼 유효성 전체 체크
function checkFormValid() {
	const service = document.getElementById('agreeService').checked;
	const privacy = document.getElementById('agreePrivacy').checked;
	const submitBtn = document.getElementById('submitBtn');
	
	// 필수 약관과 중복확인이 모두 완료되었는지 체크
	if (userIdChecked && nicknameChecked && service && privacy) {
		submitBtn.disabled = false;
	} else {
		submitBtn.disabled = true;
	}
}

