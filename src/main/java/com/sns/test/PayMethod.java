package com.sns.test;

import lombok.Getter;

@Getter
public enum PayMethod {
	
	REMITTANCE("무통장입금")
	, ACCOUNT_TRANSFER("계좌이체")
	, CREDIT("신용카드")
	, KAKAO("카카오페이")
	, NAVER("네이버페이")
	;
	
	private String title;
	
	PayMethod(String title) {
		this.title = title;
	}

}
