package com.enitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.enitec.vo.Episode;

public interface EpisodeRepository extends JpaRepository<Episode, String>{

	@Query(value="SELECT T3.E_PATH, T3.E_CODE, T3.E_NAME, T3.E_RELEASE_DATE, T3.CT_CODE, T3.S_CODE FROM EPISODE T3 JOIN SEASON T2 ON T2.s_code = T3.s_code WHERE T2.CT_CODE = :ct_code", nativeQuery = true)
	public List<Episode> findEpiCodeAndNameByCtcode(@Param("ct_code") String ct_code);
	
	@Query(value="SELECT T3.E_PATH, T3.E_CODE, T3.E_NAME, T3.E_RELEASE_DATE, T3.CT_CODE, T3.S_CODE FROM EPISODE T3 JOIN SEASON T2 ON T2.s_code = T3.s_code WHERE T2.s_CODE = :s_code", nativeQuery = true)
	public List<Episode> findEpiCodeAndNameByScode(@Param("s_code") String s_code);
	
	@Query(value="SELECT E_PATH, E_CODE, E_NAME, E_RELEASE_DATE, e.CT_CODE, e.S_CODE FROM episode e INNER JOIN (SELECT * FROM season s INNER JOIN content c ON s.ct_code = c.ct_code) j ON e.s_code = j.s_code", nativeQuery = true)
	public List<Episode> findEpisode();
}
