package com.sns.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.user.dao.UserRepository;
import com.sns.user.entity.UserEntity;

@Service
public class UserBO {

	@Autowired
	private UserRepository userRepository;
	
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	
	public UserEntity getUserEntityByUserId(int userId) {
		return userRepository.findById(userId).orElse(null);
	}
	
	
	public Integer addUser(String loginId, String password, String name, String email) {
		
		UserEntity userEntity = userRepository.save(
					UserEntity.builder()
					.loginId(loginId)
					.password(password)
					.name(name)
					.email(email)
					.build()
				);				
		
		return userEntity == null ? null : userEntity.getId();
		
	}
	
	public UserEntity getUserEntityByLoginIdPassword(String loginId, String password) {
		return userRepository.findByLoginIdAndPassword(loginId, password);
	}
	
	public UserEntity updateUserEntityPasswordById(int userId, String password) {
		
		UserEntity userEntity = userRepository.findById(userId).orElse(null);
		
		if (userEntity != null) {
			userEntity = userEntity.toBuilder()
					.password(password)
					.build();
					userEntity = userRepository.save(userEntity);					
		}
		
		return userEntity;
		
	}
	
}
