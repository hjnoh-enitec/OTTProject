package com.enitec.vo;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Data
@Table(name="membership_master")
public class Membership {
	@Id
	private String m_code;
	private String m_name;
	private String m_period;
	private String m_price;
	
}
