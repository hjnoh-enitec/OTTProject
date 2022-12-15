package com.enitec.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.enitec.vo.Membership;



public interface MembershipRepository extends JpaRepository<Membership, String > {

} 
