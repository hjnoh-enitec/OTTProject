package com.enitec.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.enitec.vo.Episode;

public interface EpisodeRepository extends JpaRepository<Episode, String> {

}
