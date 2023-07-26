package com.sns.user;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sns.comment.bo.CommentBO;
import com.sns.common.UserEntityComparator;
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
		
		return "redirect:/timeline/timeline_view";
		
	}
	
	@GetMapping("/profile_view")
	public String profile(Model model,
			HttpSession session) {
		
		// 로그인 안했으면 접근 못하게
		String userLoginId = (String)session.getAttribute("userLoginId");		
		if (userLoginId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		UserEntity userEntity = userBO.getUserEntityByLoginId(userLoginId);		
		model.addAttribute("profile", userEntity);
		
		int userId = (int)session.getAttribute("userId");		
		
		List<UserEntity> finalFollowerList = userBO.getFollowerList(userId);		
		model.addAttribute("finalFollowerList", finalFollowerList);
		
		List<UserEntity> finalFollowingList = userBO.getFollowingList(userId);
		model.addAttribute("finalFollowingList", finalFollowingList);
		
		model.addAttribute("view", "user/profile");
		return "template/layout";
		
	}
	
	@GetMapping("/other_profile_view")
	public String otherProfile(Model model,
			HttpSession session,
			@RequestParam("userId") int userId) {
		
		// 로그인 안했으면 접근 못하게
		String userLoginId = (String)session.getAttribute("userLoginId");		
		if (userLoginId == null) {
			return "redirect:/user/sign_in_view";
		}

		int currUserId = (int)session.getAttribute("userId");
		if (userId == currUserId) {
			return "redirect:/user/profile_view";
		}
		
		UserEntity userEntity = userBO.getUserEntityById(userId);
		model.addAttribute("profile", userEntity);
		
		boolean follow = userBO.getFollow(currUserId, userId);
		model.addAttribute("follow", follow);
				
		List<UserEntity> finalFollowerList = userBO.getFollowerList(userId);		
		model.addAttribute("finalFollowerList", finalFollowerList);
		
		List<UserEntity> finalFollowingList = userBO.getFollowingList(userId);
		model.addAttribute("finalFollowingList", finalFollowingList);
		
		model.addAttribute("view", "user/otherProfile");
		return "template/layout";
	}
	
}
