package com.sns.follow.domain;

import java.time.ZonedDateTime;

import lombok.Data;

@Data
public class Follow {
	private int userId;
	private int followId;
	private ZonedDateTime createdAt;
}
