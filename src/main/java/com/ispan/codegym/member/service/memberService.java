package com.ispan.codegym.member.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.model.dao.LoginDao;
import com.ispan.codegym.member.model.dao.MemberDao;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Service
@Transactional
public class memberService {
//判斷mail帳號是否重複
	@Autowired
	private MemberDao mDao;

	public UserInformation findMemberByEmail(String email) {
		Optional<UserInformation> optional = mDao.findMemberByEmail(email);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}


}
