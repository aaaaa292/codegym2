package com.ispan.codegym.member.service;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailService {
	private String userName = "a1234566713@gmail.com";// 寄件者email
	private String password = "pduymzyvzihezckb";// 寄件者密碼
	private String customer = "a1234566711@gmail.com";// 收件者email
	private String subject = "驗證您的帳戶";// 信件標題
	private String txt = "您的密碼是";// 信件內容

	public void SendMail(String memberMail, String subject, String txt) {
		this.customer = memberMail;
		this.subject = subject;
		this.txt = txt;
		// 連線設定
		Properties prop = new Properties();

		prop.setProperty("mail.transport.protocol", "smtp");

		prop.setProperty("mail.host", "smtp.gmail.com");

		prop.put("mail.smtp.port", "465");

		prop.put("mail.smtp.auth", "true");

		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");

		prop.put("mail.smtp.socketFactory.port", "465");

		prop.put("mail.debug", "true");

		Auth auth = new Auth(userName, password);
		Session session = Session.getDefaultInstance(prop, auth);

		MimeMessage message = new MimeMessage(session);

		try {
			InternetAddress sender = new InternetAddress(userName);
			message.setSender(sender);

			message.setRecipient(RecipientType.TO, new InternetAddress(customer));

			message.setSubject(subject);

			message.setContent(txt, "text/html;charset = UTF-8");

			Transport transport = session.getTransport();

			transport.send(message);

			transport.close();

		} catch (MessagingException e) {
			e.printStackTrace();
		}

	}

}

class Auth extends Authenticator {

	private String userName;
	private String password;

	public Auth(String userName, String password) {
		this.userName = userName;
		this.password = password;
	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		PasswordAuthentication pa = new PasswordAuthentication(userName, password);
		return pa;
	}

}