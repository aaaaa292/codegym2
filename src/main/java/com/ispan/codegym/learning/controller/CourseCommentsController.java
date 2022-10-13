package com.ispan.codegym.learning.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ispan.codegym.learning.model.bean.CourseComments;
import com.ispan.codegym.learning.service.CourseCommentService;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.member.model.bean.UserInformation;

@Controller
public class CourseCommentsController {
	@Autowired
	private CoursesService cService;
	
	@Autowired
	private CourseCommentService ccService;
	
	// ckeditor測試
	@GetMapping("/course/ckeditor")
	public String ckeditorPage() {
		return "/learning/CKEditorTest";
	}
	
	// 新增ckeditor內容
	@PostMapping("/course/ckeditor/add")
	public String addCkeditorContent(@RequestParam("title") String title
			, @RequestParam("content") String content, Model model) {
		model.addAttribute("title", title);
		model.addAttribute("content", content);
		System.out.println(content);
		return "/learning/CKEditorTestResult";
	}
	
	// 新增課程留言
	@GetMapping("/course/comment/add")
	public String showCoursePage(@RequestParam("courseId") int courseId
			, @RequestParam("userId") int userId
			, @RequestParam("comment") String comment
			, HttpSession session
			, Model model) {
		// 根據courseId取得課程資訊
		CourseComments courseComment = ccService.insertCourseComment(new CourseComments(cService.findCourseProfileById(courseId), (UserInformation) session.getAttribute("userInformation"), comment));
		//model.addAttribute("courseProfile", courseProfile);
		String directUrl = "redirect:/course/" + courseId + "/show";
		return directUrl;
	}
}
