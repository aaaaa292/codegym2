package com.ispan.codegym.learning.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.learning.model.bean.CourseComments;
import com.ispan.codegym.learning.model.dao.CourseCommentsDao;

@Service
@Transactional
public class CourseCommentService {
	@Autowired
	private CourseCommentsDao ccDao;
	
	// 新增課程留言
	public CourseComments insertCourseComment(CourseComments cc) {
		return ccDao.save(cc);
	}
}
