package com.enitec.vo;
import java.io.Serializable;
import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Data;
@Data
@AllArgsConstructor
@Entity(name="history")
@Table(name="history")
@IdClass(history_pk.class)
public class History implements Serializable{
	@Id
	private String pf_code;
	@Id
	private String e_code;
	private String ct_code;
	private String s_code;
	private double h_close_at;
	private LocalDate h_date;
	private int s_number;
	private int e_number;
	@Transient
	private String imgPath;
	public History() {
		h_date = LocalDate.now();
	}
}