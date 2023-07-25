<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center mt-5">
	<div class="w-75 border">
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
			<button type="button" id="writeBtn" class="btn btn-info mr-3">올리기</button>
		</div>
	</div>
</div>
<div class="d-flex justify-content-center">
	<div class="timeline-box w-75">
		<c:forEach items="${cardList}" var="card">
			<div class="card">
				<div class="card-top border d-flex justify-content-between align-items-center py-2">
				<c:choose>
				<c:when test="${not empty card.user.profileImagePath}">
					<a href="/user/other_profile_view?userId=${card.user.id}" class="a-tag-deco-none"><div class="ml-3 d-flex align-items-center"><img src="${card.user.profileImagePath}" class="card-profile-image-circle" width="35px" alt="프로필 이미지"><span class="ml-2">${card.user.loginId}</span></div></a>
				</c:when>
				<c:otherwise>
					<a href="/user/other_profile_view?userId=${card.user.id}" class="a-tag-deco-none"><div class="ml-3 d-flex align-items-center"><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" class="card-profile-image-circle" width="35px" alt="프로필 이미지"><span class="ml-2">${card.user.loginId}</span></div></a>
				</c:otherwise>
				</c:choose>	
					<a href="#" class="more-btn"><div class="mr-3"><img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30px" alt="더보기"></div></a>
				</div>
				<div class="card-img">
					<img src="${card.post.imagePath}" class="w-100" alt="본문 이미지">
				</div>
				<div class="card-like mt-2">
					<a href="#" class="like-btn"><img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="15px" class="ml-3" alt="빈 하트"></a>
					<%-- https://www.iconninja.com/files/527/809/128/heart-icon.png  채워진 하트 --%>
					<span class="small">좋아요 11개</span>
				</div>
				<div class="card-post mt-2 px-3">
					<a href="/user/other_profile_view?userId=${card.post.userId}" class="a-tag-deco-none"><span class="post-userLoginId ml-1 mr-1">${card.user.loginId}</span></a>
					<span class="post-content-font">${card.post.content}</span>
					
					<fmt:parseDate value="${card.post.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
					<div>
						<span class="text-secondary float-right mt-1"><fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 MM월 dd일 HH:mm"/></span>
					</div>
				</div>
					
				<div class="card-comment-desc font-weight-bold border w-100 pl-3 py-2 mt-3 mb-1">
				댓글
				</div>
				<div class="card-comment-list px-3">
					<c:forEach items="${card.commentList}" var="comment">						
							<div class="card-comment my-1">
								<a href="/user/other_profile_view?userId=${comment.user.id}" class="a-tag-deco-none">
								<c:choose>
								<c:when test="${not empty comment.user.profileImagePath}">								
								<img src="${comment.user.profileImagePath}" class="comment-profile-image-circle" width="35px" alt="댓글 작성자 이미지">								
								</c:when>
								<c:otherwise>
								<img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" class="comment-profile-image-circle" width="35px" alt="댓글 작성자 이미지">
								</c:otherwise>
								</c:choose>
								<span class="font-weight-bold mr-1">${comment.user.loginId}</span></a>
								<span>${comment.comment.content}</span>
								<fmt:parseDate value="${comment.comment.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedCreatedAt"/>
								<span class="comment-date text-secondary float-right pt-2 mr-1"><fmt:formatDate value="${parsedCreatedAt}" pattern="yyyy년 MM월 dd일 HH:mm"/></span>
								<c:if test="${userId eq comment.user.id}">
								<a href="#" class="comment-del-btn" data-post-id="${card.post.id}" data-commenter-id="${userId}" data-comment-id="${comment.comment.id}"><img src="https://www.iconninja.com/files/603/22/506/x-icon.png" class="ml-2 pb-1" width="8px" alt="삭제 버튼 이미지"></a>
								</c:if>
							</div>	
					</c:forEach>
				</div>
				
				<div class="comment-write m-1 d-flex justify-content-between">
					<input type="text" placeholder="댓글 내용을 입력하세요" class="comment-input form-control w-100 mb-1">
					<!-- <input type="text" class="postIdValue d-none" value="${post.id}"> -->
					<button type="button" class="comment-btn btn btn-secondary btn-sm" data-post-id="${card.post.id}">올리기</button>
				</div>
				<div class="card-bottom"></div>
			</div>
		</c:forEach>	
	</div>
</div>

<script>

$(document).ready(function() {
	
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
		
		let content = $('#writeTextArea').val().trim();
		
		if (!content) {
			alert("내용을 입력하세요.")
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
		
		let content = $(this).siblings('.comment-input').val().trim();		
		// * 댓글 내용 가져오기 방법1
		// let comment = $(this).siblings('input').val().trim();
		
		// * 댓글 내용 가져오기 방법2
		// let comment = $(this).prev().val().trim();
		// alert(comment);
		
		
		
		// let postId = $(this).siblings('.postIdValue').val();
		let postId = $(this).data('post-id');
		
		if (!content) {
			alert("댓글 내용을 입력하세요");
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
		
		let postId = $(this).data("post-id")
		let commenterId = $(this).data("commenter-id");
		let commentId = $(this).data("comment-id");
		
		let formData = new FormData();
		formData.append("postId", postId);
		formData.append("commenterId", commenterId);
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
	
});

</script>