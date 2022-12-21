package com.enitec.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.enitec.form.CreateProfileForm;
import com.enitec.form.SelectProfileForm;
import com.enitec.service.CustomerService;
import com.enitec.service.FileSaveService;
import com.enitec.service.ProfileService;
import com.enitec.session.Session;
import com.enitec.vo.Profile;

@Controller
@RequestMapping("/profile")
public class ProfileController {

	@Autowired
	private ProfileService ps;

	@Autowired
	private CustomerService customerServ;

	@GetMapping("/select")
	public String moveProfilePage(String toURL, HttpServletRequest request, HttpServletResponse res, Model model) {
		HttpSession session = request.getSession();
		if (!Session.checkLogin(session)) {
			return "redirect:/";
		}
		String c_id = session.getAttribute(Session.LOGIN_CUSTOMER).toString();
		List<Profile> profileList = ps.getProfileDataBase(session.getAttribute(Session.LOGIN_CUSTOMER).toString());
		session.setAttribute(Session.CUSTOMER_PROFILE_LIST, profileList);
		String pf_code = "pf";
		if (ps.getProfileCount(c_id) == 0) {
			pf_code += 1;
			pf_code += c_id;
		} else {
			pf_code += ps.nextVal(c_id);
			pf_code += c_id;
		}
		model.addAttribute(Session.LOGIN_CUSTOMER, c_id);
		model.addAttribute("pf_code", pf_code);
		model.addAttribute("profileList", profileList);
		// 유저의 멤버십 코드가 M0 (미가입상태)면 멤버십 가입 페이지로, 가입 되어있으면 프로필 선택 페이지로
		String membership = customerServ.getMembershipCode(c_id.toString());
		String noMembership = "M0";
        if(membership.equals(noMembership)) {
        	return "redirect:/customer/modifyMembership?c_id=" + c_id + "&isFromLogin=true";
        }		
		return "profile/profile";
	}

	@PostMapping("/select")
	public String selectedCustomerProfile(SelectProfileForm spf, HttpSession session, HttpServletResponse res,
			Model model) {
		if (!Session.checkLogin(session)) {
			return "redirect:/";
		}
		Profile profile = ps.findById(spf.getPf_code());
		session.setAttribute(Session.SELECT_PROFILE, profile);
		return "redirect:/";
	}


	@PostMapping("/create")
	public String createProfile(CreateProfileForm createProfileForm,  HttpSession session,
			HttpServletResponse res, MultipartFile fileUpload) {
		FileSaveService fss = new FileSaveService();
		Profile profile = new Profile();
		String profilePath = "";
		String thumbnailPath = "";
		profile.setPf_code(createProfileForm.getPf_code());
		profile.setC_id(createProfileForm.getC_id());
		profile.setPf_name(createProfileForm.getPf_name());
		if (fileUpload.isEmpty()) {
			profilePath = fss.base + fss.defaultProfileImageName;
			thumbnailPath = fss.base + fss.defaultThumbnailImageName;
		} else {
			String fileName = fileUpload.getOriginalFilename();
			boolean uploadStatus = fss.uploadFile(fileUpload, fileName);
			if (!uploadStatus) {
				Cookie error = new Cookie("error", "ファイルアップロードに失敗しました。");
				res.addCookie(error);
				return "redirect:/profile/select";
			}
			profilePath = fss.profile + fileName;
			thumbnailPath = fss.thumbnail + fileName;
		}
		profile.setPf_path(profilePath);
		profile.setPf_thumbnail_path(thumbnailPath);
		ps.CreateUpdateProfile(profile);
		return "redirect:/profile/select";
	}

}