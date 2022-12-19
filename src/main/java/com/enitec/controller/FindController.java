package com.enitec.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.enitec.form.FindForm;
import com.enitec.service.FindService;

@Controller
@RequestMapping("/find")
public class FindController {

	@Autowired
	private FindService fs;

	
	@PostMapping("id")
	@ResponseBody
	public List<String> returnId(FindForm findForm, HttpServletRequest request) {
		//List<String> idList = fs.findId(findForm.getC_name(), findForm.getC_birth(), findForm.getC_phone());
		//System.out.println("RESULT TEST1 : " + idList);
		return fs.findId(findForm.getC_name(), findForm.getC_birth(), findForm.getC_phone());
	}
	
	@GetMapping("/pwd")
	public String moveFindPassword() {
		return "customer/findPassword";
	}

	@PostMapping("/sendCheckedMail")
	//@ResponseBody
	public String sendPasswordUpdate(FindForm findForm) {
		if (fs.findCustomer(findForm.getC_id()) == null) {
			return "redirect:/login/login";
		}
		return "redirect:/token/findPwd?c_id="+findForm.getC_id();
	}

	@GetMapping("/confirm")
	public String movePasswordUpdate(String c_id, Model model) {
		model.addAttribute("c_id",c_id);
		return "customer/passwordUpdate";
	}

	@PostMapping("/pwd")
	public String PasswordUpdate(FindForm findForm) {
		fs.updatePassword(findForm.getC_pwd(), findForm.getC_id());
		return "redirect:/";
	}

}
