package com.sns.profile.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.follow.bo.FollowBO;
import com.sns.follow.domain.Follow;
import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.domain.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class ProfileBO {
	
	@Autowired
	private TimelineBO timelineBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private FollowBO followBO;
	
	
	public UserEntity getUserEntityByLoginId(String userLoginId) {
		
		UserEntity user = userBO.getUserEntityByLoginId(userLoginId);
		
		return user;
		
	}
	
	public List<CardView> getCardViewListById(int userId) {		
		return timelineBO.generateCardViewListById(userId);		
	}
	
	public List<CardView> getOtherCardViewListById(int userId, int currUserId) {		
		return timelineBO.generateOtherCardViewListById(userId, currUserId);		
	}
	
	public List<UserEntity> getFollowerList(int userId) {		
		return userBO.getFollowerList(userId);
	}
	
	public List<UserEntity> getFollowingList(int userId) {
		return userBO.getFollowingList(userId);
	}
	
	public UserEntity getUserEntityById(int userId) {
		return userBO.getUserEntityById(userId);
	}
	
	public boolean getFollow(int currUserId, int userId) {
		Follow follow = followBO.getFollow(currUserId, userId);
		
		if (follow != null) {
			return true;
		} else {
			return false;
		}
	}
	
}
