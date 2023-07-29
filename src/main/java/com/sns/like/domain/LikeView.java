package com.sns.like.domain;

import com.sns.user.entity.UserEntity;

import lombok.Data;

@Data
public class LikeView {

	private Like like;
	
	private UserEntity user;
	
}
