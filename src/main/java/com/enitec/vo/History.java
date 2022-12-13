package com.enitec.vo;

import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@Entity(name="history")
@Table(name="history")
@IdClass(History_pk.class)
public class History {
	@Id
	private String pf_code;
	@Id
	private String ct_code;
	private String e_code;
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
