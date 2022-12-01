package com.enitec.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.HistoryRepository;
import com.enitec.vo.History;

@Service
public class HistoryService {

	@Autowired
	private HistoryRepository hs;
	
	public List<History> findByProfileHistory(String pf_code){
		return hs.findByProfileHistory(pf_code);
	}
	
}
