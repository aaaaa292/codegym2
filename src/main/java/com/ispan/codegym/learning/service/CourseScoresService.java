package com.ispan.codegym.learning.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.model.bean.CourseScores;
import com.ispan.codegym.learning.model.dao.CourseScoresDao;

@Service
@Transactional
public class CourseScoresService {
	@Autowired
	private CourseScoresDao csDao;

	public CourseScores saveScoreAndComment(CourseScores cs) {
		return csDao.save(cs);
	}

	// 利用userId取得課程資訊
	public List<CourseScores> findByCourseId(int courseId) {
		return csDao.findByCourseId(courseId);
	}

	// 利用courseId取得課程資訊
	public CourseScores findByUserIdAndCourseId(int userId, int courseId) {
		Optional<CourseScores> optional = csDao.findByUserIdAndCourseId(userId, courseId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
}
