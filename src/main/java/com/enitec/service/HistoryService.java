package com.enitec.service;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.HistoryRepository;
import com.enitec.vo.History;

@Service
public class HistoryService {

	@Autowired
	private HistoryRepository historyRepo;
	
	public String findSecByPfcodeAndEcode(String pf_code, String e_code) {
		return historyRepo.findSecByPfcodeAndEcode(pf_code, e_code);
	}
	
	public History quitVideo(History history) {
		history.setH_date(LocalDate.now());
		return historyRepo.save(history);
	}
}
