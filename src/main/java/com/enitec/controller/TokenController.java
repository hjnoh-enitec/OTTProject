package com.enitec.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.enitec.service.TokenService;

@Controller
@RequestMapping("/token")
public class TokenController {

	@Autowired
	TokenService ts;
	
	@GetMapping("/signUp")
	public String createToken(@RequestParam String c_id) {
		String t_id = ts.createToken(c_id);
		return "redirect:/mail/signUp?t_id="+t_id+"&c_id="+c_id;
	}
	@GetMapping("/findPwd")
	public String createFindPwdToken(String c_id) {
		String t_id = ts.createToken(c_id);
		return "redirect:/mail/findPwd?t_id="+t_id+"&c_id="+c_id;
	}
	@GetMapping("/confirm")
	public String confirmToken(@RequestParam String t_id) {
		System.out.println("call Token Confirm");
		String c_id = ts.confirmToken(t_id);
		return "redirect:/register/confirm?c_id="+c_id;
	}
}
