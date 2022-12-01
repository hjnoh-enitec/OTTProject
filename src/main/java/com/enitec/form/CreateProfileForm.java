package com.enitec.form;

import javax.validation.constraints.NotBlank;

import lombok.Data;

@Data
public class CreateProfileForm {
	@NotBlank
	private String pf_code;
	@NotBlank
	private String c_id;
	@NotBlank
	private String pf_name;
	
	private String pf_path;
}
