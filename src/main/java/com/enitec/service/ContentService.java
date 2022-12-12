package com.enitec.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.ContentRepository;
import com.enitec.repository.SeasonRepository;
import com.enitec.repository.EpisodeRepository;
import com.enitec.repository.ProfileRepository;
import com.enitec.repository.RatingRepository;
import com.enitec.vo.Content;
import com.enitec.vo.Episode;
import com.enitec.vo.Profile;
import com.enitec.vo.Rating;
import com.enitec.vo.Season;

@Service
public class ContentService {

	@Autowired
	private ContentRepository contentRepo;
	
	@Autowired
	private SeasonRepository seasonRepo;
	
	@Autowired
	private EpisodeRepository episodeRepo;
	
	@Autowired
	private RatingRepository ratingRepo;
	
	public List<Content> findAll() {
		return contentRepo.findAll();
	}
	
	// 컨텐츠 경로
	public String findEpath(String e_code) {
		return episodeRepo.findEpath(e_code);
	}
	
	// 컨텐츠코드 찾기
	public String findCtcode(String e_code) {
		return episodeRepo.findCtcode(e_code);
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
	
	// 평점 계산
	public double calcRatingByCtcode(String ct_code) {
		return ratingRepo.calcRatingByCtcode(ct_code);
	}
}
