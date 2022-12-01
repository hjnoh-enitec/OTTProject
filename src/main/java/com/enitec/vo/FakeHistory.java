package com.enitec.vo;

import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Entity
@Data
public class FakeHistory {

	@Id
	private String fh_code;
	
	private String fh_poster_path;
	
	private String pf_code;
	
}
