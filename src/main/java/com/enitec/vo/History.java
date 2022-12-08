package com.enitec.vo;

import java.time.LocalDate;
import java.time.LocalTime;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity(name="history")
@Data
@Table(name="history")
public class History {

	@Id
	private String history_key;
	private String pf_code;
	private String e_code;
	private LocalTime h_close_at;
	private LocalDate h_date;
	private String h_poster_path;
	private double e_close_sec;
	
}
