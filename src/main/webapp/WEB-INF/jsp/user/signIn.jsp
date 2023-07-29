<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-center mt-5">
	<div id="loginBox" class="border d-flex justify-content-center align-items-center">
		<div>
			<form method="post" action="/user/sign_in" id="loginForm" class="form-horizontal" role="form">
				<div style="margin-bottom: 15px" class="input-group">
					<span class="input-group-addon"></span> 
					<input id="loginId" type="text" class="form-control" name="loginId" placeholder="아이디">
				</div>
					
				<div style="margin-bottom: 22px" class="input-group">
					<span class="input-group-addon"></span> 
					<input id="password" type="password" class="form-control" name="password" placeholder="비밀번호">
				</div>
					
				<input class="btn btn-info d-block w-100" type="submit" value="로그인"> 
				<a href="/user/sign_up_view" class="btn btn-secondary d-block w-100 mt-2">회원가입</a>
			</form>
		</div>
	</div>
</div>

<script>

$(document).ready(function() {
	
	$('#loginText').addClass('d-none');
	
	$('#loginForm').on('submit', function(e) {
		e.preventDefault();
		
		let loginId = $('#loginId').val().trim();
		let password = $('#password').val();
		
		if (!loginId) {
			alert("아이디를 입력하세요");
			return false;
		}
		if (!password) {
			alert("비밀번호를 입력하세요");
			return false;
		}
		
		let url = $(this).attr('action');
		let params = $(this).serialize();
		
		$.post(url, params)
		.done(function(data) {
			if (data.code == 1) {
				location.href = "/timeline/timeline_view";
			} else {
				alert(data.errorMessage);
			}
		});		
		
	});
	
});

</script>