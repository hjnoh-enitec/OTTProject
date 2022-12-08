package com.enitec.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.enitec.vo.Content;
import com.enitec.vo.Profile;

@Repository
public interface ProfileRepository extends JpaRepository<Profile, String>{

}
