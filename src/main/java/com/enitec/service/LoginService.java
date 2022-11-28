package com.enitec.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.CustomerRepository;

@Service
public class LoginService {
	@Autowired
	private CustomerRepository cr;
	
	public String mailCheck(String c_id, String c_pwd) {
		return cr.login(c_id, c_pwd);
	}
}
