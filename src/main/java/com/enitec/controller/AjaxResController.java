package com.enitec.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.enitec.service.RegisterService;

@Controller
public class AjaxResController {
	@Autowired
	RegisterService rs;
	@ResponseBody
	@PostMapping("/checkId")
	public int checkIdDuplicated(String customer) {
		System.out.println("controller called");
	    int result = rs.checkIdDuplicated(customer);
	    return result;
	}
}
