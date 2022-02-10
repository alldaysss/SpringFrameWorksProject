package com.spring.cjs2108_bji;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.cjs2108_bji.service.AdminService;
import com.spring.cjs2108_bji.service.BoardService;
import com.spring.cjs2108_bji.service.CalendarService;
import com.spring.cjs2108_bji.service.UserService;
import com.spring.cjs2108_bji.vo.AlOrderProcessVO;
import com.spring.cjs2108_bji.vo.BoardVO;
import com.spring.cjs2108_bji.vo.CalendarVO;
import com.spring.cjs2108_bji.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	String msgFlag = "";
	@Autowired
	AdminService adminService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	CalendarService calendarService;
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value="/adminMain", method = RequestMethod.GET)
	public String adMenuGet(Model model) { 
		int newMember = adminService.getNewMember();
		int newBoard = adminService.getNewBoard();
		model.addAttribute("newMember", newMember);
		model.addAttribute("newBoard", newBoard);
		return "admin/adminMain";
	}
	
	@RequestMapping(value="/adnav", method = RequestMethod.GET)
	public String adBarGet() { 
		return "admin/adnav";
	}
	
	// 게시글 관리
	@RequestMapping(value="/adBoardList", method = RequestMethod.GET)
	public String adadBoardListGet(
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="search", defaultValue = "", required = false) String search,
			@RequestParam(name="searchoption", defaultValue = "", required = false) String searchoption,
			@RequestParam(name="lately", defaultValue = "0", required = false) int lately,
			Model model) {
		
		List<BoardVO> vos = new ArrayList<BoardVO>();
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int pageSize = 5;
	  int totRecCnt = 0;
	  if(lately != 0 ) {
	  	totRecCnt = adminService.getNewBoard();
		}
		else {
			if(search.equals("")) totRecCnt = boardService.totRecCnt(lately);	// 전체자료 갯수 검색
			else totRecCnt = boardService.SearchtotRecCnt(search, searchoption);	// 전체자료 갯수 검색
		}
	  
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
		if(lately != 0 ) {
			vos = boardService.getadBoardListlately(startIndexNo, pageSize, lately);
		}
		else {
			vos = boardService.getadBoardList(startIndexNo, pageSize, search, searchoption);
		}
  	model.addAttribute("search", search);
  	model.addAttribute("searchoption", searchoption);
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("totRecCnt", totRecCnt);
		
		return "admin/board/adBoardList";
	}
	
	// 스몰 게시글 내용 확인하기
	@RequestMapping(value="/adBoardShortList", method= RequestMethod.GET)
	public String adboardShortListGet(int idx, Model model) {
		BoardVO vo = boardService.getBoardContent(idx);
		
		model.addAttribute("vo", vo);
		return "admin/board/adBoardShortList";
	}
	//게시글 삭제 하기
	@ResponseBody
	@RequestMapping(value="/adBoardList", method= RequestMethod.POST)
	public String selectDelCheckPost(String idxDelete) {
		String[] idxarr = idxDelete.split("/");
		for(String idx : idxarr) {
			boardService.setAdBoardDelete(Integer.parseInt(idx));
		}
		return "";
	}
	
	//일정 조회로 이동하는 폼
	@RequestMapping(value="/adCalendarManager", method= RequestMethod.GET)
	public String adCalendarListGet(Model model,
			@RequestParam(name="cDate", defaultValue="", required=false) String cDate) {
		calendarService.adCalendarMonthList(cDate);
		if(!cDate.equals("")) {
			List<CalendarVO> clVos = calendarService.adCalendarPicker(cDate);
			model.addAttribute("clVos", clVos);
		}
		return "admin/calendar/adCalendarManager";
	}
	
	//날짜별 등록된 일정을 조회한다.
	@ResponseBody
	@RequestMapping(value="/adDatePick", method= RequestMethod.POST)
	public String adSelectDateCheckPost(Model model, String cDate) {
		List<CalendarVO> clVos = calendarService.adCalendarPicker(cDate);
		
		model.addAttribute("clVos", clVos);
		return "";
	}
	
	//회원관리 창 호출
	@RequestMapping(value="/userManager", method = RequestMethod.GET)
	public String adUserManagerGet(
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="level", defaultValue="99", required=false) int level,
			@RequestParam(name="mid", defaultValue="", required=false) String mid,
			Model model) {
		
		/* 이곳부터 페이징 처리(블록페이지) 변수 지정 시작 */
	  int pageSize = 5;
	  int totRecCnt = 0;
	  if(mid.equals("")) {
	  	totRecCnt = adminService.totRecCnt(level);// 전체자료 갯수 검색(level처리)
	  }
	  else {
	  	totRecCnt = adminService.totRecCntMid(mid);	// 개별자료 검색
	  }
	  int totPage = (totRecCnt % pageSize)==0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
	  int startIndexNo = (pag - 1) * pageSize;
	  int curScrStrarNo = totRecCnt - startIndexNo;
	  int blockSize = 3;		// 한블록의 크기를 3개의 Page로 본다.(사용자가 지정한다.)
	  int curBlock = (pag - 1) / blockSize;		// 현재페이지의 블록위치
	  int lastBlock = (totPage % blockSize)==0 ? ((totPage / blockSize) - 1) : (totPage / blockSize);
	  /* 블록페이징처리 끝 */
	  
	  ArrayList<UserVO> vos = new ArrayList<UserVO>();
	  if(mid.equals("")) {	// 전체자료 갯수 검색(level처리)
	  	vos = adminService.getAdUserList(startIndexNo, pageSize, level);
	  }
	  else {								// 개별자료 검색
	  	vos = adminService.getUserListMid(startIndexNo, pageSize, mid);
	  }
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStrarNo", curScrStrarNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		model.addAttribute("level", level);
		model.addAttribute("mid", mid);
		model.addAttribute("totRecCnt", totRecCnt);
		return "admin/user/userManager";
	}
	
	@ResponseBody
	@RequestMapping(value="/adUserLevel", method = RequestMethod.POST)
	public String adUserLevelPost(int idx, int level) {
		adminService.setLevelUpdate(idx, level);
		return "";
	}
	// 탈퇴하기
	@ResponseBody
	@RequestMapping(value="/delUsers", method = RequestMethod.POST)
	public String calendarPlanDelete(int idx) {
		adminService.deleteUsers(idx);
		return "";
	}
	//차트 가입자수 차트 만들기
	@ResponseBody
	@RequestMapping(value="/visitChart", method=RequestMethod.POST)
	public List<BoardVO> visitChartCalendarGet() {
		
		return adminService.visitChartCalendarGet();
	}
	//차트 일일 매출액 조회 차트 만들기
	@ResponseBody
	@RequestMapping(value="/amountChart", method=RequestMethod.POST)
	public List<AlOrderProcessVO> drawChartCalendarGet() {
		return adminService.drawChartCalendarGet();
	}
	//차트 일일 예약 별 카운트 조회 차트 만들기
	@ResponseBody
	@RequestMapping(value="/reserveChart", method=RequestMethod.POST)
	public List<CalendarVO> reserveChartCalendarGet() {
		return adminService.reserveChartCalendarGet();
	}
}
