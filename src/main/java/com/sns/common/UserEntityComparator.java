package com.sns.common;

import java.util.Comparator;

import com.sns.user.entity.UserEntity;

public class UserEntityComparator implements Comparator<UserEntity> {

	@Override
	public int compare(UserEntity a, UserEntity b) {
		return a.getLoginId().compareTo(b.getLoginId());		
	}
	
	
}
