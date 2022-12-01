package com.enitec.vo;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class History {

	@Id
	private String history_pk;
	
	private String pf_code;
	
	private String e_code;
	
	private String h_close_at;
	
	private String h_date;
	
	private String h_poster_path;
}
