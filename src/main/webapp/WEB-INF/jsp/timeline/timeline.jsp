<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="d-flex justify-content-center mt-2">

	<div class="w-75">
	<c:if test="${not empty recommendedUsers}">
		<!-- 유저 추천 -->
		<div class="mt-2 mb-3 py-2">
			<div class="stop-drag font-weight-bold border-bottom text-center">유저 추천</div>
			<div class="d-flex justify-content-around py-1">
			<c:forEach items="${recommendedUsers}" var="recommendedUser">
				<c:choose>
				<c:when test="${not empty recommendedUser.profileImagePath}">
				<a href="#" class="a-tag-deco-none card-user-click" data-card-user-id="${recommendedUser.id}">
				<img src="${recommendedUser.profileImagePath}" width="5px" alt="프로필 이미지" class="recommended-profile-image">			
				${recommendedUser.loginId}
				</a>
				</c:when>
				<c:otherwise>
				<a href="#" class="a-tag-deco-none card-user-click" data-card-user-id="${recommendedUser.id}">
				<img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" width="5px" alt="프로필 이미지" class="recommended-profile-image">
				${recommendedUser.loginId}
				</a>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			</div>
		</div>
	</c:if>
		<div class="border">	
		<textarea id="writeTextArea" placeholder="내용을 입력하세요" rows="3" class="w-100"></textarea>
		<div class="d-flex justify-content-between pb-2">
			<div class="file-upload d-flex ml-3">				
				<%-- file 태그를 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 효과를 준다. --%>
				<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif" class="d-none">
				<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
				<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
				<%-- 업로드 된 임시 파일 이름 저장되는 곳 --%>
				<div class="ml-2 d-flex align-items-center" id="fileName"></div>				
			</div>
			<button type="button" id="writeBtn" class="btn btn-info mr-2">올리기</button>
		</div>
		</div>
	</div>
</div>


<div class="d-flex justify-content-center">
	<div class="timeline-box w-75">
		<c:forEach items="${cardList}" var="card">
			<div class="card">
				<div class="card-top border d-flex justify-content-between align-items-center py-2 stop-drag">
				
				<c:choose>
				<c:when test="${not empty userId}">
					<c:choose>
					<c:when test="${not empty card.user.profileImagePath}">
						<a href="#" class="a-tag-deco-none card-user-click" data-card-user-id="${card.user.id}"><div class="ml-3 d-flex align-items-center"><img src="${card.user.profileImagePath}" class="card-profile-image-circle" width="35px" alt="프로필 이미지"><span class="ml-2">${card.user.loginId}</span></div></a>
					</c:when>
					<c:otherwise>
						<a href="#" class="a-tag-deco-none card-user-click" data-card-user-id="${card.user.id}"><div class="ml-3 d-flex align-items-center"><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" class="card-profile-image-circle" width="35px" alt="프로필 이미지"><span class="ml-2">${card.user.loginId}</span></div></a>
					</c:otherwise>
					</c:choose>	
				</c:when>
				<c:otherwise>
					<c:choose>
					<c:when test="${not empty card.user.profileImagePath}">
						<a href="#" class="a-tag-deco-none card-user-click" data-card-user-id="${card.user.id}"><div class="ml-3 d-flex align-items-center"><img src="${card.user.profileImagePath}" class="card-profile-image-circle" width="35px" alt="프로필 이미지"><span class="ml-2">${card.user.loginId}</span></div></a>
					</c:when>
					<c:otherwise>
						<a href="#" class="a-tag-deco-none card-user-click" data-card-user-id="${card.user.id}"><div class="ml-3 d-flex align-items-center"><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" class="card-profile-image-circle" width="35px" alt="프로필 이미지"><span class="ml-2">${card.user.loginId}</span></div></a>
					</c:otherwise>
					</c:choose>	
				</c:otherwise>	
				</c:choose>
					<%-- 내가 쓴 글일 때만 노출 --%>
					<c:if test="${userId eq card.user.id}">
						<a href="#" class="more-btn" data-toggle="modal" data-target="#eModal" data-post-id="${card.post.id}"><div class="mr-3"><img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30px" alt="더보기"></div></a>
					</c:if>
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
					<c:choose>
					<c:when test="${not empty userId}">
					<a href="#" class="a-tag-deco-none card-user-click stop-drag" data-card-user-id="${card.user.id}"><span class="post-userLoginId ml-1 mr-1">${card.user.loginId}</span></a>
					</c:when>
					<c:otherwise>
					<a href="#" class="a-tag-deco-none card-user-click stop-drag" data-card-user-id="${card.user.id}"><span class="post-userLoginId ml-1 mr-1">${card.user.loginId}</span></a>
					</c:otherwise>					
					</c:choose>
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

