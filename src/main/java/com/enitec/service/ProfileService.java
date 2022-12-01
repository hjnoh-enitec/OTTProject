package com.enitec.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.form.CreateProfileForm;
import com.enitec.repository.ProfileRepository;
import com.enitec.vo.Profile;

@Service
public class ProfileService {

	@Autowired
	private ProfileRepository pr;
	
	public void CreateUpdateProfile(CreateProfileForm profileForm) {
		Profile profile = new Profile();
		profile.setPf_code(profileForm.getPf_code());
		profile.setC_id(profileForm.getC_id());
		profile.setPf_name(profileForm.getPf_name());
		profile.setPf_path(profileForm.getPf_path());
		pr.save(profile);
	}
	
	public List<Profile> getProfileDataBase(String c_id) {
		return pr.findByCustomerId(c_id);
	}
	
	public int getProfileCount(String c_id) {
		return pr.findByProfileCount(c_id);
	}
}
