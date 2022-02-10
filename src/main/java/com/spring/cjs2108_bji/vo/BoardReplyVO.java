package com.spring.cjs2108_bji.vo;

import lombok.Data;

@Data
public class BoardReplyVO {
	private int idx;
	private int boardIdx;
	private String mid;
	private String nickName;
	private String wDate;
	private String content;
	private int replyGood;
	private int level;
	private int levelOrder;
}
