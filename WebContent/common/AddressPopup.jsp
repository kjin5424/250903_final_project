<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주소 검색</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: #f5f7fa;
	padding: 20px;
}

.popup-container {
	max-width: 460px;
	margin: 0 auto;
}

.popup-header {
	background: white;
	padding: 20px;
	border-radius: 12px 12px 0 0;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.popup-title {
	font-size: 20px;
	font-weight: bold;
	color: #2d5a29;
	margin-bottom: 15px;
}

.search-section {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.select-group {
	display: flex;
	gap: 10px;
}

.form-select {
	flex: 1;
	padding: 12px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	font-family: inherit;
	cursor: pointer;
	transition: all 0.2s ease;
}

.form-select:focus {
	outline: none;
	border-color: #a8d5a1;
}

.form-select:disabled {
	background: #f5f5f5;
	cursor: not-allowed;
}

.btn-confirm {
	width: 100%;
	padding: 12px;
	background: #2d5a29;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
	margin-top: 10px;
}

.btn-confirm:hover {
	background: #1f4019;
}

.btn-confirm:disabled {
	background: #ccc;
	cursor: not-allowed;
}

.result-section {
	background: white;
	padding: 20px;
	border-radius: 0 0 12px 12px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
	margin-top: 2px;
}

.result-title {
	font-size: 14px;
	font-weight: 600;
	color: #333;
	margin-bottom: 10px;
}

.result-address {
	background: #f8faf9;
	border: 2px solid #e8f5e6;
	border-radius: 8px;
	padding: 15px;
	font-size: 15px;
	color: #2d5a29;
	line-height: 1.6;
	min-height: 60px;
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
}

.result-address.empty {
	color: #999;
	font-size: 14px;
}

.button-group {
	display: flex;
	gap: 10px;
	margin-top: 15px;
}

.btn {
	flex: 1;
	padding: 12px;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.2s ease;
}

.btn-cancel {
	background: #f0f0f0;
	color: #666;
}

.btn-cancel:hover {
	background: #e0e0e0;
}

.btn-submit {
	background: #2d5a29;
	color: white;
}

.btn-submit:hover {
	background: #1f4019;
}

.btn-submit:disabled {
	background: #ccc;
	cursor: not-allowed;
}

.info-box {
	background: #fff9e6;
	border-left: 4px solid #ffc107;
	padding: 12px;
	border-radius: 6px;
	margin-bottom: 15px;
	font-size: 13px;
	color: #666;
	line-height: 1.5;
}
</style>
</head>
<body>
	<div class="popup-container">
		<div class="popup-header">
			<h2 class="popup-title">📍 주소 검색</h2>
			
			<div class="info-box">
				시/도, 시/군/구, 읍/면/동을 순서대로 선택해주세요.
			</div>
			
			<div class="search-section">
				<select id="sido" class="form-select" onchange="loadSigungu()">
					<option value="">시/도 선택</option>
				</select>
				
				<div class="select-group">
					<select id="sigungu" class="form-select" onchange="loadDong()" disabled>
						<option value="">시/군/구 선택</option>
					</select>
					
					<select id="dong" class="form-select" onchange="updateAddress()" disabled>
						<option value="">읍/면/동 선택</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="result-section">
			<div class="result-title">선택된 주소</div>
			<div id="resultAddress" class="result-address empty">
				주소를 선택해주세요
			</div>
			
			<div class="button-group">
				<button class="btn btn-cancel" onclick="window.close()">
					취소
				</button>
				<button class="btn btn-submit" id="submitBtn" onclick="confirmAddress()" disabled>
					확인
				</button>
			</div>
		</div>
	</div>
	
	<script>
		// 주소 데이터 (실제로는 서버에서 가져와야 함)
		const addressData = {
			"서울특별시": {
				"강남구": ["역삼동", "개포동", "청담동", "삼성동", "대치동", "신사동", "논현동", "압구정동", "세곡동", "자곡동"],
				"강동구": ["명일동", "고덕동", "상일동", "길동", "둔촌동", "암사동", "성내동", "천호동"],
				"강북구": ["미아동", "번동", "수유동", "우이동"],
				"강서구": ["염창동", "등촌동", "화곡동", "가양동", "마곡동", "내발산동", "외발산동", "공항동", "방화동"],
				"관악구": ["봉천동", "신림동", "남현동"],
			},
			"경기도": {
				"수원시": ["장안구", "권선구", "팔달구", "영통구"],
				"성남시": ["수정구", "중원구", "분당구"],
				"용인시": ["처인구", "기흥구", "수지구"],
				"고양시": ["덕양구", "일산동구", "일산서구"],
			},
			"인천광역시": {
				"중구": ["신생동", "신포동", "선화동", "답동", "북성동"],
				"동구": ["만석동", "화수동", "송현동", "화평동"],
				"미추홀구": ["숭의동", "용현동", "학익동", "도화동"],
				"연수구": ["옥련동", "선학동", "연수동", "청학동", "동춘동"],
			},
			"부산광역시": {
				"해운대구": ["우동", "중동", "송정동", "재송동", "반여동"],
				"부산진구": ["부전동", "연지동", "초읍동", "양정동", "전포동"],
				"남구": ["대연동", "문현동", "용호동", "용당동"],
			},
			"대구광역시": {
				"중구": ["동인동", "삼덕동", "성내동", "대신동"],
				"동구": ["신암동", "효목동", "도평동", "불로동"],
				"서구": ["내당동", "비산동", "평리동"],
			},
			"광주광역시": {
				"동구": ["지산동", "학동", "충장동", "금남로"],
				"서구": ["화정동", "치평동", "농성동", "광천동"],
				"남구": ["봉선동", "진월동", "주월동", "대촌동"],
			},
			"대전광역시": {
				"중구": ["은행동", "선화동", "대사동", "문화동"],
				"동구": ["중앙동", "신인동", "판암동", "용운동"],
				"서구": ["둔산동", "탄방동", "용문동", "갈마동"],
			},
			"울산광역시": {
				"중구": ["성안동", "복산동", "태화동", "학성동"],
				"남구": ["삼산동", "신정동", "달동", "무거동"],
				"동구": ["방어동", "일산동", "화정동"],
			}
		};
		
		let selectedSido = '';
		let selectedSigungu = '';
		let selectedDong = '';
		
		// 페이지 로드시 시/도 목록 초기화
		window.addEventListener('load', function() {
			const sidoSelect = document.getElementById('sido');
			Object.keys(addressData).forEach(sido => {
				const option = document.createElement('option');
				option.value = sido;
				option.textContent = sido;
				sidoSelect.appendChild(option);
			});
		});
		
		// 시/군/구 로드
		function loadSigungu() {
			const sidoSelect = document.getElementById('sido');
			const sigunguSelect = document.getElementById('sigungu');
			const dongSelect = document.getElementById('dong');
			
			selectedSido = sidoSelect.value;
			
			// 초기화
			sigunguSelect.innerHTML = '<option value="">시/군/구 선택</option>';
			dongSelect.innerHTML = '<option value="">읍/면/동 선택</option>';
			dongSelect.disabled = true;
			selectedSigungu = '';
			selectedDong = '';
			
			if (!selectedSido) {
				sigunguSelect.disabled = true;
				updateAddress();
				return;
			}
			
			sigunguSelect.disabled = false;
			
			// 시/군/구 목록 추가
			const sigungus = addressData[selectedSido];
			Object.keys(sigungus).forEach(sigungu => {
				const option = document.createElement('option');
				option.value = sigungu;
				option.textContent = sigungu;
				sigunguSelect.appendChild(option);
			});
			
			updateAddress();
		}
		
		// 읍/면/동 로드
		function loadDong() {
			const sigunguSelect = document.getElementById('sigungu');
			const dongSelect = document.getElementById('dong');
			
			selectedSigungu = sigunguSelect.value;
			
			// 초기화
			dongSelect.innerHTML = '<option value="">읍/면/동 선택</option>';
			selectedDong = '';
			
			if (!selectedSigungu) {
				dongSelect.disabled = true;
				updateAddress();
				return;
			}
			
			dongSelect.disabled = false;
			
			// 읍/면/동 목록 추가
			const dongs = addressData[selectedSido][selectedSigungu];
			dongs.forEach(dong => {
				const option = document.createElement('option');
				option.value = dong;
				option.textContent = dong;
				dongSelect.appendChild(option);
			});
			
			updateAddress();
		}
		
		// 주소 업데이트
		function updateAddress() {
			const sidoSelect = document.getElementById('sido');
		    const sigunguSelect = document.getElementById('sigungu');
		    const dongSelect = document.getElementById('dong');

		    selectedSido = sidoSelect.value;
		    selectedSigungu = sigunguSelect.value;
		    selectedDong = dongSelect.value;
		    
			const resultDiv = document.getElementById('resultAddress');
			const submitBtn = document.getElementById('submitBtn');
			
			if (selectedSido && selectedSigungu && selectedDong) {
				const fullAddress = selectedSido + " " +  selectedSigungu + " " +  selectedDong;
				resultDiv.textContent = fullAddress;
				resultDiv.classList.remove('empty');
				submitBtn.disabled = false;
			} else {
				resultDiv.textContent = '주소를 선택해주세요';
				resultDiv.classList.add('empty');
				submitBtn.disabled = true;
			}
		}
		
		// 주소 확인
		function confirmAddress() {
			if (!selectedSido || !selectedSigungu || !selectedDong) {
				alert('주소를 모두 선택해주세요.');
				return;
			}
			
			const fullAddress = selectedSido + " " +  selectedSigungu + " " +  selectedDong;
			// 부모 창의 setAddress 함수 호출
			if (window.opener && !window.opener.closed) {
				window.opener.setAddress(fullAddress);
				window.close();
			} else {
				alert('부모 창을 찾을 수 없습니다.');
			}
		}
	</script>
</body>
</html>