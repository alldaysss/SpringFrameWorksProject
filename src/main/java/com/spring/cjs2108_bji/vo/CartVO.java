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
public class CartVO {
	private int idx;	
	private String mid;
	private int itemIdx;
	private String itemName;
	private int quanTity;
	private int itemPrice;
	private String pdImage;
	
	private int quanTitySum;
}
