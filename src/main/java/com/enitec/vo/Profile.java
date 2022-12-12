package com.enitec.vo;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity(name="profile")
@Data
@Table(name="profile")
public class Profile {

	@Id
	private String pf_code;
	private String c_id;
	private String pf_name;
	private String pf_path;
	private String pf_thumbnail_path;
	
}
