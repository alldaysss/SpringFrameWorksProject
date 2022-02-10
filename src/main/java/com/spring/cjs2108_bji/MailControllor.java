package com.spring.cjs2108_bji;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/mail")
public class MailControllor {
	@Autowired
	JavaMailSender mailSender;
	
	// 메일폼 불러오기
	@RequestMapping(value="/mailForm", method = RequestMethod.GET)
	public String mailFormGet() {
		return "mail/mailForm";
	}
	
	// 임시 비밀번호 발급해서 메일로 보낼 준비처리
	@RequestMapping(value="/userPwdSearchSend/{toMail}/{content}", method = RequestMethod.GET)
	public String pwdConfirmPost(@PathVariable String toMail, @PathVariable String content) {
		try {
			String fromMail = "my188cm@gmail.com";
			String title = "임시 비밀번호가 발급 되었습니다.";
			String pwd = content;
			content = "Allday's LiquorShop에서 발송된 메일입니다. \n 임시 비밀번호를 보내드리오니 사이트에서 비밀번호를 변경하세요\n";
			content = content.replace("\n", "<br>");
			// 메세지를 변환시켜서 보관함(messageHelper)에 저장하기 위한 준비 단계.
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			
			// 메일 보관함에 회원이 보낸 메세지를 모두 저장시킴.
			messageHelper.setFrom(fromMail);
			messageHelper.setTo(toMail);
			messageHelper.setSubject(title);
			
			// 메세지 내용 편집 후 보관함에 저장처리 한다.
			content += "<br><hr><h3> 임시 비밀번호는 : <font color='orange'>"+pwd+"</font></h3><hr><br/>";
			messageHelper.setText(content, true);
			
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
		return "redirect:/msg/userPwdSearchListOk";
	}
}
