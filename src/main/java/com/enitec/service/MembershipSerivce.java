package com.enitec.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.MembershipRepository;
import com.enitec.vo.Membership;
@Service
public class MembershipSerivce {
	@Autowired
	MembershipRepository mr;
	
	public List<Membership> getMembershipList() {
		return mr.findAll();
	}
	
	public String getMcode(String m_code) {
		return mr.findMcode(m_code);
	}
}
