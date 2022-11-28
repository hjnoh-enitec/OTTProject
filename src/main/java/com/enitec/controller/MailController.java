package com.enitec.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.enitec.service.MailService;

@Controller
@RequestMapping("/mail")
public class MailController {
	@Autowired
	MailService ms;
	String url;
	String subject;
	@GetMapping("/signUp")
	public String confirmMail(@RequestParam String t_id, @RequestParam String c_id, Model model) {
		url = "/token/confirm";
		subject = "「OTT」新規登録のメールをご確認ください。";
		ms.sendMail(t_id,c_id,url,subject);
		model.addAttribute("c_id",c_id);
		return "notifyMailCheck";
	}
	@GetMapping("/findPwd")
	public String sendFindPwdMail(@RequestParam String t_id, @RequestParam String c_id, Model model) {
		url ="/find/confirm?c_id="+c_id+"&";
		subject = "「OTT」パスワードの変更をご案内いたします";
		ms.sendMail(t_id, c_id,url,subject);
		return "notifyMailCheck";
	}
	
}
