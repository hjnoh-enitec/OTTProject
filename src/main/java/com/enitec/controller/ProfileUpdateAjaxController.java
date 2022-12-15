package com.enitec.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.enitec.service.FileSaveService;
import com.enitec.service.ProfileService;
import com.enitec.session.Session;
import com.enitec.vo.Profile;

@RestController
public class ProfileUpdateAjaxController {

	@Autowired
	private ProfileService ps;
	@Autowired
	private FileSaveService fss;
	
	@PostMapping("/update")
	@ResponseBody
	public int updateProfile(@RequestParam("fileUpload") MultipartFile uploadfile,@RequestParam("pf_code")String pf_code,@RequestParam("pf_name")String pf_name,HttpSession session){
		Profile profile = ps.findById(pf_code);
		profile.setPf_name(pf_name);
		if(!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();
			if(!fss.uploadFile(uploadfile, fileName)) {
				return 1;
			}else {
				File beforeProfile = new File(fss.root + fss.profile + profile.getPf_path());
				File beforeThumbnail = new File(fss.root + fss.thumbnail + profile.getPf_thumbnail_path());
				if(beforeProfile.exists()) {
					if(beforeProfile.delete()) {
						System.out.println("delete before profile");
					}else {
						return 1;
					}
				}
				if(beforeThumbnail.exists()) {
					if(beforeThumbnail.delete()) {
						System.out.println("delete before thumbnail");
					}else {
						return 1;	
					}
				}
				profile.setPf_path(fss.profile+fileName);
				profile.setPf_thumbnail_path(fss.thumbnail+fileName);
			}
		}
		ps.CreateUpdateProfile(profile);
		if(Session.checkSelectedProfile(session)) {
			session.setAttribute(Session.SELECT_PROFILE, ps.findById(pf_code));
		}
		session.setAttribute(Session.CUSTOMER_PROFILE_LIST, ps.getProfileDataBase(session.getAttribute(Session.LOGIN_CUSTOMER).toString()));
		return 0;
	}
	
	@PostMapping("/delete")
	@ResponseBody
	public int deleteProfile(@RequestParam("pf_code")String pf_code,HttpSession session) {
			boolean check = ps.deleteById(pf_code);
			if(check) {
				int profileCount = ps.getProfileCount(session.getAttribute(Session.LOGIN_CUSTOMER).toString());
				session.setAttribute(Session.CUSTOMER_PROFILE_LIST, ps.getProfileDataBase(Session.LOGIN_CUSTOMER).toString());
				if(profileCount == 0) {
					return 1;
				}
				List<Profile> profileList = ps.getProfileDataBase(session.getAttribute(Session.LOGIN_CUSTOMER).toString());
				boolean profile = profileList.contains(session.getAttribute(Session.SELECT_PROFILE));
				if(!profile) {
					session.removeAttribute(Session.SELECT_PROFILE);
				}
				return 0;
			}
			return -1;
	}
}