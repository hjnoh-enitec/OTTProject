package com.enitec.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.service.CustomerService;
import com.enitec.service.LoginService;
import com.enitec.service.MembershipSerivce;

@Controller
@RequestMapping("/login")
public class LoginContorller {
	
	@Autowired
	private LoginService loginServ;
	
	@Autowired
	private CustomerService customerServ;
	
	@Autowired
	private MembershipSerivce membershipServ;

	@GetMapping("/login")
	public String moveToPage(HttpServletRequest req,String toURL) {
		if(toURL==null) {
			toURL="/";
		}
		req.setAttribute("toURL", toURL);
		return "loginForm";
	}

	@PostMapping("/login")
	public String login(String c_id, String c_pwd, String toURL, boolean rememberId, HttpServletRequest request, HttpServletResponse res, Model model) {
		String mailCheck = mailCheck(c_id, c_pwd);
		if ("F".equals(mailCheck)) {
			request.setAttribute("c_id", c_id);
			return "notifyMailCheck";
		} else if (mailCheck == null) {
			String msg = "IDまたはパスワードが一致しません";
			request.setAttribute("msg", msg);
			request.setAttribute("toURL", toURL);
			return "loginForm";
		}
		//session生成
		HttpSession session = request.getSession();
		session.setAttribute("c_id", c_id);
		session.setAttribute("c_name", loginServ.findName(c_id));
		String m_code = customerServ.getMembershipCode(c_id);
		String m_name = membershipServ.getMcode(m_code);
		session.setAttribute("m_name", m_name);
		//cookie生成
        if(rememberId) {
            Cookie cookie = new Cookie("c_id", c_id); 
            res.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("c_id", c_id); 
            cookie.setMaxAge(0);
            res.addCookie(cookie);
        }
        
		return "redirect:" + toURL;
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "index";
	}

	private String mailCheck(String c_id, String c_pwd) {
		System.out.println(c_id + c_pwd);
		return loginServ.mailCheck(c_id, c_pwd);
	}
}
