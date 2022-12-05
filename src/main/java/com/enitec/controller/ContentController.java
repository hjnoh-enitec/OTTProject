package com.enitec.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.enitec.service.ContentService;
import com.enitec.service.CustomerService;
import com.enitec.vo.Content;
import com.enitec.vo.Episode;
import com.enitec.vo.Season;

@RequestMapping("/content")
@Controller
public class ContentController {

	@Autowired
	private ContentService contentServ;
	
	@Autowired
	private CustomerService customerServ;
	
	@GetMapping("/main")
	public String moveToVideoMain(Model model, HttpSession session) {
		
		try {
			
			String c_id = session.getAttribute("c_id").toString();
			if(c_id != null) {
				model.addAttribute("loginID", c_id);
				
				String membership = customerServ.getMembershipCode(c_id);
				if(membership != null) {
					model.addAttribute("membership", membership);
				}
			}
			
		} catch (Exception e) {
			model.addAttribute("loginID", "Guest");
		}
		
		List<Content> contentList = contentServ.findAll();
		model.addAttribute("contentList", contentList);
		return "content/main";
	}
	
	@GetMapping("/popup")
	public String popup(String ct_code, Model model) {
		System.out.println("POPUP!");
		
		List<Season> seasonList = contentServ.findSeasonName(ct_code);
		//List<Episode> episodeList = contentServ.findEpiCodeAndNameByCtcode(ct_code);
		
		model.addAttribute("seasonList", seasonList);
		//model.addAttribute("episodeList", episodeList);
		
		return "content/popup";
	}
	
	@GetMapping("searchEpiBySeason")
	@ResponseBody
	public List<Episode> searchEpiBySeason(String s_code){
		System.out.println("sEBS TEST : " + s_code);
		return contentServ.findEpiCodeAndNameByScode(s_code);
	}
	
	@GetMapping("searchSeasonByCcode")
	@ResponseBody
	public List<Season> findSeasonName(String ct_code){
		System.out.println("sName TEST : " + ct_code);
		return contentServ.findSeasonName(ct_code);
	}
	
	@GetMapping("/watch")
	public String watchVideo(String ct_code, String toURL, Model model, HttpSession session) {
		
		// url로 바로 접속 시
		// 세션이 있음 -> 멤버십 가입 돼있으면 재생 페이지로 / 안 돼있으면 멤버십 가입 페이지로
		// 세션이 없음 -> 로그인 페이지로 -> 로그인 후 바로 재생 페이지로
		try {
			
			String c_id = session.getAttribute("c_id").toString();
			String membership = customerServ.getMembershipCode(c_id);
			
			// 로그인 안 돼있음
			if(c_id == "Guest") {
				return "redirect:/login/login?toURL=/content/watch?ct_code=" + ct_code;
				// 로그인은 돼있으나 멤버십 미가입
			} else if(c_id != "Guest" && membership.equals("M0")) {
				return "redirect:/customer/modifyMembership?c_id=" + c_id;
			}
			
			model.addAttribute("membership", membership);
			
		} catch (Exception e) {
			System.out.println(e);
			return "redirect:/login/login?toURL=/content/watch?ct_code=" + ct_code;
		}
		
		Content content = new Content();
		content.setCt_code(ct_code);
		String ct_path = contentServ.findCtpath(ct_code);
		model.addAttribute("path", ct_path);
		return "content/watch";
	}
	
}
