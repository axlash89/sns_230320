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
	
}
