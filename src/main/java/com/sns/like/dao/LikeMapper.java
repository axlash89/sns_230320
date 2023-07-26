package com.sns.like.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sns.like.domain.Like;

@Repository
public interface LikeMapper {

	public Like selectLikeByPostIdAndUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	public int insertLikeByPostIdAndUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);

	public int deleteLikeByPostIdAndUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	public List<Like> selectLikeListByPostId(int postId);
		
//	// 선생님 풀이
//	public int selectLikeCountByPostIdUserId(
//			@Param("postId") int postId, 
//			@Param("userId") int userId);
//	
//	public int selectLikeCountByPostId(int postId);
//	
//	
//	// by postId userId, by postId  =>  하나의 쿼리로 합친다.
//	public int selectLikeCountByPostIdOrUserId(
//			@Param("postId") int postId, 
//			@Param("userId") Integer userId);
	
	
}
