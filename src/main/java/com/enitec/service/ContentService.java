package com.enitec.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.ContentRepository;
import com.enitec.vo.Content;

@Service
public class ContentService {

	@Autowired
	private ContentRepository contentRepo;
	
	public List<Content> findAll() {
		return contentRepo.findAll();
	}
	
	public String findCtcode(String ct_code) {
		return contentRepo.findCtcode(ct_code);
	}
	
}
