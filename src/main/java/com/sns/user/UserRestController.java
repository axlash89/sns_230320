package com.sns.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@RequestMapping("/user")
@RestController
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	// 중복확인 버튼
	@RequestMapping("/is_duplicated_id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		List<UserEntity> list = userBO.getByLoginId(loginId);
		
		Map<String, Object> result = new HashMap<>();
		
		if (list.size() > 0) {
			result.put("code", 1);
			result.put("isDuplicatedId", true);
		} else {
			result.put("code", 2);
			result.put("isDuplicatedId", false);
		}
		
		return result;
	}
	
}
