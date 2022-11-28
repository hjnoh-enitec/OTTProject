
package com.enitec.vo;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import lombok.Data;

@Data
@Entity
@Table(name = "email_token")
public class Token {

	private static final long EMAIL_TOKEN_EXPIRATION_TIME_VALUE = 5L;

    @Id
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "uuid2")
    private String t_id;
	private LocalDateTime t_expireation_date;
	private String t_isExpired;
	private String c_id;

	public static Token createToken(String c_id) {
        Token confirmationToken = new Token();
        confirmationToken.t_isExpired = "F";
        confirmationToken.t_expireation_date = LocalDateTime.now().plusMinutes(EMAIL_TOKEN_EXPIRATION_TIME_VALUE); // 5분후 만료
        confirmationToken.c_id = c_id;
        return confirmationToken;
	}

	public void useToken() {
		this.t_isExpired = "T";
	}
}
