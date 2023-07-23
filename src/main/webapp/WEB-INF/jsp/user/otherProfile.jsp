<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center mt-5">
	<div>
	
		<c:choose>
			<c:when test="${not empty profile.profileImagePath}">
				<center><div><img src="${profile.profileImagePath}" alt="프로필 사진" width="333px" class="rounded-image"></div></center>
			</c:when>
			<c:otherwise>
				<center><div class="text-center"><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="프로필 사진" width="150px" class="rounded-image"></div></center>
			</c:otherwise>
		</c:choose>
		
		<table class="table table-border mt-4 stop-drag">
			<tr>
				<th class="text-center">아이디</th>
				<td>${profile.loginId}</td>
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

<c:choose>
	<c:when test="${profile.id eq follow.followId}">
	<div class="text-center"><button class="btn btn-primary" id="unfollowBtn" data-unfollow-id="${profile.id}" data-login-id="${profile.loginId}" data-name="${profile.name}">언팔로우</button></div>
	</c:when>
	<c:otherwise>
	<div class="text-center"><button class="btn btn-info" id="followBtn" data-follow-id="${profile.id}" data-login-id="${profile.loginId}" data-name="${profile.name}">팔로우</button></div>
	</c:otherwise>
</c:choose>

<div class="d-flex justify-content-around mt-5 stop-drag">
	<div>
		<div class="text-center text-primary h3">팔로워</div>
		<c:forEach items="${followerList}" var="follower">
			<div class="text-center text-primary h4">
				<a href="/user/other_profile_view?userId=${follower.userId}">${follower.userId}</a>
			</div>		
		</c:forEach>
	</div>
	<div>
		<div class="text-center text-primary h3">팔로잉</div>
		<c:forEach items="${followingList}" var="following">
			<div class="text-center text-primary h4">
				<a href="/user/other_profile_view?userId=${following.followId}">${following.followId}</a>
			</div>	
		</c:forEach>
	</div>
</div>

<script>

$(document).ready(function(){
	
	$('#unfollowBtn').on('click', function() {
		
		let loginId = $(this).data('login-id');
		let name = $(this).data('name');
		
		let result = confirm(loginId + "(" + name +  ")님 팔로우를 취소하시겠습니까?");
		if (!result) {
			return;
		}
		
		let unfollowId = $(this).data('unfollow-id');
		
		let formData = new FormData();
		formData.append("unfollowId", unfollowId);
		
		$.ajax({
			type: "post"
			, url: "/follow/delete"
			, data: formData
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 1) {
					alert("팔로우 취소 완료"); 
					location.href="/user/other_profile_view";
					document.location.reload(true);  // 제자리 새로고침
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("언팔로우 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	$('#followBtn').on('click', function(){
		
		let loginId = $(this).data('login-id');
		let name = $(this).data('name');
		
		let followId = $(this).data('follow-id');
		
		let formData = new FormData();
		formData.append("followId", followId);
		
		$.ajax({
			type: "post"
			, url: "/follow/create"
			, data: formData
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 1) {
					location.href="/user/other_profile_view";
					document.location.reload(true);  // 제자리 새로고침
					alert(loginId + "(" + name +  ")님 팔로우 완료")
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("팔로우 실패, 관리자에게 문의하세요.")
			}
		
		});
		
		
	});
	
});

</script>