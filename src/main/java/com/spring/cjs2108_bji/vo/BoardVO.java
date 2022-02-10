package com.spring.cjs2108_bji.vo;

import lombok.Data;

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
