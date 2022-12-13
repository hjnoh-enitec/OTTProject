package com.enitec.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/search")
public class SearchController {

	@GetMapping("/search")
	public void searchTitle(@RequestParam("search")String search) {
		System.out.println("search : " +  search);
	}
}
