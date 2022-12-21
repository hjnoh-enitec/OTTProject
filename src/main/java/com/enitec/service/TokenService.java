
package com.enitec.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.enitec.repository.TokenRepository;
import com.enitec.vo.Token;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
@Transactional
public class TokenService {

	@Autowired
	TokenRepository tr;
	
	public String createToken(String c_id) {
		Token token = Token.createToken(c_id);
		tr.save(token);
		return token.getT_id();
	}
	public String confirmToken(String t_id) {
		Token token = tr.findById(t_id).get();
		token.useToken();
		tr.save(token);
		return token.getC_id();
	}
}
