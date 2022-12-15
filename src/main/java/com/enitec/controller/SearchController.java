package com.enitec.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.enitec.service.ContentService;
import com.enitec.vo.Content;

@Controller
public class SearchController {

	@Autowired
	private ContentService cts;
	
	@GetMapping("/search")
	public String searchKeyword(@RequestParam(value = "keyword")String keyword,Model model){
		System.out.println("keyword : " + keyword);
		List<Content> searchContent = cts.search("%"+keyword+"%");
		model.addAttribute("search", searchContent);
		return "searchContent";
	}
	
}
