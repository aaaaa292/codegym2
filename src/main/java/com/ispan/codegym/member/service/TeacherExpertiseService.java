package com.ispan.codegym.member.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.member.model.bean.TeacherExpertise;
import com.ispan.codegym.member.model.dao.TeacherexpertiesDao;

@Service
@Transactional
public class TeacherExpertiseService {
	@Autowired
	private TeacherexpertiesDao tDao;
	
	public TeacherExpertise save(TeacherExpertise te) {
		return tDao.save(te);
	}
	
	public TeacherExpertise findByUserId(Integer UserId) {
		Optional<TeacherExpertise> optional = tDao.findByUserId(UserId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
}
	
	
	
