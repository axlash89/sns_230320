package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.domain.CardView;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
//	@Autowired
//	private PostBO postBO;
//	
//	@Autowired
//	private CommentBO commentBO;
//	
//	@Autowired
//	private UserBO userBO;
	
	@Autowired
	private TimelineBO timelineBO;
	
	
	@GetMapping("/timeline_view")
	public String timelineListView(Model model) {
		// postList를 jpa로 가져오기
//		List<PostEntity> postList = postBO.getPostList();
//		List<Comment> commentList = commentBO.getCommentList();
		// List<UserEntity> userList = userBO.getUserList();
//		
//		model.addAttribute("postList", postList);
//		model.addAttribute("commentList", commentList);
		// model.addAttribute("userList", userList);
		
		
		// 브레이크 포인트 잡고 디버깅 한번 봐보기
		List<CardView> cardList = timelineBO.generateCardViewList();
		
		model.addAttribute("cardList", cardList);
		
		model.addAttribute("view", "timeline/timeline");
		return "template/layout";
	}
	
}
