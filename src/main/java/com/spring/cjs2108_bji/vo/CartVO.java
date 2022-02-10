package com.spring.cjs2108_bji.vo;

import lombok.Data;

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
