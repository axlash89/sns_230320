<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="d-flex justify-content-center">
	<div class="d-flex justify-content-center mt-5">
		<div class="pb-2">
			<div class="text-center h3 stop-drag font-weight-bold mb-4">내 프로필</div>
			
			<div class="file-upload d-flex ml-3">
				<%-- file 태그를 숨겨두고 이미지를 클릭하면 file 태그를 클릭한 것처럼 효과를 준다. --%>
				<input type="file" id="file" accept=".jpg, .jpeg, .png, .gif" class="d-none">
			</div>		
			
			<c:choose>
				<c:when test="${not empty profile.profileImagePath}">
					<center><div><img src="${profile.profileImagePath}" alt="프로필 사진" width="333px" class="rounded-image"></div>
				</c:when>
				<c:otherwise>
					<center><div class="text-center"><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="프로필 사진" width="150px" class="rounded-image"></div>
				</c:otherwise>
			</c:choose>
			
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-info mt-3" data-toggle="modal" data-target="#staticBackdrop">
				<c:choose>
					<c:when test="${not empty profile.profileImagePath}">			
						프로필 이미지 변경
					</c:when>
					<c:otherwise>
						프로필 이미지 올리기
					</c:otherwise>
				</c:choose>
			</button>
			
			<c:if test="${not empty profile.profileImagePath}">
			<center><div><button class="btn btn-warning btn-sm mt-2" id="imageDeleteBtn">프로필 이미지 삭제</button></div></center>
			</c:if>
			
			<!-- Modal -->
			<div class="modal fade image-modal" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="staticBackdropLabel">프로필 이미지 업로드</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="imageChangeXBtn">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			       		<div class="d-flex justify-content-between mt-3 py-3 border d-none w-100" id="imageChangeBox">
							<div class="mt-2 ml-4"><span id="fileName">첨부파일 없음</span></div>
							<div class="d-flex">
								<div><a href="#" id="fileUploadBtn" class="pr-4"><img width="25px" src="https://cdn4.iconfinder.com/data/icons/camera-20/1314/camera_upload-64.png" class="mt-2"></a></div>
								<c:choose>
									<c:when test="${not empty profile.profileImagePath}">
										<div class="mr-3"><button class="image-change-btn btn btn-success">변경</button></div>
									</c:when>
									<c:otherwise>
										<div class="mr-3"><button class="image-change-btn btn btn-success btn-sm">올리기</button></div>
									</c:otherwise>
								</c:choose>	
							</div>
						</div>
			      </div>
			      <div class="modal-footer d-flex justify-content-center">
			        <button type="button" class="btn btn-secondary" id="imgModalCancelBtn" data-dismiss="modal">취소</button>
			      </div>
			    </div>
			  </div>
			</div>
						
			<table class="table table-border mt-4 stop-drag">
				<tr>
					<th class="text-center">아이디</th>
					<td>${profile.loginId}</td>
				</tr>
				<tr>
					<th></th>
					<td><button id="passwordChangeOpenBtn" class="btn btn-primary btn-sm">비밀번호 변경</button></td>
				</tr>			
				<tr class="password-change d-none">
					<th class="text-center pt-4">기존 비밀번호</th>
					<td><input type="password" id="originalPassword" class="form-control col-10 ml-2" name="password" placeholder="비밀번호 입력"></td>
				</tr>
				<tr class="password-change d-none">
					<th class="text-center pt-4">* 새 비밀번호</th>
					<td><input type="password" id="newPassword" class="form-control col-10 ml-2" placeholder="수정할 비밀번호 입력"></td>
				</tr>
				<tr class="password-change d-none">
					<th class="text-center pt-4">* 새 비밀번호 확인</th>
					<td><input type="password" id="newPasswordCheck" class="form-control col-10 ml-2" placeholder="수정할 비밀번호 확인"></td>
				</tr>
				<tr class="password-change d-none">
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
</div>

