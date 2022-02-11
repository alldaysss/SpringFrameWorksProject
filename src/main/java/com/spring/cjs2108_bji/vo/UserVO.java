package com.spring.cjs2108_bji.vo;

import javax.validation.constraints.Future;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

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
