package com.enitec.vo;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity(name="season")
@Data
@Table(name="season")
public class Season {

	@Id
	private String s_code;
	private String ct_code;
	private String s_name;
	private String s_info;
	
}
