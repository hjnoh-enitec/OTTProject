package com.enitec.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.enitec.form.CreateProfileForm;
import com.enitec.form.SelectProfileForm;
import com.enitec.service.FileSaveService;
import com.enitec.service.ProfileService;
import com.enitec.session.Session;
import com.enitec.vo.Profile;

@Controller
@RequestMapping("/profile")
public class ProfileController {

	@Autowired
	private ProfileService ps;
	//@Autowired
	//private HistoryService hs;

	@Autowired
	private FileSaveService fss;

	@GetMapping("/select")
	public String moveProfilePage(String toURL, HttpServletRequest request, HttpServletResponse res, Model model) {
		HttpSession session = request.getSession();
		Object c_id = session.getAttribute("c_id");
		if (c_id == null) {
			return "index";
		}
		List<Profile> profileList = ps.getProfileDataBase(session.getAttribute("c_id").toString());
		session.setAttribute(Session.CUSTOMER_PROFILE_LIST, profileList);
		return "profile/profile";
	}

	@PostMapping("/select")
	public String selectedCustomerProfile(SelectProfileForm spf, HttpSession session, HttpServletResponse res,
			Model model) {
		if (!Session.checkLogin(session)) {
			return "index";
		}
		Profile profile = ps.findById(spf.getPf_code());
		session.setAttribute(Session.SELECT_PROFILE, profile);
		return "redirect:/content/main";
	}

	@GetMapping("/update")
	public String moveProfileUpdatePage(HttpSession session, Model model) {
		Object c_id = session.getAttribute(Session.LOGIN_CUSTOMER);
		if (c_id == null) {
			return "index";
		}
		List<Profile> profileList = ps.getProfileDataBase(c_id.toString());
		model.addAttribute("profileList", profileList);
		return "/profile/profileUpdate";
	}

	@GetMapping("/create")
	public String moveProfileInsertPage(Model model, HttpServletRequest request, HttpServletResponse res) {
		HttpSession session = request.getSession(false);
		String c_id = session.getAttribute("c_id").toString();
		if (c_id == null) {
			return "index";
		}
		Cookie[] cookies = request.getCookies();
		String msg = "";
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("error")) {
					msg = cookie.getValue().toString();
					cookie.setMaxAge(0);
					res.addCookie(cookie);
				}
			}
		}
		String pf_code = "pf";
		if (ps.getProfileCount(c_id) == 0) {
			pf_code += 1;
			pf_code += c_id;
		} else {
			pf_code += ps.nextVal(c_id);
			pf_code += c_id;
		}
		model.addAttribute("c_id", c_id);
		model.addAttribute("pf_code", pf_code);
		model.addAttribute("msg", msg);
		return "profile/profileCreate";
	}

	@PostMapping("/create")
	public String createProfile(@Validated CreateProfileForm createProfileForm, Errors errors, HttpSession session,
			HttpServletResponse res, MultipartFile fileUpload) {
		Profile profile = new Profile();
		String profilePath = "";
		String thumbnailPath = "";
		if (errors.hasErrors()) {
			Cookie error = new Cookie("error", "プロフィール名を入力してください。");
			res.addCookie(error);
			return "redirect:/profile/create";
		}

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
				return "redirect:/profile/create";
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