package com.ispan.codegym.learning.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.service.CoursesService;

@Controller
public class TeacherUploadedCourseController {
	@Autowired
	private CoursesService cService;
	
	// 導向學生名單
	@GetMapping("/course/{courseId}/students/show")
	public String showStudentList(@PathVariable Integer courseId, Model model) {
		CourseProfiles courseProfile = cService.findCourseProfileById(courseId);
		model.addAttribute("courseProfile", courseProfile);
		return "learning/showStudentList";
	}
}
