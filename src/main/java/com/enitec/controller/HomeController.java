package com.enitec.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home(HttpSession session,HttpServletRequest request) {
		Object loginCustomer = session.getAttribute("c_id");
		Object selectProfile = session.getAttribute("pf_code");
		if(loginCustomer == null) {
			return "index";	
		}
		if(selectProfile == null) {
			return "redirect:/profile/select";
		}
		request.setAttribute("toURL", "/");
		return "content";
	}
}
