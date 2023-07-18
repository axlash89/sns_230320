<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center mt-3">
	<div class="w-50 border">
		<textarea id="content" placeholder="내용을 입력하세요" rows="4" class="w-100"></textarea>
		<div class="d-flex justify-content-between pb-2">
			<input type="file" id="file" class="ml-3">
			<button type="button" class="btn btn-info mr-3">업로드</button>
		</div>
	</div>
</div>
<div class="d-flex justify-content-center">
	<div class="w-50 border">
		<div class="border d-flex justify-content-between align-items-center">
			<div class="font-weight-bold ml-3">axlash</div>
			<div class="mr-2"><img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="25px" alt="더보기"></div>
		</div>
		<div>
			<img src="https://cdn.pixabay.com/photo/2015/03/31/23/08/neuschwanstein-701732_1280.jpg" class="w-100" alt="이미지">
		</div>
		<div class="mt-2">
			<img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="15px" class="ml-3">
			<%-- https://www.iconninja.com/files/527/809/128/heart-icon.png  채워진 하트 --%>
			<span class="small">좋아요 11개</span>
		</div>
		<div class="mt-2 px-3">
			<span class="font-weight-bold">axlash</span>
			<span>비지도 학습을 해본 결과입니다. cluster 알고리즘을 사용해봤어요.</span>
		</div>
		<div class="font-weight-bold mt-3 ml-3">
			댓글
		</div>
		<div class="mt-2 px-3 border">
			<div class="my-1">
				<span class="font-weight-bold">hagulu :</span>
				<span>분류가 잘 되었군요~</span><img src="https://www.iconninja.com/files/603/22/506/x-icon.png" class="ml-3" width="8px" alt="삭제 버튼 이미지">
			</div>
			<div class="my-1">
				<span class="font-weight-bold">jun_coffee :</span>
				<span>제가 철이 없었죠~ 분류를 위해 클러스터를 쓰다니..</span><img src="https://www.iconninja.com/files/603/22/506/x-icon.png" class="ml-3" width="8px" alt="삭제 버튼 이미지">
			</div>
		</div>
		<div class="m-2 d-flex justify-content-between">
			<input type="text" placeholder="댓글 내용을 입력하세요" id="comment" class="w-100">
			<button type="button" class="btn btn-secondary">게시</button>
		</div>
	</div>
</div>