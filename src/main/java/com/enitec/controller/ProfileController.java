package com.enitec.controller;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
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
import com.enitec.form.SendProfileHistory;
import com.enitec.service.FakeHistoryService;
import com.enitec.service.ProfileService;
import com.enitec.vo.FakeHistory;
import com.enitec.vo.Profile;

@Controller
@RequestMapping("/profile")
public class ProfileController {

	@Autowired
	private ProfileService ps;
	//@Autowired
	//private HistoryService hs;
	@Autowired
	private FakeHistoryService fs;
	
	String defaultName = "basicProfileImage.jpg";
	String settingPath = "/image/";

	@GetMapping("/select")
	public String moveProfilePage(String toURL, HttpServletRequest request, HttpServletResponse res, Model model) {
		HttpSession session = request.getSession();
		Object c_id = session.getAttribute("c_id");
		if(c_id == null) {
			return "index";
		}
		List<Profile> profileList = ps.getProfileDataBase(c_id.toString());
		request.setAttribute("profile", profileList);
		model.addAttribute("c_id", c_id.toString());
		return "profile/profile";
	}

	@PostMapping("/select")
	public String selectedCustomerProfile(SelectProfileForm spf,SendProfileHistory sfh, HttpServletRequest request, HttpServletResponse res,Model model) {
		String pf_code = spf.getPf_code();
		List<FakeHistory> fakeHistoryList = fs.findByHistory(pf_code);
		List<String> fh_codeList = new ArrayList<String>();
		List<String> fh_poster_pathList = new ArrayList<String>();
		for(FakeHistory fh : fakeHistoryList) {
			fh_codeList.add(fh.getFh_code());
			fh_poster_pathList.add(fh.getFh_poster_path());
		}
		HttpSession session = request.getSession();
		session.setAttribute("pf_code", pf_code);
		sfh.setH_code(fh_codeList);
		sfh.setH_poster_path(fh_poster_pathList);
		model.addAttribute("history", sfh);
		return "content";
	}

	@GetMapping("/update")
	public String moveProfileUpdatePage() {
		return "/profile/profileUpdate";
	}

	@GetMapping("/create")
	public String moveProfileInsertPage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		String c_id = session.getAttribute("c_id").toString();
		if(c_id == null) {
			return "index";
		}
		Cookie[] cookies = request.getCookies();
		String msg = "";
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				if(cookie.getName().equals("error")) {
					msg = cookie.getValue().toString();	
				}
			}
		}
		int nextProfileCount = ps.getProfileCount(c_id) + 1;
		String pf_code = "pf" + nextProfileCount + c_id;
		model.addAttribute("c_id", c_id);
		model.addAttribute("pf_code", pf_code);
		model.addAttribute("msg", msg);
		return "profile/profileCreate";
	}

	@PostMapping("/create")
	public String createProfile(@Validated CreateProfileForm createProfileForm,Errors errors, HttpServletRequest request, HttpServletResponse res
			, MultipartFile fileUpload)   {
		String ProfilePath = createProfileForm.getPf_path();
		if (errors.hasErrors()) {
			Cookie error = new Cookie("error","プロフィール名を入力してください。");
			res.addCookie(error);
			return "redirect:/profile/create";
		}
		if(ProfilePath == "") {
			ProfilePath = defaultName;
		}
		boolean uploadStatus = uploadFile(fileUpload);
		if(!uploadStatus) {
			Cookie error = new Cookie("error","ファイルアップロードに失敗しました。");
			res.addCookie(error);
			return "redirect:/profile/create";
		}
		ProfilePath = settingPath + fileUpload.getOriginalFilename();
		createProfileForm.setPf_path(ProfilePath);
		ps.CreateUpdateProfile(createProfileForm);
		return "redirect:/profile/select";
	}
	
	public boolean uploadFile(MultipartFile uploadFile) {
		
		
		try {
		InputStream in = uploadFile.getInputStream();
		BufferedImage originImage = ImageIO.read(in);
		BufferedImage thumbImage = new BufferedImage(150,150,BufferedImage.TYPE_INT_BGR);
		Graphics2D g = thumbImage.createGraphics();
		g.setBackground(Color.WHITE);
		g.drawImage(originImage,0,0,150,150,null);
		g.dispose();
		in.close();
		}
		catch(Exception e) {
			return false;
		}
		return true;
	}
}
