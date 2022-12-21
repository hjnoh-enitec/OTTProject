package com.enitec;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class EnitecOttProjectApplication extends SpringBootServletInitializer{
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder appilcation) {
		return appilcation.sources(EnitecOttProjectApplication.class);
	}
	
	public static void main(String[] args) {
		SpringApplication.run(EnitecOttProjectApplication.class, args);
	}
}