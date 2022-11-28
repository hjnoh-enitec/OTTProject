package com.enitec.vo;



import java.time.LocalDate;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;


@Entity(name="customer")
@Data
@Table(name="customer")
public class Customer {
	@Id
	private String c_id;
	private String c_name;
	private String c_pwd;
	private String c_mailcheck;
	private String c_birth;
	private String c_phone;
	private String m_code;
	private String m_autopay;
	private LocalDate m_start_date;
	private LocalDate m_end_date;
	public void compleMailCheck() {
		c_mailcheck="T";
	}
}
