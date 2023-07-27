<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
						<div><button class="image-change-open-btn btn btn-info mt-2">프로필 이미지 변경</button><button class="image-change-close-btn btn btn-secondary mt-2 d-none">프로필 이미지 변경 취소</button></div>
						<div><button class="btn btn-warning btn-sm mt-2" id="imageDeleteBtn">프로필 이미지 삭제</button></div></center>
					</c:when>
					<c:otherwise>
						<center><div class="text-center"><img src="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png" alt="프로필 사진" width="150px" class="rounded-image"></div>
						<button class="image-change-open-btn btn btn-info btn-sm mt-2">프로필 이미지 올리기</button><button class="image-change-close-btn btn btn-secondary btn-sm mt-2 d-none">프로필 이미지 올리기 취소</button></center>
					</c:otherwise>
				</c:choose>
				<div class="d-flex justify-content-between mt-3 py-3 border d-none" id="imageChangeBox">
					<div class="mt-1 ml-4"><span id="fileName">첨부파일 없음</span></div>
					<div class="d-flex">
						<div><a href="#" id="fileUploadBtn" class="pr-4"><img width="25px" src="https://cdn4.iconfinder.com/data/icons/camera-20/1314/camera_upload-64.png"></a></div>
						<c:choose>
							<c:when test="${not empty profile.profileImagePath}">
								<div class="mr-3"><button class="image-change-btn btn btn-success btn-sm">변경</button></div>
							</c:when>
							<c:otherwise>
								<div class="mr-3"><button class="image-change-btn btn btn-success btn-sm">올리기</button></div>
							</c:otherwise>
						</c:choose>	
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

<div class="d-flex justify-content-around mt-2 stop-drag">
	<div>
		<div class="text-center h4 font-weight-bold pb-2">팔로워</div>
		<c:forEach items="${finalFollowerList}" var="follower">
			<div class="text-center text-primary h4">
				<a href="/user/other_profile_view?userId=${follower.id}">${follower.loginId}</a>
			</div>		
		</c:forEach>
	</div>
	<div>
		<div class="text-center h4 font-weight-bold pb-2">팔로잉</div>
		<c:forEach items="${finalFollowingList}" var="following">
			<div class="text-center text-primary h4">
				<a href="/user/other_profile_view?userId=${following.id}">${following.loginId}</a>
			</div>	
		</c:forEach>
	</div>
</div>

<script>

$(document).ready(function(){
	
	$('.image-change-open-btn').on('click', function() {
		if($('.image-change-close-btn').hasClass('d-none')) {
			$('#imageChangeBox').removeClass('d-none');
			$('.image-change-open-btn').addClass('d-none');
			$('.image-change-close-btn').removeClass('d-none');
		} else {
			$('#imageChangeBox').addClass('d-none');
		}
	})
	
	$('.image-change-close-btn').on('click', function() {
		$('#file').val("");  // 파일 태그에 파일 제거(보이지 않지만 업로드 될 수 있으므로 주의)
		$('#fileName').text('첨부파일 없음');
		if($('.image-change-open-btn').hasClass('d-none')) {
			$('#imageChangeBox').addClass('d-none');
			$('.image-change-open-btn').removeClass('d-none');
			$('.image-change-close-btn').addClass('d-none');
		} else {
			$('#imageChangeBox').removeClass('d-none');
		}
	})
	
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

