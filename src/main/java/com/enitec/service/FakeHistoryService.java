package com.enitec.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.FakeHistoryRepository;
import com.enitec.vo.FakeHistory;

@Service
public class FakeHistoryService {

	@Autowired
	private FakeHistoryRepository fakeHistoryRepository;
	
	public List<FakeHistory> findByHistory(String pf_code){
		return fakeHistoryRepository.findByHistory(pf_code);
	}
}
