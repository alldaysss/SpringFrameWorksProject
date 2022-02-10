package com.spring.cjs2108_bji;

import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.cjs2108_bji.service.UserService;
import com.spring.cjs2108_bji.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {
	String msgFlag ="";
	
	@Autowired
	UserService userService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	// 회원 가입 폼
	@RequestMapping(value="/userInput", method = RequestMethod.GET)
	public String userInputGet() {
		return "user/userInput";
	}
	
	//회원 가입처리하기
	@RequestMapping(value="/userInput", method = RequestMethod.POST)
	public String userInputPost(MultipartFile fName, UserVO vo) {
		/*
		 * // 아이디 중복체크 if(userService.getIdCheck(vo.getMid()) != null) { return
		 * "redirect:/msg/" + msgFlag; } // 닉네임 중복체크
		 * if(userService.getNickNameCheck(vo.getNickName()) != null) { return
		 * "redirect:/msg/" + msgFlag; }
		 */
		// 비밀번호 암호화처리
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// DB에 가입회원 등록하기
		int res = userService.setUserInput(fName, vo);
		if(res == 1) msgFlag = "userInputOk";
		else msgFlag = "userInputNo";
		return "redirect:/msg/" + msgFlag;
	}
	// 아이디 체크
	@ResponseBody
	@RequestMapping(value="/idReset")
	public String idReset(String mid) {
		String res = "";
		UserVO vo = userService.getIdCheck(mid);
		if(vo != null) res= "o";
		else res ="n";
		return res;
	}
	// 닉네임 체크
	@ResponseBody
	@RequestMapping(value="/nickReset")
	public String nickReset(String nickName) {
		UserVO vo = userService.getNickNameCheck(nickName);
		if(vo != null) return "o";
		else return "n";
	}
	
	// 로그인 화면 호출
	@RequestMapping(value="/userLogin", method = RequestMethod.GET)
	public String userLoginGet(HttpServletRequest request) {
		// 로그인폼 호출시 기존에 저장된 쿠키가 있으면 불러올수 있게 한다.
		Cookie[] cookies = request.getCookies();	// 기존에 저장된 현재 사이트의 쿠키를 불러와서 배열로 저장한다.
		String mid = "";
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue();
				request.setAttribute("mid", mid);
				break;
			}
		}
		return "user/userLogin";
	}
	// 로그인 인증처리
	@RequestMapping(value="/userLogin", method = RequestMethod.POST)
	public String userLoginPost(String mid, String pwd, HttpSession session, HttpServletResponse response, HttpServletRequest request, Model model) {
		UserVO vo = userService.getIdCheck(mid);
		
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd()) && vo.getUserDel().equals("NO")) {
			String strLevel = "";
		  if(vo.getLevel() == 0) strLevel = "관리자";
		  else if(vo.getLevel() == 1) strLevel = "특별회원";
		  else if(vo.getLevel() == 2) strLevel = "우수회원";
		  else if(vo.getLevel() == 3) strLevel = "정회원";
		  else if(vo.getLevel() == 4) strLevel = "준회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);			
			
			// 아이디에 대한 정보를 쿠키로 저장처리...
			String idCheck = request.getParameter("idCheck")==null? "" : request.getParameter("idCheck");
			// 쿠키 처리(아이디에 대한 정보를 쿠키로 저장할지를 처리한다)-jsp에서 idCheck변수에 값이 체크되어서 넘어오면 'on'값이 담겨서 넘어오게 된다.
			if(idCheck.equals("on")) {				// 앞의 jsp에서 쿠키를 저장하겠다고 넘겼을경우...
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*3); 	// 쿠키의 만료시간을 3일로 정했다.(단위: 초)
				response.addCookie(cookie);
			}
			else {		// jsp에서 쿠키저장을 취소해서 보낸다면? 쿠키명을 삭제처리한다.
				Cookie[] cookies = request.getCookies();	// 기존에 저장되어 있는 현재 사이트의 쿠키를 불러와서 배열로 저장한다.
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);		//  저장된 쿠키명 중에서 'cMid' 쿠키를 찾아서 삭제한다.
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			msgFlag = "userLoginOk";
		}
		else {
			msgFlag = "userLoginNo";
		}
		return "redirect:/msg/" + msgFlag;
	}
	
	// 로그인 성공후 만나는 회원메인창보기
	@RequestMapping(value="/userMain", method = RequestMethod.GET)
	public String userMainGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = userService.getIdCheck(mid);
		model.addAttribute("vo", vo);
		
		// 게시판에 올린 글수 가져오기
		int boardCnt = userService.getBoardWriteCnt(mid);
		model.addAttribute("boardCnt", boardCnt);
		
		return "user/userMain";
	}
	
	// 로그아웃처리
	@RequestMapping(value="/userLogout", method = RequestMethod.GET)
	public String userLogoutGet() {
		msgFlag = "userLogout";
		return "redirect:/msg/" + msgFlag;
	}
	//회원정보변경 시 비밀번호 확인창 이동
	@RequestMapping(value="/userPwdCheck", method = RequestMethod.GET)
	public String memPwdCheckGet() {
		return "user/userPwdCheck";
	}
	
	// 회원정보변경 시 비밀번호 확인
	@RequestMapping(value="/userPwdCheck", method = RequestMethod.POST)
	public String userPwdCheckPost(String pwd, HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = userService.getIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			session.setAttribute("sPwd", pwd);
			model.addAttribute("vo", vo);
			return "user/userUpdate";
		}
		else {
			msgFlag = "pwdCheckNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	// 회원정보변경폼 불러오기
	@RequestMapping(value="/userUpdate", method = RequestMethod.GET)
	public String userUpdateGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = userService.getIdCheck(mid);
		model.addAttribute("vo", vo);
		return "user/userUpdate";
	}
	
	//회원 정보 변경하기
	@RequestMapping(value="/userUpdateOk", method = RequestMethod.POST)
	public String userUpdatePost(MultipartFile fName, UserVO vo, HttpSession session) {
		String nickName = (String) session.getAttribute("sNickName");
		// 닉네임 중복체크하기(닉네임이 변경되었으면 새롭게 닉네임을 세션에 등록시켜준다.)
		if(!nickName.equals(vo.getNickName())) {
			session.setAttribute("sNickName", vo.getNickName());
		}
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		int res = userService.setUserUpdate(fName, vo);
		if(res == 1) {
			msgFlag = "userUpdateOk";
		}
		else {
			msgFlag = "userUpdateNo";
		}
		return "redirect:/msg/" + msgFlag;
	}
	
	//회원 탈퇴 신청
	@RequestMapping(value="/userDelete")
	public String userDeleteGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		userService.setUserDelete(mid);
		msgFlag = "userDeleteOk";
		return "redirect:/msg/" + msgFlag;
	}
	
	// 아이디 찾기 폼 이동
	@RequestMapping(value="/userIdSearch", method = RequestMethod.GET)
	public String userIdSearchGet() {
		return "user/userIdSearch";
	}
	
  // 아이디를 찾아서 화면에 리스트로 출력처리준비하는곳
	@RequestMapping(value="/userIdSearch", method = RequestMethod.POST)
	public String userIdSearchPost(String toMail, String name, String tel, Model model) {
		ArrayList<UserVO> vos = userService.getIdSearcher(toMail, name, tel);
		if(vos.size() != 0) {
				model.addAttribute("vos", vos);
				return "user/userIdSearchList";				
		}
		else {
			msgFlag = "userIdSearchListNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	
	// 패스워드 찾기 폼 이동
	@RequestMapping(value="/userPwdSearch", method = RequestMethod.GET)
	public String userPwdSearchGet() {
		return "user/userPwdSearch";
	}
	
	// 임시 비밀번호 발급해서 메일로 보낼 준비처리
	@RequestMapping(value="/userPwdSearch", method = RequestMethod.POST)
	public String userPwdSearchPost(String mid, String toMail) {
		UserVO vo = userService.getPwdSearcher(mid, toMail);
		if(vo != null) {
			// 임시비밀번호를 만들자
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			userService.setNewPwdChange(mid, passwordEncoder.encode(pwd));
			String content = pwd;
			return "redirect:/mail/userPwdSearchSend/"+toMail+"/"+content+"/";
		}
		else {
			msgFlag = "userPwdSearchListNo";
			return "redirect:/msg/" + msgFlag;
		}
	}
	
	@RequestMapping(value="/quesTion", method = RequestMethod.GET)
	public String quesTionGet() {
		return "etc/quesTion";
	}
	@RequestMapping(value="/kakaomap", method = RequestMethod.GET)
	public String kakaomapGet() {
		return "etc/kakao";
	}
	@RequestMapping(value="/companyIntro", method = RequestMethod.GET)
	public String companyIntroGet() {
		return "etc/companyIntro";
	}
	@RequestMapping(value="/terms", method = RequestMethod.GET)
	public String termsGet() {
		return "etc/terms";
	}
}
