package com.enitec.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.enitec.service.CustomerMembershipService;
import com.enitec.service.CustomerService;
import com.enitec.service.MembershipSerivce;
import com.enitec.vo.Customer;
import com.enitec.vo.Membership;

@RequestMapping("/customer")
@Controller
public class CustomerController {
	@Autowired
	CustomerService cs;
	@Autowired
	private MembershipSerivce ms;
	@Autowired
	private CustomerMembershipService cms;

	@GetMapping("/info")
	public String customerinfo(HttpSession session, Model model) {
		System.out.println("hey");
		if (session.getAttribute("c_id") == null) {
			return "error";
		}
		String c_id = session.getAttribute("c_id").toString();
		Customer customer = getCustomerInfo(c_id);
		model.addAttribute("customer", customer);
		return "customer/customerinfo";
	}

	private Customer getCustomerInfo(String c_id) {
		return cs.getCustomerInfo(c_id);
	}

	@GetMapping("/modifyMembership")
	public String membership(HttpSession session, String toURL, Model model) {
		if (session.getAttribute("c_id") == null) {
			return "redirect:/login/login?toURL=" + toURL;
		}
		List<Membership> ml = ms.getMembershipList();
		model.addAttribute("ml", ml);
		String c_id = session.getAttribute("c_id").toString();
		String membershipCode = cs.getMembershipCode(c_id);
		model.addAttribute("membershipCode", membershipCode);
		model.addAttribute("ml", ml);
		return "member/membership";
	}

	@PostMapping("/membershipSuccess")
	public String changeMembership(String c_id, String m_code) {
		cms.changeMembership(c_id, m_code);
		return "index";
	}
	@GetMapping("/withdrwal")
	public String moveToWithdrwalPage(String c_id) {
		System.out.println("hey");
		return "member/membershipquit";
	}
	@PostMapping("/withdrwal") 
	public String membershipquit(String c_id) { 
		cms.withdrwalMembership(c_id);
		return "index";
}
	
}