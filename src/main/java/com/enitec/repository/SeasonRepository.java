package com.enitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.enitec.vo.Season;

public interface SeasonRepository extends JpaRepository<Season, String>{

	@Query(value="SELECT s.s_name, s.s_info, s.s_code, s.ct_code FROM enitec.season s INNER JOIN enitec.CONTENT c on s.ct_code = c.ct_code WHERE c.ct_code = :ct_code", nativeQuery = true)
	public List<Season> findSeasonName(@Param("ct_code") String ct_code);
	
}
