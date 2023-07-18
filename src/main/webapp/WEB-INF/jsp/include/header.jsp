<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<div class="d-flex justify-content-between align-items-center">
	<div class="h2 font-weight-bold pl-5">Instagram</div>
	<div>
		<c:choose>
			<c:when test="${not empty userName}">
				<div class="mr-5">
					<div class="text-center">
						<c:choose>
							<c:when test="${not empty profileImagePath}">
								<img src="${profileImagePath}" width="50px" alt="프로필 이미지" class="mt-2">
							</c:when>
							<c:otherwise>
								<img src="https://cdn.pixabay.com/photo/2021/06/07/13/45/user-6318003_1280.png" width="25px" alt="프로필 이미지" class="mt-2">
							</c:otherwise>	
						</c:choose>
					</div>
					<div class="mt-1 text-center font-weight-bold small">
						${userName}
					</div>
					<div class="mt-1 text-center small">
						<a href="/user/sign_out">로그아웃</a>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div class="mr-5 mt-4">
					<a href="/user/sign_in_view">로그인</a>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>