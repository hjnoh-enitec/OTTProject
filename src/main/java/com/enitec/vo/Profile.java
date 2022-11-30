package com.enitec.vo;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class Profile {

	@Id
	private String pf_code;
	private String c_id;

	private String pf_name;

	private String pf_path;
}
