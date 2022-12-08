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
import com.enitec.service.HistoryService;
import com.enitec.vo.Content;
import com.enitec.vo.Episode;
import com.enitec.vo.History;
import com.enitec.vo.Season;

@RequestMapping("/content")
@Controller
public class ContentController {

	@Autowired
	private ContentService contentServ;
	
	@Autowired
	private CustomerService customerServ;
	
	@Autowired
	private HistoryService historyServ;
	
	@GetMapping("/main")
	public String moveToVideoMain(Model model, HttpSession session, String pf_code) {
		
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
	
	// 시즌 코드로 그 시즌에 포함된 에피소드들을 찾음
	@GetMapping("searchEpiBySeason")
	@ResponseBody
	public List<Episode> searchEpiBySeason(String s_code){
		return contentServ.findEpiCodeAndNameByScode(s_code);
	}
	
	// 컨텐츠 코드로 해당 컨텐츠에 포함된 시즌들을 불러옴
	@GetMapping("searchSeasonByCcode")
	@ResponseBody
	public List<Season> findSeasonName(String ct_code){
		return contentServ.findSeasonName(ct_code);
	}
	
	// 컨텐츠 코드로 해당 컨텐츠를 찾아 평점을 계산 후 불러옴
	@GetMapping("calcRatingByCtcode")
	@ResponseBody
	public String calcRatingByCtcode(String ct_code){
		return String.format("%.2f", contentServ.calcRatingByCtcode(ct_code));
	}
	
	// 컨텐츠 코드로 해당 컨텐츠를 찾아 평점을 계산 후 불러옴
	@GetMapping("saveCloseTime")
	@ResponseBody
	public String saveCloseTime(String ct_code){
		return String.format("%.2f", contentServ.calcRatingByCtcode(ct_code));
	}
	
	// 시청기록 가져오기
	@GetMapping("findSecByPfcodeAndEcode")
	@ResponseBody
	public String findSecByPfcodeAndEcode(String pf_code, String e_code){
		String closedAt = "";
		try {
			closedAt = historyServ.findSecByPfcodeAndEcode(pf_code + "_" + e_code);
		} catch (Exception e) {
			
		}
		return closedAt;
	}
	
	// 영상 종료 시 history 테이블에 종료 시간 저장
	@GetMapping("quitVideo")
	public String quitVideo(History history) {

		history = historyServ.quitVideo(history);	
		
		return "redirect:/content/main";
	}
	
	@GetMapping("/watch")
	public String watchVideo(String e_code, String e_close_sec, String pf_code, String toURL, Model model, HttpSession session) {
		
		// url로 바로 접속 시
		// 세션이 있음 -> 멤버십 가입 돼있으면 재생 페이지로 / 안 돼있으면 멤버십 가입 페이지로
		// 세션이 없음 -> 로그인 페이지로 -> 로그인 후 바로 재생 페이지로
		try {
			String guest = "Guest";
			String noMembership = "M0";
			String c_id = session.getAttribute("c_id").toString();
			String membership = customerServ.getMembershipCode(c_id);
			pf_code = "s45511071G_PF01";
			
			// 로그인 안 돼있음 -> 로그인 페이지로
			if(c_id.equals(guest)) {
				return "redirect:/login/login?toURL=/content/watch?e_code=" + e_code;
				// 로그인은 돼있으나 멤버십 미가입 -> 멤버십 신청/변경 페이지로
			} else if(!c_id.equals(guest) && membership.equals(noMembership)) {
				return "redirect:/customer/modifyMembership?c_id=" + c_id;
			}
			
			model.addAttribute("membership", membership);
			model.addAttribute("pf_code", pf_code);
			
		} catch (Exception e) {
			System.out.println(e);
			return "redirect:/login/login?toURL=/content/watch?e_code=" + e_code;
		}
		
		Episode episode = new Episode();
		episode.setE_code(e_code);
		String e_path = contentServ.findEpath(e_code);
		model.addAttribute("path", e_path);
		model.addAttribute("e_code", e_code);
		System.out.println("CLOSE : " + e_close_sec);
		model.addAttribute("e_close_sec", e_close_sec);
		return "content/watch";
	}
	
}
