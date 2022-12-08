package com.enitec.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.enitec.vo.Content;
import com.enitec.vo.Rating;

@Repository
public interface RatingRepository extends JpaRepository<Rating, String>{
	
	@Query(value="SELECT sum(r_star) / count(:ct_code) AS ct_rating FROM enitec.rating WHERE ct_code=:ct_code", nativeQuery = true)
	public double calcRatingByCtcode(@Param("ct_code") String ct_code);
}
