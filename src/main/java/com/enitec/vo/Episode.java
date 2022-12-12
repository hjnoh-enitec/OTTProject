package com.enitec.vo;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity(name="episode")
@Data
@Table(name="episode")
public class Episode {

	@Id
	private String e_code;
	private String ct_code;
	private String s_code;
	private String e_name;
	private String e_path;
	private LocalDate e_release_date;
	
}
