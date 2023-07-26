package com.sns.user.bo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.common.UserEntityComparator;
import com.sns.follow.bo.FollowBO;
import com.sns.follow.domain.Follow;
import com.sns.user.dao.UserRepository;
import com.sns.user.entity.UserEntity;

@Service
public class UserBO {

	@Autowired
	private FollowBO followBO;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private FileManagerService fileManager;
	
	
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	
	public UserEntity getUserEntityById(int userId) {
		return userRepository.findById(userId).orElse(null);
	}
	
	public List<UserEntity> getUserList() {
		return userRepository.findAllByOrderById();
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
	
	public UserEntity updateUserEntityProfileImagePathById(int userId, MultipartFile file) {
		
		String profileImagePath = null;
		
		UserEntity userEntity = userRepository.findById(userId).orElse(null);
		
		String existingFilePath = null;
		
		if (userEntity != null && userEntity.getProfileImagePath() != null) {
			existingFilePath = userEntity.getProfileImagePath().split("/")[2] + "/" + userEntity.getProfileImagePath().split("/")[3];
		}
		
		if (file != null) {
			profileImagePath = fileManager.saveProfileImageFile(existingFilePath, userId, file);
			if (userEntity != null && profileImagePath != null) {
				userEntity = userEntity.toBuilder()
						.profileImagePath(profileImagePath)
						.build();
						userEntity = userRepository.save(userEntity);
			}
		}
		
		return userEntity;
		
	}
	
	public UserEntity updateUserEntityProfileImageNullPathById(int userId) {
	
		UserEntity userEntity = userRepository.findById(userId).orElse(null);
		
		String existingFilePath = null;
		
		if (userEntity != null) {
			
			existingFilePath = userEntity.getProfileImagePath().split("/")[2] + "/" + userEntity.getProfileImagePath().split("/")[3];
			
			fileManager.deleteExistingProfileImageFile(existingFilePath);
			
			userEntity = userEntity.toBuilder()
					.profileImagePath(null)
					.build();
					userEntity = userRepository.save(userEntity);
		}
		
		return userEntity;
	}

	public List<UserEntity> getFollowerList(int userId) {
		
		List<Follow> followerList = followBO.getFollowerList(userId); 
		List<UserEntity> finalFollowerList = new ArrayList<>();
		
		for (int i = 0; i < followerList.size(); i++) {
			UserEntity user = getUserEntityById(followerList.get(i).getUserId());
			finalFollowerList.add(user);			
		}
		
		Collections.sort(finalFollowerList, new UserEntityComparator());
		
		return finalFollowerList;
		
	}
	
	public List<UserEntity> getFollowingList(int userId) {
		
		List<Follow> followingList = followBO.getFollowingList(userId); 
		List<UserEntity> finalFollowingList = new ArrayList<>();
		
		for (int i = 0; i < followingList.size(); i++) {
			UserEntity user = getUserEntityById(followingList.get(i).getFollowId());
			finalFollowingList.add(user);			
		}
		
		Collections.sort(finalFollowingList, new UserEntityComparator());
		
		return finalFollowingList;
		
	}
	
	public boolean getFollow(int currUserId, int userId) {
		Follow follow = followBO.getFollow(currUserId, userId);
		
		if (follow != null) {
			return true;
		} else {
			return false;
		}
		
	}
	
}
