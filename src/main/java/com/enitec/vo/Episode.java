package com.enitec.vo;

import java.time.LocalDateTime;

import javax.persistence.Entity;

import lombok.Data;


public class Episode {
	private String e_code;
	private String ct_code;
	private String s_code;
	private String e_name;
	private LocalDateTime e_release_Date;
	private String e_path;
}
