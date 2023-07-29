package com.sns.profile;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sns.profile.bo.ProfileBO;
import com.sns.timeline.domain.CardView;
import com.sns.user.entity.UserEntity;

@RequestMapping("/profile")
@Controller
public class ProfileController {
	
	@Autowired
	private ProfileBO profileBO;


	@GetMapping("/profile_view")
	public String profile(Model model,
			HttpSession session) {
		
		// 로그인 안했으면 접근 못하게
		String userLoginId = (String)session.getAttribute("userLoginId");		
		if (userLoginId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		int userId = (int)session.getAttribute("userId");
		
		UserEntity userEntity = profileBO.getUserEntityByLoginId(userLoginId);		
		model.addAttribute("profile", userEntity);		
		
		List<CardView> myCardList = profileBO.getCardViewListById(userId);
		
		if (!myCardList.isEmpty()) {
			model.addAttribute("cardList", myCardList);
			model.addAttribute("cardListSize", myCardList.size());
		}
		
		List<UserEntity> finalFollowerList = profileBO.getFollowerList(userId);		
		model.addAttribute("finalFollowerList", finalFollowerList);
		
		List<UserEntity> finalFollowingList = profileBO.getFollowingList(userId);
		model.addAttribute("finalFollowingList", finalFollowingList);
		
		model.addAttribute("view", "profile/profile");
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
			return "redirect:/profile/profile_view";
		}
		
		UserEntity userEntity = profileBO.getUserEntityById(userId);
		model.addAttribute("profile", userEntity);
		
		List<CardView> otherCardList = profileBO.getOtherCardViewListById(userId, currUserId);
		
		if (!otherCardList.isEmpty()) {
			model.addAttribute("cardList", otherCardList);
			model.addAttribute("cardListSize", otherCardList.size());
		}
		
		boolean follow = profileBO.getFollow(currUserId, userId);
		model.addAttribute("follow", follow);
				
		List<UserEntity> finalFollowerList = profileBO.getFollowerList(userId);		
		model.addAttribute("finalFollowerList", finalFollowerList);
		
		List<UserEntity> finalFollowingList = profileBO.getFollowingList(userId);
		model.addAttribute("finalFollowingList", finalFollowingList);
		
		model.addAttribute("view", "profile/otherProfile");
		return "template/layout";
	}
	
}
