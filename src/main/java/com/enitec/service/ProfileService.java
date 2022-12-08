package com.enitec.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.ProfileRepository;
import com.enitec.vo.Profile;

@Service
public class ProfileService {

	@Autowired
	private ProfileRepository pr;
	
	public void CreateUpdateProfile(Profile profile) {
		pr.save(profile);
	}
	
	public List<Profile> getProfileDataBase(String c_id) {
		return pr.findByCustomerId(c_id);
	}
	
	public int getProfileCount(String c_id) {
		return pr.findByProfileCount(c_id);
	}
	
	public Profile findById(String pf_code) {
		return pr.findById(pf_code).get();
	}
	
	public boolean deleteById(String pf_code) {
		Profile profile = pr.findById(pf_code).get();
		if(profile!=null) {
			pr.delete(profile);
			return true;
		}
		return false;
	}
}
