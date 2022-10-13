package com.ispan.codegym.learning.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ispan.codegym.learning.model.bean.CourseProfiles;
import com.ispan.codegym.learning.service.SearchCourseService;
import com.ispan.codegym.member.model.bean.UserInformation;
import com.ispan.codegym.order.model.bean.Orders;
import com.ispan.codegym.order.service.OrderService;

@Controller
public class CourseSearchController {
	@Autowired
	private SearchCourseService scService;
	@Autowired
	private OrderService ordService;

	// 搜尋課程
	@GetMapping("/course/search")
	public String searchCourse(HttpSession session, @RequestParam("keyword") String keyword, Model model) {
		// 取得使用者已購買課程
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if (userInformation != null) {
			int userId = userInformation.getId();

			List<Orders> orders = ordService.findByUserId(userId);
			model.addAttribute("orders", orders);
		}
		List<CourseProfiles> courseProfileList = scService.searchCoursesByKeyword(keyword);
		model.addAttribute("courseProfiles", courseProfileList);
		model.addAttribute("keyword", keyword);
		return "/learning/showAllCourses";
	}
}
