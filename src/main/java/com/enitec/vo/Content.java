package com.enitec.vo;

import java.time.LocalDate;

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
	private String ct_path_thumbnail;
	private int ct_star;
	private String ct_path;	
	private LocalDate ct_release_Date;
	private LocalDate ct_modifydate; 

	public Content() {
		ct_modifydate = LocalDate.now();
	}
}
