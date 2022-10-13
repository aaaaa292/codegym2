package com.ispan.codegym.learning.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ispan.codegym.learning.model.bean.CourseDetails;
import com.ispan.codegym.learning.model.bean.UserFavoriteCourses;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.learning.service.UserFavoriteCoursesService;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.member.service.EditInformationService;

@Controller
public class UserFavoriteCoursesController {
	@Autowired
	private UserFavoriteCoursesService fcService;
	@Autowired
	private CoursesService cService;
	@Autowired
	private EditInformationService eService;
	
	@GetMapping("/course/favorite")
	public String showFavoriteCourse(HttpSession session, Model model) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if(userInformation == null) {
			return "member/login";	
		}
		// 更新userInformation
		userInformation = eService.findMemberById(userInformation.getId());
		session.setAttribute("userInformation", userInformation);
		
		model.addAttribute("favoriteCourses", userInformation.getUserFavoriteCourses());
		return "/learning/showFavoriteCourses";
	}
	
	@PostMapping("/course/favorite/keep/{id}")
	@ResponseBody
	public String addFavoriteCourse(HttpSession session, @PathVariable int id) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if(userInformation == null) {
			return "請先登入";	
		}
		CourseDetails courseDetail = cService.findCourseDetailById(id);
		UserFavoriteCourses userFavoriteCourse = fcService.keepFavoriteCourse(new UserFavoriteCourses(userInformation, courseDetail));
		
		if(userFavoriteCourse != null) {
			return "收藏成功";
		}
		return "已收藏";	
	}
	
	@PostMapping("/course/favorite/remove/{courseDetailId}")
	@ResponseBody
	public String removeFavoriteCourse(HttpSession session, @PathVariable int courseDetailId) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if(userInformation == null) {
			return "請先登入";	
		}
		//UserFavoriteCourses userFavoriteCourse = fcService.findByCourseIdAndUserId(userInformation.getId(), courseDetailId);
		fcService.removeFavoriteCourse(userInformation.getId(), courseDetailId);

		return "取消收藏";	
	}
}
