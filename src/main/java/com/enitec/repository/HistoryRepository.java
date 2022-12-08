package com.enitec.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.enitec.vo.History;

public interface HistoryRepository extends JpaRepository<History, String>{

	@Query(value="SELECT e_close_sec FROM history WHERE history_key = :history_key", nativeQuery = true)
	public String findSecByPfcodeAndEcode(@Param("history_key") String history_key);
	
}
