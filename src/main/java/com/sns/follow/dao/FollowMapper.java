package com.sns.follow.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.sns.follow.domain.Follow;

@Repository
public interface FollowMapper {

	public Follow selectFollowByCurrUserIdAndUserId(
			@Param("currUserId") int currUserId, 
			@Param("userId") int userId);
	
	public int insertFollow(
			@Param("currUserId") int currUserId, 
			@Param("followId") int followId);
	
	public int deleteFollow(
			@Param("currUserId") int currUserId, 
			@Param("unfollowId") int unfollowId);

	public List<Follow> selectFollowerList(int userId);
	
	public List<Follow> selectFollowingList(int userId);
	
}
