package com.enitec.repository;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.enitec.vo.History;

public interface HistoryRepository extends JpaRepository<History, String>{
	@Query(value="SELECT h_close_at FROM history WHERE pf_code = :pf_code AND e_code = :e_code", nativeQuery = true)
	public String findSecByPfcodeAndEcode(@Param("pf_code") String pf_code, @Param("e_code") String e_code);
	@Query(value="select * from enitec.history where pf_code = :pf_code", nativeQuery=true)
	public ArrayList<History> findAllByProfileCode(@Param("pf_code") String pf_code);
}
