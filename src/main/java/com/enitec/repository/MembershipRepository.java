package com.enitec.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.enitec.vo.Membership;

public interface MembershipRepository extends JpaRepository<Membership, String > {

	@Query(value="SELECT m_name FROM enitec.membership_master WHERE m_code=:m_code",nativeQuery = true)
	public String findMcode(@Param("m_code") String m_code);
	
}
