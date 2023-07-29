package com.sns.like.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.dao.LikeMapper;
import com.sns.like.domain.Like;
import com.sns.like.domain.LikeView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class LikeBO {

	@Autowired
	private LikeMapper likeMapper;
	
	@Autowired
	private UserBO userBO;
	
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
	
	
	public List<LikeView> generateLikeViewList(int postId) {
		
		List<Like> likeList = likeMapper.selectLikeListByPostId(postId);
		
		List<LikeView> likeViewList = new ArrayList<>();
		
		for (int i = 0; i < likeList.size(); i++) {
			LikeView like = new LikeView();
			UserEntity user = userBO.getUserEntityById(likeList.get(i).getUserId());
			like.setLike(likeList.get(i));
			like.setUser(user);
			likeViewList.add(like);
		}
		
		return likeViewList;
		
	}
	
}
