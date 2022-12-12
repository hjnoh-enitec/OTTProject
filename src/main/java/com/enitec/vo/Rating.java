package com.enitec.vo;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity(name="rating")
@Data
@Table(name="rating")
public class Rating {

	@Id
	private String pf_code;
	private String ct_code;
	private double r_star;
	
}
