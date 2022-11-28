package com.enitec.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.CustomerRepository;
import com.enitec.vo.Customer;

@Service
public class FindService {

	@Autowired
	private CustomerRepository cr;

	@Transactional
	public List<String> findId(String c_name, String c_birth, String c_phone) {
		List<String> idList = cr.findByNameAndBirthAndPhone(c_name, c_birth, c_phone); // just id
		return idList;
	}

	public Customer findCustomer(String id) {
		Customer customer = cr.findById(id).get();
		return customer;
	}

	public void updatePassword(String c_pwd, String c_id) {
		Customer customer = cr.findById(c_id).get();
		customer.setC_pwd(c_pwd);
		cr.save(customer);
	}
}
