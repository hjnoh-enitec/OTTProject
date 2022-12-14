package com.enitec.form;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProfileUpdateForm {

	private MultipartFile file;
	
	private String pf_name;
}
