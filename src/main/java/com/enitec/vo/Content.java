package com.enitec.vo;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
public class Content {
	@Id
	private String ct_code;
	private String ct_title;
	private String g_code;
	private String genres;
	private String ct_info;
	private String preview;
	private String poster;
	private int ct_star;
	private LocalDateTime ct_release_date;
}
