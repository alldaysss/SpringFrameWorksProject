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
public class CalendarVO {
	private int idx;
	private String mid;
	private String cDate;
	private String part;
	private String itemCode;
	private String reItemName;
	private String content;
	
	//private String ymd;
	private int count;
}
