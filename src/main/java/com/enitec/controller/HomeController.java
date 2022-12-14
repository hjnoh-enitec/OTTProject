package com.enitec.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.enitec.session.Session;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home(HttpSession session,HttpServletRequest request) {

		request.setAttribute("toURL", "/");
		return "redirect:/content/main";
	}
}
