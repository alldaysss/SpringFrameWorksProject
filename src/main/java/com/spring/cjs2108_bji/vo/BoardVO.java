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
public class BoardVO {
	private int idx;
	private String nickName;
	private String title;
	private String content;
	private String wDate;
	private int readNum;
	private String hostIp;
	private int good;
	private String mid;
	
	private String itemNames;
	private String itemName;
	private String pdImage;
	
	private int diffTime;
	private String oriContent; // 원본 content의 내용을 저장시켜두기위한 필드
	private String oriTitle;
	private int count;
	private int replyCnt;
	
}
