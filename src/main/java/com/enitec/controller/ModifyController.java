package com.enitec.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.enitec.form.ModifyForm;
import com.enitec.service.CustomerService;
import com.enitec.session.Session;
import com.enitec.vo.Customer;

@Controller
@RequestMapping("/modify")
public class ModifyController {
	
	@Autowired
	private CustomerService ms;

	@GetMapping("/pwCheck")
	public String pwCheck(HttpSession session, HttpServletRequest req) {
		if (session.getAttribute("c_id") == null) {
			return "redirect:/login/login?toURL=" + req.getRequestURL();
		}
		return "pwCheck";
	}

	@PostMapping("/modify")
	public String moveToModyfyPage(@ModelAttribute Customer customer, Model model, RedirectAttributes redirect) {
		customer = ms.pwCheck(customer.getC_id(), customer.getC_pwd());
		if (customer == null) {
			String msg = "パスワードを確認してください";
			redirect.addAttribute("msg",msg);
			return "redirect:/modify/pwCheck";
		}
		model.addAttribute("customer", customer);
		return "modifyForm";
	}

	@PostMapping("/save")
	public String modifySaveUser(ModifyForm modify,RedirectAttributes redirect) {
		Customer customer = ms.findById(modify.getC_id());
		customer.setC_pwd(modify.getC_pwd());
		customer.setC_phone(modify.getC_phone());
		ms.modifyUser(customer);
		return "redirect:/";
	}
	
}