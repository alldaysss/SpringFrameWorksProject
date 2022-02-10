package com.spring.cjs2108_bji.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.BoardVO;
import com.spring.cjs2108_bji.vo.CalendarVO;
import com.spring.cjs2108_bji.vo.UserVO;

public interface AdminDAO {

	public int totRecCnt(@Param("level") int level);

	public int totRecCntMid(@Param("mid") String mid);

	public ArrayList<UserVO> getAdUserList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	public ArrayList<UserVO> getUserListMid(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public void setLevelUpdate(@Param("idx") int idx, @Param("level") int level);

	public void deleteUsers(@Param("idx") int idx);

	public List<BoardVO> visitChartCalendarGet();

	public List<AlOrderProcessVO> drawChartCalendarGet();

	public List<CalendarVO> reserveChartCalendarGet();

	public int getNewMember();

	public int getNewBoard();
}
