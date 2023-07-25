<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="signUpBox" class="d-flex justify-content-center align-items-center mt-5">

	<form id="signUpForm" method="post" action="/user/sign_up">

		<table class="table">
			<tr>
				<th class="text-center pt-4">* 아이디</th>
				<td>
					<div class="d-flex">
						<input type="text" class="form-control col-8 ml-2" name="loginId" id="loginId" placeholder="아이디 입력"> 
						<input type="button" class="btn btn-info ml-3" id="duplicatedIdCheckBtn" value="중복확인">
					</div>
					<div class="pt-1">					
						<div id="msgSpace" class="small">&nbsp;</div>
						<%-- 아이디 체크 결과 --%>
						<%-- d-none 클래스: display none (보이지 않게) --%>
						<div id="msgWrongIdLength" class="small text-danger d-none ml-3">ID는 5~20자 영어 소문자, 숫자만 사용 가능합니다.</div>
						<div id="msgAlreadyUsedId" class="small text-danger d-none ml-3">이미 사용중인 ID입니다.</div>
						<div id="msgUsableId" class="small text-success d-none ml-3">사용 가능한 ID 입니다.</div>
					</div>
				</td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 비밀번호</th>
				<td><input type="password" class="form-control col-8 ml-2" name="password" placeholder="비밀번호 입력"></td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 비밀번호 확인</th>
				<td><input type="password" class="form-control col-8 ml-2" id="passwordCheck" placeholder="비밀번호 입력"></td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 이름</th>
				<td><input type="text" class="form-control col-8 ml-2" name="name" placeholder="이름 입력">
				</td>
			</tr>
			<tr>
				<th class="text-center pt-4">* 이메일주소</th>
				<td><input type="text" class="form-control col-8 ml-2" name="email" placeholder="이메일 주소 입력"></td>
			</tr>
		</table>
		
		<div class="d-flex justify-content-center">
			<input type="submit" class="btn btn-primary col-4" id="submitBtn" value="회원가입">
		</div>
		
	</form>
	
</div>

<script>
	$(document).ready(function() {
		$('#duplicatedIdCheckBtn').on('click', function() {
			
			let loginId = $('#loginId').val().trim();
			
			// 경고 문구 초기화
			$('#msgWrongIdLength').addClass('d-none');
			$('#msgAlreadyUsedId').addClass('d-none');
			$('#msgUsableId').addClass('d-none');
			$('#msgSpace').removeClass('d-none');
			
			let upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			let special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;			
			let korean = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			
			if (loginId.length < 5 || loginId.length > 20 || special_pattern.test(loginId) || korean.test(loginId)) {
				$('#msgWrongIdLength').removeClass('d-none');
				$('#msgSpace').addClass('d-none');
				return;
			}
			
			let loginIdArr = loginId.split("");
			for (let i = 0; i < loginIdArr.length; i++) {
				if (upperCase.includes(loginIdArr[i])) {
					$('#msgWrongIdLength').removeClass('d-none');
					$('#msgSpace').addClass('d-none');
					return;	
				}
			}
			
			$.ajax({
				
				url : "/user/is_duplicated_id"
				, data : { "loginId" : loginId }
				, success : function(data) {
					if (data.isDuplicatedId) {
						$('#msgAlreadyUsedId').removeClass('d-none');
						$('#msgSpace').addClass('d-none');
					} else {
						$('#msgUsableId').removeClass('d-none');
						$('#msgSpace').addClass('d-none');
					}
				}
				
				, error : function(request, status, error) {
					alert("중복확인에 실패했습니다. 관리자에게 문의하세요.");
				}
				
			});
			
		});
		
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault();
			
			let loginId = $('#loginId').val().trim();
			let password = $('input[name = password]').val();
			let passwordCheck = $('#passwordCheck').val();
			let name = $('input[name = name]').val().trim();
			let email = $('input[name = email]').val().trim();
			
			if (!loginId) {
				alert("아이디를 입력하세요");
 				return false;
			}
			if (!password || !passwordCheck) {
				alert("비밀번호를 입력하세요");
				return false;
			}
			if (password != passwordCheck) {
				alert("비밀번호가 일치하지 않습니다");
				return false;
			}
			if (!name) {
				alert("이름을 입력하세요");
				return false;
			}
			if (!email) {
				alert("이메일을 입력하세요");
				return false;
			}
			
			if ($('#msgUsableId').hasClass('d-none')) {
				alert('아이디를 확인하세요.');
				return false;
			}
			
			
			let url = $(this).attr('action');
			let params = $(this).serialize();
			
			$.post(url, params)
			.done(function(data){
				if (data.code == 1) {
					alert("회원가입을 환영합니다. 로그인을 해주세요.");
					location.href="/user/sign_in_view"
				} else {
					alert(data.errorMessage);
				}				
			});
			
		});
		
	});
</script>