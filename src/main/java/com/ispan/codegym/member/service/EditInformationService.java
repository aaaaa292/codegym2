package com.ispan.codegym.member.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.model.dao.EditInformationDao;

@Service
@Transactional
public class EditInformationService {
	@Autowired
	private EditInformationDao eDao;
	
	public UserInformation findMemberById(int userId) {
		Optional<UserInformation> optional = eDao.findById(userId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
	
	public void updateUserInformation(UserInformation u) {
		eDao.save(u);
	}
}
