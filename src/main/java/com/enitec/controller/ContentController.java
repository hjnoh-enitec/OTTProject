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
import com.enitec.service.CustomerService;
import com.enitec.service.HistoryService;
import com.enitec.session.Session;
import com.enitec.vo.History;
import com.enitec.vo.Image;
import com.enitec.vo.Profile;

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
	private CustomerService customerServ;
	
	@Autowired
	private HistoryService historyServ;
	
	@GetMapping("/main")
	public String moveToContentPage(Model model, HttpServletRequest request) {

		HttpSession session = request.getSession(false);
		/*
		 * ArrayList<History> playedList = cts.getPlayedList("p01");
		 * model.addAttribute("playedList",playedList); ArrayList<Image> movieList =
		 * cts.getImgList(movieURL , jasonName,requestPage);
		 * model.addAttribute("topRated", movieList); ArrayList<Image> tvList =
		 * cts.getImgList(tvURL,jasonName, requestPage); model.addAttribute("myList",
		 * tvList); return "content/content";
		 */
		ArrayList<Image> movieList = cts.getImgList(movieURL , jasonName,requestPage);
		model.addAttribute("topRated", movieList);
		ArrayList<Image> tvList = cts.getImgList(tvURL,jasonName, requestPage);
		model.addAttribute("myList", tvList);
		if(Session.checkLogin(session)) {
			if(Session.isNoPayCustomer(session)) {
			return "redirect:/customer/modifyMembership?c_id=" + session.getAttribute("c_id");
			}else if(!Session.checkSelectedProfile(session)) {
				return "redirect:/profile/select";
			}
			String pf_code= ((Profile)session.getAttribute(Session.SELECT_PROFILE)).getPf_code();
			ArrayList<History> playedList = cts.getPlayedList(pf_code);
			model.addAttribute("playedList",playedList);

			return "content/content";
		}
		return "content/content";

	}

	@GetMapping("/watch")
	public String watchVideo(String e_code, String h_close_at, String pf_code, String toURL, Model model, HttpSession session) {
		try {
			String guest = "Guest";
			String noMembership = "M0";
			String c_id = session.getAttribute("c_id").toString();
			// 세션이 널인지 아닌지 봐야
			String membership = customerServ.getMembershipCode(c_id);
			
			System.out.println(c_id);
			System.out.println(membership);
			
			// 로그인 안 돼있음 -> 로그인 페이지로
			if(session.equals(null)) {
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
		return "content/watch";
	}

	
	// 에피소드에 있는거 싹다 지우고 새로 등록하는 코드
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