<div class="d-flex justify-content-around mt-2 stop-drag mb-5 border-top border-bottom">
	<div class="py-5">
		<div class="text-center h4 font-weight-bold pb-2">팔로워 (${fn:length(finalFollowerList)}명)</div>
		<c:if test="${empty finalFollowerList}">
				<div class="text-center">팔로워 없음</div>
		</c:if>
		<c:forEach items="${finalFollowerList}" var="follower">
			<div class="text-center text-primary h5">
				<a href="/profile/other_profile_view?userId=${follower.id}" class="a-tag-deco-none">
				<c:choose>
					<c:when test="${not empty follower.profileImagePath}">
						<img src="${follower.profileImagePath}" width="50px" alt="프로필 이미지" class="card-profile-image-circle">
					</c:when>
					<c:otherwise>
						<img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" width="50px" alt="프로필 이미지" class="card-profile-image-circle">
					</c:otherwise>
				</c:choose>
				${follower.loginId}
				</a>
			</div>				
		</c:forEach>
	</div>
	<div class="py-5">
		<div class="text-center h4 font-weight-bold pb-2">팔로잉 (${fn:length(finalFollowingList)}명)</div>
		<c:if test="${empty finalFollowingList}">
			<div class="text-center">팔로잉 없음</div>
		</c:if>
		<c:forEach items="${finalFollowingList}" var="following">
			<div class="text-center text-primary h5">
				<a href="/profile/other_profile_view?userId=${following.id}" class="a-tag-deco-none">
				<c:choose>
					<c:when test="${not empty following.profileImagePath}">
						<img src="${following.profileImagePath}" width="50px" alt="프로필 이미지" class="card-profile-image-circle">
					</c:when>
					<c:otherwise>
						<img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" width="50px" alt="프로필 이미지" class="card-profile-image-circle">
					</c:otherwise>
				</c:choose>
				${following.loginId}
				</a>
			</div>				
		</c:forEach>
	</div>
</div>

