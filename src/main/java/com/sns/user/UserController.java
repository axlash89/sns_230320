package com.sns.user;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sns.comment.bo.CommentBO;
import com.sns.follow.bo.FollowBO;
import com.sns.follow.domain.Follow;
import com.sns.post.bo.PostBO;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@RequestMapping("/user")
@Controller
public class UserController {
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private FollowBO followBO;
	
	/**
	 * 로그인 화면
	 * @param model
	 * @return
	 */
	@GetMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("view", "user/signIn");
		return "template/layout";
	}
	
	/** 
	 * 회원가입 화면
	 * @param model
	 * @return
	 */
	@GetMapping("/sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("view", "user/signUp");
		return "template/layout";
	}
	
	/**
	 * 로그아웃
	 * @param session
	 * @return
	 */
	@RequestMapping("/sign_out")
	public String signOut(HttpSession session) {
		
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		session.removeAttribute("profileImagePath");
		
		return "redirect:/user/sign_in_view";
		
	}
	
	@GetMapping("/profile_view")
	public String profile(Model model,
			HttpSession session) {
		
		String userLoginId = (String)session.getAttribute("userLoginId");		
		UserEntity userEntity = userBO.getUserEntityByLoginId(userLoginId);		
		model.addAttribute("profile", userEntity);
		
		int userId = (int)session.getAttribute("userId");
		
		List<Follow> followerList = followBO.getFollowerList(userId);
		model.addAttribute("followerList", followerList);
		
		List<Follow> followingList = followBO.getFollowingList(userId);
		model.addAttribute("followingList", followingList);
		
		
//		int userId = (int) session.getAttribute("userId");
//		List<PostEntity> myPostList = postBO.getMyPostList(userId);
//		model.addAttribute("myPostList", myPostList);
		
//		List<Comment> commentList = commentBO.getCommentList();
//		model.addAttribute("commentList", commentList);

		model.addAttribute("view", "user/profile");
		return "template/layout";
	}
	
	@GetMapping("/other_profile_view")
	public String profile(Model model,
			HttpSession session,
			@RequestParam("userId") int userId) {
		
		int currUserId = (int)session.getAttribute("userId");
		
		if (userId == currUserId) {
			return "redirect:/user/profile_view";
		}
		
		UserEntity userEntity = userBO.getUserEntityById(userId);
		model.addAttribute("profile", userEntity);
		
		Follow follow = followBO.getFollow(currUserId, userId);
		if (follow != null) {
			model.addAttribute("follow", follow);
		}
		
		List<Follow> followerList = followBO.getFollowerList(userId);
		model.addAttribute("followerList", followerList);
		
		List<Follow> followingList = followBO.getFollowingList(userId);
		model.addAttribute("followingList", followingList);
		
//		int userId = (int) session.getAttribute("userId");
//		List<PostEntity> myPostList = postBO.getMyPostList(userId);
//		model.addAttribute("myPostList", myPostList);
		
//		List<Comment> commentList = commentBO.getCommentList();
//		model.addAttribute("commentList", commentList);

		model.addAttribute("view", "user/otherProfile");
		return "template/layout";
	}
	
}
