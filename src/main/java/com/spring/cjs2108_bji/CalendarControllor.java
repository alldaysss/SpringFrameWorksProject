package com.spring.cjs2108_bji;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_bji.service.CalendarService;
import com.spring.cjs2108_bji.vo.AlcoholVO;
import com.spring.cjs2108_bji.vo.CalendarVO;

@Controller
@RequestMapping("/calendar")
public class CalendarControllor {
	String msgFlag = "";
	
	@Autowired
	CalendarService calendarService;
	
	//캘린더로 이동하는 폼
	@RequestMapping(value="/calendarForm", method = RequestMethod.GET)
	public String calendarFormGet(HttpSession session, Model model) {
		String sMid = (String) session.getAttribute("sMid");
		calendarService.getCalendarForm();
		List<AlcoholVO> alCateVos = calendarService.AlvosCateGet();
		List<AlcoholVO> alVos = calendarService.AlvosDataGet();
		
		model.addAttribute("alVos", alVos);
		model.addAttribute("alCateVos", alCateVos);
		return "calendar/calendar";
	}
	// 일정 등록하기
	@RequestMapping(value="/calendarForm", method = RequestMethod.POST)
	public String calendarFormPost(CalendarVO vo) {
		calendarService.setCalendarInsert(vo);
		
		msgFlag = "calendarFormInputOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	// 예약 된 일정 삭제하기
	@ResponseBody
	@RequestMapping(value="/delTimes", method = RequestMethod.POST)
	public String calendarPlanDelete(int idx) {
		calendarService.deleteTimes(idx);
		return "";
	}
	// 타 회원이 일정 등록 시 등록버튼에 불이 꺼지는 메소드
	@ResponseBody
	@RequestMapping(value="/calendarPicks", method = RequestMethod.POST)
	public List<CalendarVO> calendarPicker(String cDate) {
		return calendarService.calendarPicker(cDate);
	}
	
	//일정 팝업으로 보여주기
	@RequestMapping(value="/calendarShortCon", method=RequestMethod.GET)
	public String scheduleContentGet(int idx, Model model) {
		CalendarVO vo = calendarService.getScheduleSearch(idx);
		model.addAttribute("vo", vo);
		return "calendar/calendarShortCon";
	}
}
