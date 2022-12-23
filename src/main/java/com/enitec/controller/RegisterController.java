package com.enitec.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.enitec.service.RegisterService;
import com.enitec.vo.Customer;

@Controller
@RequestMapping("/register")
public class RegisterController {
	@Autowired
	RegisterService rs;

	// ---------------------------------------register-------------------------------------------------------
	@GetMapping("/signup")
	public String moveRegisterPage() {
		return "registerForm";
	}

	@PostMapping("/signup")
	public String saveCustomer(Customer customer, RedirectAttributes redirect) {
		if(rs.checkCustomer(customer.getC_id()) > 0) {
			String msg = "会員登録中問題が発生しました。もう一度やり直してください。";
			redirect.addAttribute("validateMsg", msg);
			return "redirect:/register/signup";
		}
		customer = rs.insertCustomer(customer);
		System.out.println("hy");
		return "redirect:/token/signUp?c_id=" + customer.getC_id();
	}

	// -------------------mail confirm
	@GetMapping("/confirm")
	public String confirmCustomer(@RequestParam String c_id) {
		if(c_id.equals("used")) {
			return "usedMailToken";
		}
		rs.compleMailCheck(c_id);
		return "completeRegister";
	}
}
