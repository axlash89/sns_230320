package com.sns.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.dao.CommentMapper;
import com.sns.comment.domain.Comment;
import com.sns.comment.domain.CommentView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class CommentBO {

	@Autowired
	private CommentMapper commentMapper;
	
	@Autowired
	private UserBO userBO;
	
	public int addComment(int postId, int userId, String content) {		
		return commentMapper.insertComment(postId, userId, content);
	}
	
	public List<Comment> getCommentList() {
		return commentMapper.selectCommentList();
	}
	
	// input : postId
	// output : 가공된 댓글 리스트
	public List<CommentView> generateCommentViewList(int postId) {

		// 글에 해당하는 댓글들
		List<Comment> commentList = new ArrayList<>();		
		commentList = commentMapper.selectCommentListByPostId(postId);
		
		List<CommentView> commentViewList = new ArrayList<>();
		for (int i = 0; i < commentList.size(); i++) {
			
			CommentView commentView = new CommentView();
			
			UserEntity user = userBO.getUserEntityById(commentList.get(i).getUserId());
			commentView.setUser(user);
			
			commentView.setComment(commentList.get(i));
			
			
			commentViewList.add(commentView);
			
		}
				
		// 반복문 순회  comment  =>  commentView   => commentViewList에 담는다.	
		return commentViewList;
		
	}
	
	public int deleteCommentById(int commentId) {
		return commentMapper.deleteCommentById(commentId);
	}
	
}
