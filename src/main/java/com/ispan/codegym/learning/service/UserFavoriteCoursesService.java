package com.ispan.codegym.learning.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.model.bean.UserFavoriteCourses;
import com.ispan.codegym.learning.model.dao.UserFavoriteCoursesDao;

@Service
@Transactional
public class UserFavoriteCoursesService {
	@Autowired
	private UserFavoriteCoursesDao fcDao;
	
	// 透過courseId及userId找到收藏課程
	public UserFavoriteCourses findByCourseIdAndUserId(int userId, int courseDetailId) {
		Optional<UserFavoriteCourses> optional = fcDao.findByCourseIdAndUserId(userId, courseDetailId);
		if (optional.isPresent()) {
			return optional.get();
		}
		return null;
		
	}
	
	// 新增收藏課程
	public UserFavoriteCourses keepFavoriteCourse(UserFavoriteCourses fc) {
		return fcDao.save(fc);
	}

	// 取消收藏課程
	public void removeFavoriteCourse(int userId, int courseDetailId) {
		fcDao.deleteByCourseIdAndUserId(userId, courseDetailId);
	}
}
