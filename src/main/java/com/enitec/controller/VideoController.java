package com.enitec.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/video")
public class VideoController {

	@GetMapping("")
	public String moveToVideoMain() {
		return "video/main";
	}
	
	
	
}
