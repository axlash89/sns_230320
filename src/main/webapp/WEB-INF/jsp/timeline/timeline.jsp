<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center mt-3">
	<div class="w-75 border">
		<textarea id="writeTextArea" placeholder="내용을 입력하세요" rows="4" class="w-100"></textarea>
		<div class="d-flex justify-content-between pb-2">
			<div class="file-upload d-flex ml-3">
				<%-- 이미지에 마우스 올리면 마우스커서가 링크 커서가 변하도록 a 태그 사용 --%>
				<a href="#" id="fileUploadBtn"><img width="35" src="https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-image-512.png"></a>
			</div>
			<button type="button" id="writeBtn" class="btn btn-info mr-3">업로드</button>
		</div>
	</div>
</div>
<div class="d-flex justify-content-center">
	<div class="timeline-box w-75">
		<c:forEach items="${postList}" var="post">
			<div class="card border rounded mt-5">
				<div class="border d-flex justify-content-between align-items-center">
					<div class="font-weight-bold ml-3">${userLoginId}</div>
					<a href="#" class="more-btn"><div class="mr-2"><img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="25px" alt="더보기"></div></a>
				</div>
				<div class="card-img">
					<img src="${post.imagePath}" class="w-100" alt="본문 이미지">
				</div>
				<div class="card-like mt-2">
					<a href="#" class="like-btn" data-post-id="${card.post.id}"><img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="15px" class="ml-3"></a>
					<%-- https://www.iconninja.com/files/527/809/128/heart-icon.png  채워진 하트 --%>
					<span class="small">좋아요 11개</span>
				</div>
				<div class="card-post mt-2 px-3">
					<span class="font-weight-bold">${userLoginId}</span>
					<span>${post.content}</span>
				</div>
					
				<div class="card-comment-desc font-weight-bold mt-3 ml-3">
				댓글
				</div>
				
				<div class="card-comment-list mt-2 px-3 border">
					<div class="card-comment my-1">
						<span class="font-weight-bold">hagulu :</span>
						<span>분류가 잘 되었군요~</span><a href="#" class="comment-del-btn"><img src="https://www.iconninja.com/files/603/22/506/x-icon.png" class="ml-3" width="8px" alt="삭제 버튼 이미지"></a>
					</div>
				</div>
				
				<div class="comment-write m-2 d-flex justify-content-between">
					<input type="text" placeholder="댓글 내용을 입력하세요" class="comment-input w-100">
					<button type="button" class="comment-btn btn btn-secondary">게시</button>
				</div>			
			</div>
		</c:forEach>
	</div>
</div>