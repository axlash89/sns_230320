package com.sns.test;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import lombok.Getter;

@Getter
public enum NewPayType {

	CASH("현금", List.of(PayMethod.REMITTANCE, PayMethod.ACCOUNT_TRANSFER))
	, CARD("카드", List.of(PayMethod.CREDIT, PayMethod.KAKAO, PayMethod.NAVER))
	, EMPTY("없음", Collections.emptyList());
	
	// 필드
	private String title;
	private List<PayMethod> payList;

	// 생성자
	NewPayType(String title, List<PayMethod> payList) {
		this.title = title;
		this.payList = payList;
	}
	
	boolean hasPayMethod(PayMethod payMethod) {
		return payList.stream().anyMatch(pay -> pay.equals(payMethod));
	}

	
	// String(결제수단)으로 enum 상수(부모 그룹)를 찾기
	public static NewPayType findByPayMethod(PayMethod payMethod) {
		return Arrays.stream(NewPayType.values())
				.filter(payType -> payType.hasPayMethod(payMethod))
				.findAny()  // 찾은 요소 반환
				.orElse(EMPTY);  // 없으면 NewPayType.EMPTY
	}
	
}
