package com.enitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.enitec.vo.History;

public interface HistoryRepository extends JpaRepository<History, String> {

	@Query(value="select e_code,h_date,h_close_at, h_poster_path from history where pf_code = :pf_code", nativeQuery=true)
	List<History> findByProfileHistory(@Param("pf_code")String pf_coode);
	
}
