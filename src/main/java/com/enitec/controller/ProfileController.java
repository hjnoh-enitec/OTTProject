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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.enitec.form.ProfileForm;
import com.enitec.service.ProfileService;
import com.enitec.vo.Profile;

@Controller
@RequestMapping("/profile")
public class ProfileController {

	@Autowired
	private ProfileService ps;

	@Autowired
	private FileContoller fc;
	
	String defaultName = "basicProfileImage.jpg";
	String filePath = "/image";

	@GetMapping("/select")
	public String moveProfilePage(String toURL, HttpServletRequest request, HttpServletResponse res, Model model) {
		HttpSession session = request.getSession();
		String id = session.getAttribute("c_id").toString();
		System.out.println(session.getAttribute("c_id"));
		List<Profile> profileList = ps.getProfileDataBase(id);
		request.setAttribute("profile", profileList);
		model.addAttribute("c_id", id);
		return "profile/profile";
	}

	@PostMapping("/select")
	public String selectedCustomerProfile(String toURL, HttpServletRequest request, HttpServletResponse res) {

		return "content";
	}

	@GetMapping("/update")
	public String moveProfileUpdatePage(String toURL, HttpServletRequest request, HttpServletResponse res) {
		return "/";
	}

	@GetMapping("/create")
	public String moveProfileInsertPage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Cookie[] cookies = request.getCookies();
		String msg = "";
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("error")) {
					msg = cookie.getValue().toString();	
				}
			}
		}
		String c_id = session.getAttribute("c_id").toString();
		int nextProfileCount = ps.getProfileCount(c_id) + 1;
		String pf_code = "pf" + nextProfileCount + c_id;
		model.addAttribute("c_id", c_id);
		model.addAttribute("pf_code", pf_code);
		model.addAttribute("msg", msg);
		return "profile/profileCreate";
	}

	@PostMapping("/create")
	public String createProfile(@Validated ProfileForm profileForm,Errors errors, HttpServletRequest request, HttpServletResponse res
			, @RequestParam("fileUpload") List<MultipartFile> files)   {
		if (errors.hasErrors()) {
			Cookie error = new Cookie("error","プロフィール名を入力してください。");
			res.addCookie(error);
			return "redirect:/profile/create";
		}
		if(profileForm.getPf_path() == "") {
			profileForm.setPf_path(defaultName);
		}
		boolean uploadStatus=fc.uploadFile(files);
		if(!uploadStatus) {
			Cookie error = new Cookie("error","ファイルアップロードに失敗しました。");
			res.addCookie(error);
			return "redirect:/profile/create";
		}
		ps.CreateUpdateProfile(profileForm);
		return "redirect:/profile/select";
	}
}
