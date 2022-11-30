package com.enitec.vo;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity(name="content")
@Data
@Table(name="content")
public class Content {

	@Id
	private String ct_code;
	private String ct_title;
	private String g_code;
	private String ct_info;
	private double ct_star;
	private LocalDate ct_release_date;
	private LocalDate ct_modifyed_date;
	private String ct_path;
	private String ct_path_thumbnail;
	
}
