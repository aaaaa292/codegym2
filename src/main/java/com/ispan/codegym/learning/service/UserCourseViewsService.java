package com.ispan.codegym.learning.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.learning.model.bean.UserCourseViews;
import com.ispan.codegym.learning.model.dao.UserCourseViewsDao;

@Service
@Transactional
public class UserCourseViewsService {
	@Autowired
	private UserCourseViewsDao cvDao;
	// 新增觀看次數
	public UserCourseViews addCourseViews(UserCourseViews cv) {
		return cvDao.save(cv);
	}
}
