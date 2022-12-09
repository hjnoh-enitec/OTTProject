package com.enitec.vo;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity(name="content")
public class Content {
	@Id
	private String ct_code;
	private String ct_title;
	private String g_code;
	private String ct_genre;
	private String ct_info;
	private int popularity;
	private String thumbnail;
	private int ct_star;
}
