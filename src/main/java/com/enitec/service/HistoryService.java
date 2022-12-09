package com.enitec.service;

import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.HistoryRepository;
import com.enitec.vo.History;

@Service
public class HistoryService {

	@Autowired
	private HistoryRepository historyRepo;
	
	public String findSecByPfcodeAndEcode(String history_key) {
		return historyRepo.findSecByPfcodeAndEcode(history_key);
	}
	
	public History quitVideo(History history) {
		history.setH_close_at(LocalTime.now());
		history.setH_date(LocalDate.now());
		return historyRepo.save(history);
	}
}
