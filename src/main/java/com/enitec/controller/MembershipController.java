package com.enitec.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.service.MembershipSerivce;
import com.enitec.vo.Membership;

@Controller
@RequestMapping("/membership")
public class MembershipController {
	@Autowired
	private MembershipSerivce ms;
	
	@GetMapping("/get")
	public String modifyMembership(HttpServletRequest req, Model model) {


		return "redirect:/customer/modifyMembership";
	}

	/*
	
	 * 
	 * return "member/membershipquit"; }
	 * 
	 * @PostMapping("/membershipsuccess") public String

	 * 
	 * @PostMapping("/membershipquitsuccess") public String
	 * membershipquitsuccess(MembershipQuitVo msUpdate) {
	 * cms.membershipPlanQuit(msUpdate); return "member/membershipsuccess"; }
	 * 
	 * @GetMapping("/findID") public String findID() { return "member/findID"; }
	 * 
	 * @PostMapping("/yourID") public String yourID(Customer findID, Model model) {
	 * try { System.out.println("ID 찾기 결과");
	 * 
	 * String id = cms.findID(findID.getC_name(), findID.getC_birth(),
	 * findID.getC_phone());
	 * 
	 * model.addAttribute("result", id);
	 * 
	 * if(id != null) { return "member/yourID"; } else { String errMsg =
	 * "入力した情報と一致するIDがありません。"; model.addAttribute("error", errMsg); return
	 * "member/findID"; }
	 * 
	 * } catch (Exception e) { System.out.println(e); } return "member/findID"; }
	 */
}
