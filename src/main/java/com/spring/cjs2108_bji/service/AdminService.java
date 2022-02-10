package com.spring.cjs2108_bji.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.BoardVO;
import com.spring.cjs2108_bji.vo.CalendarVO;
import com.spring.cjs2108_bji.vo.UserVO;

public interface AdminService {

	int totRecCnt(int level);

	int totRecCntMid(String mid);

	int getNewMember();

	int getNewBoard();
	
	ArrayList<UserVO> getAdUserList(int startIndexNo, int pageSize, int level);

	ArrayList<UserVO> getUserListMid(int startIndexNo, int pageSize, String mid);

	void setLevelUpdate(int idx, int level);

	void deleteUsers(int idx);

	List<BoardVO> visitChartCalendarGet();

	List<AlOrderProcessVO> drawChartCalendarGet();

	List<CalendarVO> reserveChartCalendarGet();



	
}
