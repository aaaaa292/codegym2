package com.ispan.codegym.member.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.model.dao.LoginDao;

@Service
@Transactional
public class LoginService {
	@Autowired
	private LoginDao lDao;

	public UserInformation findMemberByEmailAndPassword(String email, String password) {
		Optional<UserInformation> optional = lDao.findMemberByEmailAndPassword(email, password);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
	
	public UserInformation findMemberByVerification(String verification) {
		Optional<UserInformation> optional = lDao.findByVerification(verification);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
	public UserInformation findByEmail(String email) {
		Optional<UserInformation> optional = lDao.findByEmail(email);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
}
