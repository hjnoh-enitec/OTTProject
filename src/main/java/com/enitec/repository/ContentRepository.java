package com.enitec.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.enitec.vo.Content;

public interface ContentRepository extends JpaRepository<Content, String> {

}
