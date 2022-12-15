package com.enitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.enitec.vo.Content;

public interface ContentRepository extends JpaRepository<Content, String> {

	@Query(value="select ct_code,ct_title,g_code,ct_genre,ct_info,ct_path_thumbnail,ct_star,ct_path,ct_release_Date,ct_modifydate from content where ct_title LIKE :keyword",nativeQuery=true)
	List<Content> findByCt_titleContaining(@Param("keyword")String keyword);
}
