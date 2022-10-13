package com.ispan.codegym.member.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.member.model.bean.UserInterest;
import com.ispan.codegym.member.model.dao.UserinterestDao;

@Service
@Transactional
public class UserInterestService {
	@Autowired
	private UserinterestDao iDao;
	
	public UserInterest save(UserInterest ui) {
		return iDao.save(ui);
	}
	
	public UserInterest findByUserId(Integer UserId) {
		Optional<UserInterest> optional = iDao.findByUserId(UserId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
}
	
	
	
