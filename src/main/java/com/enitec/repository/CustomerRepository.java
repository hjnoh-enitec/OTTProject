package com.enitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.enitec.vo.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, String>{
	@Query(value="SELECT c_mailcheck FROM enitec.customer WHERE c_id=:c_id AND c_pwd =:c_pwd",nativeQuery = true)
	public String login(@Param("c_id") String c_id,@Param("c_pwd") String c_pwd);
	@Modifying
	@Query(value="UPDATE enitec.customer SET c_mailcheck ='T' WHERE c_id=:c_id",nativeQuery=true)
	public void updateMailCheck(@Param("c_id") String c_id);
	
	@Query(value="SELECT c_id FROM enitec.customer WHERE c_name=:c_name AND c_birth=:c_birth AND c_phone=:c_phone",nativeQuery=true)
	public List<String> findByNameAndBirthAndPhone(@Param("c_name") String c_name, @Param("c_birth") String c_birth, @Param("c_phone") String c_phone);
	
	@Query(value="SELECT m_code FROM enitec.customer WHERE c_id=:c_id",nativeQuery = true)
	public String findMembershipCode(@Param("c_id") String c_id);
	
	@Query(value="SELECT c_name FROM enitec.customer WHERE c_id=:c_id",nativeQuery = true)
	public String findName(@Param("c_id") String c_id);
	
	@Query(value="SELECT m_autopay FROM enitec.customer WHERE c_id=:c_id",nativeQuery = true)
	public String findAutopay(@Param("c_id") String c_id);
}
