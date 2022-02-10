package com.spring.cjs2108_bji.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_bji.vo.UserVO;

public interface UserDAO {

	public UserVO getIdCheck(@Param("mid") String mid); //유저 중복체크 

	public UserVO getNickNameCheck(@Param("nickName") String nickName);

	public void setUserInput(@Param("vo") UserVO vo);

	public int getBoardWriteCnt(@Param("mid") String mid); // 게시판 작성 글 불러오기

	public void setUserUpdate(@Param("vo") UserVO vo);

	public void setUserDelete(@Param("mid") String mid);

	public ArrayList<UserVO> getIdSearcher(@Param("toMail") String toMail, @Param("name")  String name, @Param("tel") String tel);

	public UserVO getPwdSearcher(@Param("mid") String mid, @Param("toMail")  String toMail);

	public void setNewPwdChange(@Param("mid") String mid ,@Param("pwd")  String pwd);
	
}
