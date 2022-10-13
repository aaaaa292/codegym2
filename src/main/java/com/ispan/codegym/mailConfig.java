package com.ispan.codegym;

import java.util.Properties;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
@Configuration
public class mailConfig  {

	@Bean
	 public JavaMailSender getJavaMailSender() {
	     JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	     mailSender.setHost("smtp.gmail.com");
	     mailSender.setPort(587);
	     mailSender.setUsername("cyl20130613@gmail.com");
	     mailSender.setPassword("swumcjukoyfnnunm");
	      
	     Properties props = mailSender.getJavaMailProperties();
	     props.put("mail.transport.protocol", "smtp");
	     props.put("mail.smtp.auth", "true");
	     props.put("mail.smtp.starttls.enable", "true");
	     props.put("mail.smtp.starttls.required", "true");
	     props.put("mail.debug", "true");
	      
	     return mailSender;
	 }

}
