package com.enitec.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.service.ContentService;
import com.enitec.vo.Content;

@RequestMapping("/video")
@Controller
public class ContentController {

	@Autowired
	private ContentService contentServ;
	
	@GetMapping("/contents")
	public String moveToVideoMain(Model model, HttpSession session) {
		
		try {
			String c_id = session.getAttribute("c_id").toString();
			if(c_id != null) {
				model.addAttribute("loginID", c_id);
			}
		} catch (Exception e) {
			model.addAttribute("loginID", "Guest");
		}
		
		List<Content> contentList = contentServ.findAll();
		model.addAttribute("contentList", contentList);
		return "video/contents";
	}
	
	@PostMapping("/contents")
	public String watchVideo(String ct_code, Model model) {
		Content content = new Content();
		content.setCt_code(ct_code);
		String ct_path = contentServ.findCtcode(ct_code);
		System.out.println("TEST : " + ct_code);
		System.out.println("TEST : " + ct_path);
		model.addAttribute("path", ct_path);
		return "video/watch";
	}
	
}
