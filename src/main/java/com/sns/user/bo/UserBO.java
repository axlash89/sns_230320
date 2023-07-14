package com.sns.user.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.user.dao.UserRepository;
import com.sns.user.entity.UserEntity;

@Service
public class UserBO {

	@Autowired
	private UserRepository userRepository;
	
	public List<UserEntity> getByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	
}
