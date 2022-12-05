package com.enitec.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.ContentRepository;
import com.enitec.repository.SeasonRepository;
import com.enitec.repository.EpisodeRepository;
import com.enitec.vo.Content;
import com.enitec.vo.Episode;
import com.enitec.vo.Season;

@Service
public class ContentService {

	@Autowired
	private ContentRepository contentRepo;
	
	@Autowired
	private SeasonRepository seasonRepo;
	
	@Autowired
	private EpisodeRepository episodeRepo;
	
	public List<Content> findAll() {
		return contentRepo.findAll();
	}
	
	// 컨텐츠 경로
	public String findCtpath(String ct_code) {
		return contentRepo.findCtpath(ct_code);
	}
	
	// 컨텐츠별 시즌명 찾기
	public List<Season> findSeasonName(String ct_code) {
		return seasonRepo.findSeasonName(ct_code);
	}
	
	// 컨텐츠 내 모든 에피소드들 찾기
	public List<Episode> findEpiCodeAndNameByCtcode(String ct_code) {
		return episodeRepo.findEpiCodeAndNameByCtcode(ct_code);
	}
	
	// 시즌 내 모든 에피소드들 찾기
	public List<Episode> findEpiCodeAndNameByScode(String s_code) {
		return episodeRepo.findEpiCodeAndNameByScode(s_code);
	}	
	
}
