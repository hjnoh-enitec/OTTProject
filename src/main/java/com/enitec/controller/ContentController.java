package com.enitec.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.service.ContentService;
import com.enitec.service.HistoryService;
import com.enitec.vo.History;
import com.enitec.vo.Image;

@Controller
@RequestMapping("/content")
public class ContentController {
	@Autowired
	ContentService cts;
	String movieURL = "/movie/popular?";
	String tvURL = "/tv/popular?";
	String jasonName = "results";
	String requestPage = "1";

	@Autowired
	private HistoryService historyServ;
	
	@GetMapping("/main")
	public String moveToContentPage(Model model, HttpServletRequest request) {
		
		
		
		ArrayList<History> playedList = cts.getPlayedList("p01");
		model.addAttribute("playedList",playedList);
		ArrayList<Image> movieList = cts.getImgList(movieURL , jasonName,requestPage);
		model.addAttribute("topRated", movieList);
		ArrayList<Image> tvList = cts.getImgList(tvURL,jasonName, requestPage);
		model.addAttribute("myList", tvList);
		return "content/content";
	}

	@GetMapping("/watch")
	public String watchVideo(Model model) {
		try {
			model.addAttribute("membership", "M1");
			model.addAttribute("path", "/video/M1/video.mp4");
			return "content/watch";
		} catch (Exception e) {
			System.out.println(e);
		}
		return "content/watch";
	}

	@GetMapping("/test")
	public String setContent() {
		cts.setContent(movieURL, tvURL, jasonName, requestPage);
		return "redirect:/";
	}

	// 영상 종료 시 history 테이블에 종료 시간 저장
	@GetMapping("quitVideo")
	public String quitVideo(History history) {
		history = historyServ.quitVideo(history);
		return "redirect:/content/main";
	}
	

}
