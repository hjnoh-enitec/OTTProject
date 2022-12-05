package com.enitec.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.enitec.vo.Content;

@Repository
public interface ContentRepository extends JpaRepository<Content, String>{

	@Query(value="SELECT ct_path FROM enitec.content WHERE ct_code=:ct_code",nativeQuery = true)
	public String findCtpath(@Param("ct_code") String ct_code);
	
}
