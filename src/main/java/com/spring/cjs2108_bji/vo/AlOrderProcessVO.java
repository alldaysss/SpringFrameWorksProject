package com.spring.cjs2108_bji.vo;

import lombok.Data;
/*
	@Digits(integer=, fraction=) : @숫자(정수, 소수이하자릿수)
	@Pattern(regex=, flag=)      : 정규식
	@Past : 과거 날짜이냐?, @Future : 미래 날짜냐?
	@NotEmpty() : 넘어온 값이 비어있지 않았으면 처리 ..
	@Size(min=, max, message=) : @길이체크 (최소길이, 최대길이, 메세지)
	@Range(min=, max=, message=) : @범위체크(최소길이, 최대길이, 메세지)
*/

@Data
public class AlOrderProcessVO {
	private int idx;
	private String orderIdx;
	private String itemIdx;
	private String pdImage;
	private String itemName;
	private String itemPrice;
	private String quanTitySum;
	private String mid;
	private int totCalcPrice;
	private String orderDate;
	
	//배송 파트
	private String dvTel;
	private String dvAddress;
	private String dvName;
	private String dvPayment;     // 결재방식 :             카드/   휴대폰/   은행
	private String dvPaymentNumber;  // 결제방식에 따른 번호(카드번호,휴대폰번호,은행계좌번호)
	private String dvPayer;				// 결제방식에 따른 결제처 명(카드사명, 통신사명, 입금자명,)
	private String dvRequest;			// 배송 시 요청 사항
	private String dvStatus;		// 기본값 : 결재완료
	
	private int maxIdx;
	private int usePoint;
	private int todayAmount;
}
