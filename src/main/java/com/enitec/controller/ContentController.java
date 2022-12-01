package com.enitec.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.service.ContentService;
import com.enitec.vo.Image;

@Controller
@RequestMapping("/content")
public class ContentController {
	@Autowired
	ContentService cts;
	@GetMapping("/main")
	public String moveToContentPage(Model model) {
		ArrayList<Image> imageList = cts.getImgList("/movie/popular?","results","1");
		model.addAttribute("popularList", imageList);
		ArrayList<Image> imageList2 = cts.getImgList("/movie/popular?","results","4");
		model.addAttribute("myList",imageList2);
		return "content/content";
	}



}
