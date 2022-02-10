package com.spring.cjs2108_bji.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_bji.vo.UserVO;

public interface UserService {

	public UserVO getIdCheck(String mid);

	public UserVO getNickNameCheck(String nickName);

	int setUserInput(MultipartFile fName, UserVO vo);

	public int getBoardWriteCnt(String mid);

	public int setUserUpdate(MultipartFile fName, UserVO vo);

	public void setUserDelete(String mid);

	public ArrayList<UserVO> getIdSearcher(String toMail, String name, String tel);

	public UserVO getPwdSearcher(String mid, String toMail);

	public void setNewPwdChange(String mid, String pwd);

}
