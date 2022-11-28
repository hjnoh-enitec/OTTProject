package com.enitec.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.Form.FindForm;
import com.enitec.service.FindService;
import com.enitec.service.MailService;
import com.enitec.service.TokenService;

@Controller
@RequestMapping("/find")
public class FindController {

	@Autowired
	private FindService fs;
	@Autowired
	private TokenService ts;
	@Autowired
	private MailService ms;

	@GetMapping("/id")
	public String moveFindId() {
		return "customer/findId";
	}

	@PostMapping("/id")
	public String returnId(FindForm findForm, HttpServletRequest request) {
		List<String> idList = fs.findId(findForm.getC_name(), findForm.getC_birth(), findForm.getC_phone());
		if (idList == null) {
			return "redirect:/findId";
		}
		String sendId = "";
		for (String id : idList) {
			sendId += " ";
			sendId += id;
		}
		request.setAttribute("sendId", sendId);
		return "customer/idList";
	}

	@GetMapping("/pwd")
	public String moveFindPassword() {
		return "customer/findPassword";
	}

	@PostMapping("/sendCheckedMail")
	public String sendPasswordUpdate(FindForm findForm) {
		if (fs.findCustomer(findForm.getC_id()) == null) {
			return "error";
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
		return "index";
	}

}
