package com.ispan.codegym.learning.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ispan.codegym.learning.model.bean.CourseDetails;
import com.ispan.codegym.learning.model.bean.UserCourseProgressRate;
import com.ispan.codegym.learning.service.CoursesService;
import com.ispan.codegym.learning.service.UserCourseProgressRateService;
import com.ispan.codegym.member.model.bean.UserInformation;

@Controller
public class UserCourseProgressRateController {
	@Autowired
	private CoursesService cService;
	
	@Autowired
	private UserCourseProgressRateService prService;
	
	@PostMapping("/course/progress/update/{courseDetailId}")
	@ResponseBody
	public void updateCourseProgress(HttpSession session, @PathVariable int courseDetailId, @RequestParam("rate") float rate) {
		UserInformation userInformation = (UserInformation) session.getAttribute("userInformation");
		if(userInformation != null) {
			CourseDetails courseDetail = cService.findCourseDetailById(courseDetailId);
			UserCourseProgressRate userCourseProgressRate = prService.findByUserIdAndCourseDetailId(userInformation.getId(), courseDetailId);
			// 更新課程進度
			if (userCourseProgressRate != null) {
				// 跟過往紀錄比較
				if (rate > userCourseProgressRate.getRate()) {
					userCourseProgressRate.setRate(rate);
					prService.saveRate(userCourseProgressRate);
				}
			}
			// 增加全新課程進度
			else {
				prService.saveRate(new UserCourseProgressRate(userInformation, courseDetail));
			}
		}
	}
}


