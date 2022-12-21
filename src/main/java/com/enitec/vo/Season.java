package com.enitec.vo;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity(name="season")
@Data
public class Season {
	@Id
	private String s_code;
	private String ct_code;
	private String s_name;
	private String s_info;
	private int s_number;
	
}
