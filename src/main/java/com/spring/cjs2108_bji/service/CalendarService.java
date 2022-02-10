package com.spring.cjs2108_bji.service;

import java.util.List;

import com.spring.cjs2108_bji.vo.AlcoholVO;
import com.spring.cjs2108_bji.vo.CalendarVO;

public interface CalendarService {

	public void getCalendarForm();

	public List<AlcoholVO> AlvosDataGet();

	public List<AlcoholVO> AlvosCateGet();

	public void setCalendarInsert(CalendarVO vo);

	public void deleteTimes(int idx);

	public List<CalendarVO> selectCalendarList(String sMid, String ymd);

	public List<CalendarVO> calendarPicker(String cDate);

	public void adCalendarMonthList(String cDate);

	public List<CalendarVO> adCalendarPicker(String cDate);

	public CalendarVO getScheduleSearch(int idx);

}