<!-- Modal -->
<div class="modal fade" id="eModal" class="w-50">
	<%-- modal-sm : 작은 모달 --%>
	<%-- modal-dialog-centered : 모달창을 수직기준 가운데 위치 --%>
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content text-center font-weight-bold">
			<div class="py-3 border-bottom">
     			<a href="#" id="deletePostBtn" class="a-tag-deco-none">삭제하기</a>
     		</div>
			<div class="py-3">
				<a href="#" data-dismiss="modal" class="a-tag-deco-none">취소</a>
			</div>
		</div>
	</div>
</div>

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
	
	// 글 삭제(더보기(...) 버튼 클릭) => 모달 띄우기
	$('.more-btn').on('click', function(e){
		e.preventDefault();  // a태그 위로 올라감 방지
		
		let postId = $(this).data('post-id');

		// 한개인 모달 태그에(재활용) data-post-id를 심어줌
		$('#eModal').data('post-id', postId);  // 세팅
		
	});
	
	// 모달 안에 있는 삭제하기 클릭 => 진짜 삭제
	$('#eModal #deletePostBtn').on('click', function(e) {
		e.preventDefault();
		
		let postId = $('#eModal').data('post-id');
		
		$.ajax({
			
			type: "delete"
			, url: "/post/delete"
			, data : {"postId": postId}
		
			, success:function(data) {
				if(data.code == 1) {
					alert("게시물이 삭제되었습니다.");
					location.href="/timeline/timeline_view";
					document.location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("게시물 삭제에 실패하였습니다. 관리자에게 문의하세요.")
			}
			
		})
		
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
	})
	
	// 파일 이미지 클릭 => 숨겨져 있는 type="file"을 동작시킨다.
	$('#fileUploadBtn').on('click', function(e) {
		e.preventDefault();  // a태그의 스크롤 올라가는 현상 방지
		$('#file').click();  // input file을 클릭한 것과 같은 효과
	});
	
	function lessThanFiveMegaBytes(){
		if(document.getElementById("file").value!=""){
			let fileSize = document.getElementById("file").files[0].size;
			let maxSize = 5 * 1024 * 1024;  // 5MB
			
			if(fileSize > maxSize){				
				return false;
			} else {
				return true;
			}
		}
	}
	
	// 사용자가 이미지를 선택하는 순간 유효성 확인 및 업로드 된 파일명 노출
	$('#file').on('change', function(e) {		
		if(lessThanFiveMegaBytes() == false) {
			alert("첨부파일 사이즈는 5MB 이내로 등록 가능합니다. ");
			$('#file').val("");  // 파일 태그에 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
			$('#fileName').text('');
			return;
		}
		
		let fileName = e.target.files[0].name;  // git10.jpg
		// console.log(fileName);
		
		// 확장자 유효성 확인
		let ext = fileName.split(".").pop().toLowerCase();
		// alert(ext);
		if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif") {
			alert("이미지 파일(jpg, jpeg, png, gif)만 업로드 할 수 있습니다.")
			$('#file').val("");  // 파일 태그에 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
			$('#fileName').text('');
			return;
		}
		// 유효성 통과한 이미지는 상자에 업로드 된 파일 이름 노출
		$('#fileName').text(fileName);
						
	});
	
	$('#writeBtn').on('click', function() {
		
		let userId = "${userId}";
		
		if (userId == "") {
			let result = confirm("게시물 업로드 기능은 로그인이 필요합니다. 로그인 하시겠습니까?");
			if (!result) {
				return;
			} else {
				location.href="/user/sign_in_view";
				return;
			}
		}
		
		let content = $('#writeTextArea').val().trim();
		
		if (!content) {
			alert("내용을 입력하세요.");
			return;
		}
		
		if($('#fileName').text() == "") {
			alert("이미지를 업로드하세요.");
			return;
		}
				
		let formData = new FormData();
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		$.ajax({
			type: "post"
			, url: "/post/create"
			, data: formData
			, enctype: "multipart/form-data"
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 1) {
					alert("게시물 업로드 완료");
					location.href="/timeline/timeline_view"
				} else {
					alert(data.errorMessage);
				}
			} 
			
			, error:function(request, status, error) {
				alert("게시물 업로드 실패, 관리자에게 문의하세요.")
			}
		
		});
		
		
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
					location.href="/timeline/timeline_view";
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
					location.href="/timeline/timeline_view";
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
					location.href="/timeline/timeline_view";
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
	
});

</script>