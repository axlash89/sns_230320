package com.sns.like.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.dao.LikeMapper;
import com.sns.like.domain.Like;

@Service
public class LikeBO {

	@Autowired
	private LikeMapper likeMapper;
	
	public int likeToggle(int postId, int userId) {
		
		Like like = likeMapper.selectLikeByPostIdAndUserId(postId, userId);		
		
		if (like == null) {			
			int row = likeMapper.insertLikeByPostIdAndUserId(postId, userId);
			return row;						
		} else {			
			int row = likeMapper.deleteLikeByPostIdAndUserId(postId, userId);
			return row;
		}
		
	}

	public List<Like> getLikeListByPostId(int postId) {
		return likeMapper.selectLikeListByPostId(postId);
	}
	
//	public int getLikeCountByPostId(int postId) {
//		return likeMapper.selectLikeCountByPostId(postId);
//	}
	
	// 비로그인인 경우도 있을 수 있으므로 userId는 Integer로!
	public boolean getLikeByPostIdAndUserId(int postId, Integer userId) {
		
		if (userId == null) {
			return false;
		}
		
		if (likeMapper.selectLikeByPostIdAndUserId(postId, userId) != null) {
			return true;
		} else {
			return false;
		}
		
//		return likeMapper.selectLikeCountByPostIdUserId(postId, userId) > 0;
				
	}
	
}
