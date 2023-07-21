package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.Comment;
import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private CommentBO commentBO;
	
	
	@GetMapping("/timeline_view")
	public String timelineListView(Model model) {
		// postList를 jpa로 가져오기
		List<PostEntity> postList = postBO.getPostList();
		List<Comment> commentList = commentBO.getCommentList();
		
		model.addAttribute("postList", postList);
		model.addAttribute("commentList", commentList);
		model.addAttribute("view", "timeline/timeline");
		return "template/layout";
	}
	
}
