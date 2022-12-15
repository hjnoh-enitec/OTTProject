package com.enitec.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.service.CustomerService;
import com.enitec.service.LoginService;
import com.enitec.session.Session;

@Controller
@RequestMapping("/login")
public class LoginContorller {
	
	@Autowired
	private LoginService ls;

	@Autowired
	private CustomerService customerServ;
	
	@GetMapping("/login")
	public String moveToPage(HttpServletRequest req,String toURL) {
		if(toURL==null) {
			toURL="/";
		}
		req.setAttribute("toURL", toURL);
		return "login/loginForm";
	}

	@PostMapping("/login")
	public String login(String c_id, String c_pwd, String toURL, boolean rememberId, HttpServletRequest request, HttpServletResponse res) {
		String mailCheck = mailCheck(c_id, c_pwd);
		if ("F".equals(mailCheck)) {
			request.setAttribute("c_id", c_id);
			return "notifyMailCheck";
		} else if (mailCheck == null) {
			String msg = "IDまたはパスワードが一致しません";
			request.setAttribute("msg", msg);
			return "redirect:/login/login";
		}
		//session生成
		HttpSession session = request.getSession();
		session.setAttribute(Session.LOGIN_CUSTOMER, c_id);
		//cookie生成
        if(rememberId) {
            Cookie cookie = new Cookie("c_id", c_id); 
            res.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("c_id", c_id); 
            cookie.setMaxAge(0);
            res.addCookie(cookie);
        }
        
        // 유저의 멤버십 코드가 M0 (미가입상태)면 멤버십 가입 페이지로, 가입 되어있으면 프로필 선택 페이지로
		String membership = customerServ.getMembershipCode(c_id);
		String noMembership = "M0";
        if(membership.equals(noMembership)) {
        	return "redirect:/customer/modifyMembership?c_id=" + c_id;
        }
		return "redirect:/profile/select";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	private String mailCheck(String c_id, String c_pwd) {
		System.out.println(c_id + c_pwd);
		return ls.mailCheck(c_id, c_pwd);
	}
}
