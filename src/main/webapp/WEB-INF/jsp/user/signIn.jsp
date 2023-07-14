<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>&nbsp;</div>
<div>&nbsp;</div>
			
<div class="d-flex justify-content-center">
	<div id="loginBox" class="border d-flex justify-content-center align-items-center">
		<div>
			<form method="post" action="" id="loginform" class="form-horizontal" role="form">
				<div style="margin-bottom: 15px" class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span> 
					<input id="login-username" type="text" class="form-control" name="loginId" placeholder="아이디">
				</div>
					
				<div style="margin-bottom: 22px" class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span> 
					<input id="login-password" type="password" class="form-control" name="password" placeholder="비밀번호">
				</div>
					
				<input class="btn btn-primary d-block w-100" type="submit" value="로그인"> 
				<a href="/user/sign_up_view" class="btn btn-secondary d-block w-100 mt-3">회원가입</a>
			</form>
		</div>
	</div>
</div>