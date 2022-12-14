package com.enitec.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class rating_pk implements Serializable{

	private String pf_code;
	private String ct_code;
	
}
