package com.enitec.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.MembershipRepository;
import com.enitec.vo.Membership;
@Service
@Transactional
public class MembershipSerivce {
	@Autowired
	MembershipRepository mr;
	
	public List<Membership> getMembershipList() {
		return mr.findAll();
	}
	

}
