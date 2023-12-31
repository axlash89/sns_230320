package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.CommentView;
import com.sns.follow.bo.FollowBO;
import com.sns.like.bo.LikeBO;
import com.sns.like.domain.Like;
import com.sns.like.domain.LikeView;
import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;
import com.sns.timeline.domain.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class TimelineBO {

	@Autowired
	private PostBO postBO;

	@Autowired
	private UserBO userBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private FollowBO followBO;
	
	
	// input : X
	// output : List<CardView>
	// 비로그인시에도 카드리스트는 뿌려져야 하므로 Integer userId - null 허용
	public List<CardView> generateCardViewList(Integer userId) {
		
		List<CardView> cardViewList = new ArrayList<>();  // []
		
		// 글 목록 가져온다.
		List<PostEntity> postList = postBO.getPostList();
		
		// 글 목록 반복문 순회

		// postEntity => cardView   =>   cardViewList에 담는다.
		for (int i = 0; i < postList.size(); i++) {
			// post에 대응되는 하나의 카드를 만든다.
			CardView card = new CardView();
			
			// 글을 세팅한다.
			card.setPost(postList.get(i));
			
			// 글쓴이를 세팅한다.
			UserEntity user = userBO.getUserEntityById(postList.get(i).getUserId());
			card.setUser(user);
			
			
			// 댓글들을 세팅한다.
			List<CommentView> commentViewList = new ArrayList<>();
			commentViewList = commentBO.generateCommentViewList(postList.get(i).getId());
			card.setCommentList(commentViewList);
			
			// 좋아요
			List<LikeView> likeList = new ArrayList<>();
			likeList = likeBO.generateLikeViewList(postList.get(i).getId());
			card.setLikeList(likeList);
			
			// 좋아요 여부
			boolean filledLike;
			if (userId == null) {
				card.setFilledLike(false);
			} else {
				filledLike = likeBO.getLikeByPostIdAndUserId(postList.get(i).getId(), userId);
				card.setFilledLike(filledLike);
			}
			
			// ★★★★★★ cardViewList에 담는다.
			cardViewList.add(card);
		}		
		
		return cardViewList;
	}
	
	public List<CardView> generateCardViewListById(int userId) {
		
		List<CardView> cardViewList = new ArrayList<>();  // []
		
		// 글 목록 가져온다.
		List<PostEntity> postList = postBO.getPostListByUserId(userId);
		
		// 글 목록 반복문 순회

		// postEntity => cardView   =>   cardViewList에 담는다.
		for (int i = 0; i < postList.size(); i++) {
			// post에 대응되는 하나의 카드를 만든다.
			CardView card = new CardView();
			
			// 글을 세팅한다.
			card.setPost(postList.get(i));
			
			// 글쓴이를 세팅한다.
			UserEntity user = userBO.getUserEntityById(postList.get(i).getUserId());
			card.setUser(user);
			
			
			// 댓글들을 세팅한다.
			List<CommentView> commentViewList = new ArrayList<>();
			commentViewList = commentBO.generateCommentViewList(postList.get(i).getId());
			card.setCommentList(commentViewList);
			
			// 좋아요
			List<LikeView> likeList = new ArrayList<>();
			likeList = likeBO.generateLikeViewList(postList.get(i).getId());
			card.setLikeList(likeList);
			
			// 좋아요 여부
			boolean filledLike;
			filledLike = likeBO.getLikeByPostIdAndUserId(postList.get(i).getId(), userId);
			card.setFilledLike(filledLike);
			
			// ★★★★★★ cardViewList에 담는다.
			cardViewList.add(card);
		}		
		
		return cardViewList;
	}
	
		
	public List<CardView> generateOtherCardViewListById(int userId, int currUserId) {
		
		List<CardView> cardViewList = new ArrayList<>();  // []
		
		// 글 목록 가져온다.
		List<PostEntity> postList = postBO.getPostListByUserId(userId);
		
		// 글 목록 반복문 순회

		// postEntity => cardView   =>   cardViewList에 담는다.
		for (int i = 0; i < postList.size(); i++) {
			// post에 대응되는 하나의 카드를 만든다.
			CardView card = new CardView();
			
			// 글을 세팅한다.
			card.setPost(postList.get(i));
			
			// 글쓴이를 세팅한다.
			UserEntity user = userBO.getUserEntityById(postList.get(i).getUserId());
			card.setUser(user);
			
			
			// 댓글들을 세팅한다.
			List<CommentView> commentViewList = new ArrayList<>();
			commentViewList = commentBO.generateCommentViewList(postList.get(i).getId());
			card.setCommentList(commentViewList);
			
			// 좋아요 개수
			List<LikeView> likeList = new ArrayList<>();
			likeList = likeBO.generateLikeViewList(postList.get(i).getId());
			card.setLikeList(likeList);
			
			// 좋아요 여부
			boolean filledLike;
			filledLike = likeBO.getLikeByPostIdAndUserId(postList.get(i).getId(), currUserId);
			card.setFilledLike(filledLike);
			
			// ★★★★★★ cardViewList에 담는다.
			cardViewList.add(card);
		}		
		
		return cardViewList;
	}

	public List<UserEntity> getRecommendedUserList(String userLoginId) {
		return userBO.getRecommendedUserList(userLoginId);	
	}
	
}
