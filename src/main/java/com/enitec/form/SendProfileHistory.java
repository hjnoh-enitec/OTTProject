package com.enitec.form;

import java.util.List;

import lombok.Data;

@Data
public class SendProfileHistory {

	private String pf_code;
	
	private String pf_path;
	
	private List<String> h_code;
	
	private List<String> h_poster_path;
	
}
