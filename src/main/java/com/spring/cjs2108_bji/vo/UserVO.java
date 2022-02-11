package com.spring.cjs2108_bji.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class UserVO {
	private int idx;
	
	private String photo;
	@NotEmpty
	@Size(min = 4, max = 20, message="아이디는 4~20자 이내로 사용하세요.")
	private String mid;
	@NotEmpty
	private String pwd;
	@NotEmpty
	@Size(min = 2, max = 10, message="닉네임은 2~10자 이내로 사용하세요.")
	private String nickName;
	private String tel;
	
	@NotEmpty
	private String name;
	
	private String birthday;
	private String gender;
	private String address;
	
	@NotEmpty
	@Pattern(regexp = "/^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$/i")
	private String email;
	private String userDel;
	private int point;
	private int level;
}
