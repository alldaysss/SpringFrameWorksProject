package com.spring.cjs2108_bji.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.cjs2108_bji.vo.AlcoholVO;
import com.spring.cjs2108_bji.vo.CalendarVO;

public interface CalendarDAO {

	List<CalendarVO> getCalendarList(@Param("mid") String mid, @Param("ym") String ym);

	List<CalendarVO> getAdCalendarList(@Param("ym") String ym);

	List<AlcoholVO> AlvosDataGet();

	List<AlcoholVO> AlvosCateGet();

	void setCalendarInsert(@Param("vo") CalendarVO vo);

	List<CalendarVO> selectCalendarList(@Param("sMid") String sMid, @Param("ymd") String ymd);

	void deleteTimes(@Param("idx") int idx);

	List<CalendarVO> calendarPicker(@Param("cDate") String cDate);

	void adCalendarMonthList();

	List<CalendarVO> getadCalendarList(@Param("ym") String ym);

	List<CalendarVO> adCalendarPicker(@Param("cDate") String cDate);

	CalendarVO getScheduleSearch(@Param("idx") int idx);

}
