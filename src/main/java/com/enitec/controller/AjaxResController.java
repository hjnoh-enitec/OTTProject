package com.enitec.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.enitec.service.ContentService;
import com.enitec.service.HistoryService;
import com.enitec.service.RegisterService;
import com.enitec.vo.Content;
import com.enitec.vo.History;

@Controller
public class AjaxResController {
	@Autowired
	RegisterService rs;
	@Autowired
	HistoryService hs;
	@ResponseBody
	@PostMapping("/checkId")
	public int checkIdDuplicated(String customer) {
		System.out.println("controller called");
	    int result = rs.checkIdDuplicated(customer);
	    return result;
	}
	
	
	@GetMapping("/quitVideo")
	public String quitVideo(History history) {
		if(!"".equals(history.getCt_code())) {

			hs.quitVideo(history);	
		}
		return "redirect:/";
	}
}
