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
	
	public List<Profile> getProfileDataBase(String c_id) {
		return pr.findByCustomerId(c_id);
	}
}
