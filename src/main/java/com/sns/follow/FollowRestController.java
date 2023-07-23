package com.sns.follow;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.follow.bo.FollowBO;

@RequestMapping("/follow")
@RestController
public class FollowRestController {

	@Autowired
	private FollowBO followBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(HttpSession session,
			@RequestParam("followId") int followId) {
		
		int currUserId = (int)session.getAttribute("userId");
		int row = followBO.addFollow(currUserId, followId);
		
		Map<String, Object> result = new HashMap<>();
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "팔로우 실패");
		}
		
		return result;
		
	}
	
	@PostMapping("/delete")
	public Map<String, Object> delete(HttpSession session,
			@RequestParam("unfollowId") int unfollowId) {
		
		int currUserId = (int)session.getAttribute("userId");
		int row = followBO.deleteFollow(currUserId, unfollowId);
		
		Map<String, Object> result = new HashMap<>();
		
		if (row > 0) {
			result.put("code", 1);
			result.put("result", "성공");			
		} else {
			result.put("code", 500);
			result.put("errorMessage", "언팔로우 실패");
		}
		
		return result;
		
	}
	
}
