package com.enitec.service;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.enitec.vo.Mail;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MailService {

	@Autowired
	private JavaMailSender ms;
	@Async
	public void sendMail(String t_id, String c_id, String url, String subject) {
        MimeMessage mimeMessage = ms.createMimeMessage();
        Mail mail = new Mail();
        try {
            mail.setRecipient(c_id);
            mail.setSubject(subject);
            mail.setText("http://localhost:8000"+url+"?t_id="+t_id);
            System.out.println("link : -> -> "+"http://localhost:8000/token/confirm?t_id="+t_id);
            MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, false, "UTF-8");
            mimeMessageHelper.setTo(mail.getRecipient());
            mimeMessageHelper.setSubject(mail.getSubject());
            mimeMessageHelper.setText(mail.getText(), true);
            ms.send(mimeMessage);
            log.info("sent email: {}", mail.getText());
        } catch (MessagingException e) {
            log.error("[EmailService.send()] error {}", e.getMessage());
        }
	}
}
