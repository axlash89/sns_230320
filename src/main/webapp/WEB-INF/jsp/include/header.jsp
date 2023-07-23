<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-between align-items-center">

	<c:choose>
		<c:when test="${not empty userName}">
			<a href="/timeline/timeline_view" class="logo-text stop-drag"><div
					class="h2 font-weight-bold pl-5 mt-4 pt-2">Photogram</div></a>
		</c:when>
		<c:otherwise>
			<a href="/user/sign_in_view" class="logo-text stop-drag"><div
					class="h2 font-weight-bold pl-5 pb-1">Photogram</div></a>
		</c:otherwise>
	</c:choose>

	<div class="d-flex align-items-center pt-3">
		<c:choose>
			<c:when test="${not empty userName}">
				<div class="mr-3">
					<c:choose>
						<c:when test="${not empty profileImagePath}">
							<div class="profile-image-circle">
								<a href="/user/profile_view"><img src="${profileImagePath}" width="50px" alt="프로필 이미지" class="profile-image-ratio"></a>
							</div>
						</c:when>
						<c:otherwise>
							<div class="profile-image-circle">
								<a href="/user/profile_view"><img
									src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
									width="50px" alt="프로필 이미지" class="profile-image-ratio"></a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="mr-5">
					<div class="text-center"></div>
					<a href="/user/profile_view" id="userNameInHead"><div class="mt-2 text-center font-weight-bold stop-drag">
						${userName}</div></a>
					<div class="mt-1 text-center">
						<a href="/user/sign_out" id="logoutText" class="stop-drag">로그아웃</a>
					</div>

				</div>
			</c:when>


			<c:otherwise>
				<div class="mr-5 mt-2">
					<a href="/user/sign_in_view" class="font-weight-bold stop-drag" id="loginText">로그인</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>