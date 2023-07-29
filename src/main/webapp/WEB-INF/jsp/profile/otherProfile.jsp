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
	<c:when test="${follow}">
	<div class="text-center"><button class="btn btn-primary" id="unfollowBtn" data-unfollow-id="${profile.id}" data-login-id="${profile.loginId}" data-name="${profile.name}">언팔로우</button></div>
	</c:when>
	<c:otherwise>
	<div class="text-center"><button class="btn btn-info" id="followBtn" data-follow-id="${profile.id}" data-login-id="${profile.loginId}" data-name="${profile.name}">팔로우</button></div>
	</c:otherwise>
</c:choose>

<div class="d-flex justify-content-around mt-5 stop-drag">
	<div>
		<div class="text-center h4 font-weight-bold pb-2">팔로워</div>
		<c:forEach items="${finalFollowerList}" var="follower">
			<div class="text-center text-primary h5">
				<a href="/profile/other_profile_view?userId=${follower.id}" class="a-tag-deco-none">${follower.loginId}</a>
			</div>		
		</c:forEach>
	</div>
	<div>
		<div class="text-center h4 font-weight-bold pb-2">팔로잉</div>
		<c:forEach items="${finalFollowingList}" var="following">
			<div class="text-center text-primary h5">
				<a href="/profile/other_profile_view?userId=${following.id}" class="a-tag-deco-none">${following.loginId}</a>
			</div>	
		</c:forEach>
	</div>
</div>


<c:choose>
	<c:when test="${empty cardList}">
		<div class="text-center h5 stop-drag mt-5 mb-5">${profile.loginId}님이 올린 게시물이 아직 없네요.</div>
	</c:when>
	<c:otherwise>
		<div class="d-flex justify-content-center">
			<div class="timeline-box w-75">
				<c:forEach items="${cardList}" var="card" varStatus="status">
					<div class="card">
						<div class="card-top border d-flex justify-content-between align-items-center py-2 stop-drag">
						
							<div class="pl-2">
								${profile.loginId}님의&nbsp;${cardListSize - status.index}번째 글
							</div>
						</div>
						<div class="card-img">
							<img src="${card.post.imagePath}" class="w-100" alt="본문 이미지">
						</div>
						<div class="card-like mt-1 stop-drag d-flex align-items-center">
							<%-- 인덱스가 유니크 아이디인 것 알기 --%>
							<c:choose>
								<c:when test="${card.filledLike}">
								<a href="#" class="like-btn" data-post-id="${card.post.id}"><img src="https://cdn1.iconfinder.com/data/icons/cyber-monday-85/32/like_heart_love_button_follow-256.png" width="25px" class="ml-3" alt="채워진 하트"></a>
								</c:when>
								<c:otherwise>
								<a href="#" class="like-btn" data-post-id="${card.post.id}"><img src="https://cdn1.iconfinder.com/data/icons/cyber-monday-82/32/like_heart_love_button_follow-256.png" width="25px" class="ml-3" alt="빈 하트"></a>
								</c:otherwise>
							</c:choose>					
							<span class="font-weight-bold ml-1">좋아요 ${card.likeCount}개</span>
						</div>
						<div class="card-post mt-2 px-3">
							
							<span class="post-content-font">${card.post.content}</span>
							
							<fmt:parseDate value="${card.post.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
							<div>
								<span class="text-secondary float-right mt-1 stop-drag"><fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 MM월 dd일 HH:mm"/></span>
							</div>
						</div>
							
						<div class="card-comment-desc font-weight-bold border w-100 pl-3 py-2 mt-3 mb-1 stop-drag">
						댓글
						</div>
						<div class="card-comment-list px-2">
							<c:forEach items="${card.commentList}" var="commentView">						
									<div class="card-comment my-1 d-flex align-items-center">
										<div class="comment-id-box stop-drag">
										<c:choose>
										<c:when test="${not empty userId}">
											<a href="#" class="a-tag-deco-none comment-user-click" data-comment-user-id="${commentView.user.id}">
											<c:choose>
											<c:when test="${not empty commentView.user.profileImagePath}">								
											<img src="${commentView.user.profileImagePath}" class="comment-profile-image-circle" width="35px" alt="댓글 작성자 이미지">								
											</c:when>
											<c:otherwise>
											<img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" class="comment-profile-image-circle" width="35px" alt="댓글 작성자 이미지">
											</c:otherwise>
											</c:choose>
											<span class="font-weight-bold mr-1">${commentView.user.loginId}</span></a>
										</c:when>
										<c:otherwise>
											<a href="#" class="a-tag-deco-none comment-user-click" data-comment-user-id="${commentView.user.id}">
											<c:choose>
											<c:when test="${not empty commentView.user.profileImagePath}">								
											<img src="${commentView.user.profileImagePath}" class="comment-profile-image-circle" width="35px" alt="댓글 작성자 이미지">								
											</c:when>
											<c:otherwise>
											<img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" class="comment-profile-image-circle" width="35px" alt="댓글 작성자 이미지">
											</c:otherwise>
											</c:choose>
											<span class="font-weight-bold mr-1">${commentView.user.loginId}</span></a>
										</c:otherwise>					
										</c:choose>
										</div>
										<div class="comment-content-box">
											<span>${commentView.comment.content}</span>
											
											<%-- 댓글 삭제 버튼 - 로그인 된 사람의 댓글일 때 삭제 버튼 노출 --%>
											<c:if test="${userId eq commentView.user.id}">
											<a href="#" class="comment-del-btn" data-comment-id="${commentView.comment.id}"><img src="https://www.iconninja.com/files/603/22/506/x-icon.png" class="ml-2 pb-1" width="8px" alt="삭제 버튼 이미지"></a>
											</c:if>
										</div>
										<div class="comment-date-box text-right">
											<fmt:parseDate value="${commentView.comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
											<span class="comment-date text-secondary pt-1 float-right mr-1 stop-drag"><fmt:formatDate value="${parsedCreatedAt}" pattern="yy.MM.dd HH:mm"/></span>
										</div>
									</div>	
							</c:forEach>
						</div>
						
						<div class="comment-write m-1 d-flex justify-content-between">
							<input type="text" placeholder="댓글 내용을 입력하세요" class="comment-input form-control w-100 mb-1">
							<!-- <input type="text" class="postIdValue d-none" value="${post.id}"> -->
							<button type="button" class="comment-btn btn btn-secondary" data-post-id="${card.post.id}">올리기</button>
						</div>
						<div class="card-bottom"></div>
					</div>
				</c:forEach>	
			</div>
		</div>
		<div class="mb-5"></div>		
	</c:otherwise>
