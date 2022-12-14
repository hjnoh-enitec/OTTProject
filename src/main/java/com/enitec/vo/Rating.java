package com.enitec.vo;

import java.io.Serializable;

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
@Entity(name="rating")
@Table(name="rating")
@IdClass(rating_pk.class)
public class Rating implements Serializable{

	@Id
	private String pf_code;
	
	@Id
	private String ct_code;
	private double r_star;
	
}
