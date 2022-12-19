package com.enitec.service;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.CustomerRepository;
import com.enitec.vo.Customer;

@Service
public class CustomerMembershipService {

	@Autowired
	CustomerRepository cr;
	
	public void changeMembership(String c_id, String m_code) {
		Customer customer = cr.findById(c_id).get();
		customer.setM_code(m_code);
		customer.setM_start_date(LocalDate.now());
		customer.setM_end_date(LocalDate.now().plusMonths(1));
		customer.setM_autopay("T");
		cr.save(customer);
	}
	
	public void withdrwalMembership(String c_id) {
		Customer customer = cr.findById(c_id).orElse(null);
		if(customer != null) {
			customer.setM_code("M0");
			cr.save(customer);
		}
	}
	
}
