package com.ispan.codegym.learning.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ispan.codegym.learning.model.bean.CourseDetails;
import com.ispan.codegym.learning.model.bean.UserCourseViews;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.learning.service.UserCourseViewsService;
import com.ispan.codegym.member.model.bean.UserInformation;

@Controller
public class UserCourseViewsController {
	@Autowired
	private CoursesService cService;
	@Autowired
	private UserCourseViewsService cvService;
	
	@PostMapping("/course/views/add/{courseDetailId}")
	@ResponseBody
	public void addCourseViews(HttpSession session, @PathVariable int courseDetailId) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if(userInformation != null) {
			CourseDetails courseDetail = cService.findCourseDetailById(courseDetailId);
			cvService.addCourseViews(new UserCourseViews(userInformation, courseDetail));
		}
	}
}
