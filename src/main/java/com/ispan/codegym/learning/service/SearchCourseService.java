package com.ispan.codegym.learning.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.model.dao.CourseProfilesDao;

@Service
@Transactional
public class SearchCourseService {
	@Autowired
	private CourseProfilesDao cpDao;

	// 利用關鍵字搜尋課程
	public List<CourseProfiles> searchCoursesByKeyword(String keyword) {
		return cpDao.findByKeyword(keyword);
	}
}
