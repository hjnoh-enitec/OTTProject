package com.enitec.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.service.ProfileService;
import com.enitec.vo.Profile;

@Controller
@RequestMapping("/profile")
public class ProfileController {

	@Autowired
	private ProfileService ps;
	
	@GetMapping("/select")
	public String moveProfilePage(String toURL,HttpServletRequest request,HttpServletResponse res) {
		HttpSession session = request.getSession();
		System.out.println(session.getAttribute("c_id"));
		String id = session.getAttribute("c_id").toString();
		List<Profile> profileList = ps.getProfileDataBase(id); 
		request.setAttribute("profile", profileList);
		Cookie cookie = new Cookie("c_id",id);
		res.addCookie(cookie);
		return "profile";
	}
	@PostMapping("/select")
	public String selectedCustomerProfile(String toURL,HttpServletRequest request,HttpServletResponse res) {
		
		return "content";
	}
	@GetMapping("/update")
	public String moveProfileUpdatePage(String toURL,HttpServletRequest request,HttpServletResponse res) {
		return "/";
	}
	@GetMapping("/insert")
	public String moveProfileInsertPage(String toURL,HttpServletRequest request,HttpServletResponse res) {
		return "profileCreate";
	}
}
