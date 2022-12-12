package com.enitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.enitec.vo.Profile;

@Repository
public interface ProfileRepository extends JpaRepository<Profile, String>{

	@Query(value="SELECT pf_code,c_id,pf_name,pf_path,pf_thumbnail_path from profile where c_id = :c_id order by pf_code",nativeQuery = true)
	List<Profile> findByCustomerId(@Param("c_id")String c_id);
	
	@Query(value="SELECT count(pf_code) from profile where c_id= :c_id",nativeQuery=true)
	int findByProfileCount(@Param("c_id")String c_id);
	
}
