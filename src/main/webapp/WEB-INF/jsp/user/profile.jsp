<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center mt-5">
	<div>
	<div class="text-center h4 mb-3 font-weight-bold">내 정보</div>
		<c:choose>
			<c:when test="${not empty profile.profileImagePath}">
				<center><div><img src="${profile.profileImagePath}" alt="프로필 사진" width="333px" class="rounded-image"></div>
				<button class="image-change-btn btn btn-info btn-sm mt-2">프로필 이미지 수정</button></center>
			</c:when>
			<c:otherwise>
				<center><div class="text-center"><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="프로필 사진" width="150px" class="rounded-image"></div>
				<button class="image-change-btn btn btn-info btn-sm mt-2">프로필 이미지 올리기</button></center>
			</c:otherwise>
		</c:choose>
		
		<table class="table table-border mt-4 stop-drag">
			<tr>
				<th class="text-center">아이디</th>
				<td>${profile.loginId}</td>
			</tr>
			<tr>
				<th></th>
				<td><button id="passwordChangeOpenBtn" class="btn btn-secondary btn-sm">비밀번호 변경</button></td>
			</tr>			
			<tr class="password-change hidden">
				<th class="text-center pt-4">기존 비밀번호</th>
				<td><input type="password" id="originalPassword" class="form-control col-10 ml-2" name="password" placeholder="비밀번호 입력"></td>
			</tr>
			<tr class="password-change hidden">
				<th class="text-center pt-4">* 새 비밀번호</th>
				<td><input type="password" id="newPassword" class="form-control col-10 ml-2" placeholder="수정할 비밀번호 입력"></td>
			</tr>
			<tr class="password-change hidden">
				<th class="text-center pt-4">* 새 비밀번호 확인</th>
				<td><input type="password" id="newPasswordCheck" class="form-control col-10 ml-2" placeholder="수정할 비밀번호 확인"></td>
			</tr>
			<tr class="password-change hidden">
				<th></th>
				<td><button id="passwordChangeBtn" class="btn btn-dark btn-sm float-right mr-5">변경</button></td>
			</tr>
			<tr>
				<th class="text-center">이름</th>
				<td>${profile.name}</td>
			</tr>
			<tr>
				<th class="text-center">이메일</th>
				<td>${profile.email}</td>
			</tr>
			<tr>
				<th class="text-center">가입일자</th>
				<fmt:parseDate value="${profile.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedCreatedAt"/>
				<td><fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 MM월 dd일"/></td>
			</tr>
		</table>
	</div>
</div>

<div class="d-flex justify-content-around mt-5">
	<div>
		<div class="text-center">팔로워</div>
		<c:forEach items="${followerList}" var="follower">
			<div>
				${follower.userId}
			</div>		
		</c:forEach>
	</div>
	<div>
		<div class="text-center">팔로잉</div>
		<c:forEach items="${followingList}" var="following">
			<div>
				${following.followId}
			</div>		
		</c:forEach>
	</div>
</div>

<script>

$(document).ready(function(){
	
	$('#passwordChangeOpenBtn').on('click', function() {
		if($('#passwordChangeOpenBtn').text() == "비밀번호 변경 취소") {
			$('.password-change').addClass('hidden');
			$('#passwordChangeOpenBtn').text("비밀번호 변경");
			$('#originalPassword').val('');
			$('#newPassword').val('');
			$('#newPasswordCheck').val('');
		} else {
			$('.password-change').removeClass('hidden');
			$('#passwordChangeOpenBtn').text("비밀번호 변경 취소");
		}		
	});
	
	$('#passwordChangeBtn').on('click', function() {
		let password = $('#originalPassword').val();
		let newPassword = $('#newPassword').val();
		let newPasswordCheck = $('#newPasswordCheck').val();
		
		if (!password) {
			alert("기존 비밀번호를 입력하세요.");
			return;
		}
		
		if (!newPassword) {
			alert("새로운 비밀번호를 입력하세요.");
			return;
		}
		if (!newPasswordCheck) {
			alert("새로운 비밀번호 확인란도 입력하세요.");
			return;
		}
		if (newPassword != newPasswordCheck) {
			alert("새로운 비밀번호를 정확하게 다시 입력해주세요.");
			return;
		}
		if (password == newPassword) {
			alert("기존 비밀번호와 다른 비밀번호로 변경해주세요.");
			return;
		}
		
		let formData = new FormData();
		formData.append("password", password);
		formData.append("newPassword", newPassword);
		
		$.ajax({
			type: "post"
			, url: "/user/change_password"
			, data: formData
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 1) {
					alert("비밀번호 변경 완료");
					location.href="/user/profile_view"
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("비밀번호 변경 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
});

</script>