</c:choose>

<script>

$(document).ready(function() {
	
	$('.card-user-click').on('click', function(e) {
		e.preventDefault();
		let userId = "${userId}";
		let cardUserId = $(this).data('card-user-id');
		
		if (userId == "") {
			
			let result = confirm("회원정보 열람 기능은 로그인이 필요합니다. 로그인 하시겠습니까?");
			
			if (!result) {
				return;
			} else {
				location.href="/user/sign_in_view";
				return;
			}
			
		} else {
			
			location.href="/profile/other_profile_view?userId=" + cardUserId;
			
		}				
	});
	
	
	$('.comment-user-click').on('click', function(e) {
		e.preventDefault();
		let userId = "${userId}";
		let commentUserId = $(this).data('comment-user-id');
		
		if (userId == "") {
			
			let result = confirm("회원정보 열람 기능은 로그인이 필요합니다. 로그인 하시겠습니까?");
			
			if (!result) {
				location.href="/timeline/timeline_view";
				document.location.reload(true);
				return;
			} else {
				location.href="/user/sign_in_view";
				return;
			}
			
		} else {
			
			location.href="/profile/other_profile_view?userId=" + commentUserId;
			
		}				
	});
	
	$('.comment-input').keydown(function(keyNum){
		//현재의 키보드의 입력값을 keyNum으로 받음
		if(keyNum.keyCode == 13){ 
			// keydown으로 발생한 keyNum의 숫자체크
			// 숫자가 enter의 아스키코드 13과 같으면
			// 기존에 정의된 클릭함수를 호출
			$(this).siblings('.comment-btn').click();
		}
	});
	
	
	$('.comment-btn').on('click', function() {
		
		let userId = "${userId}";
		
		if (userId == "") {
			let result = confirm("댓글 기능은 로그인이 필요합니다. 로그인 하시겠습니까?");
			if (!result) {
				return;
			} else {
				location.href="/user/sign_in_view";
				return;
			}
		}
		
		let content = $(this).siblings('.comment-input').val().trim();		
		// * 댓글 내용 가져오기 방법1
		// let comment = $(this).siblings('input').val().trim();
		
		// * 댓글 내용 가져오기 방법2
		// let comment = $(this).prev().val().trim();
		// alert(comment);
		
		
		
		// let postId = $(this).siblings('.postIdValue').val();
		let postId = $(this).data('post-id');
		
		if (!content) {
			alert("댓글 내용을 입력하세요.");
			return;
		}
		
		if (content.length > 70) {
			alert("댓글은 70자 이내로 작성해주세요. 작성하신 댓글이 " + (content.length - 70) + "자 초과되었습니다.");
			return;
		}
		
		let formData = new FormData();
		formData.append("content", content);
		formData.append("postId", postId);
		
		$.ajax({
			type: "post"
			, url: "/comment/create"
			, data: formData
			, processData: false
			, contentType: false
			
			
			, success: function(data) {
				if (data.code == 1) {
					document.location.reload(true);  // 제자리 새로고침
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("댓글 업로드 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});

	$('.comment-del-btn').on('click', function(e) {
		e.preventDefault();
		
		let result = confirm("댓글을 삭제하시겠습니까?");
		if (!result) {
			return;
		}
		
		let commentId = $(this).data("comment-id");
		
		let formData = new FormData();
		formData.append("commentId", commentId);
		
		$.ajax({
			type: "post"
			, url: "/comment/delete"
			, data: formData
			, processData: false
			, contentType: false
			
			
			, success: function(data) {
				if (data.code == 1) {
					document.location.reload(true);  // 제자리 새로고침
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("댓글 삭제 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});
	
	$('.like-btn').on('click', function(e) {
		e.preventDefault();

		// 자바스크립트에서도 이거 가능 ↓
		// let userId = "${userId}";
		let userId = "${userId}";
		
		if (userId == "") {
			let result = confirm("좋아요 기능은 로그인이 필요합니다. 로그인 하시겠습니까?");
			if (!result) {
				return;
			} else {
				location.href="/user/sign_in_view";
				return;
			}
		}
		
		let postId = $(this).data("post-id");
		
		$.ajax({
			type: "get"
			, url: "/like/" + postId
			
			, success: function(data) {
				if (data.code == 1) {
					document.location.reload(true);  // 제자리 새로고침
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("좋아요/해제 실패, 관리자에게 문의하세요.")
			}
		
		});
		
	});

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
					document.location.reload(true);  // 제자리 새로고침
					// alert(loginId + "(" + name +  ")님 팔로우 완료")
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