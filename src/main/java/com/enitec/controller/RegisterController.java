package com.enitec.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String saveCustomer(Customer customer) {
		customer = rs.insertCustomer(customer);
		return "redirect:/token/signUp?c_id=" + customer.getC_id();
	}

	// -------------------mail confirm
	@GetMapping("/confirm")
	public String confirmCustomer(@RequestParam String c_id) {
		rs.compleMailCheck(c_id);
		return "completeRegister";
	}
}
