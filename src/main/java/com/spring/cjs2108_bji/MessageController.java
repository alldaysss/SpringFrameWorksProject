package com.spring.cjs2108_bji;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {
	
	@RequestMapping(value="/msg/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model, HttpSession session) {
		String nickName = session.getAttribute("sNickName")==null ? "" : (String) session.getAttribute("sNickName");
		String strLevel = session.getAttribute("sStrLevel")==null ? "" : (String) session.getAttribute("sStrLevel");
		
		if(msgFlag.equals("userInputOk")) {
			model.addAttribute("msg", "회원 가입되었습니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("UserAccess")) {
			model.addAttribute("msg", "정상적인 로그인이 아닙니다 로그인 페이지로 이동합니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("userInputNo")) {
			model.addAttribute("msg", "회원 가입실패~~~");
			model.addAttribute("url", "user/userInput");
		}
		else if(msgFlag.equals("userLoginOk")) {
			model.addAttribute("msg", nickName+"님("+strLevel+") 로그인 되었습니다.");
			if(strLevel.equals("관리자") ) {
				model.addAttribute("url", "admin/adminMain");
			}
			//else if(strLevel.equals("우수회원") || strLevel.equals("특별회원") || strLevel.equals("정회원") || strLevel.equals("준회원")){
			else {
				model.addAttribute("url", "user/userMain");				
			}
		}
		else if(msgFlag.equals("userLoginNo")) {
			model.addAttribute("msg", "로그인 실패~~~");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("userLogout")) {
			session.invalidate();
			model.addAttribute("msg", nickName+"회원님 로그아웃 되었습니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("msg", "비밀번호를 다시 확인하세요");
			model.addAttribute("url", "user/userPwdCheck");
		}
		else if(msgFlag.equals("userUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "user/userMain");
		}
		else if(msgFlag.equals("userUpdateNo")) {
			model.addAttribute("msg", "회원정보 수정 실패");
			model.addAttribute("url", "user/userUpdate");
		}
		else if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", nickName + "회원님 탈퇴신청 되었습니다. \\n 1개월동안 동일한 아이디로 가입 불가합니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("userIdSearchListNo")) {
			model.addAttribute("msg", "가입된 이메일을 다시 확인하세요");
			model.addAttribute("url", "user/userIdSearch");
		}
		else if(msgFlag.equals("userPwdSearchListNo")) {
			model.addAttribute("msg", "가입된 아이디와 이메일을 다시 확인하세요");
			model.addAttribute("url", "user/userPwdSearch");
		}
		else if(msgFlag.equals("userPwdSearchListOk")) {
			model.addAttribute("msg", "임시 비밀번호가 발급 되었습니다.");
			model.addAttribute("url", "user/userLogin");
		}
		else if(msgFlag.equals("categoryInputOk")) {
			model.addAttribute("msg", "상품등록이 완료 되었습니다.");
			model.addAttribute("url", "alcohol/alcoholCategory");
		}
		else if(msgFlag.equals("orderInputOk")) {
			model.addAttribute("msg", "주문이 완료 되었습니다.");
			model.addAttribute("url", "alcohol/itemOrderConfirm");
		}
		else if(msgFlag.equals("CartProductNo")) {
			model.addAttribute("msg", "장바구니가 비어 있습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("notBuyItem")) {
			model.addAttribute("msg", "먼저 상품을 구매 후 글을 써주세요");
			model.addAttribute("url", "board/boardList");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시글이 등록 되었습니다.");
			model.addAttribute("url", "board/boardList");
		}
		else if(msgFlag.equals("calendarFormInputOk")) {
			model.addAttribute("msg", "일정이 정상적으로 등록 되었습니다.");
			model.addAttribute("url", "calendar/calendarForm");
		}
		else if(msgFlag.substring(0,15).equals("boardUpdateOkNo")) {
			model.addAttribute("msg", "변경된 사항이 없습니다.");
			model.addAttribute("url", "board/boardContent?"+msgFlag.substring(16));
		}
		else if(msgFlag.substring(0,13).equals("boardUpdateOk")) {
			model.addAttribute("msg", "게시물이 정상적으로 수정 되었습니다."); //수정이 됬을때만 페이지 가지고 간다.
			model.addAttribute("url", "board/boardContent?"+msgFlag.substring(14));
		}
		else if(msgFlag.substring(0,13).equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제 되었습니다.");
			model.addAttribute("url", "board/boardList?"+msgFlag.substring(14));
		}
		return "include/message";
	}
}
