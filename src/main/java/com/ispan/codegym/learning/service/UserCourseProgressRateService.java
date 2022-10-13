package com.ispan.codegym.learning.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.learning.model.bean.UserCourseProgressRate;
import com.ispan.codegym.learning.model.dao.UserCourseProgressRateDao;

@Service
@Transactional
public class UserCourseProgressRateService {
	@Autowired
	private UserCourseProgressRateDao prDao;

	public UserCourseProgressRate saveRate(UserCourseProgressRate pr) {
		return prDao.save(pr);
	}

	// 利用courseId取得課程資訊
	public UserCourseProgressRate findByUserIdAndCourseDetailId(int userId, int courseDetailId) {
		Optional<UserCourseProgressRate> optional = prDao.findByUserIdAndCourseDetailId(userId, courseDetailId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
	}
}
