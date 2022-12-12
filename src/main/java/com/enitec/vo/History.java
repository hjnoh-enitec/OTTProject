package com.enitec.vo;

import java.io.Serializable;
import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity(name="history")
@Table(name="history")
@IdClass(history_pk.class)
public class History implements Serializable{
	
	@Id
	@Column(name="pf_code")
	private String pf_code;
	
	@Id
	@Column(name="e_code")
	private String e_code;
	
	@Column(name="h_close_at")
	private double h_close_at;
	private LocalDate h_date;
	private String ct_code;
	
}
