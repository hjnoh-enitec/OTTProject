package com.enitec.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.enitec.vo.Profile;

public interface ProfileRepository extends JpaRepository<Profile, String>{

}
