package com.spring.cjs2108_bji.service;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.cjs2108_bji.dao.CalendarDAO;
import com.spring.cjs2108_bji.vo.AlcoholVO;
import com.spring.cjs2108_bji.vo.CalendarVO;

@Service
public class CalendarServiceImpl implements CalendarService {
	@Autowired
	CalendarDAO calendarDAO;

	@Override
	public void getCalendarForm() {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		//오늘의 날짜를 저장한다.
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth= calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		// 화면에 보여줄 해당년월을 셋팅하는 부분
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy")== null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")== null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
		if(mm < 0 ) { // 1월에서 전월을 클릭할 시 12월이 표시가 되야 하니...(int는 0부터 시작이라 
			yy--;
			mm = 11;
		}
		if(mm > 11) { // 12월에서 다음월 버튼을 클릭 시 1년을 +해주고 월은 1월이 된다.
			yy++;
			mm = 0;
		}
		calView.set(yy, mm, 1);
		int startWeek = calView.get(Calendar.DAY_OF_WEEK); // 해당 년/월/의 1일에 해당하는 요일 값
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH); // 해당월의 마지막 일자 구하기.
		// 화면에 보여줄 년 월 기준 전년도와 다음년도를 구하기 위한 부분
		int prevYear = yy; 				// 전년도
		int prevMonth = (mm) - 1; // 이전월
		int nextYear = yy;				//다음년도
		int nextMonth = (mm) + 1; // 다음월
		if(prevMonth == -1) { // 1월에서 전월 버튼을 클릭시 실행..
			prevYear--;
			prevMonth = 11;
		}
		if(nextMonth == 12) { // 12월에서 다음월 버튼을 클릭 시 실행.
			nextYear++;
			nextMonth = 0;
		}
		//이전 달력과 다음 달력 처리 부.
		Calendar calPre = Calendar.getInstance(); // 이전달력
		calPre.set(prevYear, prevMonth, 1);
		int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH); // 해당월의 마지막일자.
		
		Calendar calNext = Calendar.getInstance(); // 다음달 달력
		calNext.set(nextYear, nextMonth, 1);
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK); // 다음들의 1일에 해당하는 요일값 가져오기
		// 예시 2021.1 > 2021> 01.로 단/ 2021.10처럼 10의 자리에선 변환시켜주지 않아도 됨
		String ym = "";
		int tmpMM = (mm + 1);
		if(tmpMM >= 1 && tmpMM <= 9) {
			ym = yy + "-0" + (mm + 1);
		}
		else {
			ym = yy + "-" + (mm + 1 );
		}
		List<CalendarVO> vos = calendarDAO.getCalendarList(mid, ym);
	  /* ---------  아래는  앞에서 처리된 값들을 모두 request객체에 담는다.  -----------------  */
	  // 오늘기준 달력...
	  request.setAttribute("toYear", toYear);
	  request.setAttribute("toMonth", toMonth);
	  request.setAttribute("toDay", toDay);
	  // 화면에 보여줄 해당 달력...
	  request.setAttribute("yy", yy);
	  request.setAttribute("mm", mm);
	  request.setAttribute("startWeek", startWeek);
	  request.setAttribute("lastDay", lastDay);
	  // 화면에 보여줄 해당 달력 기준의 전년도, 전월, 다음년도, 다음월 ...
	  request.setAttribute("preYear", prevYear);
		request.setAttribute("preMonth", prevMonth);
		request.setAttribute("preLastDay", preLastDay);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("nextStartWeek", nextStartWeek);
		// 해당월에 자료들을 vos에 담는다.
		request.setAttribute("vos", vos);
	}

	@Override
	public List<CalendarVO> selectCalendarList(String sMid, String ymd) {
		String mm = "", dd = "";			// ymd의 값은? 2021-6-5  --> 2021-06-05
		String[] ymds = ymd.split("-");
		if(ymd.length() != 10) {
			if(ymds[1].length() == 1) mm = "0" + ymds[1];
			else mm = ymds[1];
			if(ymds[2].length() == 1) dd = "0" + ymds[2];
			else dd = ymds[2];
			ymd = ymds[0] + "-" + mm + "-" + dd;
		}
		return calendarDAO.selectCalendarList(sMid, ymd);
	}
	
	// 관리자 달력 조회
	@Override
	public void adCalendarMonthList(String cDate) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		//오늘의 날짜를 저장한다.
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth= calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		int yy;
		int mm;
		Calendar calView = Calendar.getInstance();
		
		if(cDate.equals("")) {
			yy = request.getParameter("yy")== null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
			mm = request.getParameter("mm")== null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
		} else {
			// 화면에 보여줄 해당년월을 셋팅하는 부분
			yy = Integer.parseInt(cDate.split("-")[0]);
			mm = Integer.parseInt(cDate.split("-")[1])-1;
		}
		if(mm < 0 ) { // 1월에서 전월을 클릭할 시 12월이 표시가 되야 하니...(int는 0부터 시작이라 
			yy--;
			mm = 11;
		}
		if(mm > 11) { // 12월에서 다음월 버튼을 클릭 시 1년을 +해주고 월은 1월이 된다.
			yy++;
			mm = 0;
		}
		calView.set(yy, mm, 1);
		int startWeek = calView.get(Calendar.DAY_OF_WEEK); // 해당 년/월/의 1일에 해당하는 요일 값
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH); // 해당월의 마지막 일자 구하기.
		// 화면에 보여줄 년 월 기준 전년도와 다음년도를 구하기 위한 부분
		int prevYear = yy; 				// 전년도
		int prevMonth = (mm) - 1; // 이전월
		int nextYear = yy;				//다음년도
		int nextMonth = (mm) + 1; // 다음월
		if(prevMonth == -1) { // 1월에서 전월 버튼을 클릭시 실행..
			prevYear--;
			prevMonth = 11;
		}
		if(nextMonth == 12) { // 12월에서 다음월 버튼을 클릭 시 실행.
			nextYear++;
			nextMonth = 0;
		}
		//이전 달력과 다음 달력 처리 부.
		Calendar calPre = Calendar.getInstance(); // 이전달력
		calPre.set(prevYear, prevMonth, 1);
		int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH); // 해당월의 마지막일자.
		
		Calendar calNext = Calendar.getInstance(); // 다음달 달력
		calNext.set(nextYear, nextMonth, 1);
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK); // 다음들의 1일에 해당하는 요일값 가져오기
		// 예시 2021.1 > 2021> 01.로 단/ 2021.10처럼 10의 자리에선 변환시켜주지 않아도 됨
		String ym = "";
		int tmpMM = (mm + 1);
		if(tmpMM >= 1 && tmpMM <= 9) {
			ym = yy + "-0" + (mm + 1);
		}
		else {
			ym = yy + "-" + (mm + 1 );
		}
		List<CalendarVO> adVos = calendarDAO.getAdCalendarList(ym);
	  /* ---------  아래는  앞에서 처리된 값들을 모두 request객체에 담는다.  -----------------  */
	  // 오늘기준 달력...
	  request.setAttribute("toYear", toYear);
	  request.setAttribute("toMonth", toMonth);
	  request.setAttribute("toDay", toDay);
	  // 화면에 보여줄 해당 달력...
	  request.setAttribute("yy", yy);
	  request.setAttribute("mm", mm);
	  request.setAttribute("startWeek", startWeek);
	  request.setAttribute("lastDay", lastDay);
	  // 화면에 보여줄 해당 달력 기준의 전년도, 전월, 다음년도, 다음월 ...
	  request.setAttribute("preYear", prevYear);
		request.setAttribute("preMonth", prevMonth);
		request.setAttribute("preLastDay", preLastDay);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("nextStartWeek", nextStartWeek);
		// 해당월에 자료들을 vos에 담는다.
		request.setAttribute("adVos", adVos);
	}
	@Override
	public List<CalendarVO> adCalendarPicker(String cDate) {
		return calendarDAO.adCalendarPicker(cDate);
	}
	
	@Override
	public List<AlcoholVO> AlvosCateGet() {
		return calendarDAO.AlvosCateGet();
	}

	@Override
	public List<AlcoholVO> AlvosDataGet() {
		return calendarDAO.AlvosDataGet();
	}

	@Override
	public void setCalendarInsert(CalendarVO vo) {
		calendarDAO.setCalendarInsert(vo);
	}

	@Override
	public void deleteTimes(int idx) {
		calendarDAO.deleteTimes(idx);
	}

	@Override
	public List<CalendarVO> calendarPicker(String cDate) {
		return calendarDAO.calendarPicker(cDate);
	}

	@Override
	public CalendarVO getScheduleSearch(int idx) {
		return calendarDAO.getScheduleSearch(idx);
	}



}