<c:choose>
	<c:when test="${empty cardList}">
		<div class="text-center h5 stop-drag mt-4">내가 올린 게시물이 아직 없어요.</div>
		<div class="text-center h5 stop-drag mt-2 mb-5">회원님들에게 당신의 멋진 사진들을 공유해주세요.</div>
	</c:when>
	<c:otherwise>
		<div class="mt-5 h3 text-center font-weight-bold">내 게시물이 ${fn:length(cardList)}개 있습니다.</div>
	
		<div class="d-flex justify-content-center">
			<div class="timeline-box w-75">
				<c:forEach items="${cardList}" var="card" varStatus="status">
					<div class="card">
						<div class="card-top border d-flex justify-content-between align-items-center py-2 stop-drag">
						
							<div class="pl-2">
								내&nbsp;${cardListSize - status.index}번째 글 
							</div>
							
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
							<a href="#" class="like-user-btn a-tag-deco-none-b" data-toggle="modal" data-target="#likeModal${card.post.id}"><span class="font-weight-bold ml-1">좋아요 ${fn:length(card.likeList)}개</span></a>
					
							<!-- '좋아요'한 유저 Modal -->
							<div class="modal fade like-modal" id="likeModal${card.post.id}">
								<%-- modal-sm : 작은 모달 --%>
								<%-- modal-dialog-centered : 모달창을 수직기준 가운데 위치 --%>
								<div class="modal-dialog modal-sm modal-dialog-centered">
									<div class="modal-content text-center">								
										<div class="modal-body" style="max-height: calc(50vh - 50px); overflow-x: hidden; overflow-y: auto;">
								            <div class="pb-2 border-bottom">
												<c:choose>
													<c:when test="${fn:length(card.likeList) eq 0}">
															<span>좋아요가 아직 없어요.</span>
													</c:when>
													<c:otherwise>
										     			<c:forEach items="${card.likeList}" var="likeUser">
										     				<a href="/profile/other_profile_view?userId=${likeUser.user.id}" class="a-tag-deco-none-b">
										     					<c:choose>
																	<c:when test="${not empty likeUser.user.profileImagePath}">																
																		<div class="ml-3 d-flex justify-content-center pr-3 align-items-center mt-2"><img src="${likeUser.user.profileImagePath}" class="card-profile-image-circle" width="35px" alt="프로필 이미지"><c:choose><c:when test="${likeUser.user.loginId eq userLoginId}"><span class="ml-2 text-success">${likeUser.user.loginId}</span></c:when><c:otherwise><span class="ml-2">${likeUser.user.loginId}</span></c:otherwise></c:choose></div>
																	</c:when>
																	<c:otherwise>
																		<div class="ml-3 d-flex justify-content-center pr-3 align-items-center mt-2"><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" class="card-profile-image-circle" width="35px" alt="프로필 이미지"><c:choose><c:when test="${likeUser.user.loginId eq userLoginId}"><span class="ml-2 text-success">${likeUser.user.loginId}</span></c:when><c:otherwise><span class="ml-2">${likeUser.user.loginId}</span></c:otherwise></c:choose></div>
																	</c:otherwise>
																</c:choose>	
										     				</a>
										     			</c:forEach>
										     		</c:otherwise>
												</c:choose>	
								     		</div>			
											<div class="pt-2">
												<a href="#" data-dismiss="modal" class="a-tag-deco-none font-weight-bold">닫기</a>
											</div>
										</div>
									</div>
								</div>
							</div>
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

	$('#fileUploadBtn').on('click', function(e) {
		e.preventDefault();
		$('#file').click();
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
			$('#fileName').text("첨부파일 없음");
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
			$('#fileName').text("첨부파일 없음");
			return;
		}
		// 유효성 통과한 이미지는 상자에 업로드 된 파일 이름 노출
		$('#fileName').text(fileName);						
	});
	
	$('#imageChangeXBtn').on('click', function() {
		$('#file').val("");  // 파일 태그에 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
		$('#fileName').text("첨부파일 없음");
	});
	
	$('#imgModalCancelBtn').on('click', function() {
		$('#file').val("");  // 파일 태그에 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
		$('#fileName').text("첨부파일 없음");
	});
	
	$('.image-change-btn').on('click', function() {
		
		if($('#fileName').text() == "첨부파일 없음") {
			alert("이미지 파일을 첨부 후 업로드 버튼을 눌러주세요.");
			return;
		}
				
		let formData = new FormData();
		formData.append("file", $('#file')[0].files[0]);
		
		$.ajax({
			type: "put"
			, url: "/user/image_update"
			, data: formData
			, enctype: "multipart/form-data"
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 1) {
					alert("이미지 업로드 완료");
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("이미지 업로드 실패, 관리자에게 문의하세요.")
			}		
		});
				
	});
	
	$('#imageDeleteBtn').on('click', function(){
		
		let result = confirm("프로필 이미지를 삭제하시겠습니까?");
		if (!result) {
			return;
		}
		
		$.ajax({
			
			type: "post"
			, url: "/user/image_delete"
			, processData: false
			, contentType: false
			
			, success: function(data) {
				if (data.code == 1) {
					alert("이미지 삭제 완료");
					location.reload(true);
				} else {
					alert(data.errorMessage);
				}
			}
			
			, error:function(request, status, error) {
				alert("이미지 삭제 실패, 관리자에게 문의하세요.")
			}
		});
		
	});
	
	
	$('#passwordChangeOpenBtn').on('click', function() {
		if($('#passwordChangeOpenBtn').text() == "비밀번호 변경 취소") {
			$('#passwordChangeOpenBtn').removeClass("btn-secondary");
			$('#passwordChangeOpenBtn').addClass("btn-primary");	
			$('.password-change').addClass('d-none');
			$('#passwordChangeOpenBtn').text("비밀번호 변경");
			$('#originalPassword').val('');
			$('#newPassword').val('');
			$('#newPasswordCheck').val('');
		} else {
			$('#passwordChangeOpenBtn').removeClass("btn-primary");
			$('#passwordChangeOpenBtn').addClass("btn-secondary");	
			$('.password-change').removeClass('d-none');
			$('#passwordChangeOpenBtn').text("비밀번호 변경 취소");
		}		
	});
	
	$('#newPasswordCheck').keydown(function(keyNum){
		//현재의 키보드의 입력값을 keyNum으로 받음
		if(keyNum.keyCode == 13){ 
			// keydown으로 발생한 keyNum의 숫자체크
			// 숫자가 enter의 아스키코드 13과 같으면
			// 기존에 정의된 클릭함수를 호출
			$('#passwordChangeBtn').click();
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
					location.href="/profile/profile_view"
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