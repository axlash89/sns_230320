package com.sns.follow.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.follow.dao.FollowMapper;
import com.sns.follow.domain.Follow;

@Service
public class FollowBO {

	@Autowired
	private FollowMapper followMapper;
	
	public Follow getFollow(int currUserId, int userId) {
		return followMapper.selectFollowByCurrUserIdAndUserId(currUserId, userId);
	}
	
	public int addFollow(int currUserId, int followId) {
		return followMapper.insertFollow(currUserId, followId);
	}
	
	public int deleteFollow(int currUserId, int unfollowId) {
		return followMapper.deleteFollow(currUserId, unfollowId);
	}

	public List<Follow> getFollowerList(int userId) {
		return followMapper.selectFollowerList(userId);
	}
	
	public List<Follow> getFollowingList(int userId) {
		return followMapper.selectFollowingList(userId);
	}
	
}
