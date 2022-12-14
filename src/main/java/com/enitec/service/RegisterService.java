package com.enitec.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.CustomerRepository;
import com.enitec.vo.Customer;

@Service
public class RegisterService {
	@Autowired
	CustomerRepository cr;

	
	public Customer insertCustomer(Customer customer) {
		customer.setC_mailcheck("F");
		customer.setM_code("M0");
		return cr.save(customer);
	}
	public void updateMailCheck(String c_id) {
		Customer customer = new Customer();
		customer = cr.findById(c_id).get();
		customer.setC_mailcheck("T");
		cr.save(customer);
	}
	public String login(Customer customer) {
		String c_id = cr.login(customer.getC_id(), customer.getC_pwd());
		return c_id;
	}
	@Transactional
	public void compleMailCheck(String c_id) {
		cr.updateMailCheck(c_id);
	}
	public int checkIdDuplicated(String customer) {
		if(cr.findById(customer).orElse(null)==null)
		{
			return 0;
		}
		return 1;
	}
}
