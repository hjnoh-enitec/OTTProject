package com.enitec.service;

import java.time.LocalDate;

import javax.transaction.Transactional;

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
	@Transactional
	public History quitVideo(History history) {
		history.setH_date(LocalDate.now());
		if(history.getE_code()==null && history.getS_code()==null&&history.getE_number()==0&&history.getS_number()==0){
			history.setE_number(-1);
		}
		return historyRepo.save(history);
	}
}

