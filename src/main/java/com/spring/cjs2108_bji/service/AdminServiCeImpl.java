package com.spring.cjs2108_bji.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.cjs2108_bji.dao.AdminDAO;
import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.BoardVO;
import com.spring.cjs2108_bji.vo.CalendarVO;
import com.spring.cjs2108_bji.vo.UserVO;

@Service
public class AdminServiCeImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;

	@Override
	public int totRecCnt(int level) {
		return adminDAO.totRecCnt(level);
	}

	@Override
	public int totRecCntMid(String mid) {
		return adminDAO.totRecCntMid(mid);
	}

	@Override
	public ArrayList<UserVO> getAdUserList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getAdUserList(startIndexNo, pageSize, level);
	}

	@Override
	public ArrayList<UserVO> getUserListMid(int startIndexNo, int pageSize, String mid) {
		return adminDAO.getUserListMid(startIndexNo, pageSize, mid);
	}

	@Override
	public void setLevelUpdate(int idx, int level) {
		adminDAO.setLevelUpdate(idx, level);
	}

	@Override
	public void deleteUsers(int idx) {
		adminDAO.deleteUsers(idx);
	}

	@Override
	public List<BoardVO> visitChartCalendarGet() {
		return adminDAO.visitChartCalendarGet();
	}

	@Override
	public List<AlOrderProcessVO> drawChartCalendarGet() {
		return adminDAO.drawChartCalendarGet();
	}

	@Override
	public List<CalendarVO> reserveChartCalendarGet() {
		return adminDAO.reserveChartCalendarGet();
	}

	@Override
	public int getNewMember() {
		return adminDAO.getNewMember();
	}

	@Override
	public int getNewBoard() {
		return adminDAO.getNewBoard();
	}
}
