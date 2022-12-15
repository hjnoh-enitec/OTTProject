package com.enitec.repository;

import java.util.ArrayList;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.enitec.vo.Content;

public interface ContentRepository extends JpaRepository<Content, String> {
@Query(value="SELECT * FROM enitec.\"content\" c WHERE ct_code LIKE 'T%'",nativeQuery = true)
	public ArrayList<Content> getMovie();

@Query(value="SELECT * FROM enitec.\"content\" c WHERE ct_code LIKE 'CT%'",nativeQuery = true)
	public ArrayList<Content> getTv();
}
