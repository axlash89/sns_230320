package com.sns;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

import com.sns.test.NewPayType;
import com.sns.test.PayMethod;

public class EnumTest {

	@Test
	void pay테스트2() {
		// given
		PayMethod payMethod = PayMethod.CREDIT;
		
		// when
		NewPayType payType = NewPayType.findByPayMethod(payMethod);
		
		// then
		assertEquals(NewPayType.CARD, payType);
		assertEquals("신용카드", payMethod.getTitle());
	}
	
}
